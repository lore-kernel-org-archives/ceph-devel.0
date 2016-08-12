From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Jemalloc enabled build is failing
Date: Fri, 12 Aug 2016 00:17:52 +0000
Message-ID: <BL2PR02MB21155D6B967D81A35FB55C2CF41F0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam01on0063.outbound.protection.outlook.com ([104.47.32.63]:31072
	"EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750708AbcHLAR4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Aug 2016 20:17:56 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
I was planning to report this for long but keep on forgetting. Basically, if I enable jemalloc  on ceph build , it is failing for me with the following error.

Makefile:16236: recipe for target 'ceph_objectstore_bench' failed
make[3]: *** [ceph_objectstore_bench] Error 1
rocksdb/librocksdb.a(db_impl.o): In function `DumpMallocStats':
/root/ceph-master/src/rocksdb/db/db_impl.cc:595: undefined reference to `malloc_stats_print'
rocksdb/librocksdb.a(db_impl.o): In function `DumpMallocStats':
/root/ceph-master/src/rocksdb/db/db_impl.cc:595: undefined reference to `malloc_stats_print'
collect2: error: ld returned 1 exit status
Makefile:16792: recipe for target 'ceph_test_objectstore' failed
make[3]: *** [ceph_test_objectstore] Error 1
collect2: error: ld returned 1 exit status
Makefile:16359: recipe for target 'ceph_smalliobenchfs' failed
make[3]: *** [ceph_smalliobenchfs] Error 1
rocksdb/librocksdb.a(db_impl.o): In function `DumpMallocStats':
/root/ceph-master/src/rocksdb/db/db_impl.cc:595: undefined reference to `malloc_stats_print'


I am commenting out the following line (and do a make clean on rocksdb folder) in src/rocksdb/db/db_impl.cc to make build go through.

malloc_stats_print(GetJemallocStatus, &mstat, "");



Thanks & Regards
Somnath
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
