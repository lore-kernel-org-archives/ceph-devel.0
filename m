From: John Spray <john.spray@redhat.com>
Subject: Re: MDS auth caps for cephfs
Date: Fri, 22 May 2015 10:28:48 +0100
Message-ID: <555EF6D0.5000903@redhat.com>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58413 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757259AbbEVJ2u (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 May 2015 05:28:50 -0400
In-Reply-To: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org
Cc: nishtha3rai@gmail.com



On 21/05/2015 01:14, Sage Weil wrote:
> Looking at the MDSAuthCaps again, I think there are a few things we might
> need to clean up first.  The way it is currently structured, the idea is
> that you have an array of grants (MDSCapGrant).  For any operation, you'd
> look at each grant until one that says what you're trying to do is okay.
> If non match, you fail.  (i.e., they're additive only.)
>
> Each MDSCapGrant has a 'spec' and a 'match'.  The 'match' is a check
> to see if the current grant applies to a given operation, and the 'spec'
> says what you're allowed to do.
>
> Currently MDSCapMatch is just
>
>    int uid;  // Require UID to be equal to this, if !=MDS_AUTH_UID_ANY
>    std::string path;  // Require path to be child of this (may be "/" for any)
>
> I think path is clearly right.  UID I'm not sure makes sense here... I'm
> inclined to ignore it (instead of removing it) until we decide
> how to restrict a mount to be a single user.
>
> The spec is
>
>    bool read;
>    bool write;
>    bool any;
>
> I'm not quite sure what 'any' means, but read/write are pretty clear.

Ah, I added that when implementing 'tell' -- 'any' is checked when 
handling incoming MCommand in MDS, so it's effectively the admin permission.

> The root_squash option clearly belongs in spec, and Nistha's first patch
> adds it there.  What about the other NFS options.. should be mirror those
> too?
>
> root_squash
>   Map requests from uid/gid 0 to the anonymous uid/gid. Note that this does
>   not apply to any other uids or gids that might be equally sensitive, such
>   as user bin or group staff.
> no_root_squash
>   Turn off root squashing. This option is mainly useful for diskless
>   clients.
> all_squash
>   Map all uids and gids to the anonymous user. Useful for NFS-exported
>   public FTP directories, news spool directories, etc. The opposite option
>   is no_all_squash, which is the default setting.
> anonuid and anongid
>   These options explicitly set the uid and gid of the anonymous account.
>   This option is primarily useful for PC/NFS clients, where you might want
>   all requests appear to be from one user. As an example, consider the
>   export entry for /home/joe in the example section below, which maps all
>   requests to uid 150 (which is supposedly that of user joe).

Yes, I think we should.  Part of me wants to say that people who want 
NFS-like behaviour should be using NFS gateways.  However, these are all 
probably straightforward enough to implement that it's worth maintaining 
them in cephfs too.

We probably need to mirror these in our mount options too, so that e.g. 
someone with an admin key can still enable root_squash at will, rather 
than having to craft an authentication token with the desired behaviour.

> We could also do an all_squash bool at the same time (or a flags field for
> more efficient encoding), and anonuid/gid so that we don't hard-code
> 65534.
>
> In order to add these to the grammer, I suspect we should go back to
> root_squash (not squash_root), and add an 'optoins' tag.  e.g.,
>
>   allow path /foo rw options no_root_squash anonuid=123 anongid=123
>
> (having them live next to rw was breaking the spirit parser, bah).
Looks good to me.

John
