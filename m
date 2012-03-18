From: Sage Weil <sage@newdream.net>
Subject: Re: Mysteriously poor write performance
Date: Sun, 18 Mar 2012 11:22:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203181121460.580@cobra.newdream.net>
References: <CABYiri-C1ftxsM3dWqtcRzXBYoddRbHug=TA6j+0EY-cuMt3Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43250 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288Ab2CRSWw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Mar 2012 14:22:52 -0400
In-Reply-To: <CABYiri-C1ftxsM3dWqtcRzXBYoddRbHug=TA6j+0EY-cuMt3Mw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel@vger.kernel.org

On Sat, 17 Mar 2012, Andrey Korolyov wrote:
> Hi,
> 
> I`ve did some performance tests at the following configuration:
> 
> mon0, osd0 and mon1, osd1 - two twelve-core r410 with 32G ram, mon2 -
> dom0 with three dedicated cores and 1.5G, mostly idle. First three
> disks on each r410 arranged into raid0 and holds osd data when fourth
> holds os and osd` journal partition, all ceph-related stuff mounted on
> the ext4 without barriers.
> 
> Firstly, I`ve noticed about a difference of benchmark performance and
> write speed through rbd from small kvm instance running on one of
> first two machines - when bench gave me about 110Mb/s, writing zeros
> to raw block device inside vm with dd was at top speed about 45 mb/s,
> for vm`fs (ext4 with default options) performance drops to ~23Mb/s.
> Things get worse, when I`ve started second vm at second host and tried
> to continue same dd tests simultaneously - performance fairly divided
> by half for each instance :). Enabling jumbo frames, playing with cpu
> affinity for ceph and vm instances and trying different TCP congestion
> protocols gave no effect at all - with DCTCP I have slightly smoother
> network load graph and that`s all.
> 
> Can ml please suggest anything to try to improve performance?

Can you try setting

	rbd writeback window = 8192000

or similar, and see what kind of effect that has?  I suspect it'll speed 
up dd; I'm less sure about ext3.

Thanks!
sage


> 
> ceph-0.43, libvirt-0.9.8, qemu-1.0.0, kernel 3.2
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
