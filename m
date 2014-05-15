From: Sage Weil <sage@inktank.com>
Subject: Re: Suspend and the ceph clients
Date: Thu, 15 May 2014 07:29:48 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405150720080.28306@cobra.newdream.net>
References: <CAPYLRzhr7XA9sBArqe=5bPaXd3XPwgVGo_QOM024-J_ovh93BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50130 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbaEOO3t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 May 2014 10:29:49 -0400
In-Reply-To: <CAPYLRzhr7XA9sBArqe=5bPaXd3XPwgVGo_QOM024-J_ovh93BA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Zheng Yan <ukernel@gmail.com>

On Wed, 14 May 2014, Gregory Farnum wrote:
> There's a recent ticket discussing the behavior of ceph-fuse after the
> machine it's running on has been suspended:
> http://tracker.ceph.com/issues/8291
> 
> In short, CephFS clients which are disconnected from the cluster for a
> sufficiently long time are generally forbidden from reconnecting ?
> after a configurable timeout, their "capabilities" on inodes and
> dentries are revoked, and other users are allowed to change them. If
> the client then comes back, it's entirely possible it has incompatible
> changes to the tree, so we don't let it reconnect in order to prevent
> that. (We could make the system smarter in some situations, if for
> instance nobody has changed the given filesystem data in the
> meanwhile, but that's hard and a problem for another day.)
> 
> Apparently, ceph-fuse does exactly this, as we expect (although we
> have newly-merged features which let the admin force a reconnect). But
> the kernel client does allow a reconnect. I haven't done this myself,
> so the first question is just a fact check for Sage or Zheng:
> 1) What is the kernel client doing after suspend? Does it in fact
> reconnect under situations where ceph-fuse won't, and what are they?

It looks to me like it is making a blind attempt to reconnect via 
peer_reset(), which is probably wrong.  Haven't thought through it, 
though.

There is an ancient ticket to make the client do a best-effort reconnect 
after the MDS reconnect period, but it's a hard to impossible task.

For me, the minimum that we need to support well today is to make it 
clearly visible on the client whether or now we were disconnected so that 
any applications or humans using that mount can tell what happened.  
Zheng's patch for ceph-fuse that added the STALE state accomplishes this 
(by dumping mds_sessions on the ceph-fuse admin socket), and I backported 
just that patch to firefly (and dumpling? I forget).

I think we should do the same thing for the kernel client so that you can 
look in /sys/kernel/debug/ceph/*/mdsc to get the same info.

> More interestingly, while suspended systems aren't part of our normal
> target use case, they'd be nice to support well. The trivial solution
> would be to somehow flush out all dirty data on suspend, and then on
> wake or when we discover we have a reset session, we can clean out our
> cache and reconnect as a new client if we have no dirty data.

This will at least avoid losing client data, but I think it will take 
significant work to keep the client mount alive in any meaningful way.  
Even if all of the cache contents (including dentry) are blown away, 
there are still open files that may not exist afterwards, so at a minimum 
there needs to be a way to identify and mark those deleted inode refs 
as stale at reconnect time.  Perhaps it could all be a client-side thing 
based on fresh MDS sessions and open-by-ino?

> Unfortunately, I don't know anything about Linux's suspend
> functionality or APIs, and my weak attempts at googling and grepping
> aren't turning anything up. So a question to everybody:
> 
> 2) What notifications does Linux send, and what filesystem mechanisms
> does it invoke, when it is suspending?
> I see that it has in the past forced a sync whenever suspending, but I
> think that's no longer required. Are there other interfaces we can
> rely on, or use heuristically?

There is a bunch of in-kernel infrastructure for doing sleep/wake stuff.  
For userspace, it sounds like Holger's systemd pointer is the most 
promising?

sage
