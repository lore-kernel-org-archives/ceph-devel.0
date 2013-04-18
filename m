From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: poor write performance
Date: Thu, 18 Apr 2013 23:23:12 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B4D73695A@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au>
 <516FF893.1030309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:49786 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966999Ab3DRXnF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 19:43:05 -0400
In-Reply-To: <516FF893.1030309@inktank.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> > Where should I start looking for performance problems? I've tried running
> > some of the benchmark stuff in the documentation but I haven't gotten very
> > far...
> 
> Hi James!  Sorry to hear about the performance trouble!  Is it just
> sequential 4KB direct IO writes that are giving you troubles?  If you
> are using the kernel version of RBD, we don't have any kind of cache
> implemented there and since you are bypassing the pagecache on the
> client, those writes are being sent to the different OSDs in 4KB chunks
> over the network.  RBD stores data in blocks that are represented by 4MB
> objects on one of the OSDs, so without cache a lot of sequential 4KB
> writes will be hitting 1 OSD repeatedly and then moving on to the next
> one.  Hopefully those writes would get aggregated at the OSD level, but
> clearly that's not really happening here given your performance.

Using dd I tried various block sizes. With 4kb I was getting around 500kbytes/second rate. With 1MB I was getting a few mbytes/second. Read performance seems great though.

> Here's a couple of thoughts:
> 
> 1) If you are working with VMs, using the QEMU/KVM interface with virtio
> drivers and RBD cache enabled will give you a huge jump in small
> sequential write performance relative to what you are seeing now.

I'm using Xen so that won't work for me right now, although I did notice someone posted some blktap code to support ceph.

I'm trying a windows restore of a physical machine into a VM under Xen and performance matches what I am seeing with dd - very very slow.

> 2) You may want to try upgrading to 0.60.  We made a change to how the
> pg_log works that causes fewer disk seeks during small IO, especially
> with XFS.

Do packages for this exist for Debian? At the moment my sources.list contains "ceph.com/debian-bobtail wheezy main".

> 3) If you are still having trouble, testing your network, disk speeds,
> and using rados bench to test the object store all may be helpful.
> 

I tried that and while the write worked the seq test always said I had to do a write test first.

While running my Xen restore, /var/log/ceph/ceph.log looks like:

pgmap v18316: 832 pgs: 832 active+clean; 61443 MB data, 119 GB used, 1742 GB / 1862 GB avail; 824KB/s wr, 12op/s
pgmap v18317: 832 pgs: 832 active+clean; 61446 MB data, 119 GB used, 1742 GB / 1862 GB avail; 649KB/s wr, 10op/s
pgmap v18318: 832 pgs: 832 active+clean; 61449 MB data, 119 GB used, 1742 GB / 1862 GB avail; 652KB/s wr, 10op/s
pgmap v18319: 832 pgs: 832 active+clean; 61452 MB data, 119 GB used, 1742 GB / 1862 GB avail; 614KB/s wr, 9op/s
pgmap v18320: 832 pgs: 832 active+clean; 61454 MB data, 119 GB used, 1742 GB / 1862 GB avail; 537KB/s wr, 8op/s
pgmap v18321: 832 pgs: 832 active+clean; 61457 MB data, 119 GB used, 1742 GB / 1862 GB avail; 511KB/s wr, 7op/s

James

