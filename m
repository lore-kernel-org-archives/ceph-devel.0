From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH TRIVIVAL] ceph: Move the place for EOLDSNAPC handle in
 ceph_aio_write to easily understand
Date: Thu, 8 Aug 2013 09:40:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308080940000.18359@cobra.newdream.net>
References: <201308081532168498411@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53906 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757988Ab3HHQkk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Aug 2013 12:40:40 -0400
In-Reply-To: <201308081532168498411@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Looks good; I've applied this to the tree.  Canyou review the below patch 
while we are looking at this code?

Thanks!
sage

From 26d0d7b213d87db0ef46e885ae749c27395c11b1 Mon Sep 17 00:00:00 2001
From: Sage Weil <sage@inktank.com>
Date: Thu, 8 Aug 2013 09:39:44 -0700
Subject: [PATCH] ceph: replace hold_mutex flag with goto

All of the early exit paths need to drop the mutex; it is only the normal
path through the function that does not.  Skip the unlock in that case
with a goto out_unlocked.

Signed-off-by: Sage Weil <sage@inktank.com>
---
 fs/ceph/file.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 7478d5d..a17ffe4 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -710,13 +710,11 @@ static ssize_t ceph_aio_write(struct kiocb *iocb, const struct iovec *iov,
 		&ceph_sb_to_client(inode->i_sb)->client->osdc;
 	ssize_t count, written = 0;
 	int err, want, got;
-	bool hold_mutex;
 
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return -EROFS;
 
 	mutex_lock(&inode->i_mutex);
-	hold_mutex = true;
 
 	err = generic_segment_checks(iov, &nr_segs, &count, VERIFY_READ);
 	if (err)
@@ -772,7 +770,6 @@ retry_snap:
 				inode, ceph_vinop(inode),
 				pos, (unsigned)iov->iov_len);
 			mutex_lock(&inode->i_mutex);
-			hold_mutex = true;
 			goto retry_snap;
 		}
 	} else {
@@ -781,7 +778,6 @@ retry_snap:
 						      count, 0);
 		mutex_unlock(&inode->i_mutex);
 	}
-	hold_mutex = false;
 
 	if (written >= 0) {
 		int dirty;
@@ -805,11 +801,12 @@ retry_snap:
 			written = err;
 	}
 
+	goto out_unlocked;
+
 out:
-	if (hold_mutex)
-		mutex_unlock(&inode->i_mutex);
+	mutex_unlock(&inode->i_mutex);
+out_unlocked:
 	current->backing_dev_info = NULL;
-
 	return written ? written : err;
 }
 
-- 
1.8.1.2




On Thu, 8 Aug 2013, majianpeng wrote:

> Only for ceph_sync_write, the osd can return EOLDSNAPC.so move the
> related codes after the call ceph_sync_write.
> 
> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  fs/ceph/file.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 2ddf061..30e959f 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -768,6 +768,15 @@ retry_snap:
>  		mutex_unlock(&inode->i_mutex);
>  		written = ceph_sync_write(file, iov->iov_base, count,
>  					  pos, &iocb->ki_pos);
> +		if (written == -EOLDSNAPC) {
> +			dout("aio_write %p %llx.%llx %llu~%u"
> +				"got EOLDSNAPC, retrying\n",
> +				inode, ceph_vinop(inode),
> +				pos, (unsigned)iov->iov_len);
> +			mutex_lock(&inode->i_mutex);
> +			hold_mutex = true;
> +			goto retry_snap;
> +		}
>  	} else {
>  		written = generic_file_buffered_write(iocb, iov, nr_segs,
>  						      pos, &iocb->ki_pos,
> @@ -797,14 +806,7 @@ retry_snap:
>  		if (err < 0)
>  			written = err;
>  	}
> -
> -	if (written == -EOLDSNAPC) {
> -		dout("aio_write %p %llx.%llx %llu~%u got EOLDSNAPC, retrying\n",
> -		     inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len);
> -		mutex_lock(&inode->i_mutex);
> -		hold_mutex = true;
> -		goto retry_snap;
> -	}
> +
>  out:
>  	if (hold_mutex)
>  		mutex_unlock(&inode->i_mutex);
> -- 
> 1.8.3.rc1.44.gb387c77
> 
