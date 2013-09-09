From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH V2 1/2] ceph: Implement readv/preadv for sync operation.
Date: Mon, 09 Sep 2013 16:05:26 +0800
Message-ID: <522D8146.2050103@intel.com>
References: <201309061648229668212@gmail.com>,  <522A783B.3070306@intel.com> <201309091009084849062@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53597 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848Ab3IIIFz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 Sep 2013 04:05:55 -0400
In-Reply-To: <201309091009084849062@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On 09/09/2013 10:09 AM, majianpeng wrote:
>> On 09/06/2013 04:48 PM, majianpeng wrote:
>>> For readv/preadv sync-operatoin, ceph only do the first iov.
>>> It don't think other iovs.Now implement this.
>>>
>>> V2:
>>>   -add generic_segment_checks
>>>   -using struct iov_iter replace cloning the iovs.
>>>   -return previous successfully copied if ceph_copy_page_vector_to_user
>>>    met error.
>>>
>>> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
>>> ---
>>>  fs/ceph/file.c | 174 ++++++++++++++++++++++++++++++++++++++++-----------------
>>>  1 file changed, 123 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> index 3de8982..1c28c52 100644
>>> --- a/fs/ceph/file.c
>>> +++ b/fs/ceph/file.c
>>> @@ -408,51 +408,109 @@ more:
>>>   *
>>>   * If the read spans object boundary, just do multiple reads.
>>>   */
>>> -static ssize_t ceph_sync_read(struct file *file, char __user *data,
>>> -			      unsigned len, loff_t *poff, int *checkeof)
>>> +static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *i,
>>> +				int *checkeof)
>>>  {
>>> +	struct file *file = iocb->ki_filp;
>>>  	struct inode *inode = file_inode(file);
>>>  	struct page **pages;
>>> -	u64 off = *poff;
>>> -	int num_pages, ret;
>>> +	u64 off = iocb->ki_pos;
>>> +	int num_pages, ret, n;
>>>  
>>> -	dout("sync_read on file %p %llu~%u %s\n", file, off, len,
>>> +	dout("sync_read on file %p %llu~%u %s\n", file, off,
>>> +	     (unsigned)iocb->ki_left,
>>>  	     (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
>>> -
>>> -	if (file->f_flags & O_DIRECT) {
>>> -		num_pages = calc_pages_for((unsigned long)data, len);
>>> -		pages = ceph_get_direct_page_vector(data, num_pages, true);
>>> -	} else {
>>> -		num_pages = calc_pages_for(off, len);
>>> -		pages = ceph_alloc_page_vector(num_pages, GFP_NOFS);
>>> -	}
>>> -	if (IS_ERR(pages))
>>> -		return PTR_ERR(pages);
>>> -
>>>  	/*
>>>  	 * flush any page cache pages in this range.  this
>>>  	 * will make concurrent normal and sync io slow,
>>>  	 * but it will at least behave sensibly when they are
>>>  	 * in sequence.
>>>  	 */
>>> -	ret = filemap_write_and_wait(inode->i_mapping);
>>> +	ret = filemap_write_and_wait_range(inode->i_mapping, off,
>>> +						off + iocb->ki_left);
>>>  	if (ret < 0)
>>> -		goto done;
>>> +		return ret;
>>>  
>>> -	ret = striped_read(inode, off, len, pages, num_pages, checkeof,
>>> -			   file->f_flags & O_DIRECT,
>>> -			   (unsigned long)data & ~PAGE_MASK);
>>> +	if (file->f_flags & O_DIRECT) {
>>> +		for (n = 0; n < i->nr_segs; n++) {
>>> +			void __user *data = i->iov[n].iov_base;
>>> +			size_t len = i->iov[n].iov_len;
>>> +
>>> +			if (n == 0) {
>>> +				len -=  i->iov_offset;
>>> +				data += i->iov_offset;
>>> +			}
>>> +
>>> +			num_pages = calc_pages_for((unsigned long)data, len);
>>> +			pages = ceph_get_direct_page_vector(data,
>>> +							    num_pages, true);
>>> +			if (IS_ERR(pages))
>>> +				return PTR_ERR(pages);
>>> +
>>> +			ret = striped_read(inode, off, len,
>>> +					   pages, num_pages, checkeof,
>>> +					   1, (unsigned long)data & ~PAGE_MASK);
>>> +			ceph_put_page_vector(pages, num_pages, true);
>>> +
>>> +			if (ret <= 0)
>>> +				break;
>>> +			off += ret;
>>> +			if (ret < len)
>>> +				break;
>>> +		}
>>>  
>>> -	if (ret >= 0 && (file->f_flags & O_DIRECT) == 0)
>>> -		ret = ceph_copy_page_vector_to_user(pages, data, off, ret);
>>> -	if (ret >= 0)
>>> -		*poff = off + ret;
>>> +		if (off > iocb->ki_pos) {
>>> +			ret = off - iocb->ki_pos;
>>> +			iocb->ki_pos = off;
>>> +			iocb->ki_left -= ret;
>>> +		}
>>> +	} else {
>>> +		size_t len = iocb->ki_left;
>>>  
>>> -done:
>>> -	if (file->f_flags & O_DIRECT)
>>> -		ceph_put_page_vector(pages, num_pages, true);
>>> -	else
>>> +		num_pages = calc_pages_for(off, len);
>>> +		pages = ceph_alloc_page_vector(num_pages, GFP_NOFS);
>>> +		if (IS_ERR(pages))
>>> +			return PTR_ERR(pages);
>>> +		ret = striped_read(inode, off, len, pages,
>>> +					num_pages, checkeof, 0, 0);
>>> +		len = ret;
>>> +		if (len) {
>>> +			int l, k = 0;
>>> +			size_t left = len;
>>> +
>>> +			for (n = 0; n < i->nr_segs && left; n++) {
>>> +				void __user *data = i->iov[n].iov_base;
>>> +				l = min(left, i->iov[n].iov_len);
>>> +
>>> +				if (n == 0) {
>>> +					data += i->iov_offset;
>>> +					l = min(i->iov[0].iov_len - i->iov_offset,
>>> +						left);
>>> +				}
>>> +
>>> +				ret = ceph_copy_page_vector_to_user(&pages[k],
>>> +								    data, off,
>>> +								    l);
>>> +				if (ret > 0) {
>>> +					left -= ret;
>>> +					off += ret;
>>> +					k = calc_pages_for(iocb->ki_pos,
>>> +							   len - left + 1) - 1;
>>> +					BUG_ON(k >= num_pages && left);
>>> +				} else
>>> +					break;
>>> +			}
>>
>> I think it's better to call iov_iter_advance() here instead of in ceph_aio_read(),
>> and change the code to something like:
>> ----
>> while (iov_iter_count(&i) && left > 0) {
>>   void __user *data = i->iov->iov_base + i->iov_offset;
>>   l = min(left, i->iov->iov_len - i->iov_offset);
>>
>>   ret = ceph_copy_page_vector_to_user(&pages[k], data, off, l);
>>   if (ret > 0) {
>>     iov_iter_advance(&i, ret);
>>     left -= ret;
>>     off += ret;
>>     k = calc_pages_for(iocb->ki_pos, len - left + 1) - 1;
>>     BUG_ON(k >= num_pages && left);
>>   } else
>>     break;
>> }
>>
>>
>> rest change looks good.
>>
>> Regards
>> Yan, Zheng
>>
> Thanks!
> Jianpeng Ma
> 
> 
> Subject:ceph: Implement readv/preadv for sync operation.
> 
> For readv/preadv sync-operatoin, ceph only do the first iov.
> It don't think other iovs.Now implement this.
> 
> V2:
>   -add generic_segment_checks
>   -using struct iov_iter replace cloning the iovs.
>   -return previous successfully copied if ceph_copy_page_vector_to_user
>    met error.
> 
> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  fs/ceph/file.c | 171 ++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 120 insertions(+), 51 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 3de8982..78018c9 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -408,51 +408,106 @@ more:
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
> -	int num_pages, ret;
> +	u64 off = iocb->ki_pos;
> +	int num_pages, ret, n;
>  
> -	dout("sync_read on file %p %llu~%u %s\n", file, off, len,
> +	dout("sync_read on file %p %llu~%u %s\n", file, off,
> +	     (unsigned)iocb->ki_left,
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
> +						off + iocb->ki_left);
>  	if (ret < 0)
> -		goto done;
> +		return ret;
>  
> -	ret = striped_read(inode, off, len, pages, num_pages, checkeof,
> -			   file->f_flags & O_DIRECT,
> -			   (unsigned long)data & ~PAGE_MASK);
> +	if (file->f_flags & O_DIRECT) {
> +		for (n = 0; n < i->nr_segs; n++) {
> +			void __user *data = i->iov[n].iov_base;
> +			size_t len = i->iov[n].iov_len;
> +
> +			if (n == 0) {
> +				len -=  i->iov_offset;
> +				data += i->iov_offset;
> +			}
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
> +			if (ret < len)
> +				break;
> +		}
>  
> -	if (ret >= 0 && (file->f_flags & O_DIRECT) == 0)
> -		ret = ceph_copy_page_vector_to_user(pages, data, off, ret);
> -	if (ret >= 0)
> -		*poff = off + ret;
> +		if (off > iocb->ki_pos) {
> +			ret = off - iocb->ki_pos;
> +			iocb->ki_pos = off;
> +			iocb->ki_left -= ret;
> +		}
> +	} else {
> +		size_t len = iocb->ki_left;
>  
> -done:
> -	if (file->f_flags & O_DIRECT)
> -		ceph_put_page_vector(pages, num_pages, true);
> -	else
> +		num_pages = calc_pages_for(off, len);
> +		pages = ceph_alloc_page_vector(num_pages, GFP_NOFS);
> +		if (IS_ERR(pages))
> +			return PTR_ERR(pages);
> +		ret = striped_read(inode, off, len, pages,
> +					num_pages, checkeof, 0, 0);
> +		len = ret;
> +		if (len) {
> +			int l, k = 0;
> +			size_t left = len;
> +
> +			while (left) {
> +				void __user *data = i->iov[0].iov_base
> +							+ i->iov_offset;
> +				l = min(i->iov[0].iov_len - i->iov_offset,
> +					len);
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
> +
> +			len -= left;
> +			if (len > 0) {
> +				iocb->ki_pos += len;
> +				iocb->ki_left -= len;
> +				ret = len;
> +			}
> +		}
>  		ceph_release_page_vector(pages, num_pages);
> +	}
> +
>  	dout("sync_read result %d\n", ret);
>  	return ret;
>  }
> @@ -647,55 +702,69 @@ static ssize_t ceph_aio_read(struct kiocb *iocb, const struct iovec *iov,
>  {
>  	struct file *filp = iocb->ki_filp;
>  	struct ceph_file_info *fi = filp->private_data;
> -	loff_t *ppos = &iocb->ki_pos;
> -	size_t len = iov->iov_len;
> +	size_t len = 0;
>  	struct inode *inode = file_inode(filp);
>  	struct ceph_inode_info *ci = ceph_inode(inode);
> -	void __user *base = iov->iov_base;
>  	ssize_t ret;
>  	int want, got = 0;
>  	int checkeof = 0, read = 0;
>  
> +
>  	dout("aio_read %p %llx.%llx %llu~%u trying to get caps on %p\n",
>  	     inode, ceph_vinop(inode), pos, (unsigned)len, inode);
> -again:
> +
> +	ret = generic_segment_checks(iov, &nr_segs, &len, VERIFY_WRITE);
> +	if (ret)
> +		return ret;
> +
>  	if (fi->fmode & CEPH_FILE_MODE_LAZY)
>  		want = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
>  	else
>  		want = CEPH_CAP_FILE_CACHE;
>  	ret = ceph_get_caps(ci, CEPH_CAP_FILE_RD, want, &got, -1);
>  	if (ret < 0)
> -		goto out;
> +		return ret;
> +
>  	dout("aio_read %p %llx.%llx %llu~%u got cap refs on %s\n",
>  	     inode, ceph_vinop(inode), pos, (unsigned)len,
>  	     ceph_cap_string(got));
>  
>  	if ((got & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) == 0 ||
>  	    (iocb->ki_filp->f_flags & O_DIRECT) ||
> -	    (fi->flags & CEPH_F_SYNC))
> +	    (fi->flags & CEPH_F_SYNC)) {
> +		struct iov_iter i;
> +
> +		iocb->ki_left = len;
> +		iov_iter_init(&i, iov, nr_segs, len, 0);
> +again:
>  		/* hmm, this isn't really async... */
> -		ret = ceph_sync_read(filp, base, len, ppos, &checkeof);
> -	else
> +		ret = ceph_sync_read(iocb, &i, &checkeof);
> +
> +		if (checkeof && ret >= 0) {
> +			int statret = ceph_do_getattr(inode,
> +						      CEPH_STAT_CAP_SIZE);
> +
> +			/* hit EOF or hole? */
> +			if (statret == 0 && iocb->ki_pos < inode->i_size &&
> +				iocb->ki_left) {
> +				dout("sync_read hit hole, ppos %lld < size %lld"
> +				     ", reading more\n", iocb->ki_pos,
> +				     inode->i_size);
> +
> +				read += ret;
> +				iov_iter_advance(&i, ret);

I think this "iov_iter_advance" is superfluous. Other than this, your patch looks
good.

By the way, your email is base64 encoded. please make your email client use plain text instead.

Regards
Yan, Zheng



> +				checkeof = 0;
> +				goto again;
> +			}
> +		}
> +
> +	} else
>  		ret = generic_file_aio_read(iocb, iov, nr_segs, pos);
>  
> -out:
>  	dout("aio_read %p %llx.%llx dropping cap refs on %s = %d\n",
>  	     inode, ceph_vinop(inode), ceph_cap_string(got), (int)ret);
>  	ceph_put_cap_refs(ci, got);
>  
> -	if (checkeof && ret >= 0) {
> -		int statret = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE);
> -
> -		/* hit EOF or hole? */
> -		if (statret == 0 && *ppos < inode->i_size) {
> -			dout("aio_read sync_read hit hole, ppos %lld < size %lld, reading more\n", *ppos, inode->i_size);
> -			read += ret;
> -			base += ret;
> -			len -= ret;
> -			checkeof = 0;
> -			goto again;
> -		}
> -	}
>  	if (ret >= 0)
>  		ret += read;
>  
> 

