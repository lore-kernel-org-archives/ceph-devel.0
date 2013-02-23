From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 3/3] ceph: fix vmtruncate deadlock
Date: Sat, 23 Feb 2013 12:31:32 +0800
Message-ID: <51284624.9050007@intel.com>
References: <1361498899-15831-1-git-send-email-zheng.z.yan@intel.com> <1361498899-15831-4-git-send-email-zheng.z.yan@intel.com> <CAPYLRziAgfT0F2cdNe+sMbiphBMz20Sm3oSgqkdwNcJL-K--DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4791 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757366Ab3BWEbf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 Feb 2013 23:31:35 -0500
In-Reply-To: <CAPYLRziAgfT0F2cdNe+sMbiphBMz20Sm3oSgqkdwNcJL-K--DQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On 02/23/2013 02:54 AM, Gregory Farnum wrote:
> I haven't spent that much time in the kernel client, but this patch
> isn't working out for me. In particular, I'm pretty sure we need to
> preserve this:
> 
>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>> index 5d5c32b..b9d8417 100644
>> --- a/fs/ceph/caps.c
>> +++ b/fs/ceph/caps.c
>> @@ -2067,12 +2067,6 @@ static int try_get_cap_refs(struct ceph_inode_info *ci, int need, int want,
>>         }
>>         have = __ceph_caps_issued(ci, &implemented);
>>
>> -       /*
>> -        * disallow writes while a truncate is pending
>> -        */
>> -       if (ci->i_truncate_pending)
>> -               have &= ~CEPH_CAP_FILE_WR;
>> -
>>         if ((have & need) == need) {
>>                 /*
>>                  * Look at (implemented & ~have & not) so that we keep waiting
> 
> Because if there's a pending truncate, we really can't write. You do
> handle it in the particular case of doing buffered file writes, but
> these caps are a marker of permission, and the client shouldn't have
> write permission to a file until it's up to date on the truncates. Or
> am I misunderstanding something?

pending vmtruncate is only relevant to buffered write case. If client doesn't have 'b' cap,
the page cache is empty, and __ceph_do_pending_vmtruncate is no-op. For buffered write,
this patch only affects situation that clients receives truncate request from MDS in the
middle of write. I think it's better to do vmtruncate after write finishes. 

> 
> 
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index a1e5b81..bf7849a 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>> @@ -653,7 +653,6 @@ static ssize_t ceph_aio_read(struct kiocb *iocb, const struct iovec *iov,
>>         dout("aio_read %p %llx.%llx %llu~%u trying to get caps on %p\n",
>>              inode, ceph_vinop(inode), pos, (unsigned)len, inode);
>>  again:
>> -       __ceph_do_pending_vmtruncate(inode);
> 
> There doesn't seem to be any kind of replacement for this? We need to
> do any pending truncates before reading or we might get stale data
> back.

generic_file_aio_read checks i_size when coping data to user buffer, so the user program can't
get stale data. This __ceph_do_pending_vmtruncate is not protected by i_mutex, it's a potential
bug, that's the reason I remove it.

Regards
Yan, Zheng

> 
> The first two in the series look good to me, but I'll wait and pull
> them in as a unit with this one once we're done discussing. :)
> -Greg
> 

