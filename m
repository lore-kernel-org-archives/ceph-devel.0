From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Bluestore Bitmap allocator crash
Date: Thu, 21 Jul 2016 01:44:09 +0000
Message-ID: <BL2PR02MB211503A698A90F23CC6BF383F4090@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-dm3nam03on0080.outbound.protection.outlook.com ([104.47.41.80]:15632
	"EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753453AbcGUBoO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jul 2016 21:44:14 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ramesh Chander <Ramesh.Chander@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Ramesh,
I am hitting the following crash during IO path the moment I started io.

os/bluestore/BitMapAllocator.cc: 76: FAILED assert(!(off % m_block_size))

 ceph version 11.0.0-696-ga3438ba (a3438bac71a54cb43e5feb93ad09228bf69942ae)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x80) [0x55804242de40]
 2: (BitMapAllocator::insert_free(unsigned long, unsigned long)+0x2e3) [0x558042132813]
 3: (BitMapAllocator::commit_finish()+0x2a5) [0x558042132e55]
 4: (BlueStore::_kv_sync_thread()+0x142d) [0x558041fff61d]
 5: (BlueStore::KVSyncThread::entry()+0xd) [0x558042028c2d]
 6: (Thread::entry_wrapper()+0x75) [0x55804240d755]
 7: (()+0x76fa) [0x7f36699076fa]
 8: (clone()+0x6d) [0x7f3667767b5d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.


What I did :
------------

1. I have a separate wal partition to a nvram device

2. change min_alloc_size to 16K

3. ran 4k rw.

Let me know if you need further details.

Thanks & Regards
Somnath



PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
