From: kefu chai <tchaikov@gmail.com>
Subject: Re: Build failed in Jenkins: ceph-master #1458
Date: Sun, 19 Nov 2017 12:45:31 +0800
Message-ID: <CAJE9aOOM-uRDfE=xu-7FX2uWa0sVf1PKZzDfiGewtggh7uegJg@mail.gmail.com>
References: <1749630341.11.1510988706686.JavaMail.jenkins@cephdev.digiware.nl> <28fc15b3-cc0b-51e2-de65-243a757413cd@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:46141 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbdKSEpd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 18 Nov 2017 23:45:33 -0500
Received: by mail-qk0-f179.google.com with SMTP id b85so3924309qkc.13
        for <ceph-devel@vger.kernel.org>; Sat, 18 Nov 2017 20:45:32 -0800 (PST)
In-Reply-To: <28fc15b3-cc0b-51e2-de65-243a757413cd@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Nov 18, 2017 at 7:55 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi Kefu,
>
> I think the SPDKs setting broke the FreeBSD build.
> But I was under the impression that it would default to off on FreeBSD?

it's disabled by do_freebsd.sh. and i'd suggest pass
-DCMAKE_MAKE_PROGRAM=gmake along with other `-D` options in your build
script.


>
> --WjW
>
>
> -------- Forwarded Message --------
> Subject: Build failed in Jenkins: ceph-master #1458
> Date: Sat, 18 Nov 2017 08:05:06 +0100 (CET)
> From: jenkins@digiware.nl
> Reply-To: jenkins@digiware.nl
> To: wjw@digiware.nl
>
> See
> <http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/1458/display/redirect?page=changes>
>
> Changes:
>
> [kchai] cmake: build spdk/dpdk in cmake modules
>
> [kchai] rpm,deb: add cunit1 as build dependency
>
> [kchai] cmake: WITH_SPDK=ON by default
>
> [kchai] cmake: refactor dpdk related code
>
> [kchai] cmake: remove duplicated spdk linkage
>
> [kchai] cmake: BuildDPDK: do not build kernel modules
>
> [kchai] cmake: add rte_mempool_{ring,stack} to Finddpdk.cmake
>
> [kchai] cmake: use BuildDPDK if libdpdk not found
>
> [kchai] msg/async: rebase msg/async/dpdk to spdk/dpdk
>
> ------------------------------------------
> [...truncated 1.24 KB...]
> cleaning Virtualenv locations.
> + sudo rm -rf /tmp/ceph-detect-init-virtualenv
> + sudo rm -rf /tmp/ceph-disk-virtualenv
> + echo Fetch submodules, overwrite just everything that was patched
> Fetch submodules, overwrite just everything that was patched
> + git submodule update --init --recursive --force
> Submodule path 'ceph-erasure-code-corpus': checked out
> '2d7d78b9cc52e8a9529d8cc2d2954c7d375d5dd7'
> Submodule path 'ceph-object-corpus': checked out
> '420d02a8a2cbfac010dc62f6ff9017f190bb8312'
> Submodule path 'src/Beast': checked out
> 'dca65932a8055dd3e240633c6a058db8aa7f7915'
> Submodule path 'src/blkin': checked out
> 'f24ceec055ea236a093988237a9821d145f5f7c8'
> Submodule path 'src/civetweb': checked out
> 'de23828cea740032428ce6f288ad061b429ce68e'
> Submodule path 'src/crypto/isa-l/isa-l_crypto': checked out
> '603529a4e06ac8a1662c13d6b31f122e21830352'
> Submodule path 'src/erasure-code/jerasure/gf-complete': checked out
> '7e61b44404f0ed410c83cfd3947a52e88ae044e1'
> Submodule path 'src/erasure-code/jerasure/jerasure': checked out
> '96c76b89d661c163f65a014b8042c9354ccf7f31'
> Submodule path 'src/googletest': checked out
> 'fdb850479284e2aae047b87df6beae84236d0135'
> Submodule path 'src/isa-l': checked out
> '7e1a337433a340bc0974ed0f04301bdaca374af6'
> Submodule path 'src/lua': checked out
> '1fce39c6397056db645718b8f5821571d97869a4'
> Submodule path 'src/rapidjson': checked out
> 'f54b0e47a08782a6131cc3d60f94d038fa6e0a51'
> Submodule path 'src/rapidjson/thirdparty/gtest': checked out
> '0a439623f75c029912728d80cb7f1b8b48739ca4'
> Submodule path 'src/rocksdb': checked out
> '8dd0a7e11abad6bc32e59a5cba8769961e085312'
> Submodule path 'src/spdk': checked out
> '7b7f2aa6854745caf6e2803133043132ca400285'
> Submodule path 'src/spdk/dpdk': checked out
> '193a6860dfd84ddad2a72c567480e0dd959724d4'
> Submodule path 'src/xxHash': checked out
> '1f40c6511fa8dd9d2e337ca8c9bc18b3e87663c9'
> Submodule path 'src/zstd': checked out
> 'f4340f46b2387bc8de7d5320c0b83bb1499933ad'
> + set -xv
> which patch
> + which patch
> /usr/bin/patch
> echo apply patches that are still in the PR queue with Ceph
> + echo apply patches that are still in the PR queue with Ceph
> apply patches that are still in the PR queue with Ceph
> if [ -d ../patches.master ]; then
>     for p in ../patches.master/*.diff; do
>         RESULT=0
>         echo Try patch: $p
>         gpatch --quiet -N -p1 -F3 --dry-run < $p || RESULT=1
>         if [ $RESULT -eq 0 ]
>         then
>             echo Patching: $p
>             gpatch --quiet -N -p1 -F3 < $p
>         else
>                 echo Patch: $p, not accepted
>         fi
>     done
> fi
> + [ -d ../patches.master ]
> + RESULT=0
> + echo Try patch: ../patches.master/src_common_blkdev.cc.diff
> Try patch: ../patches.master/src_common_blkdev.cc.diff
> + gpatch --quiet -N -p1 -F3 --dry-run
> + [ 0 -eq 0 ]
> + echo Patching: ../patches.master/src_common_blkdev.cc.diff
> Patching: ../patches.master/src_common_blkdev.cc.diff
> + gpatch --quiet -N -p1 -F3
>
> echo Build Makefiles
> + echo Build Makefiles
> Build Makefiles
> while [ -d build ] ; do
>     sudo rm -rf build || true
>     sleep 2
> done + [ -d build ]
> + sudo rm -rf build
> + sleep 2
> + [ -d build ]
>
> mkdir build
> + mkdir build
> # CXX_FLAGS_DEBUG="-Wno-null-dereference # CXX_FLAGS_DEBUG="$CXX_FLAGS_DEBUG
> -Wno-expansion-o-defined"
> (cd build; cmake \
>         -D CMAKE_BUILD_TYPE=Debug \
>         -D CMAKE_CXX_FLAGS_DEBUG="$CXX_FLAGS_DEBUG -O0 -g
> -DBEAST_NO_BOOST_STRING_VIEW" \
>         -D CMAKE_C_FLAGS_DEBUG="$C_FLAGS_DEBUG -O0 -g
> -DBEAST_NO_BOOST_STRING_VIEW" \
>         -D ALLOCATOR=libc \
>         -D WITH_CCACHE=ON \
>         -D ENABLE_GIT_VERSION=OFF \
>         -D WITH_SYSTEM_BOOST=ON \
>         -D WITH_BABELTRACE=OFF \
>         -D WITH_LTTNG=OFF \
>         -D WITH_BLKID=OFF \
>         -D WITH_BLUESTORE=OFF \
>         -D WITH_FUSE=ON \
>         -D WITH_KRBD=OFF \
>         -D WITH_XFS=OFF \
>         -D WITH_KVS=OFF \
>         -D WITH_EMBEDDED=OFF \
>         -D WITH_MANPAGE=ON \
>         -D WITH_LIBCEPHFS=OFF \
>         -D WITH_CEPHFS=OFF \
>         -D WITH_TESTS=ON \
>     ..
>     )
> + cd build
> + cmake -D 'CMAKE_BUILD_TYPE=Debug' -D 'CMAKE_CXX_FLAGS_DEBUG= -O0 -g
> -DBEAST_NO_BOOST_STRING_VIEW' -D 'CMAKE_C_FLAGS_DEBUG= -O0 -g
> -DBEAST_NO_BOOST_STRING_VIEW' -D 'ALLOCATOR=libc' -D 'WITH_CCACHE=ON' -D
> 'ENABLE_GIT_VERSION=OFF' -D 'WITH_SYSTEM_BOOST=ON' -D 'WITH_BABELTRACE=OFF'
> -D 'WITH_LTTNG=OFF' -D 'WITH_BLKID=OFF' -D 'WITH_BLUESTORE=OFF' -D
> 'WITH_FUSE=ON' -D 'WITH_KRBD=OFF' -D 'WITH_XFS=OFF' -D 'WITH_KVS=OFF' -D
> 'WITH_EMBEDDED=OFF' -D 'WITH_MANPAGE=ON' -D 'WITH_LIBCEPHFS=OFF' -D
> 'WITH_CEPHFS=OFF' -D 'WITH_TESTS=ON' ..
> -- The CXX compiler identification is Clang 5.0.0
> -- The C compiler identification is Clang 5.0.0
> -- The ASM compiler identification is Clang
> -- Found assembler: /usr/bin/cc
> -- Check for working CXX compiler: /usr/bin/c++
> -- Check for working CXX compiler: /usr/bin/c++ -- works
> -- Detecting CXX compiler ABI info
> -- Detecting CXX compiler ABI info - done
> -- Detecting CXX compile features
> -- Detecting CXX compile features - done
> -- Check for working C compiler: /usr/bin/cc
> -- Check for working C compiler: /usr/bin/cc -- works
> -- Detecting C compiler ABI info
> -- Detecting C compiler ABI info - done
> -- Detecting C compile features
> -- Detecting C compile features - done
> -- Looking for pthread.h
> -- Looking for pthread.h - found
> -- Looking for pthread_create
> -- Looking for pthread_create - not found
> -- Looking for pthread_create in pthreads
> -- Looking for pthread_create in pthreads - not found
> -- Looking for pthread_create in pthread
> -- Looking for pthread_create in pthread - found
> -- Found Threads: TRUE  -- Building with ccache: /usr/local/bin/ccache,
> CCACHE_DIR=
> -- Looking for fallocate
> -- Looking for fallocate - not found
> -- Looking for posix_fadvise
> -- Looking for posix_fadvise - found
> -- Looking for posix_fallocate
> -- Looking for posix_fallocate - found
> -- Looking for syncfs
> -- Looking for syncfs - not found
> -- Looking for sync_file_range
> -- Looking for sync_file_range - not found
> -- Looking for pwritev
> -- Looking for pwritev - found
> -- Looking for splice
> -- Looking for splice - not found
> -- Looking for getgrouplist
> -- Looking for getgrouplist - found
> -- Looking for fdatasync
> -- Looking for fdatasync - found
> -- Looking for strerror_r
> -- Looking for strerror_r - found
> -- Looking for name_to_handle_at
> -- Looking for name_to_handle_at - not found
> -- Looking for pipe2
> -- Looking for pipe2 - found
> -- Looking for pthread_spin_init
> -- Looking for pthread_spin_init - found
> -- Looking for pthread_set_name_np
> -- Looking for pthread_set_name_np - found
> -- Looking for pthread_setname_np
> -- Looking for pthread_setname_np - not found
> -- Looking for pthread_getname_np
> -- Looking for pthread_getname_np - not found
> -- Looking for eventfd
> -- Looking for eventfd - not found
> -- Looking for getprogname
> -- Looking for getprogname - found
> -- Looking for include file linux/types.h
> -- Looking for include file linux/types.h - not found
> -- Looking for include file linux/version.h
> -- Looking for include file linux/version.h - not found
> -- Looking for include file arpa/nameser_compat.h
> -- Looking for include file arpa/nameser_compat.h - found
> -- Looking for include file sys/mount.h
> -- Looking for include file sys/mount.h - found
> -- Looking for include file sys/param.h
> -- Looking for include file sys/param.h - found
> -- Looking for include file sys/types.h
> -- Looking for include file sys/types.h - found
> -- Looking for include file sys/vfs.h
> -- Looking for include file sys/vfs.h - not found
> -- Looking for include file sys/prctl.h
> -- Looking for include file sys/prctl.h - not found
> -- Looking for include file execinfo.h
> -- Looking for include file execinfo.h - found
> -- Looking for include file valgrind/helgrind.h
> -- Looking for include file valgrind/helgrind.h - found
> -- Looking for stdint.h
> -- Looking for stdint.h - found
> -- Looking for stddef.h
> -- Looking for stddef.h - found
> -- Check size of __be16
> -- Check size of __be16 - failed
> -- Check size of __be32
> -- Check size of __be32 - failed
> -- Check size of __be64
> -- Check size of __be64 - failed
> -- Check size of __le16
> -- Check size of __le16 - failed
> -- Check size of __le32
> -- Check size of __le32 - failed
> -- Check size of __le64
> -- Check size of __le64 - failed
> -- Check size of __u8
> -- Check size of __u8 - failed
> -- Check size of __u16
> -- Check size of __u16 - failed
> -- Check size of __u32
> -- Check size of __u32 - failed
> -- Check size of __u64
> -- Check size of __u64 - failed
> -- Check size of __s8
> -- Check size of __s8 - failed
> -- Check size of __s16
> -- Check size of __s16 - failed
> -- Check size of __s32
> -- Check size of __s32 - failed
> -- Check size of __s64
> -- Check size of __s64 - failed
> -- Looking for res_nquery
> -- Looking for res_nquery - not found
> -- Looking for F_SETPIPE_SZ
> -- Looking for F_SETPIPE_SZ - not found
> -- Looking for __func__
> -- Looking for __func__ - found
> -- Looking for __PRETTY_FUNCTION__
> -- Looking for __PRETTY_FUNCTION__ - found
> -- Looking for getentropy
> -- Looking for getentropy - not found
> -- Performing Test STRERROR_R_CHAR_P
> -- Performing Test STRERROR_R_CHAR_P - Failed
> -- Performing Test HAVE_STAT_ST_MTIM_TV_NSEC
> -- Performing Test HAVE_STAT_ST_MTIM_TV_NSEC - Success
> -- Performing Test HAVE_STAT_ST_MTIMESPEC_TV_NSEC
> -- Performing Test HAVE_STAT_ST_MTIMESPEC_TV_NSEC - Success
> -- Not Found libibverbs: RDMA_LIBRARY-NOTFOUND
> -- Could NOT find ibverbs (missing: RDMA_LIBRARIES RDMA_INCLUDE_DIR) --
> Looking for backtrace
> -- Looking for backtrace - not found
> -- Found Backtrace: /usr/lib/libexecinfo.so  -- Not using udev
> -- Not using BLKID
> -- Found OpenLdap: /usr/local/include  -- Found fuse:
> /usr/local/include/fuse  make:
> "/home/jenkins/workspace/ceph-master/src/spdk/dpdk/Makefile" line 32: Error
> please compile using GNU Make (gmake)
> CMake Error at cmake/modules/BuildDPDK.cmake:61 (message):
>   not able to build DPDK support: unsupported target
>   "x86_64-native-bsdapp-clang"
> Call Stack (most recent call first):
>   cmake/modules/BuildDPDK.cmake:82 (do_build_dpdk)
>   cmake/modules/BuildSPDK.cmake:4 (build_dpdk)
>   CMakeLists.txt:225 (build_spdk)
>
>
> -- Configuring incomplete, errors occurred!
> See also
> "/home/jenkins/workspace/ceph-master/build/CMakeFiles/CMakeOutput.log".
> See also
> "/home/jenkins/workspace/ceph-master/build/CMakeFiles/CMakeError.log".
> Build step 'Execute shell' marked build as failure



-- 
Regards
Kefu Chai
