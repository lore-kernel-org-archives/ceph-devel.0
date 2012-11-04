From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH V2 2/2] ceph: Fix i_size update race
Date: Sun, 4 Nov 2012 03:29:46 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211040122420.26143@cobra.newdream.net>
References: <1351905581-14374-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41864 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab2KDL3r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 06:29:47 -0500
In-Reply-To: <1351905581-14374-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Hi Yan,

On Sat, 3 Nov 2012, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> ceph_aio_write() has an optimization that marks cap EPH_CAP_FILE_WR
> dirty before data is copied to page cache and inode size is updated.
> If sceph_check_caps() flushes the dirty cap before the inode size is
> updated, MDS can miss the new inode size. The fix is move
> ceph_{get,put}_cap_refs() into ceph_write_{begin,end}() and call
> __ceph_mark_dirty_caps() after inode size is updated.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>

Hmm, I'm a little worried at the get/put caps sequence inside of 
write_begin/end since that happens on every page... do you think it's 
something to worry about?

The Fw revocation kludge was something we hit in practice.  It looks like 
balance_dirty_pages*() happens outside of the write_begin/_end calls in 
generic_perform_write(), so that's a win.

Comments below:

> ---
> Changes since v1
>  - Fix a cap leak when ceph_write_begin fail to get page
> 
>  fs/ceph/addr.c | 51 +++++++++++++++++++++++++++++++++++++++----
>  fs/ceph/file.c | 69 +++++++++++++++++++++++-----------------------------------
>  2 files changed, 74 insertions(+), 46 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 22b6e45..21a0718 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1078,23 +1078,51 @@ static int ceph_write_begin(struct file *file, struct address_space *mapping,
>  			    struct page **pagep, void **fsdata)
>  {
>  	struct inode *inode = file->f_dentry->d_inode;
> +	struct ceph_inode_info *ci = ceph_inode(inode);
> +	struct ceph_file_info *fi = file->private_data;
>  	struct page *page;
>  	pgoff_t index = pos >> PAGE_CACHE_SHIFT;
> -	int r;
> +	int r, want, got = 0;
> +
> +	if (fi->fmode & CEPH_FILE_MODE_LAZY)
> +		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
> +	else
> +		want = CEPH_CAP_FILE_BUFFER;
> +
> +	dout("write_begin %p %llx.%llx %llu~%u getting caps. i_size %llu\n",
> +	     inode, ceph_vinop(inode), pos, len, inode->i_size);
> +	r = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, &got, pos+len);
> +	if (r < 0)
> +		return r;
> +	dout("write_begin %p %llx.%llx %llu~%u  got cap refs on %s\n",
> +	     inode, ceph_vinop(inode), pos, len, ceph_cap_string(got));
> +	if (!(got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO))) {
> +		ceph_put_cap_refs(ci, got);
> +		return -EAGAIN;
> +	}
>  
>  	do {
>  		/* get a page */
>  		page = grab_cache_page_write_begin(mapping, index, 0);
> -		if (!page)
> -			return -ENOMEM;
> -		*pagep = page;
> +		if (!page) {
> +			r = -ENOMEM;
> +			break;
> +		}
>  
>  		dout("write_begin file %p inode %p page %p %d~%d\n", file,
>  		     inode, page, (int)pos, (int)len);
>  
>  		r = ceph_update_writeable_page(file, pos, len, page);
> +		if (r)
> +			page_cache_release(page);
>  	} while (r == -EAGAIN);
>  
> +	if (r) {
> +		ceph_put_cap_refs(ci, got);
> +	} else {
> +		*pagep = page;
> +		*(int *)fsdata = got;
> +	}
>  	return r;
>  }
>  
> @@ -1108,10 +1136,12 @@ static int ceph_write_end(struct file *file, struct address_space *mapping,
>  			  struct page *page, void *fsdata)
>  {
>  	struct inode *inode = file->f_dentry->d_inode;
> +	struct ceph_inode_info *ci = ceph_inode(inode);
>  	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
>  	struct ceph_mds_client *mdsc = fsc->mdsc;
>  	unsigned from = pos & (PAGE_CACHE_SIZE - 1);
>  	int check_cap = 0;
> +	int got = (unsigned long)fsdata;
>  
>  	dout("write_end file %p inode %p page %p %d~%d (%d)\n", file,
>  	     inode, page, (int)pos, (int)copied, (int)len);
> @@ -1134,6 +1164,19 @@ static int ceph_write_end(struct file *file, struct address_space *mapping,
>  	up_read(&mdsc->snap_rwsem);
>  	page_cache_release(page);
>  
> +	if (copied > 0) {
> +		int dirty;
> +		spin_lock(&ci->i_ceph_lock);
> +		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR);
> +		spin_unlock(&ci->i_ceph_lock);
> +		if (dirty)
> +			__mark_inode_dirty(inode, dirty);
> +	}
> +
> +	dout("write_end %p %llx.%llx %llu~%u  dropping cap refs on %s\n",
> +	     inode, ceph_vinop(inode), pos, len, ceph_cap_string(got));
> +	ceph_put_cap_refs(ci, got);
> +
>  	if (check_cap)
>  		ceph_check_caps(ceph_inode(inode), CHECK_CAPS_AUTHONLY, NULL);
>  
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 5840d2a..266f6e0 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -712,63 +712,49 @@ static ssize_t ceph_aio_write(struct kiocb *iocb, const struct iovec *iov,
>  	struct ceph_osd_client *osdc =
>  		&ceph_sb_to_client(inode->i_sb)->client->osdc;
>  	loff_t endoff = pos + iov->iov_len;
> -	int want, got = 0;
> -	int ret, err;
> +	int got = 0;
> +	int ret, err, written;
>  
>  	if (ceph_snap(inode) != CEPH_NOSNAP)
>  		return -EROFS;
>  
>  retry_snap:
> +	written = 0;
>  	if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL))
>  		return -ENOSPC;
>  	__ceph_do_pending_vmtruncate(inode);
> -	dout("aio_write %p %llx.%llx %llu~%u getting caps. i_size %llu\n",
> -	     inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
> -	     inode->i_size);
> -	if (fi->fmode & CEPH_FILE_MODE_LAZY)
> -		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
> -	else
> -		want = CEPH_CAP_FILE_BUFFER;
> -	ret = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, &got, endoff);
> -	if (ret < 0)
> -		goto out_put;
> -
> -	dout("aio_write %p %llx.%llx %llu~%u  got cap refs on %s\n",
> -	     inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
> -	     ceph_cap_string(got));
> -
> -	if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) == 0 ||

This check seems to have been dropped... I think we want

> -	    (iocb->ki_filp->f_flags & O_DIRECT) ||
> -	    (inode->i_sb->s_flags & MS_SYNCHRONOUS) ||
> -	    (fi->flags & CEPH_F_SYNC)) {
> -		ret = ceph_sync_write(file, iov->iov_base, iov->iov_len,
> -			&iocb->ki_pos);
> -	} else {
> -		/*
> -		 * buffered write; drop Fw early to avoid slow
> -		 * revocation if we get stuck on balance_dirty_pages
> -		 */
> -		int dirty;
> -
> -		spin_lock(&ci->i_ceph_lock);
> -		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR);
> -		spin_unlock(&ci->i_ceph_lock);
> -		ceph_put_cap_refs(ci, got);
>  
> +	if (!(iocb->ki_filp->f_flags & O_DIRECT) &&
> +	    !(inode->i_sb->s_flags & MS_SYNCHRONOUS) &&
> +	    !(fi->flags & CEPH_F_SYNC)) {
>  		ret = generic_file_aio_write(iocb, iov, nr_segs, pos);
> +		if (ret >= 0)
> +			written = ret;
> +
>  		if ((ret >= 0 || ret == -EIOCBQUEUED) &&
>  		    ((file->f_flags & O_SYNC) || IS_SYNC(file->f_mapping->host)
>  		     || ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_NEARFULL))) {
> -			err = vfs_fsync_range(file, pos, pos + ret - 1, 1);
> +			err = vfs_fsync_range(file, pos, pos + written - 1, 1);
>  			if (err < 0)
>  				ret = err;
>  		}
> -
> -		if (dirty)
> -			__mark_inode_dirty(inode, dirty);
> -		goto out;
> +		if ((ret < 0 && ret != -EAGAIN) || pos + written >= endoff)
> +			goto out;

This check makes me nervous.  The *only* time we want to jump to the sync 
path is when we get -EAGAIN, right?  I'd rather see that branch explicitly 
taken immediately after generic_file_aio_write().  I'm not sure when we'd 
do a short write in generic_file_aio_write(), but I'm pretty sure we don't 
want to fall back to a sync write in that case...

>  	}
>  
> +	dout("aio_write %p %llx.%llx %llu~%u getting caps. i_size %llu\n",
> +	     inode, ceph_vinop(inode), pos + written,
> +	     (unsigned)iov->iov_len - written, inode->i_size);
> +	ret = ceph_get_caps(ci, CEPH_CAP_FILE_WR, 0, &got, endoff);
> +	if (ret < 0)
> +		goto out_put;

We don't want to put if the get failed.

An incremental patch is below.

> +
> +	dout("aio_write %p %llx.%llx %llu~%u  got cap refs on %s\n",
> +	     inode, ceph_vinop(inode), pos + written,
> +	     (unsigned)iov->iov_len - written, ceph_cap_string(got));
> +
> +	ret = ceph_sync_write(file, iov->iov_base + written,
> +			      iov->iov_len - written, &iocb->ki_pos);
>  	if (ret >= 0) {
>  		int dirty;
>  		spin_lock(&ci->i_ceph_lock);
> @@ -780,10 +766,9 @@ retry_snap:
>  
>  out_put:
>  	dout("aio_write %p %llx.%llx %llu~%u  dropping cap refs on %s\n",
> -	     inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
> -	     ceph_cap_string(got));
> +	     inode, ceph_vinop(inode), pos + written,
> +	     (unsigned)iov->iov_len - written, ceph_cap_string(got));
>  	ceph_put_cap_refs(ci, got);
> -
>  out:
>  	if (ret == -EOLDSNAPC) {
>  		dout("aio_write %p %llx.%llx %llu~%u got EOLDSNAPC, retrying\n",
> -- 
> 1.7.11.7

How does the below look to you?

There are a few test programs in ceph.git/qa/workunits/direct_io that try 
to verify the O_DIRECT and sync io paths work.  Have you tested those?  
I'll queue this up on our qa cluster shortly.

Thanks!
sage


diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 266f6e0..2a94102 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -724,10 +724,16 @@ retry_snap:
 		return -ENOSPC;
 	__ceph_do_pending_vmtruncate(inode);
 
+	/*
+	 * try to do a buffered write.  if we don't have sufficient
+	 * caps, we'll get -EAGAIN from generic_file_aio_write.
+	 */
 	if (!(iocb->ki_filp->f_flags & O_DIRECT) &&
 	    !(inode->i_sb->s_flags & MS_SYNCHRONOUS) &&
 	    !(fi->flags & CEPH_F_SYNC)) {
 		ret = generic_file_aio_write(iocb, iov, nr_segs, pos);
+		if (ret == -EAGAIN)
+			goto sync_write;
 		if (ret >= 0)
 			written = ret;
 
@@ -738,16 +744,16 @@ retry_snap:
 			if (err < 0)
 				ret = err;
 		}
-		if ((ret < 0 && ret != -EAGAIN) || pos + written >= endoff)
-			goto out;
+		goto out;
 	}
 
+sync_write:
 	dout("aio_write %p %llx.%llx %llu~%u getting caps. i_size %llu\n",
 	     inode, ceph_vinop(inode), pos + written,
 	     (unsigned)iov->iov_len - written, inode->i_size);
 	ret = ceph_get_caps(ci, CEPH_CAP_FILE_WR, 0, &got, endoff);
 	if (ret < 0)
-		goto out_put;
+		goto out;
 
 	dout("aio_write %p %llx.%llx %llu~%u  got cap refs on %s\n",
 	     inode, ceph_vinop(inode), pos + written,
@@ -763,8 +769,6 @@ retry_snap:
 		if (dirty)
 			__mark_inode_dirty(inode, dirty);
 	}
-
-out_put:
 	dout("aio_write %p %llx.%llx %llu~%u  dropping cap refs on %s\n",
 	     inode, ceph_vinop(inode), pos + written,
 	     (unsigned)iov->iov_len - written, ceph_cap_string(got));
