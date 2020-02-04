From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [RFC PATCH v2] ceph: do not execute direct write in parallel if
 O_APPEND is specified
Date: Tue, 4 Feb 2020 22:44:32 +0800
Message-ID: <915bbfd1-2e63-48c6-e43a-2af76c29aad1@redhat.com>
References: <20200204022825.26538-1-xiubli@redhat.com>
 <fd6b6bf9247cbdc1be03637196d54feacce0d72c.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28028 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727258AbgBDOos (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Feb 2020 09:44:48 -0500
In-Reply-To: <fd6b6bf9247cbdc1be03637196d54feacce0d72c.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, hch@infradead.org, ceph-devel@vger.kernel.org

On 2020/2/4 22:35, Jeff Layton wrote:
> On Mon, 2020-02-03 at 21:28 -0500, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> In O_APPEND & O_DIRECT mode, the data from different writers will
>> be possiblly overlapping each other with shared lock.
>>
>> For example, both Writer1 and Writer2 are in O_APPEND and O_DIRECT
>> mode:
>>
>>            Writer1                         Writer2
>>
>>       shared_lock()                   shared_lock()
>>       getattr(CAP_SIZE)               getattr(CAP_SIZE)
>>       iocb->ki_pos = EOF              iocb->ki_pos = EOF
>>       write(data1)
>>                                       write(data2)
>>       shared_unlock()                 shared_unlock()
>>
>> The data2 will overlap the data1 from the same file offset, the
>> old EOF.
>>
>> Switch to exclusive lock instead when O_APPEND is specified.
>>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>
>> Changed in V2:
>> - fix the commit comment
>> - add more detail in the commit comment
>> - s/direct_lock/shared_lock/g
>>
>>   fs/ceph/file.c | 17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index ac7fe8b8081c..e3e67ef215dd 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>> @@ -1475,6 +1475,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   	struct ceph_cap_flush *prealloc_cf;
>>   	ssize_t count, written = 0;
>>   	int err, want, got;
>> +	bool shared_lock = false;
>>   	loff_t pos;
>>   	loff_t limit = max(i_size_read(inode), fsc->max_file_size);
>>   
>> @@ -1485,8 +1486,11 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   	if (!prealloc_cf)
>>   		return -ENOMEM;
>>   
>> +	if ((iocb->ki_flags & (IOCB_DIRECT | IOCB_APPEND)) == IOCB_DIRECT)
>> +		shared_lock = true;
>> +
>>   retry_snap:
>> -	if (iocb->ki_flags & IOCB_DIRECT)
>> +	if (shared_lock)
>>   		ceph_start_io_direct(inode);
>>   	else
>>   		ceph_start_io_write(inode);
>> @@ -1576,14 +1580,15 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   
>>   		/* we might need to revert back to that point */
>>   		data = *from;
>> -		if (iocb->ki_flags & IOCB_DIRECT) {
>> +		if (iocb->ki_flags & IOCB_DIRECT)
>>   			written = ceph_direct_read_write(iocb, &data, snapc,
>>   							 &prealloc_cf);
>> -			ceph_end_io_direct(inode);
>> -		} else {
>> +		else
>>   			written = ceph_sync_write(iocb, &data, pos, snapc);
>> +		if (shared_lock)
>> +			ceph_end_io_direct(inode);
>> +		else
>>   			ceph_end_io_write(inode);
>> -		}
>>   		if (written > 0)
>>   			iov_iter_advance(from, written);
>>   		ceph_put_snap_context(snapc);
>> @@ -1634,7 +1639,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   
>>   	goto out_unlocked;
>>   out:
>> -	if (iocb->ki_flags & IOCB_DIRECT)
>> +	if (shared_lock)
>>   		ceph_end_io_direct(inode);
>>   	else
>>   		ceph_end_io_write(inode);
> Ok, I think this looks reasonable, but I actually preferred the
> "direct_lock" name you had before. I'm going to do some testing today
> and will probably merge this (with s/shared_lock/direct_lock/) if it
> tests out ok.

Okay :-) Thanks.

>
