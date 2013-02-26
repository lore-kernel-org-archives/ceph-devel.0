From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 3/3] ceph: fix vmtruncate deadlock
Date: Mon, 25 Feb 2013 16:01:12 -0800
Message-ID: <CAPYLRzinxnLg9+c-2Bh2f=S6vjqdTi+WjGsf02FTkj1sJK0iSQ@mail.gmail.com>
References: <1361498899-15831-1-git-send-email-zheng.z.yan@intel.com>
	<1361498899-15831-4-git-send-email-zheng.z.yan@intel.com>
	<CAPYLRziAgfT0F2cdNe+sMbiphBMz20Sm3oSgqkdwNcJL-K--DQ@mail.gmail.com>
	<51284624.9050007@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:44403 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab3BZABN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Feb 2013 19:01:13 -0500
Received: by mail-qe0-f43.google.com with SMTP id s14so2033619qeb.2
        for <ceph-devel@vger.kernel.org>; Mon, 25 Feb 2013 16:01:12 -0800 (PST)
In-Reply-To: <51284624.9050007@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Fri, Feb 22, 2013 at 8:31 PM, Yan, Zheng <zheng.z.yan@intel.com> wro=
te:
> On 02/23/2013 02:54 AM, Gregory Farnum wrote:
>> I haven't spent that much time in the kernel client, but this patch
>> isn't working out for me. In particular, I'm pretty sure we need to
>> preserve this:
>>
>>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>>> index 5d5c32b..b9d8417 100644
>>> --- a/fs/ceph/caps.c
>>> +++ b/fs/ceph/caps.c
>>> @@ -2067,12 +2067,6 @@ static int try_get_cap_refs(struct ceph_inod=
e_info *ci, int need, int want,
>>>         }
>>>         have =3D __ceph_caps_issued(ci, &implemented);
>>>
>>> -       /*
>>> -        * disallow writes while a truncate is pending
>>> -        */
>>> -       if (ci->i_truncate_pending)
>>> -               have &=3D ~CEPH_CAP_FILE_WR;
>>> -
>>>         if ((have & need) =3D=3D need) {
>>>                 /*
>>>                  * Look at (implemented & ~have & not) so that we k=
eep waiting
>>
>> Because if there's a pending truncate, we really can't write. You do
>> handle it in the particular case of doing buffered file writes, but
>> these caps are a marker of permission, and the client shouldn't have
>> write permission to a file until it's up to date on the truncates. O=
r
>> am I misunderstanding something?
>
> pending vmtruncate is only relevant to buffered write case. If client=
 doesn't have 'b' cap,
> the page cache is empty, and __ceph_do_pending_vmtruncate is no-op. F=
or buffered write,
> this patch only affects situation that clients receives truncate requ=
est from MDS in the
> middle of write.
It looks to me like truncates can get queued for later, so that's not t=
he case?
And how could the client receive a truncate while in the middle of
writing? Either it's got the write caps (in which case nobody else can
truncate), or it shouldn't be writing...I suppose if somebody enables
lazyIO that would do it, but again in that case I imagine we'd rather
do the truncate before writing:

> I think it's better to do vmtruncate after write finishes.
What if you're writing past the truncate point? Then your written data
would be truncated off even though it should have been a file
extension.


>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> index a1e5b81..bf7849a 100644
>>> --- a/fs/ceph/file.c
>>> +++ b/fs/ceph/file.c
>>> @@ -653,7 +653,6 @@ static ssize_t ceph_aio_read(struct kiocb *iocb=
, const struct iovec *iov,
>>>         dout("aio_read %p %llx.%llx %llu~%u trying to get caps on %=
p\n",
>>>              inode, ceph_vinop(inode), pos, (unsigned)len, inode);
>>>  again:
>>> -       __ceph_do_pending_vmtruncate(inode);
>>
>> There doesn't seem to be any kind of replacement for this? We need t=
o
>> do any pending truncates before reading or we might get stale data
>> back.
>
> generic_file_aio_read checks i_size when coping data to user buffer, =
so the user program can't
> get stale data. This __ceph_do_pending_vmtruncate is not protected by=
 i_mutex, it's a potential
> bug, that's the reason I remove it.

Oh, you're right about the locking (I think, anyway?). However, i_size
doesn't protect us =97 we might for instance have truncated to zero and
then back up to the original file size. :( But that doesn't look like
it's handled correctly anyway (racy) =97 am I misreading that badly or
is the infrastructure in fact broken in that case?

As I said, I don't spend much time in the kernel client, but I looked
around a bit more and this is what I came up with. Education, if
nothing else. ;)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
