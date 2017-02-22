From: Jeff Layton <jlayton@redhat.com>
Subject: Re: blacklisting etc
Date: Wed, 22 Feb 2017 06:30:01 -0500
Message-ID: <1487763001.2886.1.camel@redhat.com>
References: <CALe9h7c8YtA3YPUkwtOQzvqu-DTQpFXAHxvjUOdd-Ywx_9ccNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34919 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932234AbdBVLaG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Feb 2017 06:30:06 -0500
Received: by mail-qk0-f179.google.com with SMTP id u188so6546535qkc.2
        for <ceph-devel@vger.kernel.org>; Wed, 22 Feb 2017 03:30:05 -0800 (PST)
In-Reply-To: <CALe9h7c8YtA3YPUkwtOQzvqu-DTQpFXAHxvjUOdd-Ywx_9ccNg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 2017-02-22 at 10:57 +0000, John Spray wrote:
> I meant to mention yesterday, I have a branch with the
> mds-obeys-blacklist behaviour here:
> https://github.com/jcsp/ceph/tree/wip-17980
> 

Thanks, I'll take a look.

> For the other side (blacklisting clients from the MDS), I also
> remembered that we currently we have a precedent for special-casing an
> mds->OSDMonitor operation, in the form of the MRemoveSnaps message.
> 
> I think the options we currently have for blacklisting clients from the MDS are:
>  A) Add a new MBlacklist message a la MRemoveSnaps
>  B) Send a MMonCommand and special case the auth on the mon side to
> allow any mds.* entity to run "osd blacklist add" without needing the
> usual caps
>  C) Send a MMonCommand and ask users/scripts setting up Ceph to
> explicitly include the mon cap to run the blacklist command.
>  D) Piggy-back a list of clients to evict on MMDSBeacon, where the MDS
> daemon would trim that list once it saw that the blacklist had been
> updated to include those clients.
> 
> D is a bit circuitous, but I think it could be interesting as it would
> let the mon exercise some discretion on whether to do the client
> blacklisting or not, rather than giving the MDSs such power.
> 
> 

Ugh...I had started working on an approach similar to B/C above, but
missed the fact that the mds.* user would need the mon cap. That is a
potential problem.

A sounds fairly straightforward, and since all of this would require an
updated MDS and monitor anyway, it might be the best approach.

D sounds clever, but "fiddly". Under what circumstances would you want
the monitor to ignore a request from an MDS to blacklist a client?
-- 
Jeff Layton <jlayton@redhat.com>
