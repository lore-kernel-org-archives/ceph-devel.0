From: Sage Weil <sage@inktank.com>
Subject: Re: [RESEND PATCH V6] ceph:Implement readv/preadv for sync
 operation
Date: Tue, 24 Sep 2013 21:34:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309242134010.21904@cobra.newdream.net>
References: <201309250906595293650@gmail.com>, <5242556E.7090102@intel.com> <201309251123462217227@gmail.com> <5242632A.6020501@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51016 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab3IYEef (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Sep 2013 00:34:35 -0400
In-Reply-To: <5242632A.6020501@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

Applied this to the testing branch. 

Thanks, everyone!
sage

On Wed, 25 Sep 2013, Yan, Zheng wrote:

> On 09/25/2013 11:23 AM, majianpeng wrote:
> >> On 09/25/2013 09:07 AM, majianpeng wrote:
> >>> For readv/preadv sync-operatoin, ceph only do the first iov.
> >>> It don't think other iovs.Now implement this.
> >>>
> >>> V6:
> >>>    Fix some bugs;
> >>> V5:
> >>>   -before getattr,it must put caps which already holded avoid deadlock.
> >>>   -only do generic_segment_checks for sync-read avoid do again in func
> >>>    generic_file_aio_read
> >>> V4:
> >>>   -modify one bug.
> >>> V3:
> >>>   -modify some bugs.
> >>> V2:
> >>>   -add generic_segment_checks
> >>>   -using struct iov_iter replace cloning the iovs.
> >>>   -return previous successfully copied if ceph_copy_page_vector_to_user
> >>>    met error.
> >>>
> >>> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> >>> ---
> >>>  fs/ceph/file.c | 164 +++++++++++++++++++++++++++++++++++++++++----------------
> >>>  1 file changed, 118 insertions(+), 46 deletions(-)
> >>>
> >>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> >>> index 3de8982..b64aa33 100644
> >>> --- a/fs/ceph/file.c
> >>> +++ b/fs/ceph/file.c
> >>> @@ -408,51 +408,94 @@ more:
> >>>   *
> >>>   * If the read spans object boundary, just do multiple reads.
> >>>   */
> >>> -static ssize_t ceph_sync_read(struct file *file, char __user *data,
> >>> -			      unsigned len, loff_t *poff, int *checkeof)
> >>> +static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *i,
> >>> +				int *checkeof)
> >>>  {
> >>> +	struct file *file = iocb->ki_filp;
> >>>  	struct inode *inode = file_inode(file);
> >>>  	struct page **pages;
> >>> -	u64 off = *poff;
> >>> +	u64 off = iocb->ki_pos;
> >>>  	int num_pages, ret;
> >>>  
> >>> -	dout("sync_read on file %p %llu~%u %s\n", file, off, len,
> >>> +	dout("sync_read on file %p %llu~%u %s\n", file, off,
> >>> +	     (unsigned)iocb->ki_left,
> >>>  	     (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
> >>> -
> >>> -	if (file->f_flags & O_DIRECT) {
> >>> -		num_pages = calc_pages_for((unsigned long)data, len);
> >>> -		pages = ceph_get_direct_page_vector(data, num_pages, true);
> >>> -	} else {
> >>> -		num_pages = calc_pages_for(off, len);
> >>> -		pages = ceph_alloc_page_vector(num_pages, GFP_NOFS);
> >>> -	}
> >>> -	if (IS_ERR(pages))
> >>> -		return PTR_ERR(pages);
> >>> -
> >>>  	/*
> >>>  	 * flush any page cache pages in this range.  this
> >>>  	 * will make concurrent normal and sync io slow,
> >>>  	 * but it will at least behave sensibly when they are
> >>>  	 * in sequence.
> >>>  	 */
> >>> -	ret = filemap_write_and_wait(inode->i_mapping);
> >>> +	ret = filemap_write_and_wait_range(inode->i_mapping, off,
> >>> +						off + iocb->ki_left);
> >>>  	if (ret < 0)
> >>> -		goto done;
> >>> -
> >>> -	ret = striped_read(inode, off, len, pages, num_pages, checkeof,
> >>> -			   file->f_flags & O_DIRECT,
> >>> -			   (unsigned long)data & ~PAGE_MASK);
> >>> +		return ret;
> >>>  
> >>> -	if (ret >= 0 && (file->f_flags & O_DIRECT) == 0)
> >>> -		ret = ceph_copy_page_vector_to_user(pages, data, off, ret);
> >>> -	if (ret >= 0)
> >>> -		*poff = off + ret;
> >>> +	if (file->f_flags & O_DIRECT) {
> >>> +		while (iov_iter_count(i)) {
> >>> +			void __user *data = i->iov[0].iov_base + i->iov_offset;
> >>> +			size_t len = i->iov[0].iov_len - i->iov_offset;
> >>> +
> >>> +			num_pages = calc_pages_for((unsigned long)data, len);
> >>> +			pages = ceph_get_direct_page_vector(data,
> >>> +							    num_pages, true);
> >>> +			if (IS_ERR(pages))
> >>> +				return PTR_ERR(pages);
> >>> +
> >>> +			ret = striped_read(inode, off, len,
> >>> +					   pages, num_pages, checkeof,
> >>> +					   1, (unsigned long)data & ~PAGE_MASK);
> >>> +			ceph_put_page_vector(pages, num_pages, true);
> >>> +
> >>> +			if (ret <= 0)
> >>> +				break;
> >>> +			off += ret;
> >>> +			iov_iter_advance(i, ret);
> >>> +			if (ret < len)
> >>> +				break;
> >>> +		}
> >>> +	} else {
> >>> +		size_t len = iocb->ki_left;
> >>>  
> >>> -done:
> >>> -	if (file->f_flags & O_DIRECT)
> >>> -		ceph_put_page_vector(pages, num_pages, true);
> >>> -	else
> >>> +		num_pages = calc_pages_for(off, len);
> >>> +		pages = ceph_alloc_page_vector(num_pages, GFP_NOFS);
> >>> +		if (IS_ERR(pages))
> >>> +			return PTR_ERR(pages);
> >>> +		ret = striped_read(inode, off, len, pages,
> >>> +					num_pages, checkeof, 0, 0);
> >>> +		if (ret > 0) {
> >>> +			int l, k = 0;
> >>> +			size_t left = len = ret;
> >>> +
> >>> +			while (left) {
> >>> +				void __user *data = i->iov[0].iov_base
> >>> +							+ i->iov_offset;
> >>> +				l = min(i->iov[0].iov_len - i->iov_offset,
> >>> +					left);
> >>> +
> >>> +				ret = ceph_copy_page_vector_to_user(&pages[k],
> >>> +								    data, off,
> >>> +								    l);
> >>> +				if (ret > 0) {
> >>> +					iov_iter_advance(i, ret);
> >>> +					left -= ret;
> >>> +					off += ret;
> >>> +					k = calc_pages_for(iocb->ki_pos,
> >>> +							   len - left + 1) - 1;
> >>> +					BUG_ON(k >= num_pages && left);
> >>> +				} else
> >>> +					break;
> >>> +			}
> >>> +		}
> >>>  		ceph_release_page_vector(pages, num_pages);
> >>> +	}
> >>> +
> >>> +	if (off > iocb->ki_pos) {
> >>> +		ret = off - iocb->ki_pos;
> >>> +		iocb->ki_pos = off;
> >>> +		iocb->ki_left -= ret;
> >>> +	}
> >>> +
> >>>  	dout("sync_read result %d\n", ret);
> >>>  	return ret;
> >>>  }
> >>> @@ -647,55 +690,84 @@ static ssize_t ceph_aio_read(struct kiocb *iocb, const struct iovec *iov,
> >>>  {
> >>>  	struct file *filp = iocb->ki_filp;
> >>>  	struct ceph_file_info *fi = filp->private_data;
> >>> -	loff_t *ppos = &iocb->ki_pos;
> >>> -	size_t len = iov->iov_len;
> >>> +	size_t len = iocb->ki_nbytes;
> >>>  	struct inode *inode = file_inode(filp);
> >>>  	struct ceph_inode_info *ci = ceph_inode(inode);
> >>> -	void __user *base = iov->iov_base;
> >>>  	ssize_t ret;
> >>>  	int want, got = 0;
> >>>  	int checkeof = 0, read = 0;
> >>>  
> >>> +again:
> >>>  	dout("aio_read %p %llx.%llx %llu~%u trying to get caps on %p\n",
> >>> -	     inode, ceph_vinop(inode), pos, (unsigned)len, inode);
> >>> -again:
> >>> +	     inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len, inode);
> >>> +
> >>>  	if (fi->fmode & CEPH_FILE_MODE_LAZY)
> >>>  		want = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
> >>>  	else
> >>>  		want = CEPH_CAP_FILE_CACHE;
> >>>  	ret = ceph_get_caps(ci, CEPH_CAP_FILE_RD, want, &got, -1);
> >>>  	if (ret < 0)
> >>> -		goto out;
> >>> -	dout("aio_read %p %llx.%llx %llu~%u got cap refs on %s\n",
> >>> -	     inode, ceph_vinop(inode), pos, (unsigned)len,
> >>> -	     ceph_cap_string(got));
> >>> +		return ret;
> >>>  
> >>>  	if ((got & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) == 0 ||
> >>>  	    (iocb->ki_filp->f_flags & O_DIRECT) ||
> >>> -	    (fi->flags & CEPH_F_SYNC))
> >>> +	    (fi->flags & CEPH_F_SYNC)) {
> >>> +		struct iov_iter i;
> >>> +
> >>> +		dout("aio_sync_read %p %llx.%llx %llu~%u got cap refs on %s\n",
> >>> +		     inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len,
> >>> +		     ceph_cap_string(got));
> >>> +
> >>> +		if (!read) {
> >>> +			ret = generic_segment_checks(iov, &nr_segs,
> >>> +							&len, VERIFY_WRITE);
> >>> +			if (ret)
> >>> +				goto out;
> >>> +		}
> >>> +
> >>> +		iocb->ki_left = len;
> >>> +		iov_iter_init(&i, iov, nr_segs, len, read);
> >>> +
> >>>  		/* hmm, this isn't really async... */
> >>> -		ret = ceph_sync_read(filp, base, len, ppos, &checkeof);
> >>> -	else
> >>> -		ret = generic_file_aio_read(iocb, iov, nr_segs, pos);
> >>> +		ret = ceph_sync_read(iocb, &i, &checkeof);
> >>> +	} else {
> >>> +		/*
> >>> +		 * We can't modify the content of iov,
> >>> +		 * so we only read from beginning.
> >>> +		 */
> >>> +		if (read) {
> >>> +			iocb->ki_pos = pos;
> >>> +			read = 0;
> >>> +		}
> >>> +		dout("aio_read %p %llx.%llx %llu~%u got cap refs on %s\n",
> >>> +		     inode, ceph_vinop(inode), pos, (unsigned)iocb->ki_nbytes,
> >>> +		     ceph_cap_string(got));
> >>>  
> >>> +		ret = generic_file_aio_read(iocb, iov, nr_segs, pos);
> >>> +	}
> >>>  out:
> >>>  	dout("aio_read %p %llx.%llx dropping cap refs on %s = %d\n",
> >>>  	     inode, ceph_vinop(inode), ceph_cap_string(got), (int)ret);
> >>>  	ceph_put_cap_refs(ci, got);
> >>>  
> >>>  	if (checkeof && ret >= 0) {
> >>> -		int statret = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE);
> >>> +		int statret = ceph_do_getattr(inode,
> >>> +					      CEPH_STAT_CAP_SIZE);
> >>>  
> >>>  		/* hit EOF or hole? */
> >>> -		if (statret == 0 && *ppos < inode->i_size) {
> >>> -			dout("aio_read sync_read hit hole, ppos %lld < size %lld, reading more\n", *ppos, inode->i_size);
> >>> +		if (statret == 0 && iocb->ki_pos < inode->i_size &&
> >>> +			iocb->ki_left) {
> >>
> >> ki_left is used here, but ki_nbytes is used when initializing the variable 'len'. Did you test your patch?
> >> ceph-client is based on 3.11 kernel, so please don't use ki_nbytes in your patch.
> >>
> > Before commit 73a7075e3f6ec63dc359064,In do_sync_read:
> >> kiocb.ki_left = len;
> >> kiocb.ki_nbytes = len;
> > 
> > In commit 73a7075e3f6ec63dc359064, it remove "kiocb.ki_left = len;"
> > 
> > In this patch, i used iocb->ki_left because i set the value "iocb->ki_left = len;"
> > So i think used ki_nbytes is ok.
> > 
> > Am i missing something?
> 
> Sorry, I misread you patch.
> 
> Reviewed-by: Yan, Zheng <zheng.z.yan@intel.com>
> 
> > 
> > 
> > 
> > 
> > Thanks!
> > Jianpeng Ma
> > 
> 
> 
