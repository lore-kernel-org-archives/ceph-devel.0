From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 3/3] ceph: fix vmtruncate deadlock
Date: Tue, 26 Feb 2013 10:19:26 -0800
Message-ID: <CAPYLRziup+6SumRJLt0WLUS3AHAGsxuUZTdru67mO4Cp=GP+SA@mail.gmail.com>
References: <1361498899-15831-1-git-send-email-zheng.z.yan@intel.com>
	<1361498899-15831-4-git-send-email-zheng.z.yan@intel.com>
	<CAPYLRziAgfT0F2cdNe+sMbiphBMz20Sm3oSgqkdwNcJL-K--DQ@mail.gmail.com>
	<51284624.9050007@intel.com>
	<CAPYLRzinxnLg9+c-2Bh2f=S6vjqdTi+WjGsf02FTkj1sJK0iSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:40577 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab3BZST2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 13:19:28 -0500
Received: by mail-wg0-f50.google.com with SMTP id es5so3587836wgb.17
        for <ceph-devel@vger.kernel.org>; Tue, 26 Feb 2013 10:19:26 -0800 (PST)
In-Reply-To: <CAPYLRzinxnLg9+c-2Bh2f=S6vjqdTi+WjGsf02FTkj1sJK0iSQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Mon, Feb 25, 2013 at 4:01 PM, Gregory Farnum <greg@inktank.com> wrot=
e:
> On Fri, Feb 22, 2013 at 8:31 PM, Yan, Zheng <zheng.z.yan@intel.com> w=
rote:
>> On 02/23/2013 02:54 AM, Gregory Farnum wrote:
>>> I haven't spent that much time in the kernel client, but this patch
>>> isn't working out for me. In particular, I'm pretty sure we need to
>>> preserve this:
>>>
>>>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>>>> index 5d5c32b..b9d8417 100644
>>>> --- a/fs/ceph/caps.c
>>>> +++ b/fs/ceph/caps.c
>>>> @@ -2067,12 +2067,6 @@ static int try_get_cap_refs(struct ceph_ino=
de_info *ci, int need, int want,
>>>>         }
>>>>         have =3D __ceph_caps_issued(ci, &implemented);
>>>>
>>>> -       /*
>>>> -        * disallow writes while a truncate is pending
>>>> -        */
>>>> -       if (ci->i_truncate_pending)
>>>> -               have &=3D ~CEPH_CAP_FILE_WR;
>>>> -
>>>>         if ((have & need) =3D=3D need) {
>>>>                 /*
>>>>                  * Look at (implemented & ~have & not) so that we =
keep waiting
>>>
>>> Because if there's a pending truncate, we really can't write. You d=
o
>>> handle it in the particular case of doing buffered file writes, but
>>> these caps are a marker of permission, and the client shouldn't hav=
e
>>> write permission to a file until it's up to date on the truncates. =
Or
>>> am I misunderstanding something?
>>
>> pending vmtruncate is only relevant to buffered write case. If clien=
t doesn't have 'b' cap,
>> the page cache is empty, and __ceph_do_pending_vmtruncate is no-op. =
=46or buffered write,
>> this patch only affects situation that clients receives truncate req=
uest from MDS in the
>> middle of write.
> It looks to me like truncates can get queued for later, so that's not=
 the case?
> And how could the client receive a truncate while in the middle of
> writing? Either it's got the write caps (in which case nobody else ca=
n
> truncate), or it shouldn't be writing...I suppose if somebody enables
> lazyIO that would do it, but again in that case I imagine we'd rather
> do the truncate before writing:
>
>> I think it's better to do vmtruncate after write finishes.
> What if you're writing past the truncate point? Then your written dat=
a
> would be truncated off even though it should have been a file
> extension.
>
>
>>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>>> index a1e5b81..bf7849a 100644
>>>> --- a/fs/ceph/file.c
>>>> +++ b/fs/ceph/file.c
>>>> @@ -653,7 +653,6 @@ static ssize_t ceph_aio_read(struct kiocb *ioc=
b, const struct iovec *iov,
>>>>         dout("aio_read %p %llx.%llx %llu~%u trying to get caps on =
%p\n",
>>>>              inode, ceph_vinop(inode), pos, (unsigned)len, inode);
>>>>  again:
>>>> -       __ceph_do_pending_vmtruncate(inode);
>>>
>>> There doesn't seem to be any kind of replacement for this? We need =
to
>>> do any pending truncates before reading or we might get stale data
>>> back.
>>
>> generic_file_aio_read checks i_size when coping data to user buffer,=
 so the user program can't
>> get stale data. This __ceph_do_pending_vmtruncate is not protected b=
y i_mutex, it's a potential
>> bug, that's the reason I remove it.
>
> Oh, you're right about the locking (I think, anyway?). However, i_siz=
e
> doesn't protect us =97 we might for instance have truncated to zero a=
nd
> then back up to the original file size. :( But that doesn't look like
> it's handled correctly anyway (racy) =97 am I misreading that badly o=
r
> is the infrastructure in fact broken in that case?

Sage pointed out in standup today that we only send a truncate message
for truncate downs, and he thinks that the more complicated cases
(truncate to zero, write out 2KB, truncate to 1KB) are okay thanks to
the capabilities bits. I haven't thought it through but that seems
plausible to me.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
