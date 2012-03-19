From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Mysteriously poor write performance
Date: Mon, 19 Mar 2012 21:13:44 +0300
Message-ID: <CABYiri9omWz_vSZxL_McYg5bMoW20x6TBCsXHTHwgZ0hqUxofA@mail.gmail.com>
References: <CABYiri-C1ftxsM3dWqtcRzXBYoddRbHug=TA6j+0EY-cuMt3Mw@mail.gmail.com>
 <Pine.LNX.4.64.1203181121460.580@cobra.newdream.net> <CABYiri9hcWdPv5Xs_X6S+tM6-U_uGq68pnTzetc=cVxK7NiNQg@mail.gmail.com>
 <4825A243C5604C48A3E022008ED974D0@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:46600 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031260Ab2CSSOH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Mar 2012 14:14:07 -0400
Received: by wejx9 with SMTP id x9so6085912wej.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Mar 2012 11:14:05 -0700 (PDT)
In-Reply-To: <4825A243C5604C48A3E022008ED974D0@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Nope, I`m using KVM for rbd guests. Surely I`ve been noticed that Sage
mentioned too small value and I`ve changed it to 64M before posting
previous message with no success - both 8M and this value cause a
performance drop. When I tried to wrote small amount of data that can
be compared to writeback cache size(both on raw device and ext3 with
sync option), following results were made:
dd if=/dev/zero of=/var/img.1 bs=10M count=10 oflag=direct (almost
same without oflag there and in the following samples)
10+0 records in
10+0 records out
104857600 bytes (105 MB) copied, 0.864404 s, 121 MB/s
dd if=/dev/zero of=/var/img.1 bs=10M count=20 oflag=direct
20+0 records in
20+0 records out
209715200 bytes (210 MB) copied, 6.67271 s, 31.4 MB/s
dd if=/dev/zero of=/var/img.1 bs=10M count=30 oflag=direct
30+0 records in
30+0 records out
314572800 bytes (315 MB) copied, 12.4806 s, 25.2 MB/s

and so on. Reference test with bs=1M and count=2000 has slightly worse
results _with_ writeback cache than without, as I`ve mentioned before.
 Here the bench results, they`re almost equal on both nodes:

bench: wrote 1024 MB in blocks of 4096 KB in 9.037468 sec at 113 MB/sec

Also, because I`ve not mentioned it before, network performance is
enough to hold fair gigabit connectivity with MTU 1500. Seems that it
is not interrupt problem or something like it - even if ceph-osd,
ethernet card queues and kvm instance pinned to different sets of
cores, nothing changes.

On Mon, Mar 19, 2012 at 8:59 PM, Greg Farnum
<gregory.farnum@dreamhost.com> wrote:
> It sounds like maybe you're using Xen? The "rbd writeback window" option only works for userspace rbd implementations (eg, KVM).
> If you are using KVM, you probably want 81920000 (~80MB) rather than 8192000 (~8MB).
>
> What options are you running dd with? If you run a rados bench from both machines, what do the results look like?
> Also, can you do the ceph osd bench on each of your OSDs, please? (http://ceph.newdream.net/wiki/Troubleshooting#OSD_performance)
> -Greg
>
>
> On Monday, March 19, 2012 at 6:46 AM, Andrey Korolyov wrote:
>
>> More strangely, writing speed drops down by fifteen percent when this
>> option was set in vm` config(instead of result from
>> http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg03685.html).
>> As I mentioned, I`m using 0.43, but due to crashed osds, ceph has been
>> recompiled with e43546dee9246773ffd6877b4f9495f1ec61cd55 and
>> 1468d95101adfad44247016a1399aab6b86708d2 - both cases caused crashes
>> under heavy load.
>>
>> On Sun, Mar 18, 2012 at 10:22 PM, Sage Weil <sage@newdream.net (mailto:sage@newdream.net)> wrote:
>> > On Sat, 17 Mar 2012, Andrey Korolyov wrote:
>> > > Hi,
>> > >
>> > > I`ve did some performance tests at the following configuration:
>> > >
>> > > mon0, osd0 and mon1, osd1 - two twelve-core r410 with 32G ram, mon2 -
>> > > dom0 with three dedicated cores and 1.5G, mostly idle. First three
>> > > disks on each r410 arranged into raid0 and holds osd data when fourth
>> > > holds os and osd` journal partition, all ceph-related stuff mounted on
>> > > the ext4 without barriers.
>> > >
>> > > Firstly, I`ve noticed about a difference of benchmark performance and
>> > > write speed through rbd from small kvm instance running on one of
>> > > first two machines - when bench gave me about 110Mb/s, writing zeros
>> > > to raw block device inside vm with dd was at top speed about 45 mb/s,
>> > > for vm`fs (ext4 with default options) performance drops to ~23Mb/s.
>> > > Things get worse, when I`ve started second vm at second host and tried
>> > > to continue same dd tests simultaneously - performance fairly divided
>> > > by half for each instance :). Enabling jumbo frames, playing with cpu
>> > > affinity for ceph and vm instances and trying different TCP congestion
>> > > protocols gave no effect at all - with DCTCP I have slightly smoother
>> > > network load graph and that`s all.
>> > >
>> > > Can ml please suggest anything to try to improve performance?
>> >
>> > Can you try setting
>> >
>> > rbd writeback window = 8192000
>> >
>> > or similar, and see what kind of effect that has? I suspect it'll speed
>> > up dd; I'm less sure about ext3.
>> >
>> > Thanks!
>> > sage
>> >
>> >
>> > >
>> > > ceph-0.43, libvirt-0.9.8, qemu-1.0.0, kernel 3.2
>> > > --
>> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > > the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
>> > > More majordomo info at http://vger.kernel.org/majordomo-info.html
>> >
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>
>
