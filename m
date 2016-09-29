From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Master build failure with jemalloc
Date: Thu, 29 Sep 2016 04:37:39 +0000
Message-ID: <BY2PR02MB3965017AD9685606928E51DF4CE0@BY2PR02MB396.namprd02.prod.outlook.com>
References: <MWHPR02MB26393FE04E6A5712E18142EFE2CE0@MWHPR02MB2639.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam02on0040.outbound.protection.outlook.com ([104.47.36.40]:8320
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751038AbcI2Ehm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 29 Sep 2016 00:37:42 -0400
In-Reply-To: <MWHPR02MB26393FE04E6A5712E18142EFE2CE0@MWHPR02MB2639.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is a known issue , workaround is to comment out the malloc_stats_print=
 within db_impl.cc..
I did post this in community twice without any response :-(

Thanks & Regards
Somnath

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel=
.org] On Behalf Of Varada Kari
Sent: Wednesday, September 28, 2016 9:26 PM
To: Ceph Development
Subject: Master build failure with jemalloc

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
/home/ems/varada/mnt/master/src/rocksdb/db/db_impl.cc:595: undefined refere=
nce to `malloc_stats_print'
../../../../src/rocksdb/librocksdb.a(db_impl.o): In function
`DumpMallocStats':
/home/ems/varada/mnt/master/src/rocksdb/db/db_impl.cc:595: undefined refere=
nce to `malloc_stats_print'
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
/home/ems/varada/mnt/master/src/rocksdb/db/db_impl.cc:595: undefined refere=
nce to `malloc_stats_print'
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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in th=
e body of a message to majordomo@vger.kernel.org More majordomo info at  ht=
tp://vger.kernel.org/majordomo-info.html
