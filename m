From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH] ceph: do not access the kiocb after aio reqeusts
Date: Tue, 7 Jul 2020 06:55:45 +0800
Message-ID: <012e8448-bd4f-26f8-b9e2-690c80b6f01d@redhat.com>
References: <20200706125135.23511-1-xiubli@redhat.com>
 <ae2bc42cc3434f62ea99f1df32729360a27e487c.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36844 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726280AbgGFW4F (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jul 2020 18:56:05 -0400
In-Reply-To: <ae2bc42cc3434f62ea99f1df32729360a27e487c.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: idryomov@gmail.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/7/7 0:17, Jeff Layton wrote:
> On Mon, 2020-07-06 at 08:51 -0400, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> In aio case, if the completion comes very fast just before the
>> ceph_read_iter() returns to fs/aio.c, the kiocb will be freed in
>> the completion callback, then if ceph_read_iter() access again
>> we will potentially hit the use-after-free bug.
>>
>> URL: https://tracker.ceph.com/issues/45649
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/file.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index 160644ddaeed..704bae794054 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>> @@ -1538,6 +1538,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>   	struct inode *inode = file_inode(filp);
>>   	struct ceph_inode_info *ci = ceph_inode(inode);
>>   	struct page *pinned_page = NULL;
>> +	bool direct_lock = false;
> Looks good. I made a slight change to this patch and had it initialize
> this variable to iocb->ki_flags & IOCB_DIRECT, and then use that rather
> than setting direct_lock in the true case. Merged into testing.

Okay, looks good to me.

Thanks Jeff.


> Thanks!
>
>>   	ssize_t ret;
>>   	int want, got = 0;
>>   	int retry_op = 0, read = 0;
>> @@ -1546,10 +1547,12 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>   	dout("aio_read %p %llx.%llx %llu~%u trying to get caps on %p\n",
>>   	     inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len, inode);
>>   
>> -	if (iocb->ki_flags & IOCB_DIRECT)
>> +	if (iocb->ki_flags & IOCB_DIRECT) {
>>   		ceph_start_io_direct(inode);
>> -	else
>> +		direct_lock = true;
>> +	} else {
>>   		ceph_start_io_read(inode);
>> +	}
>>   
>>   	if (fi->fmode & CEPH_FILE_MODE_LAZY)
>>   		want = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
>> @@ -1603,7 +1606,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>   	}
>>   	ceph_put_cap_refs(ci, got);
>>   
>> -	if (iocb->ki_flags & IOCB_DIRECT)
>> +	if (direct_lock)
>>   		ceph_end_io_direct(inode);
>>   	else
>>   		ceph_end_io_read(inode);
