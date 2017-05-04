From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Babeltrace error in FreeBSD, Build failed in Jenkins: ceph-master
 #634
Date: Thu, 4 May 2017 21:51:32 +0200
Message-ID: <36b2e3a7-93b7-f0ee-e76a-6830017b6f4a@digiware.nl>
References: <730308550.32.1493921080870.JavaMail.jenkins@cephdev.digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:35758 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751628AbdEDTvj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 4 May 2017 15:51:39 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 3A0C8412B2
        for <ceph-devel@vger.kernel.org>; Thu,  4 May 2017 21:51:34 +0200 (CEST)
In-Reply-To: <730308550.32.1493921080870.JavaMail.jenkins@cephdev.digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/634/console

Cmake fails on babletrace.
Uptill now babeltrace was optional, but if it is not really 100%
required I'll look into it in 2 weeks after my vacation.
Otherwise it would be nice if it was made optional again.

Thanx,
--WjW


-------- Forwarded Message --------
Subject: Build failed in Jenkins: ceph-master #634
Date: Thu, 4 May 2017 20:04:40 +0200 (CEST)
From: jenkins@digiware.nl
Reply-To: jenkins@digiware.nl
To: wjw@digiware.nl

See
<http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/634/display/redirect?page=changes>

+ cmake -D 'CMAKE_BUILD_TYPE=Debug' -D 'CMAKE_CXX_FLAGS_DEBUG= -O0 -g'
-D 'CMAKE_C_FLAGS_DEBUG= -O0 -g' -D 'WITH_CCACHE=ON' -D
'ENABLE_GIT_VERSION=OFF' -D 'WITH_SYSTEM_BOOST=ON' -D 'WITH_LTTNG=OFF'
-D 'WITH_FUSE=ON' -D 'WITH_KRBD=OFF' -D 'WITH_XFS=OFF' -D 'WITH_KVS=OFF'
-D 'WITH_EMBEDDED=OFF' -D 'WITH_MANPAGE=ON' -D 'WITH_LIBCEPHFS=OFF' -D
'WITH_CEPHFS=OFF' -D 'WITH_RADOSGW=ON' -D 'WITH_MGR=YES' ..
-- The C compiler identification is Clang 4.0.0
-- The CXX compiler identification is Clang 4.0.0
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Detecting C compile features
-- Detecting C compile features - done
-- Check for working CXX compiler: /usr/bin/CC
-- Check for working CXX compiler: /usr/bin/CC -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Looking for pthread.h
-- Looking for pthread.h - found
-- Looking for pthread_create
-- Looking for pthread_create - not found
-- Looking for pthread_create in pthreads
-- Looking for pthread_create in pthreads - not found
-- Looking for pthread_create in pthread
-- Looking for pthread_create in pthread - found
-- Found Threads: TRUE  -- Building with ccache: /usr/local/bin/ccache,
CCACHE_DIR=
-- Looking for fallocate
-- Looking for fallocate - not found
-- Looking for posix_fadvise
-- Looking for posix_fadvise - found
-- Looking for posix_fallocate
-- Looking for posix_fallocate - found
-- Looking for syncfs
-- Looking for syncfs - not found
-- Looking for sync_file_range
-- Looking for sync_file_range - not found
-- Looking for pwritev
-- Looking for pwritev - found
-- Looking for splice
-- Looking for splice - not found
-- Looking for getgrouplist
-- Looking for getgrouplist - found
-- Looking for fdatasync
-- Looking for fdatasync - found
-- Looking for strerror_r
-- Looking for strerror_r - found
-- Looking for name_to_handle_at
-- Looking for name_to_handle_at - not found
-- Looking for pipe2
-- Looking for pipe2 - found
-- Looking for pthread_spin_init
-- Looking for pthread_spin_init - found
-- Looking for pthread_set_name_np
-- Looking for pthread_set_name_np - found
-- Looking for pthread_setname_np
-- Looking for pthread_setname_np - not found
-- Looking for pthread_getname_np
-- Looking for pthread_getname_np - not found
-- Looking for eventfd
-- Looking for eventfd - not found
-- Looking for include file inttypes.h
-- Looking for include file inttypes.h - found
-- Looking for include file linux/types.h
-- Looking for include file linux/types.h - not found
-- Looking for include file linux/version.h
-- Looking for include file linux/version.h - not found
-- Looking for include file stdint.h
-- Looking for include file stdint.h - found
-- Looking for include file arpa/nameser_compat.h
-- Looking for include file arpa/nameser_compat.h - found
-- Looking for include file sys/mount.h
-- Looking for include file sys/mount.h - found
-- Looking for include file sys/param.h
-- Looking for include file sys/param.h - found
-- Looking for include file sys/types.h
-- Looking for include file sys/types.h - found
-- Looking for include file sys/vfs.h
-- Looking for include file sys/vfs.h - not found
-- Looking for include file sys/prctl.h
-- Looking for include file sys/prctl.h - not found
-- Looking for include file execinfo.h
-- Looking for include file execinfo.h - found
-- Looking for include file valgrind/helgrind.h
-- Looking for include file valgrind/helgrind.h - found
-- Looking for stddef.h
-- Looking for stddef.h - found
-- Check size of __be16
-- Check size of __be16 - failed
-- Check size of __be32
-- Check size of __be32 - failed
-- Check size of __be64
-- Check size of __be64 - failed
-- Check size of __le16
-- Check size of __le16 - failed
-- Check size of __le32
-- Check size of __le32 - failed
-- Check size of __le64
-- Check size of __le64 - failed
-- Check size of __u8
-- Check size of __u8 - failed
-- Check size of __u16
-- Check size of __u16 - failed
-- Check size of __u32
-- Check size of __u32 - failed
-- Check size of __u64
-- Check size of __u64 - failed
-- Check size of __s8
-- Check size of __s8 - failed
-- Check size of __s16
-- Check size of __s16 - failed
-- Check size of __s32
-- Check size of __s32 - failed
-- Check size of __s64
-- Check size of __s64 - failed
-- Looking for res_nquery
-- Looking for res_nquery - not found
-- Looking for F_SETPIPE_SZ
-- Looking for F_SETPIPE_SZ - not found
-- Looking for __func__
-- Looking for __func__ - found
-- Looking for __PRETTY_FUNCTION__
-- Looking for __PRETTY_FUNCTION__ - found
-- Performing Test STRERROR_R_CHAR_P
-- Performing Test STRERROR_R_CHAR_P - Failed
-- Performing Test HAVE_STAT_ST_MTIM_TV_NSEC
-- Performing Test HAVE_STAT_ST_MTIM_TV_NSEC - Success
-- Performing Test HAVE_STAT_ST_MTIMESPEC_TV_NSEC
-- Performing Test HAVE_STAT_ST_MTIMESPEC_TV_NSEC - Success
-- Not Found libibverbs: RDMA_LIBRARY-NOTFOUND
-- Could NOT find ibverbs (missing:  RDMA_LIBRARIES RDMA_INCLUDE_DIR) --
Looking for backtrace
-- Looking for backtrace - not found
-- Found Backtrace: /usr/lib/libexecinfo.so  -- Not using udev
-- Not using AIO
-- Not using BLKID
-- Found OpenLdap: /usr/local/include  -- Found fuse:
/usr/local/include/fuse  -- Found leveldb: /usr/local/lib/libleveldb.so
-- Found atomic_ops: /usr/local/lib/libatomic_ops.a  --
/usr/local/lib/libatomic_ops.a
-- Found snappy: /usr/local/lib/libsnappy.so  -- Found gperftools:
GPERFTOOLS_TCMALLOC_LIBRARY;GPERFTOOLS_TCMALLOC_MINIMAL_LIBRARY;GPERFTOOLS_PROFILER_LIBRARY
 -- Found CURL: /usr/local/lib/libcurl.so (found version "7.53.1") --
Looking for curl_multi_wait
-- Looking for curl_multi_wait - found
-- Found PkgConfig: /usr/local/bin/pkg-config (found version "1.0.2") --
Checking for module 'nss'
--   Found nss, version 3.27.1
-- NSS_LIBRARIES:
/usr/local/lib/nss/libssl3.so;/usr/local/lib/nss/libsmime3.so;/usr/local/lib/nss/libnss3.so;/usr/local/lib/nss/libnssutil3.so
-- NSS_INCLUDE_DIRS: /usr/local/include/nss/nss
-- Found NSS:
/usr/local/lib/nss/libssl3.so;/usr/local/lib/nss/libsmime3.so;/usr/local/lib/nss/libnss3.so;/usr/local/lib/nss/libnssutil3.so
 -- Checking for module 'nspr'
--   Found nspr, version 4.13.1
-- Found NSPR:
/usr/local/lib/libplds4.so;/usr/local/lib/libplc4.so;/usr/local/lib/libnspr4.so
 -- SSL with NSS selected (Libs:
/usr/local/lib/nss/libssl3.so;/usr/local/lib/nss/libsmime3.so;/usr/local/lib/nss/libnss3.so;/usr/local/lib/nss/libnssutil3.so)
-- Found EXPAT: /usr/local/lib/libexpat.so (found version "2.2.0") --
Found fcgi: /usr/local/lib/libfcgi.so  -- Looking for openssl anyways,
because radosgw selected
-- Found OpenSSL: /usr/lib/libssl.so;/usr/lib/libcrypto.so (found
version "1.0.2k") -- ssl soname: libssl.so.8
-- crypto soname: libcrypto.so.8
-- Found PythonInterp: /usr/local/bin/python2.7 (found suitable version
"2.7.13", minimum required is "2.7") -- Found PythonLibs:
/usr/local/lib/libpython2.7.so (found suitable version "2.7.13", minimum
required is "2.7") -- Found ZLIB: /usr/lib/libz.so (found version
"1.2.11") CMake Error at
/usr/local/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:148
(message):
  Could NOT find babeltrace (missing: BABELTRACE_INCLUDE_DIR
  BABELTRACE_LIBRARY)
Call Stack (most recent call first):
  /usr/local/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:388
(_FPHSA_FAILURE_MESSAGE)
  cmake/modules/Findbabeltrace.cmake:19 (find_package_handle_standard_args)
  CMakeLists.txt:437 (find_package)


-- Configuring incomplete, errors occurred!
See also
"/home/jenkins/workspace/ceph-master/build/CMakeFiles/CMakeOutput.log".
See also
"/home/jenkins/workspace/ceph-master/build/CMakeFiles/CMakeError.log".
Build step 'Execute shell' marked build as failure
