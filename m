From: Sage Weil <sage@inktank.com>
Subject: Re: FS / Kernel question choosing the correct kernel version
Date: Mon, 25 Jun 2012 15:11:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206251506070.22491@cobra.newdream.net>
References: <4FE60A65.2030800@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49704 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab2FYWLW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jun 2012 18:11:22 -0400
In-Reply-To: <4FE60A65.2030800@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 23 Jun 2012, Stefan Priebe wrote:
> Hi,
> 
> i got stuck while selecting the right FS for ceph / RBD.
> 
> XFS:
> - deadlock / hung task under 3.0.34 in xfs_ilock / xfs_buf_lock while syncfs

There was an ilock fix that went into 3.4, IIRC.  Have you tried vanilla 
3.4?  We are seeing some lockdep noise currently, but no deadlocks yet.

> - under 3.5-rc3 all my machines got loaded doing nothing than waiting for XFS
> / SSDs so ceph is really slow / unuseable

> btrfs:
> - 3.5-rc3 ceph is pretty fast and works good until i see also a deadlock while
> doing heavy random I/Os in my rbd / kvm.
> 
> All processes hang in btrfs_commit_transaction or
> btrfs_commit_transaction_async

We haven't seen this yet.  See my other reply; a task dump may offer some 
clues.

> Are there tested / recommanded kernel versions for rbd and a specific fs.

Lockdep noise aside, we've been fine with 3.4 for btrfs and xfs so far.  
Our regression testing hardware is probably not as fast as yours, though, 
which may explain why our qa hasn't hit the same bugs.

Can you be more specific about how you're generating the rbd workload?

sage
