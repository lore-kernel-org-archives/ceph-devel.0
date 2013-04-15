From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 4/4] ceph: apply write checks in ceph_aio_write
Date: Mon, 15 Apr 2013 11:15:27 -0500
Message-ID: <516C279F.4080005@inktank.com>
References: <1365754273-14088-1-git-send-email-zheng.z.yan@intel.com> <1365754273-14088-6-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:55827 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab3DOQPb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 12:15:31 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so5686304iec.28
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 09:15:30 -0700 (PDT)
In-Reply-To: <1365754273-14088-6-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com

On 04/12/2013 03:11 AM, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> copy write checks in __generic_file_aio_write to ceph_aio_write.
> To make these checks cover sync write path.

This one is important, and it looks good to me.  This is another
one I'd like another opinion on though.

Extra semicolon at the very end, but I can clean that up
before committing.

Reviewed-by: Alex Elder <elder@inktank.com>



> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/file.c | 94 ++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 59 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 5490598..b034c3a 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -470,7 +470,7 @@ static void sync_write_commit(struct ceph_osd_request *req,
>   * objects, rollback on failure, etc.)
>   */
>  static ssize_t ceph_sync_write(struct file *file, const char __user *data,
> -			       size_t left, loff_t *offset)
> +			       size_t left, loff_t pos, loff_t *ppos)
>  {
>  	struct inode *inode = file->f_dentry->d_inode;
>  	struct ceph_inode_info *ci = ceph_inode(inode);
> @@ -481,7 +481,6 @@ static ssize_t ceph_sync_write(struct file *file, const char __user *data,
>  	int num_ops = 1;
>  	struct page **pages;
>  	int num_pages;
> -	long long unsigned pos;
>  	u64 len;
>  	int written = 0;
>  	int flags;
> @@ -495,14 +494,9 @@ static ssize_t ceph_sync_write(struct file *file, const char __user *data,
>  	if (ceph_snap(file->f_dentry->d_inode) != CEPH_NOSNAP)
>  		return -EROFS;
>  
> -	dout("sync_write on file %p %lld~%u %s\n", file, *offset,
> +	dout("sync_write on file %p %lld~%u %s\n", file, pos,
>  	     (unsigned)left, (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
>  
> -	if (file->f_flags & O_APPEND)
> -		pos = i_size_read(inode);
> -	else
> -		pos = *offset;
> -
>  	ret = filemap_write_and_wait_range(inode->i_mapping, pos, pos + left);
>  	if (ret < 0)
>  		return ret;
> @@ -613,7 +607,7 @@ out:
>  			goto more;
>  
>  		ret = written;
> -		*offset = pos;
> +		*ppos = pos;
>  		if (pos > i_size_read(inode))
>  			check_caps = ceph_inode_set_size(inode, pos);
>  		if (check_caps)
> @@ -710,51 +704,75 @@ static ssize_t ceph_aio_write(struct kiocb *iocb, const struct iovec *iov,
>  	struct ceph_inode_info *ci = ceph_inode(inode);
>  	struct ceph_osd_client *osdc =
>  		&ceph_sb_to_client(inode->i_sb)->client->osdc;
> -	loff_t endoff = pos + iov->iov_len;
> -	int want, got = 0;
> -	int ret, err;
> +	ssize_t count, written = 0;
> +	int err, want, got;
> +	bool hold_mutex;
>  
>  	if (ceph_snap(inode) != CEPH_NOSNAP)
>  		return -EROFS;
>  
>  	sb_start_write(inode->i_sb);
> +	mutex_lock(&inode->i_mutex);
> +	hold_mutex = true;
> +
> +	err = generic_segment_checks(iov, &nr_segs, &count, VERIFY_READ);
> +	if (err)
> +		goto out;
> +
> +	/* We can write back this queue in page reclaim */
> +	current->backing_dev_info = file->f_mapping->backing_dev_info;
> +
> +	err = generic_write_checks(file, &pos, &count, S_ISBLK(inode->i_mode));
> +	if (err)
> +		goto out;
> +
> +	if (count == 0)
> +		goto out;
> +
> +	err = file_remove_suid(file);
> +	if (err)
> +		goto out;
> +
> +	err = file_update_time(file);
> +	if (err)
> +		goto out;
> +
>  retry_snap:
>  	if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL)) {
> -		ret = -ENOSPC;
> +		err = -ENOSPC;
>  		goto out;
>  	}
> -	mutex_lock(&inode->i_mutex);
> -	dout("aio_write %p %llx.%llx %llu~%u getting caps. i_size %llu\n",
> -	     inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
> -	     inode->i_size);
> +
> +	dout("aio_write %p %llx.%llx %llu~%ld getting caps. i_size %llu\n",
> +	     inode, ceph_vinop(inode), pos, count, inode->i_size);
>  	if (fi->fmode & CEPH_FILE_MODE_LAZY)
>  		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
>  	else
>  		want = CEPH_CAP_FILE_BUFFER;
> -	ret = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, &got, endoff);
> -	if (ret < 0) {
> -		mutex_unlock(&inode->i_mutex);
> +	got = 0;
> +	err = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, &got, pos + count);
> +	if (err < 0)
>  		goto out;
> -	}
>  
> -	dout("aio_write %p %llx.%llx %llu~%u  got cap refs on %s\n",
> -	     inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
> -	     ceph_cap_string(got));
> +	dout("aio_write %p %llx.%llx %llu~%ld got cap refs on %s\n",
> +	     inode, ceph_vinop(inode), pos, count, ceph_cap_string(got));
>  
>  	if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) == 0 ||
>  	    (iocb->ki_filp->f_flags & O_DIRECT) ||
>  	    (inode->i_sb->s_flags & MS_SYNCHRONOUS) ||
>  	    (fi->flags & CEPH_F_SYNC)) {
>  		mutex_unlock(&inode->i_mutex);
> -		ret = ceph_sync_write(file, iov->iov_base, iov->iov_len,
> -			&iocb->ki_pos);
> +		written = ceph_sync_write(file, iov->iov_base, count,
> +					  pos, &iocb->ki_pos);
>  	} else {
> -		ret = __generic_file_aio_write(iocb, iov, nr_segs,
> -					       &iocb->ki_pos);
> +		written = generic_file_buffered_write(iocb, iov, nr_segs,
> +						      pos, &iocb->ki_pos,
> +						      count, 0);
>  		mutex_unlock(&inode->i_mutex);
>  	}
> +	hold_mutex = false;
>  
> -	if (ret >= 0) {
> +	if (written >= 0) {
>  		int dirty;
>  		spin_lock(&ci->i_ceph_lock);
>  		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR);
> @@ -768,22 +786,28 @@ retry_snap:
>  	     ceph_cap_string(got));
>  	ceph_put_cap_refs(ci, got);
>  
> -	if (ret >= 0 &&
> +	if (written >= 0 &&
>  	    ((file->f_flags & O_SYNC) || IS_SYNC(file->f_mapping->host) ||
>  	     ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_NEARFULL))) {
> -		err = vfs_fsync_range(file, pos, pos + ret - 1, 1);
> +		err = vfs_fsync_range(file, pos, pos + written - 1, 1);
>  		if (err < 0)
> -			ret = err;
> +			written = err;
>  	}
> -out:
> -	if (ret == -EOLDSNAPC) {
> +
> +	if (written == -EOLDSNAPC) {
>  		dout("aio_write %p %llx.%llx %llu~%u got EOLDSNAPC, retrying\n",
>  		     inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len);
> +		mutex_lock(&inode->i_mutex);
> +		hold_mutex = true;
>  		goto retry_snap;
>  	}
> +out:
> +	if (hold_mutex)
> +		mutex_unlock(&inode->i_mutex);
>  	sb_end_write(inode->i_sb);
> +	current->backing_dev_info = NULL;
>  
> -	return ret;
> +	return written ? written : err;;
>  }
>  
>  /*
> 

