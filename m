From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Mysteriously poor write performance
Date: Mon, 19 Mar 2012 09:59:08 -0700
Message-ID: <4825A243C5604C48A3E022008ED974D0@dreamhost.com>
References: <CABYiri-C1ftxsM3dWqtcRzXBYoddRbHug=TA6j+0EY-cuMt3Mw@mail.gmail.com>
 <Pine.LNX.4.64.1203181121460.580@cobra.newdream.net>
 <CABYiri9hcWdPv5Xs_X6S+tM6-U_uGq68pnTzetc=cVxK7NiNQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65437 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162262Ab2CSQ7M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Mar 2012 12:59:12 -0400
Received: by gghe5 with SMTP id e5so5620458ggh.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Mar 2012 09:59:11 -0700 (PDT)
In-Reply-To: <CABYiri9hcWdPv5Xs_X6S+tM6-U_uGq68pnTzetc=cVxK7NiNQg@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel@vger.kernel.org

It sounds like maybe you're using Xen? The "rbd writeback window" option only works for userspace rbd implementations (eg, KVM). 
If you are using KVM, you probably want 81920000 (~80MB) rather than 8192000 (~8MB).

What options are you running dd with? If you run a rados bench from both machines, what do the results look like?
Also, can you do the ceph osd bench on each of your OSDs, please? (http://ceph.newdream.net/wiki/Troubleshooting#OSD_performance)
-Greg


On Monday, March 19, 2012 at 6:46 AM, Andrey Korolyov wrote:

> More strangely, writing speed drops down by fifteen percent when this
> option was set in vm` config(instead of result from
> http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg03685.html).
> As I mentioned, I`m using 0.43, but due to crashed osds, ceph has been
> recompiled with e43546dee9246773ffd6877b4f9495f1ec61cd55 and
> 1468d95101adfad44247016a1399aab6b86708d2 - both cases caused crashes
> under heavy load.
> 
> On Sun, Mar 18, 2012 at 10:22 PM, Sage Weil <sage@newdream.net (mailto:sage@newdream.net)> wrote:
> > On Sat, 17 Mar 2012, Andrey Korolyov wrote:
> > > Hi,
> > > 
> > > I`ve did some performance tests at the following configuration:
> > > 
> > > mon0, osd0 and mon1, osd1 - two twelve-core r410 with 32G ram, mon2 -
> > > dom0 with three dedicated cores and 1.5G, mostly idle. First three
> > > disks on each r410 arranged into raid0 and holds osd data when fourth
> > > holds os and osd` journal partition, all ceph-related stuff mounted on
> > > the ext4 without barriers.
> > > 
> > > Firstly, I`ve noticed about a difference of benchmark performance and
> > > write speed through rbd from small kvm instance running on one of
> > > first two machines - when bench gave me about 110Mb/s, writing zeros
> > > to raw block device inside vm with dd was at top speed about 45 mb/s,
> > > for vm`fs (ext4 with default options) performance drops to ~23Mb/s.
> > > Things get worse, when I`ve started second vm at second host and tried
> > > to continue same dd tests simultaneously - performance fairly divided
> > > by half for each instance :). Enabling jumbo frames, playing with cpu
> > > affinity for ceph and vm instances and trying different TCP congestion
> > > protocols gave no effect at all - with DCTCP I have slightly smoother
> > > network load graph and that`s all.
> > > 
> > > Can ml please suggest anything to try to improve performance?
> > 
> > Can you try setting
> > 
> > rbd writeback window = 8192000
> > 
> > or similar, and see what kind of effect that has? I suspect it'll speed
> > up dd; I'm less sure about ext3.
> > 
> > Thanks!
> > sage
> > 
> > 
> > > 
> > > ceph-0.43, libvirt-0.9.8, qemu-1.0.0, kernel 3.2
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> > > More majordomo info at http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



