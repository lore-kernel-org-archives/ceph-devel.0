From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: deadlocks in rbd unmap and map
Date: Wed, 13 Jul 2016 09:38:31 +0200
Message-ID: <CAOi1vP_7dHOVnxTHEhfYsiXQGvd+e8ecsPf10cg0s33Ry4Vt9Q@mail.gmail.com>
References: <CAE2NFgVL6_+6JmW7aFO+v3j37BFnxXEneaOHk0eOCx-Vj1pAOA@mail.gmail.com>
 <CAOi1vP8NhgYHpfZT8w=meFf6vwPrS-izRZnvSPwrRc+3vwvAWQ@mail.gmail.com>
 <CAE2NFgW0ntzuFkRup5QCGfYMBuHo4Er9+y+OtKDTeaXBBtgE3g@mail.gmail.com>
 <CAOi1vP_HwML=7+iZrJFzJpbRcSomKBX5r8RT2hnRGF23agN1FQ@mail.gmail.com>
 <CAE2NFgVVth4BRQNCy6SFOnLnLf0NQ=kgoHcuMLpnz5beG3w-nQ@mail.gmail.com>
 <CAOi1vP8fg4cmAvOOKQWZUcvNpiQ5CzpVr1q=rjhtTjasa85msQ@mail.gmail.com> <CAE2NFgXvtZYzD9EGp+GHxcSndS3AoKyvpZkwdmsTr2rB9KF__w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35425 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbcGMHio (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2016 03:38:44 -0400
Received: by mail-wm0-f44.google.com with SMTP id f65so16831789wmi.0
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2016 00:38:43 -0700 (PDT)
In-Reply-To: <CAE2NFgXvtZYzD9EGp+GHxcSndS3AoKyvpZkwdmsTr2rB9KF__w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick McLean <patrickm@gaikai.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Victor Payno <vpayno@gaikai.com>, Cliff Pajaro <cpajaro@gaikai.com>, Roderick Colenbrander <roderick@gaikai.com>, Rae Yip <ryip@gaikai.com>, Frank Reed <freed@gaikai.com>

On Wed, Jul 13, 2016 at 2:38 AM, Patrick McLean <patrickm@gaikai.com> wrote:
> On Sat, Jul 9, 2016 at 7:30 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
>> On Fri, Jul 8, 2016 at 10:30 PM, Patrick McLean <patrickm@gaikai.com> wrote:
>>> On Fri, Jul 8, 2016 at 11:46 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
>>>> On Fri, Jul 8, 2016 at 7:51 PM, Patrick McLean <patrickm@gaikai.com> wrote:
>>>>> On Fri, Jul 8, 2016 at 4:40 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
>>>>>> On Fri, Jul 8, 2016 at 3:28 AM, Patrick McLean <patrickm@gaikai.com> wrote:
>>>>>>> This is on linus git master as of 2016/07/01
>>>>>>>
>>>>>>> These appear to be two separate deadlocks, one on a a map operation,
>>>>>>> and one on an unmap operation. We can reproduce these pretty
>>>>>>> regularly, but it seems like there is some sort of race condition, as
>>>>>>> it happens no where near every time.
>>>>>>>
>>>>>
>>>>>>
>>>>>> It's a single deadlock between "rbd map" and a kworker thread, a later
>>>>>> "rbd unmap" is just a victim.
>>>>>>
>>>>>> Are you mapping the same image more than once?
>>>>>>
>>>>>
>>>>> We shouldn't be, there is a higher-level locking system that is
>>>>> supposed to prevent that.
>>>>
>>>> It's actually allowed, I'm just trying to get an idea of what was going
>>>> on.
>>>>
>>>> I spoke too soon.  The trace of pid 14109 is inconsistent - the entries
>>>> in the middle don't make sense.  Do you have a different set of traces
>>>> or are they all the same?
>>>
>>> Here is another backtrace. It seems that once it happens to a
>>> particular image once, it always does the same thing. We have not
>>> figured out what triggers the first hang.
>>>
>>> # grep -C 40 rbd /proc/*/stack
>>> /proc/5295/stack-[<ffffffff8111c7c4>] __queue_work+0x144/0x420
>>> /proc/5295/stack-[<ffffffff8112c1c0>] default_wake_function+0x0/0x10
>>> /proc/5295/stack:[<ffffffffa01621ee>]
>>> rbd_obj_method_sync.constprop.48+0x1be/0x290 [rbd]
>>> /proc/5295/stack:[<ffffffffa0162aea>] rbd_dev_header_info+0x15a/0x930 [rbd]
>>> /proc/5295/stack:[<ffffffffa0163450>] rbd_watch_cb+0x0/0xa0 [rbd]
>>> /proc/5295/stack:[<ffffffffa0163586>]
>>> rbd_dev_image_probe.part.42+0x96/0x910 [rbd]
>>> /proc/5295/stack:[<ffffffffa016240e>] rbd_dev_image_id+0x14e/0x1b0 [rbd]
>>> /proc/5295/stack:[<ffffffffa016428f>] do_rbd_add.isra.43+0x48f/0xbb0 [rbd]
>>> /proc/5295/stack-[<ffffffff8123ba27>] __kmalloc+0x27/0x170
>>> /proc/5295/stack-[<ffffffff812b7f3a>] kernfs_fop_write+0x10a/0x190
>>> /proc/5295/stack-[<ffffffff8124dc63>] __vfs_write+0x23/0x120
>>> /proc/5295/stack-[<ffffffff8124e8f3>] vfs_write+0xb3/0x1a0
>>> /proc/5295/stack-[<ffffffff8124fbd2>] SyS_write+0x42/0xa0
>>> /proc/5295/stack-[<ffffffff81816f72>] entry_SYSCALL_64_fastpath+0x1a/0xa4
>>> /proc/5295/stack-[<ffffffffffffffff>] 0xffffffffffffffff
>>>
>>> # ps aux | grep 5295
>>> root      5295  0.0  0.0 246704 10352 pts/4    Sl+  20:20   0:00 rbd
>>> map --pool XXXXXXX XXXXXXXX
>>
>> Anything in dmesg?  It looks like rbd map is waiting for a reply to one
>> of the header read-in requests and is never woken up.  rbd map holds
>> a semaphore, blocking the kworker, which blocks rbd unmap.
>>
>> Can you set "debug ms = 1" on all OSDs and try to reproduce?
>> I'd also like to see the content of /sys/kernel/debug/ceph/*/osdc when
>> it happens again.
>>
>
> Here is the contents of the osdc debug file on a machine that had been
> in that state for 3 days.
>
> # cat /sys/kernel/debug/ceph/*/osdc
> REQUESTS 1 homeless 0
> 7 osd38 4.27a8d388 [38,16,47]/38 [38,16,47]/38
> rbd_header.bea4a16ebd6a9a 0x400011 1 0'0 call
> LINGER REQUESTS
> 1 osd38 4.27a8d388 [38,16,47]/38 [38,16,47]/38
> rbd_header.bea4a16ebd6a9a 0x24 0 WC/0

OK, so it's waiting for a reply.  Do you have a debug ms = 1 log for
osd38?

Thanks,

                Ilya
