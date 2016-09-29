From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Master build failure with jemalloc
Date: Thu, 29 Sep 2016 10:29:02 +0200
Message-ID: <68e35a88-c375-3963-d1dd-d74628621e54@digiware.nl>
References: <MWHPR02MB26393FE04E6A5712E18142EFE2CE0@MWHPR02MB2639.namprd02.prod.outlook.com>
 <BY2PR02MB3965017AD9685606928E51DF4CE0@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:59667 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752718AbcI2I3H (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 29 Sep 2016 04:29:07 -0400
In-Reply-To: <BY2PR02MB3965017AD9685606928E51DF4CE0@BY2PR02MB396.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Varada Kari <Varada.Kari@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 29-9-2016 06:37, Somnath Roy wrote:
> This is a known issue , workaround is to comment out the malloc_stats_print within db_impl.cc..
> I did post this in community twice without any response :-(

That is not quite my experience
Submitting fixes to the rocksdb repo at github are usually swiftly
accepted. After which it has to trickle down into Ceph, but that also
usually is one post to get it done.

But the idea it to start at the rocksdb end.

--WjW

> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Varada Kari
> Sent: Wednesday, September 28, 2016 9:26 PM
> To: Ceph Development
> Subject: Master build failure with jemalloc
> 
> Hi,
> 
> I am facing a cmake build issue with jemalloc and latest master.
> Did anyone face same issue?
> 
> Linking CXX executable ../../../bin/ceph_test_filestore_idempotent
> collect2: error: ld returned 1 exit status
> make[2]: *** [bin/ceph_test_keyvaluedb_iterators] Error 1
> make[1]: ***
> [src/test/ObjectMap/CMakeFiles/ceph_test_keyvaluedb_iterators.dir/all]
> Error 2
> ../../../../src/rocksdb/librocksdb.a(db_impl.o): In function
> `DumpMallocStats':
> /home/ems/varada/mnt/master/src/rocksdb/db/db_impl.cc:595: undefined reference to `malloc_stats_print'
> ../../../../src/rocksdb/librocksdb.a(db_impl.o): In function
> `DumpMallocStats':
> /home/ems/varada/mnt/master/src/rocksdb/db/db_impl.cc:595: undefined reference to `malloc_stats_print'
> collect2: error: ld returned 1 exit status
> collect2: error: ld returned 1 exit status
> make[2]: *** [bin/ceph_test_objectstore_workloadgen] Error 1
> make[1]: ***
> [src/test/objectstore/CMakeFiles/ceph_test_objectstore_workloadgen.dir/all]
> Error 2
> make[2]: *** [bin/ceph_smalliobenchfs] Error 1
> make[1]: *** [src/test/bench/CMakeFiles/ceph_smalliobenchfs.dir/all] Error 2
> ../../../../src/rocksdb/librocksdb.a(db_impl.o): In function
> `DumpMallocStats':
> /home/ems/varada/mnt/master/src/rocksdb/db/db_impl.cc:595: undefined reference to `malloc_stats_print'
> collect2: error: ld returned 1 exit status
> make[2]: *** [bin/ceph_test_filestore_idempotent] Error 1
> make[1]: ***
> [src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent.dir/all]
> Error 2
> 
> 
> Any workaround or fix for this issue?
> 
> Varada
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

