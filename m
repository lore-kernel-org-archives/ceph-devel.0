From: Victor Payno <vpayno@gaikai.com>
Subject: Re: deadlocks in rbd unmap and map
Date: Mon, 11 Jul 2016 12:12:38 -0700
Message-ID: <CALXUmNR5_nEvP6mi6zo9eQX2ZG1YvTRy50kaYbb+0xCVQszAXQ@mail.gmail.com>
References: <CAE2NFgVL6_+6JmW7aFO+v3j37BFnxXEneaOHk0eOCx-Vj1pAOA@mail.gmail.com>
 <CAOi1vP8NhgYHpfZT8w=meFf6vwPrS-izRZnvSPwrRc+3vwvAWQ@mail.gmail.com>
 <CAE2NFgW0ntzuFkRup5QCGfYMBuHo4Er9+y+OtKDTeaXBBtgE3g@mail.gmail.com>
 <CAOi1vP_HwML=7+iZrJFzJpbRcSomKBX5r8RT2hnRGF23agN1FQ@mail.gmail.com>
 <CAE2NFgVVth4BRQNCy6SFOnLnLf0NQ=kgoHcuMLpnz5beG3w-nQ@mail.gmail.com> <CAOi1vP8fg4cmAvOOKQWZUcvNpiQ5CzpVr1q=rjhtTjasa85msQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:34124 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbcGKTM6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jul 2016 15:12:58 -0400
Received: by mail-io0-f170.google.com with SMTP id q83so45782632iod.1
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jul 2016 12:12:58 -0700 (PDT)
In-Reply-To: <CAOi1vP8fg4cmAvOOKQWZUcvNpiQ5CzpVr1q=rjhtTjasa85msQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Patrick McLean <patrickm@gaikai.com>, Ceph Development <ceph-devel@vger.kernel.org>, Cliff Pajaro <cpajaro@gaikai.com>, Roderick Colenbrander <roderick@gaikai.com>, Rae Yip <ryip@gaikai.com>, Frank Reed <freed@gaikai.com>

On the ceph clients we haven't seen any ceph/rbd related dmesg other th=
an these.

[28623.056936] libceph: mon0 10.9.228.50:6789 session established
[28623.060888] libceph: client773380 fsid e88d2684-47c1-5a64-a275-6e375=
d11b557
[28623.131952] rbd: rbd0: added with size 0x2540be400
[28624.040816] EXT4-fs (rbd0): mounted filesystem without journal. Opts=
: (null)
[26123.339863] libceph: osd1 10.9.228.101:6804 socket closed (con state=
 OPEN)


We can enable "debug ms=3D1" on the OSD servers.

We'll get you the output next time we are able to reproduce it (this
weekend's loadtest failed to reproduce the error with kernel
4.7.0-rc6-vanilla-ams-3-00134-gcfae7e3-dirty).

It doesn't happen when we have a single instance of map/unmap. It
seems to happen 1 or more hours into the load test.

On Sat, Jul 9, 2016 at 7:30 AM, Ilya Dryomov <idryomov@gmail.com> wrote=
:
> On Fri, Jul 8, 2016 at 10:30 PM, Patrick McLean <patrickm@gaikai.com>=
 wrote:
>> On Fri, Jul 8, 2016 at 11:46 AM, Ilya Dryomov <idryomov@gmail.com> w=
rote:
>>> On Fri, Jul 8, 2016 at 7:51 PM, Patrick McLean <patrickm@gaikai.com=
> wrote:
>>>> On Fri, Jul 8, 2016 at 4:40 AM, Ilya Dryomov <idryomov@gmail.com> =
wrote:
>>>>> On Fri, Jul 8, 2016 at 3:28 AM, Patrick McLean <patrickm@gaikai.c=
om> wrote:
>>>>>> This is on linus git master as of 2016/07/01
>>>>>>
>>>>>> These appear to be two separate deadlocks, one on a a map operat=
ion,
>>>>>> and one on an unmap operation. We can reproduce these pretty
>>>>>> regularly, but it seems like there is some sort of race conditio=
n, as
>>>>>> it happens no where near every time.
>>>>>>
>>>>
>>>>>
>>>>> It's a single deadlock between "rbd map" and a kworker thread, a =
later
>>>>> "rbd unmap" is just a victim.
>>>>>
>>>>> Are you mapping the same image more than once?
>>>>>
>>>>
>>>> We shouldn't be, there is a higher-level locking system that is
>>>> supposed to prevent that.
>>>
>>> It's actually allowed, I'm just trying to get an idea of what was g=
oing
>>> on.
>>>
>>> I spoke too soon.  The trace of pid 14109 is inconsistent - the ent=
ries
>>> in the middle don't make sense.  Do you have a different set of tra=
ces
>>> or are they all the same?
>>
>> Here is another backtrace. It seems that once it happens to a
>> particular image once, it always does the same thing. We have not
>> figured out what triggers the first hang.
>>
>> # grep -C 40 rbd /proc/*/stack
>> /proc/5295/stack-[<ffffffff8111c7c4>] __queue_work+0x144/0x420
>> /proc/5295/stack-[<ffffffff8112c1c0>] default_wake_function+0x0/0x10
>> /proc/5295/stack:[<ffffffffa01621ee>]
>> rbd_obj_method_sync.constprop.48+0x1be/0x290 [rbd]
>> /proc/5295/stack:[<ffffffffa0162aea>] rbd_dev_header_info+0x15a/0x93=
0 [rbd]
>> /proc/5295/stack:[<ffffffffa0163450>] rbd_watch_cb+0x0/0xa0 [rbd]
>> /proc/5295/stack:[<ffffffffa0163586>]
>> rbd_dev_image_probe.part.42+0x96/0x910 [rbd]
>> /proc/5295/stack:[<ffffffffa016240e>] rbd_dev_image_id+0x14e/0x1b0 [=
rbd]
>> /proc/5295/stack:[<ffffffffa016428f>] do_rbd_add.isra.43+0x48f/0xbb0=
 [rbd]
>> /proc/5295/stack-[<ffffffff8123ba27>] __kmalloc+0x27/0x170
>> /proc/5295/stack-[<ffffffff812b7f3a>] kernfs_fop_write+0x10a/0x190
>> /proc/5295/stack-[<ffffffff8124dc63>] __vfs_write+0x23/0x120
>> /proc/5295/stack-[<ffffffff8124e8f3>] vfs_write+0xb3/0x1a0
>> /proc/5295/stack-[<ffffffff8124fbd2>] SyS_write+0x42/0xa0
>> /proc/5295/stack-[<ffffffff81816f72>] entry_SYSCALL_64_fastpath+0x1a=
/0xa4
>> /proc/5295/stack-[<ffffffffffffffff>] 0xffffffffffffffff
>>
>> # ps aux | grep 5295
>> root      5295  0.0  0.0 246704 10352 pts/4    Sl+  20:20   0:00 rbd
>> map --pool XXXXXXX XXXXXXXX
>
> Anything in dmesg?  It looks like rbd map is waiting for a reply to o=
ne
> of the header read-in requests and is never woken up.  rbd map holds
> a semaphore, blocking the kworker, which blocks rbd unmap.
>
> Can you set "debug ms =3D 1" on all OSDs and try to reproduce?
> I'd also like to see the content of /sys/kernel/debug/ceph/*/osdc whe=
n
> it happens again.
>
> How long does it take to hit it on average?
>
> Thanks,
>
>                 Ilya



--=20
Victor Payno
=E3=83=93=E3=82=AF=E3=82=BF=E3=83=BC=C2=B7=E3=83=9A=E3=82=A4=E3=83=B3

Sr. Release Engineer
=E3=82=B7=E3=83=8B=E3=82=A2=E3=83=AA=E3=83=AA=E3=83=BC=E3=82=B9=E3=82=A8=
=E3=83=B3=E3=82=B8=E3=83=8B=E3=82=A2



Gaikai, a Sony Computer Entertainment Company   =E2=88=86=E2=97=8B=C3=97=
=E2=96=A1
=E3=82=AC=E3=82=A4=E3=82=AB=E3=82=A4=E3=80=81=E3=82=BD=E3=83=8B=E3=83=BC=
=E3=83=BB=E3=82=B3=E3=83=B3=E3=83=94=E3=83=A5=E3=83=BC=E3=82=BF=E3=82=A8=
=E3=83=B3=E3=82=BF=E3=83=86=E3=82=A4=E3=83=B3=E3=83=A1=E3=83=B3=E3=83=88=
=E5=82=98=E4=B8=8B=E4=BC=9A=E7=A4=BE
65 Enterprise
Aliso Viejo, CA 92656 USA

Web: www.gaikai.com
Email: vpayno@gaikai.com
Phone: (949) 330-6850
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
