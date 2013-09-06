From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 2/2] ceph: Implement writev/pwritev for sync operation.
Date: Fri, 06 Sep 2013 09:09:33 +0800
Message-ID: <52292B4D.2000708@intel.com>
References: <201309031652122920661@gmail.com>,  <5227339C.5010706@intel.com> <201309060846283230053@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57706 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753484Ab3IFBJf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 5 Sep 2013 21:09:35 -0400
In-Reply-To: <201309060846283230053@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On 09/06/2013 08:46 AM, majianpeng wrote:
>> Hi,
>>
>> Thank you for the patch.
>>
>> On 09/03/2013 04:52 PM, majianpeng wrote:
>>> For writev/pwritev sync-operatoin, ceph only do the first iov.
>>> It don't think other iovs.Now implement this.
>>> I divided the write-sync-operation into two functions.One for
>>> direct-write,other for none-direct-sync-write.This is because for
>>> none-direct-sync-write we can merge iovs to one.But for direct-write,
>>> we can't merge iovs.
>>>
>>> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
>>> ---
>>>  fs/ceph/file.c | 328 +++++++++++++++++++++++++++++++++++++++++++--------------
>>>  1 file changed, 248 insertions(+), 80 deletions(-)
>>>
>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> index 7d6a3ee..42c97b3 100644
>>> --- a/fs/ceph/file.c
>>> +++ b/fs/ceph/file.c
>>> @@ -533,17 +533,19 @@ static void ceph_sync_write_unsafe(struct ceph_osd_request *req, bool unsafe)
>>>  	}
>>>  }
>>>  
>>> +
>>>  /*
>>> - * Synchronous write, straight from __user pointer or user pages (if
>>> - * O_DIRECT).
>>> + * Synchronous write, straight from __user pointer or user pages.
>>>   *
>>>   * If write spans object boundary, just do multiple writes.  (For a
>>>   * correct atomic write, we should e.g. take write locks on all
>>>   * objects, rollback on failure, etc.)
>>>   */
>>> -static ssize_t ceph_sync_write(struct file *file, const char __user *data,
>>> -			       size_t left, loff_t pos, loff_t *ppos)
>>> +static ssize_t
>>> +ceph_sync_direct_write(struct kiocb *iocb, const struct iovec *iov,
>>> +		       unsigned long nr_segs, size_t count)
>>>  {
>>> +	struct file *file = iocb->ki_filp;
>>>  	struct inode *inode = file_inode(file);
>>>  	struct ceph_inode_info *ci = ceph_inode(inode);
>>>  	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
>>> @@ -557,59 +559,55 @@ static ssize_t ceph_sync_write(struct file *file, const char __user *data,
>>>  	int written = 0;
>>>  	int flags;
>>>  	int check_caps = 0;
>>> -	int page_align, io_align;
>>> -	unsigned long buf_align;
>>> -	int ret;
>>> +	int page_align;
>>> +	int ret, i;
>>>  	struct timespec mtime = CURRENT_TIME;
>>> -	bool own_pages = false;
>>> +	loff_t pos = iocb->ki_pos;
>>>  
>>>  	if (ceph_snap(file_inode(file)) != CEPH_NOSNAP)
>>>  		return -EROFS;
>>>  
>>> -	dout("sync_write on file %p %lld~%u %s\n", file, pos,
>>> -	     (unsigned)left, (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
>>> +	dout("sync_direct_write on file %p %lld~%u\n", file, pos,
>>> +	     (unsigned)count);
>>>  
>>> -	ret = filemap_write_and_wait_range(inode->i_mapping, pos, pos + left);
>>> +	ret = filemap_write_and_wait_range(inode->i_mapping, pos, pos + count);
>>>  	if (ret < 0)
>>>  		return ret;
>>>  
>>>  	ret = invalidate_inode_pages2_range(inode->i_mapping,
>>>  					    pos >> PAGE_CACHE_SHIFT,
>>> -					    (pos + left) >> PAGE_CACHE_SHIFT);
>>> +					    (pos + count) >> PAGE_CACHE_SHIFT);
>>>  	if (ret < 0)
>>>  		dout("invalidate_inode_pages2_range returned %d\n", ret);
>>>  
>>>  	flags = CEPH_OSD_FLAG_ORDERSNAP |
>>>  		CEPH_OSD_FLAG_ONDISK |
>>>  		CEPH_OSD_FLAG_WRITE;
>>> -	if ((file->f_flags & (O_SYNC|O_DIRECT)) == 0)
>>> -		flags |= CEPH_OSD_FLAG_ACK;
>>> -	else
>>> -		num_ops++;	/* Also include a 'startsync' command. */
>>> +	num_ops++;	/* Also include a 'startsync' command. */
>>>  
>>> -	/*
>>> -	 * we may need to do multiple writes here if we span an object
>>> -	 * boundary.  this isn't atomic, unfortunately.  :(
>>> -	 */
>>> -more:
>>> -	io_align = pos & ~PAGE_MASK;
>>> -	buf_align = (unsigned long)data & ~PAGE_MASK;
>>> -	len = left;
>>> +	for (i = 0; i < nr_segs && count; i++) {
>>
>> POSIX requires that write syscall is atomic. I means we should allocate a single OSD request
>> for all buffer segments that belong to the same object.
>>
> I think we could not.
> For direct write, we use ceph_get_direct_page_vector to get pages.
> Given iov1 and iov2 are in the same object. But we can't make the pages of iov1/2 to join together.
> Because for ceph page_vector,it only record the offset of first page.
> 
> Or am i missing something?
> Maybe we can use ceph pagelist but it will copy data.
> 

I'm wrong with the direct IO case (ext4 doesn't guarantee atomicity in direct write). But please keep
buffered write atomic.

Regards
Yan, Zheng

