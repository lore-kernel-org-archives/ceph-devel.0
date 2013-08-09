From: Sage Weil <sage@inktank.com>
Subject: Re: Re: [PATCH TRIVIVAL] ceph: Move the place for EOLDSNAPC handle
 in ceph_aio_write to easily understand
Date: Thu, 8 Aug 2013 21:08:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308082106440.1479@cobra.newdream.net>
References: <201308081532168498411@gmail.com>,  <alpine.DEB.2.00.1308080940000.18359@cobra.newdream.net> <201308091025474608831@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59760 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690Ab3HIEIi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Aug 2013 00:08:38 -0400
In-Reply-To: <201308091025474608831@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 9 Aug 2013, majianpeng wrote:
> >Looks good; I've applied this to the tree.  Canyou review the below patch 
> >while we are looking at this code?
> >
> >Thanks!
> >sage
> >
> >From 26d0d7b213d87db0ef46e885ae749c27395c11b1 Mon Sep 17 00:00:00 2001
> >From: Sage Weil <sage@inktank.com>
> >Date: Thu, 8 Aug 2013 09:39:44 -0700
> >Subject: [PATCH] ceph: replace hold_mutex flag with goto
> >
> >All of the early exit paths need to drop the mutex; it is only the normal
> >path through the function that does not.  Skip the unlock in that case
> >with a goto out_unlocked.
> >
> >Signed-off-by: Sage Weil <sage@inktank.com>
> >---
> > fs/ceph/file.c | 11 ++++-------
> > 1 file changed, 4 insertions(+), 7 deletions(-)
> >
> >diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> >index 7478d5d..a17ffe4 100644
> >--- a/fs/ceph/file.c
> >+++ b/fs/ceph/file.c
> >@@ -710,13 +710,11 @@ static ssize_t ceph_aio_write(struct kiocb *iocb, const struct iovec *iov,
> > 		&ceph_sb_to_client(inode->i_sb)->client->osdc;
> > 	ssize_t count, written = 0;
> > 	int err, want, got;
> >-	bool hold_mutex;
> > 
> > 	if (ceph_snap(inode) != CEPH_NOSNAP)
> > 		return -EROFS;
> > 
> > 	mutex_lock(&inode->i_mutex);
> >-	hold_mutex = true;
> > 
> > 	err = generic_segment_checks(iov, &nr_segs, &count, VERIFY_READ);
> > 	if (err)
> >@@ -772,7 +770,6 @@ retry_snap:
> > 				inode, ceph_vinop(inode),
> > 				pos, (unsigned)iov->iov_len);
> > 			mutex_lock(&inode->i_mutex);
> >-			hold_mutex = true;
> > 			goto retry_snap;
> > 		}
> > 	} else {
> >@@ -781,7 +778,6 @@ retry_snap:
> > 						      count, 0);
> > 		mutex_unlock(&inode->i_mutex);
> > 	}
> >-	hold_mutex = false;
> > 
> > 	if (written >= 0) {
> > 		int dirty;
> >@@ -805,11 +801,12 @@ retry_snap:
> > 			written = err;
> > 	}
> > 
> >+	goto out_unlocked;
> >+
> > out:
> >-	if (hold_mutex)
> >-		mutex_unlock(&inode->i_mutex);
> >+	mutex_unlock(&inode->i_mutex);
> >+out_unlocked:
> > 	current->backing_dev_info = NULL;
> >-
> > 	return written ? written : err;
> > }
> > 
> >-- 
> >1.8.1.2
> >
> Hi sage,
> 	It's ok.

Thanks for reviewing!

> 	BTW, i had a question about EOLDSNAPC.Now for a sync-write,if it met EOLDSNAPC, it will retry.
> The rewrite is for all bio.Supported a sync-write crossed multi stripe.
> Q1:Is there a chance that for some stripe-write it din't met EOLDSNAPC,the later met?

Yes.  The writes that cross object boundaries aren't atomic in that sense.

> Q2:If Q1 occured, can we only rewrite the stripe which met EOLDSNAPCE?

Right.  This would mean the write might be 'torn', with half of it in the 
snapshot and half after.  It's not strictly posix, and hard to make atomic 
without adding a lot of complexity and slowing things down.  So far we've 
decided it's not worth it.

sage
