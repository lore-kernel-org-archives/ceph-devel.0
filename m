From: Sage Weil <sage@newdream.net>
Subject: Re: mds getattr locked again
Date: Thu, 4 Nov 2010 13:59:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1011041104270.15958@cobra.newdream.net>
References: <AANLkTi=R=bnsjZeq5DibVzVK__evwajLefSHuA6iJKTW@mail.gmail.com>
 <Pine.LNX.4.64.1010282151220.27485@cobra.newdream.net>
 <AANLkTinOOi4XjfnfxP8qL81sxzOTLaS4zPJYwY979J0L@mail.gmail.com>
 <Pine.LNX.4.64.1010290920220.13796@cobra.newdream.net>
 <AANLkTik25uL0B56porHb8u413nJ_kcEougHP5iWwe1Z6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40036 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab0KDUzb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Nov 2010 16:55:31 -0400
In-Reply-To: <AANLkTik25uL0B56porHb8u413nJ_kcEougHP5iWwe1Z6@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: Leander Yu <leander.yu@gmail.com>, ceph-devel@vger.kernel.org

On Tue, 2 Nov 2010, Henry C Chang wrote:
> Hi Sage,
> 
> I tested the latest unstable-backport plus
> 562d305287745e047370c49e78fd838f2a35899a reverted. However, the
> getattr still hanged (see the log file dmesg.ceph), but I think I
> found the problem (see the attached dmesg.ceph.henry).
> 
> Then, I made the following modification:
> 
> diff --git a/ceph/inode.c b/ceph/inode.c
> index 6444cac..afa0595 100644
> --- a/ceph/inode.c
> +++ b/ceph/inode.c
> @@ -1392,7 +1392,7 @@ static void ceph_invalidate_work(struct work_struct *work)
>         spin_lock(&inode->i_lock);
>         dout("invalidate_pages %p gen %d revoking %d\n", inode,
>              ci->i_rdcache_gen, ci->i_rdcache_revoking);
> -       if (ci->i_rdcache_gen == 0 ||
> +       if (inode->i_data.nrpages == 0 ||
>             ci->i_rdcache_revoking != ci->i_rdcache_gen) {
>                 BUG_ON(ci->i_rdcache_revoking > ci->i_rdcache_gen);
>                 /* nevermind! */
> 
> It seems working ok, but I don't know if this is the right way.
> Perhaps, not doing try_nonblocking_invalidate in handle_cap_grant is
> another way.

Aha, okay.  That's not the right fix, but points the way to the real 
problem.  Basically, the rdcache_gen/rdcache_revoking behavior is based on 
how things worked before we looked at i_data.nrpages.  We should never 
clear rdcache_gen (unless, perhaps, we're sure we don't hold the cap, but 
there's no point), and it being zero no longer has any special meaning.

Can you try the below patch?  I've done some light testing, but nothing 
serious yet.

Thanks-
sage




From 86e44f09d6c37de381c549526f53b67344f34602 Mon Sep 17 00:00:00 2001
From: Sage Weil <sage@newdream.net>
Date: Thu, 4 Nov 2010 11:05:05 -0700
Subject: [PATCH] ceph: fix rdcache_gen usage and invalidate

We used to use rdcache_gen to indicate whether we "might" have cached
pages.  Now we just look at the mapping to determine that.  However, some
old behavior remains from that transition.

First, rdcache_gen == 0 no longer means we have no pages.  That can happen
at any time (presumably when we carry FILE_CACHE).  We should not reset it
to zero, and we should not check that it is zero.

That means that the only purpose for rdcache_revoking is to resolve races
between new issues of FILE_CACHE and an async invalidate.  If they are
equal, we should invalidate.  On success, we decrement rdcache_revoking,
so that it is no longer equal to rdcache_gen.  Similarly, if we success
in doing a sync invalidate, set revoking = gen - 1.  (This is a small
optimization to avoid doing unnecessary invalidate work and does not
affect correctness.)

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/caps.c  |    4 ++--
 fs/ceph/inode.c |   16 +++++++---------
 fs/ceph/super.h |    4 +---
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 6e0942f..36cad99 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1430,8 +1430,8 @@ static int try_nonblocking_invalidate(struct inode *inode)
 	    invalidating_gen == ci->i_rdcache_gen) {
 		/* success. */
 		dout("try_nonblocking_invalidate %p success\n", inode);
-		ci->i_rdcache_gen = 0;
-		ci->i_rdcache_revoking = 0;
+		/* save any racing async invalidate some trouble */
+		ci->i_rdcache_revoking = ci->i_rdcache_gen - 1;
 		return 0;
 	}
 	dout("try_nonblocking_invalidate %p failed\n", inode);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 1d6a45b..1ca5226 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1386,11 +1386,8 @@ static void ceph_invalidate_work(struct work_struct *work)
 	spin_lock(&inode->i_lock);
 	dout("invalidate_pages %p gen %d revoking %d\n", inode,
 	     ci->i_rdcache_gen, ci->i_rdcache_revoking);
-	if (ci->i_rdcache_gen == 0 ||
-	    ci->i_rdcache_revoking != ci->i_rdcache_gen) {
-		BUG_ON(ci->i_rdcache_revoking > ci->i_rdcache_gen);
+	if (ci->i_rdcache_revoking != ci->i_rdcache_gen) {
 		/* nevermind! */
-		ci->i_rdcache_revoking = 0;
 		spin_unlock(&inode->i_lock);
 		goto out;
 	}
@@ -1400,15 +1397,16 @@ static void ceph_invalidate_work(struct work_struct *work)
 	ceph_invalidate_nondirty_pages(inode->i_mapping);
 
 	spin_lock(&inode->i_lock);
-	if (orig_gen == ci->i_rdcache_gen) {
+	if (orig_gen == ci->i_rdcache_gen &&
+	    orig_gen == ci->i_rdcache_revoking) {
 		dout("invalidate_pages %p gen %d successful\n", inode,
 		     ci->i_rdcache_gen);
-		ci->i_rdcache_gen = 0;
-		ci->i_rdcache_revoking = 0;
+		ci->i_rdcache_revoking--;
 		check = 1;
 	} else {
-		dout("invalidate_pages %p gen %d raced, gen now %d\n",
-		     inode, orig_gen, ci->i_rdcache_gen);
+		dout("invalidate_pages %p gen %d raced, now %d revoking %d\n",
+		     inode, orig_gen, ci->i_rdcache_gen,
+		     ci->i_rdcache_revoking);
 	}
 	spin_unlock(&inode->i_lock);
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 1886294..7f01728 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -293,9 +293,7 @@ struct ceph_inode_info {
 	int i_rd_ref, i_rdcache_ref, i_wr_ref;
 	int i_wrbuffer_ref, i_wrbuffer_ref_head;
 	u32 i_shared_gen;       /* increment each time we get FILE_SHARED */
-	u32 i_rdcache_gen;      /* we increment this each time we get
-				   FILE_CACHE.  If it's non-zero, we
-				   _may_ have cached pages. */
+	u32 i_rdcache_gen;      /* incremented each time we get FILE_CACHE. */
 	u32 i_rdcache_revoking; /* RDCACHE gen to async invalidate, if any */
 
 	struct list_head i_unsafe_writes; /* uncommitted sync writes */
-- 
1.7.0

