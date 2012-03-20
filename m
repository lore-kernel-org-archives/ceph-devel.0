From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Mysteriously poor write performance
Date: Tue, 20 Mar 2012 23:37:04 +0300
Message-ID: <CABYiri-AV6WK-H7K9oSwSnMSAgB6ZAHLDn2Ar6omdS=8EAjtfA@mail.gmail.com>
References: <CABYiri-C1ftxsM3dWqtcRzXBYoddRbHug=TA6j+0EY-cuMt3Mw@mail.gmail.com>
 <Pine.LNX.4.64.1203181121460.580@cobra.newdream.net> <CABYiri9hcWdPv5Xs_X6S+tM6-U_uGq68pnTzetc=cVxK7NiNQg@mail.gmail.com>
 <4825A243C5604C48A3E022008ED974D0@dreamhost.com> <CABYiri9omWz_vSZxL_McYg5bMoW20x6TBCsXHTHwgZ0hqUxofA@mail.gmail.com>
 <4F677D95.8040208@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:42524 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab2CTUh3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Mar 2012 16:37:29 -0400
Received: by wejx9 with SMTP id x9so398413wej.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Mar 2012 13:37:25 -0700 (PDT)
In-Reply-To: <4F677D95.8040208@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: Greg Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

rados bench 60 write -p data
<skip>
Total time run:        61.217676
Total writes made:     989
Write size:            4194304
Bandwidth (MB/sec):    64.622

Average Latency:       0.989608
Max latency:           2.21701
Min latency:           0.255315

Here a snip from osd log, seems write size is okay.

2012-03-21 00:00:39.397066 7fdda86a7700 osd.0 10 pg[0.58( v 10'83
(0'0,10'83] n=3D50 ec=3D1 les/c 9/9 8/8/6) [0,1] r=3D0 lpr=3D8 mlcod 10=
'82
active+clean]  removing repgather(0x31b5360 applying 10'83 rep_tid=3D59=
7
wfack=3D wfdisk=3D op=3Dosd_op(client.4599.0:2533 rb.0.2.000000000040 [=
write
1220608~4096] 0.17eb9fd8) v4)
2012-03-21 00:00:39.397086 7fdda86a7700 osd.0 10 pg[0.58( v 10'83
(0'0,10'83] n=3D50 ec=3D1 les/c 9/9 8/8/6) [0,1] r=3D0 lpr=3D8 mlcod 10=
'82
active+clean]    q front is repgather(0x31b5360 applying 10'83
rep_tid=3D597 wfack=3D wfdisk=3D op=3Dosd_op(client.4599.0:2533
rb.0.2.000000000040 [write 1220608~4096] 0.17eb9fd8) v4)

Sorry for my previous question about rbd chunks, it was really stupid :=
)

On Mon, Mar 19, 2012 at 10:40 PM, Josh Durgin <josh.durgin@dreamhost.co=
m> wrote:
> On 03/19/2012 11:13 AM, Andrey Korolyov wrote:
>>
>> Nope, I`m using KVM for rbd guests. Surely I`ve been noticed that Sa=
ge
>> mentioned too small value and I`ve changed it to 64M before posting
>> previous message with no success - both 8M and this value cause a
>> performance drop. When I tried to wrote small amount of data that ca=
n
>> be compared to writeback cache size(both on raw device and ext3 with
>> sync option), following results were made:
>
>
> I just want to clarify that the writeback window isn't a full writeba=
ck
> cache - it doesn't affect reads, and does not help with request mergi=
ng etc.
> It simply allows a bunch of writes to be in flight while acking the w=
rite to
> the guest immediately. We're working on a full-fledged writeback cach=
e that
> to replace the writeback window.
>
>
>> dd if=3D/dev/zero of=3D/var/img.1 bs=3D10M count=3D10 oflag=3Ddirect=
 (almost
>> same without oflag there and in the following samples)
>> 10+0 records in
>> 10+0 records out
>> 104857600 bytes (105 MB) copied, 0.864404 s, 121 MB/s
>> dd if=3D/dev/zero of=3D/var/img.1 bs=3D10M count=3D20 oflag=3Ddirect
>> 20+0 records in
>> 20+0 records out
>> 209715200 bytes (210 MB) copied, 6.67271 s, 31.4 MB/s
>> dd if=3D/dev/zero of=3D/var/img.1 bs=3D10M count=3D30 oflag=3Ddirect
>> 30+0 records in
>> 30+0 records out
>> 314572800 bytes (315 MB) copied, 12.4806 s, 25.2 MB/s
>>
>> and so on. Reference test with bs=3D1M and count=3D2000 has slightly=
 worse
>> results _with_ writeback cache than without, as I`ve mentioned befor=
e.
>> =C2=A0Here the bench results, they`re almost equal on both nodes:
>>
>> bench: wrote 1024 MB in blocks of 4096 KB in 9.037468 sec at 113 MB/=
sec
>
>
> One thing to check is the size of the writes that are actually being =
sent by
> rbd. The guest is probably splitting them into relatively small (128 =
or
> 256k) writes. Ideally it would be sending 4k writes, and this should =
be a
> lot faster.
>
> You can see the writes being sent by adding debug_ms=3D1 to the clien=
t or osd.
> The format is osd_op(.*[write OFFSET~LENGTH]).
>
>
>> Also, because I`ve not mentioned it before, network performance is
>> enough to hold fair gigabit connectivity with MTU 1500. Seems that i=
t
>> is not interrupt problem or something like it - even if ceph-osd,
>> ethernet card queues and kvm instance pinned to different sets of
>> cores, nothing changes.
>>
>> On Mon, Mar 19, 2012 at 8:59 PM, Greg Farnum
>> <gregory.farnum@dreamhost.com> =C2=A0wrote:
>>>
>>> It sounds like maybe you're using Xen? The "rbd writeback window" o=
ption
>>> only works for userspace rbd implementations (eg, KVM).
>>> If you are using KVM, you probably want 81920000 (~80MB) rather tha=
n
>>> 8192000 (~8MB).
>>>
>>> What options are you running dd with? If you run a rados bench from=
 both
>>> machines, what do the results look like?
>>> Also, can you do the ceph osd bench on each of your OSDs, please?
>>> (http://ceph.newdream.net/wiki/Troubleshooting#OSD_performance)
>>> -Greg
>>>
>>>
>>> On Monday, March 19, 2012 at 6:46 AM, Andrey Korolyov wrote:
>>>
>>>> More strangely, writing speed drops down by fifteen percent when t=
his
>>>> option was set in vm` config(instead of result from
>>>> http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg03685.ht=
ml).
>>>> As I mentioned, I`m using 0.43, but due to crashed osds, ceph has =
been
>>>> recompiled with e43546dee9246773ffd6877b4f9495f1ec61cd55 and
>>>> 1468d95101adfad44247016a1399aab6b86708d2 - both cases caused crash=
es
>>>> under heavy load.
>>>>
>>>> On Sun, Mar 18, 2012 at 10:22 PM, Sage Weil<sage@newdream.net
>>>> (mailto:sage@newdream.net)> =C2=A0wrote:
>>>>>
>>>>> On Sat, 17 Mar 2012, Andrey Korolyov wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I`ve did some performance tests at the following configuration:
>>>>>>
>>>>>> mon0, osd0 and mon1, osd1 - two twelve-core r410 with 32G ram, m=
on2 -
>>>>>> dom0 with three dedicated cores and 1.5G, mostly idle. First thr=
ee
>>>>>> disks on each r410 arranged into raid0 and holds osd data when f=
ourth
>>>>>> holds os and osd` journal partition, all ceph-related stuff moun=
ted on
>>>>>> the ext4 without barriers.
>>>>>>
>>>>>> Firstly, I`ve noticed about a difference of benchmark performanc=
e and
>>>>>> write speed through rbd from small kvm instance running on one o=
f
>>>>>> first two machines - when bench gave me about 110Mb/s, writing z=
eros
>>>>>> to raw block device inside vm with dd was at top speed about 45 =
mb/s,
>>>>>> for vm`fs (ext4 with default options) performance drops to ~23Mb=
/s.
>>>>>> Things get worse, when I`ve started second vm at second host and=
 tried
>>>>>> to continue same dd tests simultaneously - performance fairly di=
vided
>>>>>> by half for each instance :). Enabling jumbo frames, playing wit=
h cpu
>>>>>> affinity for ceph and vm instances and trying different TCP cong=
estion
>>>>>> protocols gave no effect at all - with DCTCP I have slightly smo=
other
>>>>>> network load graph and that`s all.
>>>>>>
>>>>>> Can ml please suggest anything to try to improve performance?
>>>>>
>>>>>
>>>>> Can you try setting
>>>>>
>>>>> rbd writeback window =3D 8192000
>>>>>
>>>>> or similar, and see what kind of effect that has? I suspect it'll=
 speed
>>>>> up dd; I'm less sure about ext3.
>>>>>
>>>>> Thanks!
>>>>> sage
>>>>>
>>>>>
>>>>>>
>>>>>> ceph-0.43, libvirt-0.9.8, qemu-1.0.0, kernel 3.2
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel"
>>>>>> in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> (mailto:majordomo@vger.kernel.org)
>>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.htm=
l
>>>>>
>>>>>
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> (mailto:majordomo@vger.kernel.org)
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
