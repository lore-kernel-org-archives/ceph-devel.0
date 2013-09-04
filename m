From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 2/2] ceph: Implement writev/pwritev for sync operation.
Date: Wed, 04 Sep 2013 21:20:28 +0800
Message-ID: <5227339C.5010706@intel.com>
References: <201309031652122920661@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <201309031652122920661@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: majianpeng <majianpeng@gmail.com>
Cc: sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Hi,

Thank you for the patch.

On 09/03/2013 04:52 PM, majianpeng wrote:
> For writev/pwritev sync-operatoin, ceph only do the first iov.
> It don't think other iovs.Now implement this.
> I divided the write-sync-operation into two functions.One for
> direct-write,other for none-direct-sync-write.This is because for
> none-direct-sync-write we can merge iovs to one.But for direct-write,
> we can't merge iovs.
> 
> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  fs/ceph/file.c | 328 +++++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 248 insertions(+), 80 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 7d6a3ee..42c97b3 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -533,17 +533,19 @@ static void ceph_sync_write_unsafe(struct ceph_osd_request *req, bool unsafe)
>  	}
>  }
>  
> +
>  /*
> - * Synchronous write, straight from __user pointer or user pages (if
> - * O_DIRECT).
> + * Synchronous write, straight from __user pointer or user pages.
>   *
>   * If write spans object boundary, just do multiple writes.  (For a
>   * correct atomic write, we should e.g. take write locks on all
>   * objects, rollback on failure, etc.)
>   */
> -static ssize_t ceph_sync_write(struct file *file, const char __user *data,
> -			       size_t left, loff_t pos, loff_t *ppos)
> +static ssize_t
> +ceph_sync_direct_write(struct kiocb *iocb, const struct iovec *iov,
> +		       unsigned long nr_segs, size_t count)
>  {
> +	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file_inode(file);
>  	struct ceph_inode_info *ci = ceph_inode(inode);
>  	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
> @@ -557,59 +559,55 @@ static ssize_t ceph_sync_write(struct file *file, const char __user *data,
>  	int written = 0;
>  	int flags;
>  	int check_caps = 0;
> -	int page_align, io_align;
> -	unsigned long buf_align;
> -	int ret;
> +	int page_align;
> +	int ret, i;
>  	struct timespec mtime = CURRENT_TIME;
> -	bool own_pages = false;
> +	loff_t pos = iocb->ki_pos;
>  
>  	if (ceph_snap(file_inode(file)) != CEPH_NOSNAP)
>  		return -EROFS;
>  
> -	dout("sync_write on file %p %lld~%u %s\n", file, pos,
> -	     (unsigned)left, (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
> +	dout("sync_direct_write on file %p %lld~%u\n", file, pos,
> +	     (unsigned)count);
>  
> -	ret = filemap_write_and_wait_range(inode->i_mapping, pos, pos + left);
> +	ret = filemap_write_and_wait_range(inode->i_mapping, pos, pos + count);
>  	if (ret < 0)
>  		return ret;
>  
>  	ret = invalidate_inode_pages2_range(inode->i_mapping,
>  					    pos >> PAGE_CACHE_SHIFT,
> -					    (pos + left) >> PAGE_CACHE_SHIFT);
> +					    (pos + count) >> PAGE_CACHE_SHIFT);
>  	if (ret < 0)
>  		dout("invalidate_inode_pages2_range returned %d\n", ret);
>  
>  	flags = CEPH_OSD_FLAG_ORDERSNAP |
>  		CEPH_OSD_FLAG_ONDISK |
>  		CEPH_OSD_FLAG_WRITE;
> -	if ((file->f_flags & (O_SYNC|O_DIRECT)) == 0)
> -		flags |= CEPH_OSD_FLAG_ACK;
> -	else
> -		num_ops++;	/* Also include a 'startsync' command. */
> +	num_ops++;	/* Also include a 'startsync' command. */
>  
> -	/*
> -	 * we may need to do multiple writes here if we span an object
> -	 * boundary.  this isn't atomic, unfortunately.  :(
> -	 */
> -more:
> -	io_align = pos & ~PAGE_MASK;
> -	buf_align = (unsigned long)data & ~PAGE_MASK;
> -	len = left;
> +	for (i = 0; i < nr_segs && count; i++) {

POSIX requires that write syscall is atomic. I means we should allocate a single OSD request
for all buffer segments that belong to the same object.

Regards
Yan, Zheng

> +		void __user *data = iov[i].iov_base;
> +		size_t left;
>  
> -	snapc = ci->i_snap_realm->cached_context;
> -	vino = ceph_vino(inode);
> -	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
> -				    vino, pos, &len, num_ops,
> -				    CEPH_OSD_OP_WRITE, flags, snapc,
> -				    ci->i_truncate_seq, ci->i_truncate_size,
> -				    false);
> -	if (IS_ERR(req))
> -		return PTR_ERR(req);
> +		left = min(count, iov[i].iov_len);
> +more:
> +		page_align = (unsigned long)data & ~PAGE_MASK;
> +		len = left;
> +
> +		snapc = ci->i_snap_realm->cached_context;
> +		vino = ceph_vino(inode);
> +		req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
> +					    vino, pos, &len, num_ops,
> +					    CEPH_OSD_OP_WRITE, flags, snapc,
> +					    ci->i_truncate_seq,
> +					    ci->i_truncate_size,
> +					    false);
> +		if (IS_ERR(req)) {
> +			ret = PTR_ERR(req);
> +			goto out;
> +		}
>  
> -	/* write from beginning of first page, regardless of io alignment */
> -	page_align = file->f_flags & O_DIRECT ? buf_align : io_align;
> -	num_pages = calc_pages_for(page_align, len);
> -	if (file->f_flags & O_DIRECT) {
> +		num_pages = calc_pages_for(page_align, len);
>  		pages = ceph_get_direct_page_vector(data, num_pages, false);
>  		if (IS_ERR(pages)) {
>  			ret = PTR_ERR(pages);
> @@ -621,61 +619,229 @@ more:
>  		 * may block.
>  		 */
>  		truncate_inode_pages_range(inode->i_mapping, pos,
> -					   (pos+len) | (PAGE_CACHE_SIZE-1));
> -	} else {
> +				   (pos+len) | (PAGE_CACHE_SIZE-1));
> +		osd_req_op_extent_osd_data_pages(req, 0, pages, len, page_align,
> +						false, false);
> +
> +		/* BUG_ON(vino.snap != CEPH_NOSNAP); */
> +		ceph_osdc_build_request(req, pos, snapc, vino.snap, &mtime);
> +
> +		ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
> +		if (!ret)
> +			ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
> +
> +		ceph_put_page_vector(pages, num_pages, false);
> +
> +out:
> +		ceph_osdc_put_request(req);
> +		if (ret == 0) {
> +			pos += len;
> +			written += len;
> +			left -= len;
> +			count -= len;
> +			data += len;
> +			if (left)
> +				goto more;
> +
> +			ret = written;
> +			if (pos > i_size_read(inode))
> +				check_caps = ceph_inode_set_size(inode, pos);
> +				if (check_caps)
> +					ceph_check_caps(ceph_inode(inode),
> +							CHECK_CAPS_AUTHONLY,
> +							NULL);
> +		} else {
> +			if (ret != -EOLDSNAPC && written > 0)
> +				ret = written;
> +			break;
> +		}
> +	}
> +
> +	if (ret > 0)
> +		iocb->ki_pos = pos;
> +	return ret;
> +}
> +
> +
> +/*
> + * Synchronous write, straight from __user pointer or user pages.
> + *
> + * If write spans object boundary, just do multiple writes.  (For a
> + * correct atomic write, we should e.g. take write locks on all
> + * objects, rollback on failure, etc.)
> + */
> +static ssize_t ceph_sync_write(struct kiocb *iocb, const struct iovec *iov,
> +			       unsigned long nr_segs, size_t count)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct inode *inode = file_inode(file);
> +	struct ceph_inode_info *ci = ceph_inode(inode);
> +	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
> +	struct ceph_snap_context *snapc;
> +	struct ceph_vino vino;
> +	struct ceph_osd_request *req;
> +	int num_ops = 1;
> +	struct page **pages;
> +	int num_pages;
> +	u64 len;
> +	int written = 0;
> +	int flags;
> +	int check_caps = 0;
> +	int ret, i;
> +	struct timespec mtime = CURRENT_TIME;
> +	loff_t pos = iocb->ki_pos;
> +	struct iovec *iov_clone;
> +
> +	if (ceph_snap(file_inode(file)) != CEPH_NOSNAP)
> +		return -EROFS;
> +
> +	dout("sync_write on file %p %lld~%u\n", file, pos, (unsigned)count);
> +
> +	ret = filemap_write_and_wait_range(inode->i_mapping, pos, pos + count);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = invalidate_inode_pages2_range(inode->i_mapping,
> +					    pos >> PAGE_CACHE_SHIFT,
> +					    (pos + count) >> PAGE_CACHE_SHIFT);
> +	if (ret < 0)
> +		dout("invalidate_inode_pages2_range returned %d\n", ret);
> +
> +	flags = CEPH_OSD_FLAG_ORDERSNAP |
> +		CEPH_OSD_FLAG_ONDISK |
> +		CEPH_OSD_FLAG_WRITE |
> +		CEPH_OSD_FLAG_ACK;
> +
> +	iov_clone = kmalloc(nr_segs * sizeof(struct iovec), GFP_KERNEL);
> +	if (iov_clone == NULL)
> +		return -ENOMEM;
> +	memcpy(iov_clone, iov, nr_segs * sizeof(struct iovec));
> +
> +	for (i = 0; i < nr_segs && count; i++) {
> +		void __user *data;
> +		size_t left;
> +
> +		left = count;
> +more:
> +		len = left;
> +
> +		snapc = ci->i_snap_realm->cached_context;
> +		vino = ceph_vino(inode);
> +		req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
> +					    vino, pos, &len, num_ops,
> +					    CEPH_OSD_OP_WRITE, flags, snapc,
> +					    ci->i_truncate_seq,
> +					    ci->i_truncate_size,
> +					    false);
> +		if (IS_ERR(req)) {
> +			ret = PTR_ERR(req);
> +			goto out;
> +		}
> +
> +		/*
> +		 * write from beginning of first page,
> +		 * regardless of io alignment
> +		 */
> +		num_pages = (len + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
> +
>  		pages = ceph_alloc_page_vector(num_pages, GFP_NOFS);
>  		if (IS_ERR(pages)) {
>  			ret = PTR_ERR(pages);
>  			goto out;
>  		}
> -		ret = ceph_copy_user_to_page_vector(pages, data, pos, len);
> +
> +		if (len <= iov_clone[i].iov_len) {
> +			data = iov_clone[i].iov_base;
> +			ret = ceph_copy_user_to_page_vector(pages,
> +								data, 0, len);
> +			if (ret > 0) {
> +				iov_clone[i].iov_base += ret;
> +				iov_clone[i].iov_len -= ret;
> +			}
> +		} else {
> +			int j, l, k = 0, copyed = 0;
> +			size_t tmp = len;
> +
> +			for (j = i; j < nr_segs && tmp; j++) {
> +				data = iov_clone[j].iov_base;
> +				l = iov_clone[j].iov_len;
> +
> +				if (tmp < l) {
> +					ret = ceph_copy_user_to_page_vector(&pages[k],
> +									    data,
> +									    copyed,
> +									    tmp);
> +					iov_clone[j].iov_len -= ret;
> +					iov_clone[j].iov_base += ret;
> +					break;
> +				} else if (l) {
> +					ret = ceph_copy_user_to_page_vector(&pages[k],
> +									    data,
> +									    copyed,
> +									    l);
> +					if (ret < 0)
> +						break;
> +					iov_clone[j].iov_len = 0;
> +					copyed += ret;
> +					tmp -= ret;
> +					k = calc_pages_for(0, copyed + 1) - 1;
> +				}
> +			}
> +
> +			/*
> +			 * For this case,it will call for action.i will add one
> +			 * But iov_clone[j].iov_len maybe not zero.
> +			 */
> +			if (left == len)
> +				i = j - 1;
> +		}
> +
>  		if (ret < 0) {
>  			ceph_release_page_vector(pages, num_pages);
>  			goto out;
>  		}
>  
> -		if ((file->f_flags & O_SYNC) == 0) {
> -			/* get a second commit callback */
> -			req->r_unsafe_callback = ceph_sync_write_unsafe;
> -			req->r_inode = inode;
> -			own_pages = true;
> -		}
> -	}
> -	osd_req_op_extent_osd_data_pages(req, 0, pages, len, page_align,
> -					false, own_pages);
> +		/* get a second commit callback */
> +		req->r_unsafe_callback = ceph_sync_write_unsafe;
> +		req->r_inode = inode;
>  
> -	/* BUG_ON(vino.snap != CEPH_NOSNAP); */
> -	ceph_osdc_build_request(req, pos, snapc, vino.snap, &mtime);
> +		osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0,
> +						false, true);
>  
> -	ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
> -	if (!ret)
> -		ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
> +		/* BUG_ON(vino.snap != CEPH_NOSNAP); */
> +		ceph_osdc_build_request(req, pos, snapc, vino.snap, &mtime);
>  
> -	if (file->f_flags & O_DIRECT)
> -		ceph_put_page_vector(pages, num_pages, false);
> -	else if (file->f_flags & O_SYNC)
> -		ceph_release_page_vector(pages, num_pages);
> +		ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
> +		if (!ret)
> +			ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
>  
>  out:
> -	ceph_osdc_put_request(req);
> -	if (ret == 0) {
> -		pos += len;
> -		written += len;
> -		left -= len;
> -		data += len;
> -		if (left)
> -			goto more;
> -
> -		ret = written;
> -		*ppos = pos;
> -		if (pos > i_size_read(inode))
> -			check_caps = ceph_inode_set_size(inode, pos);
> -		if (check_caps)
> -			ceph_check_caps(ceph_inode(inode), CHECK_CAPS_AUTHONLY,
> -					NULL);
> -	} else if (ret != -EOLDSNAPC && written > 0) {
> -		ret = written;
> +		ceph_osdc_put_request(req);
> +		if (ret == 0) {
> +			pos += len;
> +			written += len;
> +			left -= len;
> +			count -= len;
> +			if (left)
> +				goto more;
> +
> +			ret = written;
> +			if (pos > i_size_read(inode))
> +				check_caps = ceph_inode_set_size(inode, pos);
> +				if (check_caps)
> +					ceph_check_caps(ceph_inode(inode),
> +							CHECK_CAPS_AUTHONLY,
> +							NULL);
> +		} else {
> +			if (ret != -EOLDSNAPC && written > 0)
> +				ret = written;
> +			break;
> +		}
>  	}
> +
> +	if (ret > 0)
> +		iocb->ki_pos = pos;
> +	kfree(iov_clone);
>  	return ret;
>  }
>  
> @@ -843,11 +1009,13 @@ retry_snap:
>  	     inode, ceph_vinop(inode), pos, count, ceph_cap_string(got));
>  
>  	if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) == 0 ||
> -	    (iocb->ki_filp->f_flags & O_DIRECT) ||
> -	    (fi->flags & CEPH_F_SYNC)) {
> +	    (file->f_flags & O_DIRECT) || (fi->flags & CEPH_F_SYNC)) {
>  		mutex_unlock(&inode->i_mutex);
> -		written = ceph_sync_write(file, iov->iov_base, count,
> -					  pos, &iocb->ki_pos);
> +		if (file->f_flags & O_DIRECT)
> +			written = ceph_sync_direct_write(iocb, iov,
> +							 nr_segs, count);
> +		else
> +			written = ceph_sync_write(iocb, iov, nr_segs, count);
>  		if (written == -EOLDSNAPC) {
>  			dout("aio_write %p %llx.%llx %llu~%u"
>  				"got EOLDSNAPC, retrying\n",
> 

