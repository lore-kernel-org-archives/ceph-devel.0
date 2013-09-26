From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [RESEND PATCH V7] ceph:Implement readv/preadv for sync operation
Date: Thu, 26 Sep 2013 15:19:11 +0800
Message-ID: <5243DFEF.9040409@intel.com>
References: <201309261442153908722@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59060 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755483Ab3IZHTN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Sep 2013 03:19:13 -0400
In-Reply-To: <201309261442153908722@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>

On 09/26/2013 02:42 PM, majianpeng wrote:
> For readv/preadv sync-operatoin, ceph only do the first iov.
> It don't think other iovs.Now implement this.
> 
> V7:
>    Because commit 73a7075e3f6ec63dc remove the ki_left of struct iocb.
>    So rewrite this patch. Test on v3.12-rc2, it looks good.
> V6:
>    Fix some bugs;
> V5:
>   -before getattr,it must put caps which already holded avoid deadlock.
>   -only do generic_segment_checks for sync-read avoid do again in func
>    generic_file_aio_read
> V4:
>   -modify one bug.
> V3:
>   -modify some bugs.
> V2:
>   -add generic_segment_checks
>   -using struct iov_iter replace cloning the iovs.
>   -return previous successfully copied if ceph_copy_page_vector_to_user
>    met error.
> 
> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  fs/ceph/file.c | 162 +++++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 116 insertions(+), 46 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 3de8982..c945621 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -408,51 +408,92 @@ more:
>   *
>   * If the read spans object boundary, just do multiple reads.
>   */
> -static ssize_t ceph_sync_read(struct file *file, char __user *data,
> -			      unsigned len, loff_t *poff, int *checkeof)
> +static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *i,
> +				int *checkeof)
>  {
> +	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file_inode(file);
>  	struct page **pages;
> -	u64 off = *poff;
> +	u64 off = iocb->ki_pos;
>  	int num_pages, ret;
> +	size_t len = i->count;
>  
> -	dout("sync_read on file %p %llu~%u %s\n", file, off, len,
> +	dout("sync_read on file %p %llu~%u %s\n", file, off,
> +	     (unsigned)len,
>  	     (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
> -
> -	if (file->f_flags & O_DIRECT) {
> -		num_pages = calc_pages_for((unsigned long)data, len);
> -		pages = ceph_get_direct_page_vector(data, num_pages, true);
> -	} else {
> -		num_pages = calc_pages_for(off, len);
> -		pages = ceph_alloc_page_vector(num_pages, GFP_NOFS);
> -	}
> -	if (IS_ERR(pages))
> -		return PTR_ERR(pages);
> -
>  	/*
>  	 * flush any page cache pages in this range.  this
>  	 * will make concurrent normal and sync io slow,
>  	 * but it will at least behave sensibly when they are
>  	 * in sequence.
>  	 */
> -	ret = filemap_write_and_wait(inode->i_mapping);
> +	ret = filemap_write_and_wait_range(inode->i_mapping, off,
> +						off + len);
>  	if (ret < 0)
> -		goto done;
> +		return ret;
>  
> -	ret = striped_read(inode, off, len, pages, num_pages, checkeof,
> -			   file->f_flags & O_DIRECT,
> -			   (unsigned long)data & ~PAGE_MASK);
> +	if (file->f_flags & O_DIRECT) {
> +		while (iov_iter_count(i)) {
> +			void __user *data = i->iov[0].iov_base + i->iov_offset;
> +			size_t len = i->iov[0].iov_len - i->iov_offset;
> +
> +			num_pages = calc_pages_for((unsigned long)data, len);
> +			pages = ceph_get_direct_page_vector(data,
> +							    num_pages, true);
> +			if (IS_ERR(pages))
> +				return PTR_ERR(pages);
> +
> +			ret = striped_read(inode, off, len,
> +					   pages, num_pages, checkeof,
> +					   1, (unsigned long)data & ~PAGE_MASK);
> +			ceph_put_page_vector(pages, num_pages, true);
> +
> +			if (ret <= 0)
> +				break;
> +			off += ret;
> +			iov_iter_advance(i, ret);
> +			if (ret < len)
> +				break;
> +		}
> +	} else {
> +		num_pages = calc_pages_for(off, len);
> +		pages = ceph_alloc_page_vector(num_pages, GFP_NOFS);
> +		if (IS_ERR(pages))
> +			return PTR_ERR(pages);
> +		ret = striped_read(inode, off, len, pages,
> +					num_pages, checkeof, 0, 0);
> +		if (ret > 0) {
> +			int l, k = 0;
> +			size_t left = len = ret;
> +
> +			while (left) {
> +				void __user *data = i->iov[0].iov_base
> +							+ i->iov_offset;
> +				l = min(i->iov[0].iov_len - i->iov_offset,
> +					left);
> +
> +				ret = ceph_copy_page_vector_to_user(&pages[k],
> +								    data, off,
> +								    l);
> +				if (ret > 0) {
> +					iov_iter_advance(i, ret);
> +					left -= ret;
> +					off += ret;
> +					k = calc_pages_for(iocb->ki_pos,
> +							   len - left + 1) - 1;
> +					BUG_ON(k >= num_pages && left);
> +				} else
> +					break;
> +			}
> +		}
> +		ceph_release_page_vector(pages, num_pages);
> +	}
>  
> -	if (ret >= 0 && (file->f_flags & O_DIRECT) == 0)
> -		ret = ceph_copy_page_vector_to_user(pages, data, off, ret);
> -	if (ret >= 0)
> -		*poff = off + ret;
> +	if (off > iocb->ki_pos) {
> +		ret = off - iocb->ki_pos;
> +		iocb->ki_pos = off;
> +	}
>  
> -done:
> -	if (file->f_flags & O_DIRECT)
> -		ceph_put_page_vector(pages, num_pages, true);
> -	else
> -		ceph_release_page_vector(pages, num_pages);
>  	dout("sync_read result %d\n", ret);
>  	return ret;
>  }
> @@ -647,55 +688,84 @@ static ssize_t ceph_aio_read(struct kiocb *iocb, const struct iovec *iov,
>  {
>  	struct file *filp = iocb->ki_filp;
>  	struct ceph_file_info *fi = filp->private_data;
> -	loff_t *ppos = &iocb->ki_pos;
> -	size_t len = iov->iov_len;
> +	size_t len = iocb->ki_nbytes;
>  	struct inode *inode = file_inode(filp);
>  	struct ceph_inode_info *ci = ceph_inode(inode);
> -	void __user *base = iov->iov_base;
>  	ssize_t ret;
>  	int want, got = 0;
>  	int checkeof = 0, read = 0;
>  
> +again:
>  	dout("aio_read %p %llx.%llx %llu~%u trying to get caps on %p\n",
> -	     inode, ceph_vinop(inode), pos, (unsigned)len, inode);
> -again:
> +	     inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len, inode);
> +
>  	if (fi->fmode & CEPH_FILE_MODE_LAZY)
>  		want = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
>  	else
>  		want = CEPH_CAP_FILE_CACHE;
>  	ret = ceph_get_caps(ci, CEPH_CAP_FILE_RD, want, &got, -1);
>  	if (ret < 0)
> -		goto out;
> -	dout("aio_read %p %llx.%llx %llu~%u got cap refs on %s\n",
> -	     inode, ceph_vinop(inode), pos, (unsigned)len,
> -	     ceph_cap_string(got));
> +		return ret;
>  
>  	if ((got & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) == 0 ||
>  	    (iocb->ki_filp->f_flags & O_DIRECT) ||
> -	    (fi->flags & CEPH_F_SYNC))
> +	    (fi->flags & CEPH_F_SYNC)) {
> +		struct iov_iter i;
> +
> +		dout("aio_sync_read %p %llx.%llx %llu~%u got cap refs on %s\n",
> +		     inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len,
> +		     ceph_cap_string(got));
> +
> +		if (!read) {
> +			ret = generic_segment_checks(iov, &nr_segs,
> +							&len, VERIFY_WRITE);
> +			if (ret)
> +				goto out;
> +		}
> +
> +		iov_iter_init(&i, iov, nr_segs, len, read);
> +
>  		/* hmm, this isn't really async... */
> -		ret = ceph_sync_read(filp, base, len, ppos, &checkeof);
> -	else
> -		ret = generic_file_aio_read(iocb, iov, nr_segs, pos);
> +		ret = ceph_sync_read(iocb, &i, &checkeof);
> +	} else {
> +		/*
> +		 * We can't modify the content of iov,
> +		 * so we only read from beginning.
> +		 */
> +		if (read) {
> +			iocb->ki_pos = pos;
> +			len = iocb->ki_nbytes;
> +			read = 0;
> +		}
> +		dout("aio_read %p %llx.%llx %llu~%u got cap refs on %s\n",
> +		     inode, ceph_vinop(inode), pos, (unsigned)len,
> +		     ceph_cap_string(got));
>  
> +		ret = generic_file_aio_read(iocb, iov, nr_segs, pos);
> +	}
>  out:
>  	dout("aio_read %p %llx.%llx dropping cap refs on %s = %d\n",
>  	     inode, ceph_vinop(inode), ceph_cap_string(got), (int)ret);
>  	ceph_put_cap_refs(ci, got);
>  
>  	if (checkeof && ret >= 0) {
> -		int statret = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE);
> +		int statret = ceph_do_getattr(inode,
> +					      CEPH_STAT_CAP_SIZE);
>  
>  		/* hit EOF or hole? */
> -		if (statret == 0 && *ppos < inode->i_size) {
> -			dout("aio_read sync_read hit hole, ppos %lld < size %lld, reading more\n", *ppos, inode->i_size);
> +		if (statret == 0 && iocb->ki_pos < inode->i_size &&
> +			ret < len) {
> +			dout("sync_read hit hole, ppos %lld < size %lld"
> +			     ", reading more\n", iocb->ki_pos,
> +			     inode->i_size);
> +
>  			read += ret;
> -			base += ret;
>  			len -= ret;
>  			checkeof = 0;
>  			goto again;
>  		}
>  	}
> +
>  	if (ret >= 0)
>  		ret += read;
>  
> 

