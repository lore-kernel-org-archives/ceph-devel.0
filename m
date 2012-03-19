From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Mysteriously poor write performance
Date: Mon, 19 Mar 2012 11:25:49 -0700
Message-ID: <EB35F9C3E64D42BF8669C1AAFE2A6ABB@dreamhost.com>
References: <CABYiri-C1ftxsM3dWqtcRzXBYoddRbHug=TA6j+0EY-cuMt3Mw@mail.gmail.com>
 <Pine.LNX.4.64.1203181121460.580@cobra.newdream.net>
 <CABYiri9hcWdPv5Xs_X6S+tM6-U_uGq68pnTzetc=cVxK7NiNQg@mail.gmail.com>
 <4825A243C5604C48A3E022008ED974D0@dreamhost.com>
 <CABYiri9omWz_vSZxL_McYg5bMoW20x6TBCsXHTHwgZ0hqUxofA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45410 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030328Ab2CSSZw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Mar 2012 14:25:52 -0400
Received: by mail-yx0-f174.google.com with SMTP id l12so5697617yen.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Mar 2012 11:25:52 -0700 (PDT)
In-Reply-To: <CABYiri9omWz_vSZxL_McYg5bMoW20x6TBCsXHTHwgZ0hqUxofA@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel@vger.kernel.org

On Monday, March 19, 2012 at 11:13 AM, Andrey Korolyov wrote:
> Nope, I`m using KVM for rbd guests.

Ah, okay =E2=80=94 I'm not sure what your reference to dom0 and mon2 me=
ant, then?
 =20
> Surely I`ve been noticed that Sage
> mentioned too small value and I`ve changed it to 64M before posting
> previous message with no success - both 8M and this value cause a
> performance drop. When I tried to wrote small amount of data that can
> be compared to writeback cache size(both on raw device and ext3 with
> sync option), following results were made:
> dd if=3D/dev/zero of=3D/var/img.1 bs=3D10M count=3D10 oflag=3Ddirect =
(almost
> same without oflag there and in the following samples)
> 10+0 records in
> 10+0 records out
> 104857600 bytes (105 MB) copied, 0.864404 s, 121 MB/s
> dd if=3D/dev/zero of=3D/var/img.1 bs=3D10M count=3D20 oflag=3Ddirect
> 20+0 records in
> 20+0 records out
> 209715200 bytes (210 MB) copied, 6.67271 s, 31.4 MB/s
> dd if=3D/dev/zero of=3D/var/img.1 bs=3D10M count=3D30 oflag=3Ddirect
> 30+0 records in
> 30+0 records out
> 314572800 bytes (315 MB) copied, 12.4806 s, 25.2 MB/s
> =20
> and so on. Reference test with bs=3D1M and count=3D2000 has slightly =
worse
> results _with_ writeback cache than without, as I`ve mentioned before=
=2E
> Here the bench results, they`re almost equal on both nodes:
> =20
> bench: wrote 1024 MB in blocks of 4096 KB in 9.037468 sec at 113 MB/s=
ec
Okay, this is all a little odd to me. Can you send along your ceph.conf=
 (along with any other pool config changes you've made) and the output =
from a rados bench (60 seconds or so)?
-Greg
 =20
> =20
> Also, because I`ve not mentioned it before, network performance is
> enough to hold fair gigabit connectivity with MTU 1500. Seems that it
> is not interrupt problem or something like it - even if ceph-osd,
> ethernet card queues and kvm instance pinned to different sets of
> cores, nothing changes.
> =20
> On Mon, Mar 19, 2012 at 8:59 PM, Greg Farnum
> <gregory.farnum@dreamhost.com (mailto:gregory.farnum@dreamhost.com)> =
wrote:
> > It sounds like maybe you're using Xen? The "rbd writeback window" o=
ption only works for userspace rbd implementations (eg, KVM).
> > If you are using KVM, you probably want 81920000 (~80MB) rather tha=
n 8192000 (~8MB).
> > =20
> > What options are you running dd with? If you run a rados bench from=
 both machines, what do the results look like?
> > Also, can you do the ceph osd bench on each of your OSDs, please? (=
http://ceph.newdream.net/wiki/Troubleshooting#OSD_performance)
> > -Greg
> > =20
> > =20
> > On Monday, March 19, 2012 at 6:46 AM, Andrey Korolyov wrote:
> > =20
> > > More strangely, writing speed drops down by fifteen percent when =
this
> > > option was set in vm` config(instead of result from
> > > http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg03685.h=
tml).
> > > As I mentioned, I`m using 0.43, but due to crashed osds, ceph has=
 been
> > > recompiled with e43546dee9246773ffd6877b4f9495f1ec61cd55 and
> > > 1468d95101adfad44247016a1399aab6b86708d2 - both cases caused cras=
hes
> > > under heavy load.
> > > =20
> > > On Sun, Mar 18, 2012 at 10:22 PM, Sage Weil <sage@newdream.net (m=
ailto:sage@newdream.net)> wrote:
> > > > On Sat, 17 Mar 2012, Andrey Korolyov wrote:
> > > > > Hi,
> > > > > =20
> > > > > I`ve did some performance tests at the following configuratio=
n:
> > > > > =20
> > > > > mon0, osd0 and mon1, osd1 - two twelve-core r410 with 32G ram=
, mon2 -
> > > > > dom0 with three dedicated cores and 1.5G, mostly idle. First =
three
> > > > > disks on each r410 arranged into raid0 and holds osd data whe=
n fourth
> > > > > holds os and osd` journal partition, all ceph-related stuff m=
ounted on
> > > > > the ext4 without barriers.
> > > > > =20
> > > > > Firstly, I`ve noticed about a difference of benchmark perform=
ance and
> > > > > write speed through rbd from small kvm instance running on on=
e of
> > > > > first two machines - when bench gave me about 110Mb/s, writin=
g zeros
> > > > > to raw block device inside vm with dd was at top speed about =
45 mb/s,
> > > > > for vm`fs (ext4 with default options) performance drops to ~2=
3Mb/s.
> > > > > Things get worse, when I`ve started second vm at second host =
and tried
> > > > > to continue same dd tests simultaneously - performance fairly=
 divided
> > > > > by half for each instance :). Enabling jumbo frames, playing =
with cpu
> > > > > affinity for ceph and vm instances and trying different TCP c=
ongestion
> > > > > protocols gave no effect at all - with DCTCP I have slightly =
smoother
> > > > > network load graph and that`s all.
> > > > > =20
> > > > > Can ml please suggest anything to try to improve performance?
> > > > =20
> > > > Can you try setting
> > > > =20
> > > > rbd writeback window =3D 8192000
> > > > =20
> > > > or similar, and see what kind of effect that has? I suspect it'=
ll speed
> > > > up dd; I'm less sure about ext3.
> > > > =20
> > > > Thanks!
> > > > sage
> > > > =20
> > > > =20
> > > > > =20
> > > > > ceph-0.43, libvirt-0.9.8, qemu-1.0.0, kernel 3.2
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe cep=
h-devel" in
> > > > > the body of a message to majordomo@vger.kernel.org (mailto:ma=
jordomo@vger.kernel.org)
> > > > > More majordomo info at http://vger.kernel.org/majordomo-info.=
html
> > > > =20
> > > =20
> > > =20
> > > =20
> > > =20
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
> > > the body of a message to majordomo@vger.kernel.org (mailto:majord=
omo@vger.kernel.org)
> > > More majordomo info at http://vger.kernel.org/majordomo-info.html
> > =20
> =20
> =20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@=
vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
