From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] Ceph + Xen - RBD io hang
Date: Tue, 27 Aug 2013 08:27:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308270827280.2000@cobra.newdream.net>
References: <521C8368.6040102@zynstra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49951 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449Ab3H0P1u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Aug 2013 11:27:50 -0400
In-Reply-To: <521C8368.6040102@zynstra.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Dingwall <james.dingwall@zynstra.com>
Cc: ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org

Hi James,

Can you post the contents of the hung task warning so we can see where it 
is stuck?

Thanks!
sage


On Tue, 27 Aug 2013, James Dingwall wrote:

> Hi,
> 
> I am doing some experimentation with Ceph and Xen (on the same host) and I'm
> experiencing some problems with the rbd device that I'm using as the block
> device.  My environment is:
> 
> 2 node Ceph 0.67.2 cluster, 4x OSD (btrfs) and 1x mon
> Xen 4.3.0
> Kernel 3.10.9
> 
> The domU I'm trying to build is from the Ubuntu 13.04 desktop release.  When I
> pass through the rbd (format 1 or 2) device as phy:/dev/rbd/rbd/ubuntu-test
> then the domU has no problems reading data from it, the test I ran was:
> 
> for i in $(seq 0 1023) ; do
>     dd if=/dev/xvda of=/dev/null bs=4k count=1024 skip=$(($i * 4))
> done
> 
> However writing data causes the domU to hang while while i is still in single
> figures but it doesn't seem consistent about the exact value.
> for i in $(seq 0 1023) ; do
>     dd of=/dev/xvda of=/dev/zero bs=4k count=1024 seek=$(($i * 4))
> done
> 
> eventually the kernel in the domU will print a hung task warning.  I have
> tried the domU as pv and hvm (with xen_platform_pci = 1 and 0) but have the
> same behaviour in both cases.  Once this state is triggered on the rbd device
> then any interaction with it in dom0 will result in the same hang.  I'm
> assuming that there is some unfavourable interaction between ceph/rbd and
> blkback but I haven't found anything in the dom0 logs so I would like to know
> if anyone has some suggestions about where to start trying to hunt this down.
> 
> Thanks,
> James
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
