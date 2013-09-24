From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Re: [PATCH] ceph: fix sync read eof check deadlock
Date: Tue, 24 Sep 2013 13:29:02 +0800
Message-ID: <CAAM7YAnu+oZ+kXEiSFSSbo-mrjnghkg_N0FgnSDFe=FhQB=XQA@mail.gmail.com>
References: <201309230939212660680@gmail.com>
	<CAAM7YA=bg=T0s3kagEquXfSdnxWT2-4Yv6863dhVhuTW0MNQjg@mail.gmail.com>
	<201309241043226589572@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:41110 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab3IXF3E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Sep 2013 01:29:04 -0400
Received: by mail-la0-f42.google.com with SMTP id ep20so3332163lab.29
        for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 22:29:02 -0700 (PDT)
In-Reply-To: <201309241043226589572@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: sage <sage@inktank.com>, "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Sep 24, 2013 at 10:43 AM, majianpeng <majianpeng@gmail.com> wrote:
>>On Mon, Sep 23, 2013 at 9:39 AM, majianpeng <majianpeng@gmail.com> wrote:
>>> As Yan,Zheng said, commit 0913444208db intruoduce a bug:"getattr need to
>>> "read lock" inode's filelock. But the lock can be in unstable state.
>>> the getattr request waits for lock's state to become stable, the lock
>>> waits for client to release Fr cap."
>>>
>>> Commit 6a026589ba333185c466c90 resolved the same bug also.
>>> Before doing getattr, it must put the caps which already hold avoid
>>> deadlock.
>>>
>>> Reported-by: Yan, Zheng <zheng.z.yan@intel.com>
>>> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
>>> ---
>>>  fs/ceph/file.c | 25 ++++++++++++++++++++-----
>>>  1 file changed, 20 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> index 7da35c7..bc00ace 100644
>>> --- a/fs/ceph/file.c
>>> +++ b/fs/ceph/file.c
>>> @@ -839,7 +839,15 @@ again:
>>>                 ret = ceph_sync_read(iocb, &i, &checkeof);
>>>
>>>                 if (checkeof && ret >= 0) {
>>> -                       int statret = ceph_do_getattr(inode,
>>> +                       int statret;
>>> +                       /*
>>> +                        *Before getattr,it should put caps avoid
>>> +                        *deadlock.
>>> +                        */
>>> +                       ceph_put_cap_refs(ci, got);
>>> +                       got = 0;
>>> +
>>> +                       statret = ceph_do_getattr(inode,
>>>                                                       CEPH_STAT_CAP_SIZE);
>>>
>>>                         /* hit EOF or hole? */
>>> @@ -851,16 +859,23 @@ again:
>>>
>>>                                 read += ret;
>>>                                 checkeof = 0;
>>> -                               goto again;
>>> +                               ret = ceph_get_caps(ci, CEPH_CAP_FILE_RD,
>>> +                                                       want, &got, -1);
>>> +                               if (ret < 0)
>>> +                                       ret = 0;
>>> +                               else
>>> +                                       goto again;
>>
>>I think we should try getting Frc caps here, because mds may issue Fc
>>cap to the client while requesting the size.
>>
> Yes,it maybe get Fc.My though whether or not, the later read only using sync_mode.

I don't see any reason for not doing buffered read when we succeed in
getting Fc cap. Buffered read is much faster than the sync read, we
should use it if possible.

> The reason:
> A:for requesting size only for sync-read not cache-read
> B:By the original, it will make the cache-read to do the same thing which sync-read alread done.

For buffered read, 'checkeof' be false, so the requesting size code
should never get executed.

>
> Thanks!
> Jianpeng Ma
>>Your previous patch moved the getattr code to here. please revert the
>>code to its original shape. I think it does the right thing.
>>

Another reason I prefer the original code is that it prints message
for getting/releasing caps.

Sage dropped your readv patch from the test branch (writev is still
in), please update and re-send the patch.

Regards
Yan, Zheng

>>
>>
>>>                         }
>>>                 }
>>>
>>>         } else
>>>                 ret = generic_file_aio_read(iocb, iov, nr_segs, pos);
>>>
>>> -       dout("aio_read %p %llx.%llx dropping cap refs on %s = %d\n",
>>> -            inode, ceph_vinop(inode), ceph_cap_string(got), (int)ret);
>>> -       ceph_put_cap_refs(ci, got);
>>> +       if (got) {
>>> +               dout("aio_read %p %llx.%llx dropping cap refs on %s = %d\n",
>>> +                    inode, ceph_vinop(inode), ceph_cap_string(got), (int)ret);
>>> +               ceph_put_cap_refs(ci, got);
>>> +       }
>>
>>
>>
>>
>>>
>>>         if (ret >= 0)
>>>                 ret += read;
>>> --
>>> 1.8.4-rc0
