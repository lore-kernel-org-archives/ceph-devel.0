From: Thomas Mueller <thomas@chaschperli.ch>
Subject: simple performance tests
Date: Wed, 16 Jun 2010 09:15:43 +0000 (UTC)
Message-ID: <hva4nu$2nr$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:52412 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249Ab0FPJP4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Jun 2010 05:15:56 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OOoiv-00052v-QS
	for ceph-devel@vger.kernel.org; Wed, 16 Jun 2010 11:15:53 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jun 2010 11:15:53 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jun 2010 11:15:53 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

i've done some performance tests on a small system.

HW:
* Supermicro X7SPA-HF (with IMPI and KVMoverIP integrated))
* Atom D510 1.6GHz DualCore and HT
* WD RE3 500GB 7200umin disks
* 4GB RAM

SW:
* Debian 5.0 "Lenny"
* Kernel 2.6.32 (backports.org)
* ceph/unstable
* ceph-client-standalone/unstable-backport

values are MB/s. all tests are local.

dbench 1 results:
* 1 disk, btrfs: 115
* 2 disks, btrfs data/metadata raid0: 115
* 1 osd/disk, 1 mds, 1 mon: 7
* 2 osd/disk, 1 mds, 1mon: 6.2117
* 1 disk, btrfs, samba: 14.02
* 2 disks, btrfs data/metadata raid0, samba: 13.781

dbench 10 results:
* 1 disk, btrfs: 271.724
* 2 disks, btrfs data/metadata raid0: 270.043
* 1 osd/disk, 1 mds, 1 mon: -
* 2 osd/disk, 1 mds, 1mon: 12.1862
* 1 disk, btrfs, samba: 20.22
* 2 disks, btfs data/metadata raid0, samba: 20.26

dd bs=1M count=8192 if=/dev/zero
* 1 disk, btrfs: 126
* 2 disks, btrfs data/metadata raid0:  271
* 1 osd/disk, 1 mds, 1 mon: -
* 2 osd/disk, 1 mds, 1mon: 51.2
* 1 disk, btrfs, samba: 95.2
* 2 disks, btrfs data/metadata raid0, samba: 85.9

will add a AOC-USAS-H8iR (LSI) RAID card to the mix if  i get the cables 
needed.

i'm a bit suprised about the low rates of ceph. i'll try to to the same 
tests on a more powerfull machine. 

- Thomas

