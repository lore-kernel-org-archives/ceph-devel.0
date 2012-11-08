From: Dietmar Maurer <dietmar@proxmox.com>
Subject: RE: less cores more iops / speed
Date: Thu, 8 Nov 2012 05:49:54 +0000
Message-ID: <24E144B8C0207547AD09C467A8259F75577ED87B@lisa.maurer-it.com>
References: <509ADA6A.9000807@profihost.ag>
 <24E144B8C0207547AD09C467A8259F75577ED836@lisa.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.maurer-it.com ([213.129.239.114]:55669 "EHLO
	proxmox.maurer-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab2KHFt5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 00:49:57 -0500
In-Reply-To: <24E144B8C0207547AD09C467A8259F75577ED836@lisa.maurer-it.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>, Stefan Priebe <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> > I've noticed something really interesting.
> >
> > I get 5000 iops / VM for rand. 4k writes while assigning 4 cores on a
> > 2.5 Ghz Xeon.
> >
> > When i move this VM to another kvm host with 3.6Ghz i get 8000 iops
> > (still 8
> > cores) when i then LOWER the assigned cores from 8 to 4 i get
> > 14.500 iops. If i assign only 2 cores i get 16.000 iops...
> >
> > Why does less kvm cores mean more speed?
> 
> There is a serious bug in the kvm vhost code. Do you use virtio-net with
> vhost?
> 
> see: http://lists.nongnu.org/archive/html/qemu-devel/2012-
> 11/msg00579.html
> 
> Please test using the e1000 driver instead.

Or update the guest kernel (what guest kernel do you use?). AFAIK 3.X kernels does not trigger the bug.

