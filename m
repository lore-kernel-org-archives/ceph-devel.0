From: Ramesh Chander <Ramesh.Chander@sandisk.com>
Subject: master build failing
Date: Mon, 13 Jun 2016 18:09:59 +0000
Message-ID: <CY1PR0201MB18209702FEAD607B802AC66985530@CY1PR0201MB1820.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0084.outbound.protection.outlook.com ([65.55.169.84]:8464
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932082AbcFMSKE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jun 2016 14:10:04 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: "Mark Nelson (mnelson@redhat.com)" <mnelson@redhat.com>, dl-storm-dev <dl-storm-dev@sandisk.com>

Getting these linker errors:

/root/ram/ram_bkp/ceph/ceph-latest/ceph_unit_issue/src/rocksdb/db/db_impl.cc:583: undefined reference to `malloc_stats_print'
collect2: error: ld returned 1 exit status
make[3]: *** [ceph_test_objectstore_workloadgen] Error 1
rocksdb/librocksdb.a(db_impl.o): In function `DumpMallocStats':
/root/ram/ram_bkp/ceph/ceph-latest/ceph_unit_issue/src/rocksdb/db/db_impl.cc:583: undefined reference to `malloc_stats_print'
collect2: error: ld returned 1 exit status
make[3]: *** [ceph_test_objectstore] Error 1
rocksdb/librocksdb.a(db_impl.o): In function `DumpMallocStats':
/root/ram/ram_bkp/ceph/ceph-latest/ceph_unit_issue/src/rocksdb/db/db_impl.cc:583: undefined reference to `malloc_stats_print'
collect2: error: ld returned 1 exit status
make[3]: *** [ceph_xattr_bench] Error 1
rocksdb/librocksdb.a(db_impl.o): In function `DumpMallocStats':
/root/ram/ram_bkp/ceph/ceph-latest/ceph_unit_issue/src/rocksdb/db/db_impl.cc:583: undefined reference to `malloc_stats_print'
collect2: error: ld returned 1 exit status
make[3]: *** [ceph_test_filejournal] Error 1

last time Mark did something to fix it.

I tried make clean in rocksdb directory as well, still same error.

-Ramesh Chander
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
