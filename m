From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: common/Mutex.h assertion failure
Date: Sat, 4 Dec 2010 12:59:24 -0800
Message-ID: <0BBB72FF-958F-4C60-AA1C-F65AD7342285@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:51386 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755945Ab0LDU7Z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Dec 2010 15:59:25 -0500
Received: from [192.168.51.138] (soenat3.cse.ucsc.edu [128.114.60.41])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTP id 60A341009B93
	for <ceph-devel@vger.kernel.org>; Sat,  4 Dec 2010 12:59:25 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm receiving this assertion failure using the latest unstable tree built as a deb file.

Thanks,
Noah

--- node1# /usr/bin/cosd -c /etc/ceph/ceph.conf --monmap /tmp/monmap.5741 -i 0 --mkfs --osd-data /data/osd0
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
 ** WARNING: 'filestore btrfs snap' is enabled (for safe transactions,
             rollback), but btrfs does not support the SNAP_CREATE_ASYNC ioctl
             (added in Linux 2.6.37).  Expect slow btrfs sync/commit
             performance.
 ** WARNING: No osd journal is configured: write latency may be high.
             If you will not be using an osd journal, write latency may be
             relatively high.  It can be reduced somewhat by lowering
             filestore_max_sync_interval, but lower values mean lower write
             throughput, especially with spinning disks.
./common/Mutex.h: In function 'void Mutex::Lock(bool)':
./common/Mutex.h:118: FAILED assert(r == 0)
 ceph version 0.25~rc (commit:63fab458f625f953f3f98d94b4cb56cf3293eab8)
 1: (JournalingObjectStore::op_journal_transactions(std::list<ObjectStore::Transaction*, std::allocator<ObjectStore::Transaction*> >&, unsigned long, Context*)+0x10d) [0x5725cd]
 2: (FileStore::queue_transactions(ObjectStore::Sequencer*, std::list<ObjectStore::Transaction*, std::allocator<ObjectStore::Transaction*> >&, Context*, Context*, Context*)+0x9b) [0x56a2cb]
 3: (FileStore::apply_transactions(std::list<ObjectStore::Transaction*, std::allocator<ObjectStore::Transaction*> >&, Context*)+0x168) [0x555fc8]
 4: (FileStore::apply_transaction(ObjectStore::Transaction&, Context*)+0x4e) [0x55317e]
 5: (OSD::mkfs(char const*, char const*, ceph_fsid, int)+0x9e5) [0x4cbfe5]
 6: (main()+0xfd6) [0x4538d6]
 7: (__libc_start_main()+0xfe) [0x7fa44624dd8e]
 8: /usr/bin/cosd() [0x452729]

