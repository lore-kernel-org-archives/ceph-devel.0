From: Sage Weil <sage@newdream.net>
Subject: Re: rgw: storing (and securing?) totp seed information
Date: Mon, 13 Nov 2017 02:23:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711130220150.23234@piezo.novalocal>
References: <CADRKj5SCQ-Hkb+=oWLQe_SXRnbXZm7L-MoHEG1p2tH2MxXHAfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:53997 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbdKMCXM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Nov 2017 21:23:12 -0500
In-Reply-To: <CADRKj5SCQ-Hkb+=oWLQe_SXRnbXZm7L-MoHEG1p2tH2MxXHAfQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Matt Benjamin <mbenjamin@redhat.com>, Casey Bodley <cbodley@redhat.com>

On Fri, 10 Nov 2017, Yehuda Sadeh-Weinraub wrote:
> I was looking into implementing the S3 multi-factor authentication
> (mfa) functionality that is related to object versioning. The feature
> is that when configured, certain operations (e.g., objects removal,
> change of config) require the use of a totp (time-based one time
> password) token along with the requests, so that it adds extra level
> of security to the operation. This also helps prevents accidental
> removal of objects, and is useful for enforcing archival requirements.
> I have an issue with where and how should we keep the totp devices
> seed information. My initial thought was to have it as part of the rgw
> user metadata structure. Having it there is trivial, and it has the
> added bonus that it should work out of the box for multisite. There
> are multiple problems with this solution. First, it is not secure as
> anyone with the ability to use radosgw-admin can just read it and
> replicate the totp generator. Another problem is that we need to
> update the token with information related its usage whenever it's used
> (token is single use, so need to store info about the last value that
> was used to avoid replay, and also need to keep info about
> unsuccessful attempts to avoid malicious client trying to guess the
> values). This will not work well with the user info object that is
> designed to be mostly static. Any solution needs to take into account
> that we need to work correctly in multi-site environment, so the seed
> information could be distributed to the different zones.
> 
> I was thinking of different solutions, but any solution that I come up
> with ends up either requiring some kind of a trust mechanism between
> different ceph clusters, or acknowledges that some compromises need to
> be made.
> 
> To illustrate, here's a simple-to-implement solution:
> 
>  - create a new objclass for management and authorization of a single
> totp token. It will deal with creation, sync, verification, tracking
> of attempts, etc.
>  - hooks these objects specially into the rgw metadata subsystem, such
> that the information could be synced via metadata sync
> 
> This solves tracking of the totp usage. The user info will only keep a
> reference to the totp id, and not the seed itself. However, admin can
> still potentially read the seed info. We can mask that info via
> radosgw-admin, but one could potentially get that by running a raw
> rados operation. It might be that I can stop here.

I would go for this
 
> In addition we can also do this:
>  - put seed objects (that the totp objclass are executed on) in a
> separate pool, where radosgw-admin user only has write and execute
> permissions. Creation is done by an execution of a write objclass
> method to the object.
>  - radosgw (not radosgw-admin) users will also have read permissions
> for that pool, so that they will be able to read from it
> 
> In this solution it is possible to limit users' access to the seed
> data, however, any user that that has rados permissions to the pool
> will be able to extract that information. It might be that it's
> enough.

or probably this.

Is there an external interface we can/should be hooking into here, or is 
this really something we should be implementing from scratch?  It doens't 
seem like there is any way around the ceph admin (client.admin) getting 
around it unless it's an external tool.  But even if it were, client.admin 
could still just go and delete the data on the backend, or destory the 
OSDs, or whatever, so I'm not sure it matters that much?

sage

> 
> Another attempt:
>  - start with previous solution
>  - create a trust mechanism between different ceph clusters:
>    - assign a [set of] public/private key[s] to ceph cluster
>    - osd could validate whether a public key belongs to an osd on a
> trusted ceph cluster
>    - osds will be able to access their private key
>  - radosgw itself will need to provide a public key to the objclass in
> order to fetch the seed, however, the returned result will be
> encrypted by that key
>  - metadata sync operation will first retrieve the public key for the
> target osd, and send it along with the fetch request.
>  - totp objclass will store the seed encrypted (*), but decrypt it
> whenever it needs to fetch it.
> 
> This is an order of magnitude or two more complicated solution, and
> requires changes all around ceph to get it working. Not sure it's
> worth the trouble.
> In here both radosgw and radosgw-admin cannot see the unecrypted seed.
> Potentially rados users will not be able to do it without having the
> cluster's private key. Cluster's admins are the weak link here as they
> are able to gain access to the cluster's private keys. Also,
> revocation of keys is problematic (*) unless the seeds are kept
> unencrypted in the osds , in which case why bother. There are
> solutions to that, but I think I dug too deep of a hole here.
> 
> Thinking about it, I think that a trust mechanism between different
> clusters can be useful. I don't think this feature really needs it.
> 
> Thoughts?
> 
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
