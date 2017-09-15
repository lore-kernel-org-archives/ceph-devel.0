From: Jos Collin <jcollin@redhat.com>
Subject: rocksdb fails to build with gcc 7.1.1
Date: Fri, 15 Sep 2017 10:59:44 +0530
Message-ID: <1874d0d4-b311-37ef-b98f-aa099f1168b8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:48120 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdIOF3t (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 01:29:49 -0400
Received: by mail-it0-f51.google.com with SMTP id z8so1972766itc.2
        for <ceph-devel@vger.kernel.org>; Thu, 14 Sep 2017 22:29:49 -0700 (PDT)
Received: from [10.65.193.27] ([125.16.97.117])
        by smtp.gmail.com with ESMTPSA id 12sm196472itm.1.2017.09.14.22.29.46
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2017 22:29:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>

Found this today morning with the latest ceph source. But it went 
through with the version of gcc in smithi (gcc (Ubuntu 
4.8.4-2ubuntu1~14.04.3) 4.8.4).


[ 14%] Performing forcebuild step for 'rocksdb_ext'
[ 14%] Performing build step for 'rocksdb_ext'
[  0%] Built target build_version
[  0%] Building CXX object CMakeFiles/rocksdb.dir/db/builder.cc.o
In file included from 
/home/jcollin/workspace/testbuild/ceph/src/rocksdb/db/write_batch_internal.h:12:0,
                  from 
/home/jcollin/workspace/testbuild/ceph/src/rocksdb/db/column_family.h:20,
                  from 
/home/jcollin/workspace/testbuild/ceph/src/rocksdb/db/version_set.h:31,
                  from 
/home/jcollin/workspace/testbuild/ceph/src/rocksdb/db/compaction.h:11,
                  from 
/home/jcollin/workspace/testbuild/ceph/src/rocksdb/db/compaction_iterator.h:14,
                  from 
/home/jcollin/workspace/testbuild/ceph/src/rocksdb/db/builder.cc:16:
/home/jcollin/workspace/testbuild/ceph/src/rocksdb/db/write_thread.h: In 
member function ‘std::mutex& rocksdb::WriteThread::Writer::StateMutex()’:
/home/jcollin/workspace/testbuild/ceph/src/rocksdb/db/write_thread.h:192:78: 
error: dereferencing type-punned pointer will break strict-aliasing 
rules [-Werror=strict-aliasing]
        return 
*static_cast<std::mutex*>(static_cast<void*>(&state_mutex_bytes));
 
       ^
cc1plus: all warnings being treated as errors
make[6]: *** [CMakeFiles/rocksdb.dir/build.make:135: 
CMakeFiles/rocksdb.dir/db/builder.cc.o] Error 1
make[5]: *** [CMakeFiles/Makefile2:2225: CMakeFiles/rocksdb.dir/all] Error 2
make[4]: *** [CMakeFiles/Makefile2:2237: CMakeFiles/rocksdb.dir/rule] 
Error 2
make[3]: *** [Makefile:875: rocksdb] Error 2
make[2]: *** [src/CMakeFiles/rocksdb_ext.dir/build.make:113: 
src/rocksdb_ext-prefix/src/rocksdb_ext-stamp/rocksdb_ext-build] Error 2
make[1]: *** [CMakeFiles/Makefile2:1726: 
src/CMakeFiles/rocksdb_ext.dir/all] Error 2
make: *** [Makefile:139: all] Error 2
[jcollin@earth build]$ gcc --version
gcc (GCC) 7.1.1 20170503 (Red Hat 7.1.1-1)
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

[jcollin@earth build]$
