From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: Fix file open flags on ppc64
Date: Mon, 24 Apr 2017 17:16:45 +0800
Message-ID: <5062BD33-23B6-467F-8C82-EE0E07EFEEA7@redhat.com>
References: <1492692030-146869-1-git-send-email-agraf@suse.de>
 <EEF153C1-1BC5-4BDF-8A73-5836E3A5D305@redhat.com>
 <51c27e5d-6c80-dfda-b371-dd6e46f911dd@suse.de>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1167740AbdDXJQz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 24 Apr 2017 05:16:55 -0400
In-Reply-To: <51c27e5d-6c80-dfda-b371-dd6e46f911dd@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan.Fajerski@suse.com


> On 21 Apr 2017, at 21:59, Alexander Graf <agraf@suse.de> wrote:
> 
> 
> 
> On 21.04.17 04:22, Yan, Zheng wrote:
>> 
>>> On 20 Apr 2017, at 20:40, Alexander Graf <agraf@suse.de> wrote:
>>> 
>>> The file open flags (O_foo) are platform specific and should never go
>>> out to an interface that is not local to the system.
>>> 
>>> Unfortunately these flags have leaked out onto the wire in the cephfs
>>> implementation. That lead to bogus flags getting transmitted on ppc64.
>>> 
>>> This patch converts the kernel view of flags to the ceph view of file
>>> open flags. On x86 systems, the new function should get optimized out
>>> by smart compilers. On systems where the flags differ, it should adapt
>>> them accordingly.
>>> 
>>> Fixes: 124e68e74 ("ceph: file operations")
>>> Signed-off-by: Alexander Graf <agraf@suse.de>
>>> ---
>>> fs/ceph/file.c               | 45 +++++++++++++++++++++++++++++++++++++++++++-
>>> include/linux/ceph/ceph_fs.h | 24 +++++++++++++++++++++++
>>> 2 files changed, 68 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> index 26cc954..0ed6392 100644
>>> --- a/fs/ceph/file.c
>>> +++ b/fs/ceph/file.c
>>> @@ -103,6 +103,49 @@ static size_t dio_get_pagev_size(const struct iov_iter *it)
>>> 	return ERR_PTR(ret);
>>> }
>>> 
>>> +static u32 ceph_flags_sys2wire(u32 flags)
>>> +{
>>> +	u32 wire_flags = 0;
>>> +
>>> +	switch (flags & O_ACCMODE) {
>>> +	case O_RDONLY:
>>> +		wire_flags |= CEPH_O_RDONLY;
>>> +		break;
>>> +	case O_WRONLY:
>>> +		wire_flags |= CEPH_O_WRONLY;
>>> +		break;
>>> +	case O_RDWR:
>>> +		wire_flags |= CEPH_O_RDWR;
>>> +		break;
>>> +	}
>>> +	flags &= ~O_ACCMODE;
>>> +
>>> +#define ceph_sys2wire(a) if (flags & a) { wire_flags |= CEPH_##a; flags &= ~a; }
>>> +
>>> +	ceph_sys2wire(O_CREAT);
>>> +	ceph_sys2wire(O_NOCTTY);
>>> +	ceph_sys2wire(O_TRUNC);
>>> +	ceph_sys2wire(O_APPEND);
>>> +	ceph_sys2wire(O_NONBLOCK);
>>> +	ceph_sys2wire(O_DSYNC);
>>> +	ceph_sys2wire(FASYNC);
>>> +	ceph_sys2wire(O_DIRECT);
>>> +	ceph_sys2wire(O_LARGEFILE);
>>> +	ceph_sys2wire(O_DIRECTORY);
>>> +	ceph_sys2wire(O_NOFOLLOW);
>>> +	ceph_sys2wire(O_NOATIME);
>>> +	ceph_sys2wire(O_CLOEXEC);
>>> +	ceph_sys2wire(__O_SYNC);
>>> +	ceph_sys2wire(O_PATH);
>>> +	ceph_sys2wire(__O_TMPFILE);
>>> +
>>> +#undef ceph_sys2wire
>>> +
>>> +	WARN_ONCE(flags, "Found unknown open flags: %x", flags);
>>> +
>>> +	return wire_flags;
>>> +}
>>> +
>>> /*
>>> * Prepare an open request.  Preallocate ceph_cap to avoid an
>>> * inopportune ENOMEM later.
>>> @@ -123,7 +166,7 @@ static size_t dio_get_pagev_size(const struct iov_iter *it)
>>> 	if (IS_ERR(req))
>>> 		goto out;
>>> 	req->r_fmode = ceph_flags_to_mode(flags);
>>> -	req->r_args.open.flags = cpu_to_le32(flags);
>>> +	req->r_args.open.flags = ceph_flags_sys2wire(cpu_to_le32(flags));
>> 
>> cpu_to_le32(ceph_flags_sys2wire(flags)) ?
> 
> Jeff also pointed to it. Definitely, yes. My thinko.
> 
>> 
>>> 	req->r_args.open.mode = cpu_to_le32(create_mode);
>>> out:
>>> 	return req;
>>> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
>>> index f4b2ee1..d254b48 100644
>>> --- a/include/linux/ceph/ceph_fs.h
>>> +++ b/include/linux/ceph/ceph_fs.h
>>> @@ -366,6 +366,30 @@ enum {
>>> #define CEPH_READDIR_FRAG_COMPLETE	(1<<8)
>>> #define CEPH_READDIR_HASH_ORDER		(1<<9)
>>> 
>>> +/*
>>> + * open request flags
>>> + */
>>> +#define CEPH_O_RDONLY		00000000
>>> +#define CEPH_O_WRONLY		00000001
>>> +#define CEPH_O_RDWR		00000002
>>> +#define CEPH_O_CREAT		00000100
>>> +#define CEPH_O_EXCL		00000200
>>> +#define CEPH_O_NOCTTY		00000400
>>> +#define CEPH_O_TRUNC		00001000
>>> +#define CEPH_O_APPEND		00002000
>>> +#define CEPH_O_NONBLOCK		00004000
>>> +#define CEPH_O_DSYNC		00010000
>>> +#define CEPH_FASYNC		00020000
>>> +#define CEPH_O_DIRECT		00040000
>>> +#define CEPH_O_LARGEFILE	00100000
>>> +#define CEPH_O_DIRECTORY	00200000
>>> +#define CEPH_O_NOFOLLOW		00400000
>>> +#define CEPH_O_NOATIME		01000000
>>> +#define CEPH_O_CLOEXEC		02000000
>>> +#define CEPH___O_SYNC		04000000
>>> +#define CEPH_O_PATH		010000000
>>> +#define CEPH___O_TMPFILE	020000000
>>> +
>> 
>> RDONLY, WRONLY, RDWR, CREAT, EXCL, TRUNC, DIRECTORY, NOFOLLOW  are used by mds, no need to define the rest.
> 
> So currently the function checks for any bits it doesn't know about. Do we want to drop that check then?

yes. I think it’s better to only encode flags that mds understands to wire.

Regards
Yan, Zheng 

> 
> 
> Alex

