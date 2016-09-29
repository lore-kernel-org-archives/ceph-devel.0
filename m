From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Master build failure with jemalloc
Date: Thu, 29 Sep 2016 04:25:34 +0000
Message-ID: <MWHPR02MB26393FE04E6A5712E18142EFE2CE0@MWHPR02MB2639.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn3nam01on0065.outbound.protection.outlook.com ([104.47.33.65]:62592
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750879AbcI2EZh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 29 Sep 2016 00:25:37 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I am facing a cmake build issue with jemalloc and latest master.
Did anyone face same issue?

Linking CXX executable ../../../bin/ceph_test_filestore_idempotent
collect2: error: ld returned 1 exit status
make[2]: *** [bin/ceph_test_keyvaluedb_iterators] Error 1
make[1]: ***
[src/test/ObjectMap/CMakeFiles/ceph_test_keyvaluedb_iterators.dir/all]
Error 2
../../../../src/rocksdb/librocksdb.a(db_impl.o): In function
`DumpMallocStats':
/home/ems/varada/mnt/master/src/rocksdb/db/db_impl.cc:595: undefined
reference to `malloc_stats_print'
../../../../src/rocksdb/librocksdb.a(db_impl.o): In function
`DumpMallocStats':
/home/ems/varada/mnt/master/src/rocksdb/db/db_impl.cc:595: undefined
reference to `malloc_stats_print'
collect2: error: ld returned 1 exit status
collect2: error: ld returned 1 exit status
make[2]: *** [bin/ceph_test_objectstore_workloadgen] Error 1
make[1]: ***
[src/test/objectstore/CMakeFiles/ceph_test_objectstore_workloadgen.dir/all]
Error 2
make[2]: *** [bin/ceph_smalliobenchfs] Error 1
make[1]: *** [src/test/bench/CMakeFiles/ceph_smalliobenchfs.dir/all] Error =
2
../../../../src/rocksdb/librocksdb.a(db_impl.o): In function
`DumpMallocStats':
/home/ems/varada/mnt/master/src/rocksdb/db/db_impl.cc:595: undefined
reference to `malloc_stats_print'
collect2: error: ld returned 1 exit status
make[2]: *** [bin/ceph_test_filestore_idempotent] Error 1
make[1]: ***
[src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent.dir/all]
Error 2


Any workaround or fix for this issue?

Varada
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
