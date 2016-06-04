From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Bluestore crash in mkfs
Date: Sat, 4 Jun 2016 02:16:34 +0000
Message-ID: <BL2PR02MB21151DAE1DAF64B6CC74D01FF45A0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0085.outbound.protection.outlook.com ([157.56.110.85]:39686
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751195AbcFDCQi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jun 2016 22:16:38 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil (sage@newdream.net)" <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sage,
Latest code in Bluestore is crashing on me during mkfs. Here is the dump.

ceph version 10.2.0-1809-gac8c40f (ac8c40f3e3257517f71d2af8bd26dcd264887b7f)
 1: (()+0x99e65e) [0x55cf5263565e]
 2: (()+0x113d0) [0x7f323526f3d0]
 3: (rocksdb::ColumnFamilyOptions::ColumnFamilyOptions(rocksdb::Options const&)+0x59) [0x55cf525d4ce9]
 4: (rocksdb::GetOptionsFromString(rocksdb::Options const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, rocksdb::Options*)+0x15a) [0x55cf525dc74a]
 5: (RocksDBStore::ParseOptionsFromString(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, rocksdb::Options&)+0x22e) [0x55cf524f58be]
 6: (RocksDBStore::init(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >)+0x77) [0x55cf524f5f17]
 7: (BlueStore::_open_db(bool)+0x274) [0x55cf5234b9e4]
 8: (BlueStore::mkfs()+0x899) [0x55cf52361ad9]
 9: (OSD::mkfs(CephContext*, ObjectStore*, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, uuid_d, int)+0x117) [0x55cf52001427]
 10: (main()+0x1003) [0x55cf51f9f2e3]
 11: (__libc_start_main()+0xf0) [0x7f32331fa830]
 12: (_start()+0x29) [0x55cf51fe2719]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.


I am using the following option :

       devs = /dev/sdb1
       bluestore_block_path = /dev/sdb2

Am I missing anything ?

Thanks & Regards
Somnath
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
