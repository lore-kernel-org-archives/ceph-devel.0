From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] ceph: Fix file open flags on ppc64
Date: Fri, 21 Apr 2017 15:58:13 +0200
Message-ID: <51c1c597-d573-827b-0918-1a07d86ba117@suse.de>
References: <1492692030-146869-1-git-send-email-agraf@suse.de>
 <1492782361.7308.12.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1492782361.7308.12.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@redhat.com>, ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, linux-kernel@vger.kernel.org, Jan.Fajerski@suse.com
List-Id: ceph-devel.vger.kernel.org



On 21.04.17 15:46, Jeff Layton wrote:
> On Thu, 2017-04-20 at 14:40 +0200, Alexander Graf wrote:
>> The file open flags (O_foo) are platform specific and should never go
>> out to an interface that is not local to the system.
>>
>> Unfortunately these flags have leaked out onto the wire in the cephfs
>> implementation. That lead to bogus flags getting transmitted on ppc64.
>>
>> This patch converts the kernel view of flags to the ceph view of file
>> open flags. On x86 systems, the new function should get optimized out
>> by smart compilers. On systems where the flags differ, it should adapt
>> them accordingly.
>>
>> Fixes: 124e68e74 ("ceph: file operations")
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>> ---
>>  fs/ceph/file.c               | 45 +++++++++++++++++++++++++++++++++++++++++++-
>>  include/linux/ceph/ceph_fs.h | 24 +++++++++++++++++++++++
>>  2 files changed, 68 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index 26cc954..0ed6392 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>> @@ -103,6 +103,49 @@ static size_t dio_get_pagev_size(const struct iov_iter *it)
>>  	return ERR_PTR(ret);
>>  }
>>
>> +static u32 ceph_flags_sys2wire(u32 flags)
>> +{
>> +	u32 wire_flags = 0;
>> +
>> +	switch (flags & O_ACCMODE) {
>> +	case O_RDONLY:
>> +		wire_flags |= CEPH_O_RDONLY;
>> +		break;
>> +	case O_WRONLY:
>> +		wire_flags |= CEPH_O_WRONLY;
>> +		break;
>> +	case O_RDWR:
>> +		wire_flags |= CEPH_O_RDWR;
>> +		break;
>> +	}
>> +	flags &= ~O_ACCMODE;
>> +
>> +#define ceph_sys2wire(a) if (flags & a) { wire_flags |= CEPH_##a; flags &= ~a; }
>> +
>> +	ceph_sys2wire(O_CREAT);
>> +	ceph_sys2wire(O_NOCTTY);
>> +	ceph_sys2wire(O_TRUNC);
>> +	ceph_sys2wire(O_APPEND);
>> +	ceph_sys2wire(O_NONBLOCK);
>> +	ceph_sys2wire(O_DSYNC);
>> +	ceph_sys2wire(FASYNC);
>> +	ceph_sys2wire(O_DIRECT);
>> +	ceph_sys2wire(O_LARGEFILE);
>> +	ceph_sys2wire(O_DIRECTORY);
>> +	ceph_sys2wire(O_NOFOLLOW);
>> +	ceph_sys2wire(O_NOATIME);
>> +	ceph_sys2wire(O_CLOEXEC);
>> +	ceph_sys2wire(__O_SYNC);
>> +	ceph_sys2wire(O_PATH);
>> +	ceph_sys2wire(__O_TMPFILE);
>> +
>> +#undef ceph_sys2wire
>> +
>> +	WARN_ONCE(flags, "Found unknown open flags: %x", flags);
>> +
>> +	return wire_flags;
>> +}
>> +
>>  /*
>>   * Prepare an open request.  Preallocate ceph_cap to avoid an
>>   * inopportune ENOMEM later.
>> @@ -123,7 +166,7 @@ static size_t dio_get_pagev_size(const struct iov_iter *it)
>>  	if (IS_ERR(req))
>>  		goto out;
>>  	req->r_fmode = ceph_flags_to_mode(flags);
>> -	req->r_args.open.flags = cpu_to_le32(flags);
>> +	req->r_args.open.flags = ceph_flags_sys2wire(cpu_to_le32(flags));
>
> Shouldn't that be:
>
>     req->r_args.open.flags = cpu_to_le32(ceph_flags_sys2wire(flags));

Ouch. Yes, of course.

> It might be best though to move the cpu_to_le32 conversion into
> ceph_flags_sys2wire instead.

Makes a lot of sense, yes.


Alex
