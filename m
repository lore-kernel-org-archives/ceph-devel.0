From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Fwd: Build failed in Jenkins: ceph-master #476
Date: Wed, 29 Mar 2017 19:16:36 +0300
Message-ID: <53c79eaf-2dd5-c081-525b-11d7b96f5a5d@mirantis.com>
References: <1855439852.1.1490797212316.JavaMail.jenkins@cephdev.digiware.nl>
 <5618b70a-a755-9fb3-70c8-58f4a26fda18@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33296 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753396AbdC2QQm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Mar 2017 12:16:42 -0400
Received: by mail-lf0-f53.google.com with SMTP id h125so12470070lfe.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Mar 2017 09:16:40 -0700 (PDT)
In-Reply-To: <5618b70a-a755-9fb3-70c8-58f4a26fda18@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Willem,


will fix that, sorry for inconvenience.


Thanks,

Igor


On 29.03.2017 17:36, Willem Jan Withagen wrote:
> Hi Igor,
>
> I guess you added some testing code which requires bluestore stuff.
> But it is not conditional on HAVE_LIBAIO, which is sort of the
> denominator for not using BlueStore under FreeBSD.
>
> So in my FreeBSD Jenkins compilation fails.
> Perhaps you can easily submit a fix for this, otherwise I'll have to go
> thru the code and add some '#if defined(HAVE_LIBAIO)' conditionals.
>
> Thanx,
> --WjW
>
>
> -------- Forwarded Message --------
> Subject: Build failed in Jenkins: ceph-master #476
> Date: Wed, 29 Mar 2017 16:20:11 +0200 (CEST)
> From: jenkins@digiware.nl
> Reply-To: jenkins@digiware.nl
> To: wjw@digiware.nl
>
> See
> <http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/476/display/redirect?page=changes>
>
> Changes:
>
> [ifedotov] os/bluestore: store blob logical length rather than
> recalculate it on
>
> [ifedotov] os/bluestore: refactor bluestore_blob_t to encapsulate
> extents/*length
>
> [ifedotov] os/bluestore: make punch_hole call from set_lextent optional.
>
> [ifedotov] os/bluestore: do garbage collection after main write path to
> be able to
>
> [ifedotov] os/bluestore: try to reuse blob rather than create new one on
> overwrite.
>
> [ifedotov] os/bluestore: add test cases for BlueStore blob reuse.
>
> [ifedotov] os/bluestore: remove excessive 0x in logging
>
> [ifedotov] test/store_test: adjust OnodeSizeTracking test case to
> measure full
>
> [ifedotov] os/bluestore: allow 'single step' blob reuse when overwriting
>
> [kchai] rbd-nbd: s/cpp_error/cpp_strerror/ to fix FTBFS
>
> [kchai] mgr: shutdown py_modules in Mgr::shutdown()
>
> ------------------------------------------
> [...truncated 2.24 MB...]
>                                                              ~~^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:166:23:
> note: expanded from macro 'ASSERT_PRED_FORMAT2'
>    GTEST_PRED_FORMAT2_(pred_format, v1, v2, GTEST_FATAL_FAILURE_)
>                        ^~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:147:17:
> note: expanded from macro 'GTEST_PRED_FORMAT2_'
>    GTEST_ASSERT_(pred_format(#v1, #v2, v1, v2), \
>                  ^~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:77:52:
> note: expanded from macro 'GTEST_ASSERT_'
>    if (const ::testing::AssertionResult gtest_ar = (expression)) \
>                                                     ^~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/test/objectstore/store_test.cc:5968:3:
> error: expected ')'
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest.h:1956:32:
> note: expanded from macro 'ASSERT_EQ'
> # define ASSERT_EQ(val1, val2) GTEST_ASSERT_EQ(val1, val2)
>                                 ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest.h:1938:3:
> note: expanded from macro 'GTEST_ASSERT_EQ'
>    ASSERT_PRED_FORMAT2(::testing::internal:: \
>    ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:166:3:
> note: expanded from macro 'ASSERT_PRED_FORMAT2'
>    GTEST_PRED_FORMAT2_(pred_format, v1, v2, GTEST_FATAL_FAILURE_)
>    ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:147:29:
> note: expanded from macro 'GTEST_PRED_FORMAT2_'
>    GTEST_ASSERT_(pred_format(#v1, #v2, v1, v2), \
>                              ^
> <scratch space>:66:1: note: expanded from here
> "logger->get(l_bluestore_blobs)"
> ^
> /home/jenkins/workspace/ceph-master/src/test/objectstore/store_test.cc:5968:3:
> note: to match this '('
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest.h:1956:32:
> note: expanded from macro 'ASSERT_EQ'
> # define ASSERT_EQ(val1, val2) GTEST_ASSERT_EQ(val1, val2)
>                                 ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest.h:1938:3:
> note: expanded from macro 'GTEST_ASSERT_EQ'
>    ASSERT_PRED_FORMAT2(::testing::internal:: \
>    ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:166:3:
> note: expanded from macro 'ASSERT_PRED_FORMAT2'
>    GTEST_PRED_FORMAT2_(pred_format, v1, v2, GTEST_FATAL_FAILURE_)
>    ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:147:28:
> note: expanded from macro 'GTEST_PRED_FORMAT2_'
>    GTEST_ASSERT_(pred_format(#v1, #v2, v1, v2), \
>                             ^
> /home/jenkins/workspace/ceph-master/src/test/objectstore/store_test.cc:5969:25:
> error: use of undeclared identifier 'l_bluestore_extents'; did you mean
> 'l_filestore_bytes'?
>    ASSERT_EQ(logger->get(l_bluestore_extents), 1u);
>                          ^~~~~~~~~~~~~~~~~~~
>                          l_filestore_bytes
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest.h:1956:48:
> note: expanded from macro 'ASSERT_EQ'
> # define ASSERT_EQ(val1, val2) GTEST_ASSERT_EQ(val1, val2)
>                                                 ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest.h:1939:55:
> note: expanded from macro 'GTEST_ASSERT_EQ'
>                        EqHelper<GTEST_IS_NULL_LITERAL_(val1)>::Compare, \
>                                                        ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/internal/gtest-internal.h:133:54:
> note: expanded from macro 'GTEST_IS_NULL_LITERAL_'
>      (sizeof(::testing::internal::IsNullLiteralHelper(x)) == 1)
>                                                       ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:166:23:
> note: expanded from macro 'ASSERT_PRED_FORMAT2'
>    GTEST_PRED_FORMAT2_(pred_format, v1, v2, GTEST_FATAL_FAILURE_)
>                        ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:147:17:
> note: expanded from macro 'GTEST_PRED_FORMAT2_'
>    GTEST_ASSERT_(pred_format(#v1, #v2, v1, v2), \
>                  ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:77:52:
> note: expanded from macro 'GTEST_ASSERT_'
>    if (const ::testing::AssertionResult gtest_ar = (expression)) \
>                                                     ^
> /home/jenkins/workspace/ceph-master/src/os/filestore/FileStore.h:90:3:
> note: 'l_filestore_bytes' declared here
>    l_filestore_bytes,
>    ^
> /home/jenkins/workspace/ceph-master/src/test/objectstore/store_test.cc:5969:25:
> error: use of undeclared identifier 'l_bluestore_extents'; did you mean
> 'l_filestore_bytes'?
>    ASSERT_EQ(logger->get(l_bluestore_extents), 1u);
>                          ^~~~~~~~~~~~~~~~~~~
>                          l_filestore_bytes
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest.h:1956:48:
> note: expanded from macro 'ASSERT_EQ'
> # define ASSERT_EQ(val1, val2) GTEST_ASSERT_EQ(val1, val2)
>                                                 ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest.h:1940:23:
> note: expanded from macro 'GTEST_ASSERT_EQ'
>                        val1, val2)
>                        ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:166:36:
> note: expanded from macro 'ASSERT_PRED_FORMAT2'
>    GTEST_PRED_FORMAT2_(pred_format, v1, v2, GTEST_FATAL_FAILURE_)
>                                     ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:147:39:
> note: expanded from macro 'GTEST_PRED_FORMAT2_'
>    GTEST_ASSERT_(pred_format(#v1, #v2, v1, v2), \
>                                        ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:77:52:
> note: expanded from macro 'GTEST_ASSERT_'
>    if (const ::testing::AssertionResult gtest_ar = (expression)) \
>                                                     ^
> /home/jenkins/workspace/ceph-master/src/os/filestore/FileStore.h:90:3:
> note: 'l_filestore_bytes' declared here
>    l_filestore_bytes,
>    ^
> /home/jenkins/workspace/ceph-master/src/test/objectstore/store_test.cc:6039:27:
> error: use of undeclared identifier 'l_bluestore_blobs'
>      ASSERT_EQ(logger->get(l_bluestore_blobs), 1u);
>                            ^
> /home/jenkins/workspace/ceph-master/src/test/objectstore/store_test.cc:6039:5:
> error: no type named 'Compare' in the global namespace
>      ASSERT_EQ(logger->get(l_bluestore_blobs), 1u);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest.h:1956:32:
> note: expanded from macro 'ASSERT_EQ'
> # define ASSERT_EQ(val1, val2) GTEST_ASSERT_EQ(val1, val2)
>                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest.h:1939:63:
> note: expanded from macro 'GTEST_ASSERT_EQ'
>                        EqHelper<GTEST_IS_NULL_LITERAL_(val1)>::Compare, \
>                                                              ~~^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:166:23:
> note: expanded from macro 'ASSERT_PRED_FORMAT2'
>    GTEST_PRED_FORMAT2_(pred_format, v1, v2, GTEST_FATAL_FAILURE_)
>                        ^~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:147:17:
> note: expanded from macro 'GTEST_PRED_FORMAT2_'
>    GTEST_ASSERT_(pred_format(#v1, #v2, v1, v2), \
>                  ^~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:77:52:
> note: expanded from macro 'GTEST_ASSERT_'
>    if (const ::testing::AssertionResult gtest_ar = (expression)) \
>                                                     ^~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/test/objectstore/store_test.cc:6039:5:
> error: expected ')'
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest.h:1956:32:
> note: expanded from macro 'ASSERT_EQ'
> # define ASSERT_EQ(val1, val2) GTEST_ASSERT_EQ(val1, val2)
>                                 ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest.h:1938:3:
> note: expanded from macro 'GTEST_ASSERT_EQ'
>    ASSERT_PRED_FORMAT2(::testing::internal:: \
>    ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:166:3:
> note: expanded from macro 'ASSERT_PRED_FORMAT2'
>    GTEST_PRED_FORMAT2_(pred_format, v1, v2, GTEST_FATAL_FAILURE_)
>    ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:147:29:
> note: expanded from macro 'GTEST_PRED_FORMAT2_'
>    GTEST_ASSERT_(pred_format(#v1, #v2, v1, v2), \
>                              ^
> <scratch space>:67:1: note: expanded from here
> "logger->get(l_bluestore_blobs)"
> ^
> /home/jenkins/workspace/ceph-master/src/test/objectstore/store_test.cc:6039:5:
> note: to match this '('
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest.h:1956:32:
> note: expanded from macro 'ASSERT_EQ'
> # define ASSERT_EQ(val1, val2) GTEST_ASSERT_EQ(val1, val2)
>                                 ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest.h:1938:3:
> note: expanded from macro 'GTEST_ASSERT_EQ'
>    ASSERT_PRED_FORMAT2(::testing::internal:: \
>    ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:166:3:
> note: expanded from macro 'ASSERT_PRED_FORMAT2'
>    GTEST_PRED_FORMAT2_(pred_format, v1, v2, GTEST_FATAL_FAILURE_)
>    ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:147:28:
> note: expanded from macro 'GTEST_PRED_FORMAT2_'
>    GTEST_ASSERT_(pred_format(#v1, #v2, v1, v2), \
>                             ^
> /home/jenkins/workspace/ceph-master/src/test/objectstore/store_test.cc:6040:27:
> error: use of undeclared identifier 'l_bluestore_extents'; did you mean
> 'l_filestore_bytes'?
>      ASSERT_EQ(logger->get(l_bluestore_extents), 1u);
>                            ^~~~~~~~~~~~~~~~~~~
>                            l_filestore_bytes
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest.h:1956:48:
> note: expanded from macro 'ASSERT_EQ'
> # define ASSERT_EQ(val1, val2) GTEST_ASSERT_EQ(val1, val2)
>                                                 ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest.h:1939:55:
> note: expanded from macro 'GTEST_ASSERT_EQ'
>                        EqHelper<GTEST_IS_NULL_LITERAL_(val1)>::Compare, \
>                                                        ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/internal/gtest-internal.h:133:54:
> note: expanded from macro 'GTEST_IS_NULL_LITERAL_'
>      (sizeof(::testing::internal::IsNullLiteralHelper(x)) == 1)
>                                                       ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:166:23:
> note: expanded from macro 'ASSERT_PRED_FORMAT2'
>    GTEST_PRED_FORMAT2_(pred_format, v1, v2, GTEST_FATAL_FAILURE_)
>                        ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:147:17:
> note: expanded from macro 'GTEST_PRED_FORMAT2_'
>    GTEST_ASSERT_(pred_format(#v1, #v2, v1, v2), \
>                  ^
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include/gtest/gtest_pred_impl.h:77:52:
> note: expanded from macro 'GTEST_ASSERT_'
>    if (const ::testing::AssertionResult gtest_ar = (expression)) \
>                                                     ^
> /home/jenkins/workspace/ceph-master/src/os/filestore/FileStore.h:90:3:
> note: 'l_filestore_bytes' declared here
>    l_filestore_bytes,
>    ^
> fatal error: too many errors emitted, stopping now [-ferror-limit=]
> 20 errors generated.
> gmake[2]: ***
> [src/test/objectstore/CMakeFiles/ceph_test_objectstore.dir/build.make:63:
> src/test/objectstore/CMakeFiles/ceph_test_objectstore.dir/store_test.cc.o]
> Error 1
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake[1]: *** [CMakeFiles/Makefile2:14878:
> src/test/objectstore/CMakeFiles/ceph_test_objectstore.dir/all] Error 2
> gmake[1]: *** Waiting for unfinished jobs....
> [ 75%] Building CXX object
> src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/FileStoreDiff.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore &&
> ccache /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\"
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/rocksdb/include  -Wall
> -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS -std=c++11 -o
> CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/FileStoreDiff.cc.o
> -c /home/jenkins/workspace/ceph-master/src/test/objectstore/FileStoreDiff.cc
> [ 75%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/journal/test_mock_Replay.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/journal/test_mock_Replay.cc.o -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/journal/test_mock_Replay.cc
> [ 75%] Linking CXX executable ../../../bin/ceph_test_objectstore_workloadgen
> cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore &&
> /usr/local/bin/cmake -E cmake_link_script
> CMakeFiles/ceph_test_objectstore_workloadgen.dir/link.txt --verbose=1
> ccache /usr/bin/CC    -Wall -Wtype-limits -Wignored-qualifiers
> -Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing
> -fsigned-char -Wno-unused-function -Wno-unused-local-typedef
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g  -Wl,-export-dynamic
> CMakeFiles/ceph_test_objectstore_workloadgen.dir/workload_generator.cc.o
> CMakeFiles/ceph_test_objectstore_workloadgen.dir/TestObjectStoreState.cc.o
>   -o ../../../bin/ceph_test_objectstore_workloadgen  -L/usr/local/lib
> ../../../lib/libos.a ../../../lib/libglobal.a -lrt
> /usr/local/lib/libatomic_ops.a ../../../lib/libkv.a
> /usr/local/lib/libleveldb.so ../../rocksdb/librocksdb.a
> /usr/local/lib/libtcmalloc.so /usr/local/lib/libsnappy.so -lz -lbz2
> /usr/local/lib/liblz4.so ../../../lib/libceph-common.so.0 -lrt
> ../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a
> ../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so
> /usr/local/lib/libboost_system.so /usr/local/lib/libboost_regex.so
> /usr/local/lib/libboost_random.so
> /usr/local/lib/libboost_program_options.so
> /usr/local/lib/libboost_date_time.so
> /usr/local/lib/libboost_iostreams.so -lexecinfo
> /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so
> /usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so
> /usr/local/lib/libplds4.so /usr/local/lib/libplc4.so
> /usr/local/lib/libnspr4.so -lpthread
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss
> [ 75%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/managed_lock/test_mock_AcquireRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/managed_lock/test_mock_AcquireRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/managed_lock/test_mock_AcquireRequest.cc
> [ 75%] Linking CXX executable ../../../bin/unittest_lfnindex
> cd /home/jenkins/workspace/ceph-master/build/src/test/os &&
> /usr/local/bin/cmake -E cmake_link_script
> CMakeFiles/unittest_lfnindex.dir/link.txt --verbose=1
> ccache /usr/bin/CC    -Wall -Wtype-limits -Wignored-qualifiers
> -Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing
> -fsigned-char -Wno-unused-function -Wno-unused-local-typedef
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g  -Wl,-export-dynamic
> CMakeFiles/unittest_lfnindex.dir/TestLFNIndex.cc.o  -o
> ../../../bin/unittest_lfnindex  -L/usr/local/lib
> ../../../lib/libgmock_main.a ../../../lib/libgmock.a
> ../../../lib/libgtest.a -lpthread ../../../lib/libos.a
> ../../../lib/libglobal.a ../../../lib/libkv.a
> /usr/local/lib/libleveldb.so ../../rocksdb/librocksdb.a
> /usr/local/lib/libtcmalloc.so /usr/local/lib/libsnappy.so -lz -lbz2
> /usr/local/lib/liblz4.so ../../../lib/libceph-common.so.0
> ../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a
> ../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so
> /usr/local/lib/libboost_system.so /usr/local/lib/libboost_regex.so
> /usr/local/lib/libboost_random.so
> /usr/local/lib/libboost_program_options.so
> /usr/local/lib/libboost_date_time.so
> /usr/local/lib/libboost_iostreams.so -lexecinfo
> /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so
> /usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so
> /usr/local/lib/libplds4.so /usr/local/lib/libplc4.so
> /usr/local/lib/libnspr4.so -lpthread -lrt /usr/local/lib/libatomic_ops.a
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 75%] Built target unittest_lfnindex
> [ 75%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/managed_lock/test_mock_BreakRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/managed_lock/test_mock_BreakRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/managed_lock/test_mock_BreakRequest.cc
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 75%] Built target ceph_test_objectstore_workloadgen
> [ 75%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/managed_lock/test_mock_GetLockerRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/managed_lock/test_mock_GetLockerRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/managed_lock/test_mock_GetLockerRequest.cc
> [ 75%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/managed_lock/test_mock_ReacquireRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/managed_lock/test_mock_ReacquireRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/managed_lock/test_mock_ReacquireRequest.cc
> [ 75%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/managed_lock/test_mock_ReleaseRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/managed_lock/test_mock_ReleaseRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/managed_lock/test_mock_ReleaseRequest.cc
> [ 75%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/mirror/test_mock_DisableRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/mirror/test_mock_DisableRequest.cc.o -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/mirror/test_mock_DisableRequest.cc
> [ 75%] Linking CXX executable
> ../../../bin/ceph_test_filestore_idempotent_sequence
> cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore &&
> /usr/local/bin/cmake -E cmake_link_script
> CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/link.txt --verbose=1
> ccache /usr/bin/CC    -Wall -Wtype-limits -Wignored-qualifiers
> -Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing
> -fsigned-char -Wno-unused-function -Wno-unused-local-typedef
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g  -Wl,-export-dynamic
> CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/test_idempotent_sequence.cc.o
> CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/DeterministicOpSequence.cc.o
> CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/TestObjectStoreState.cc.o
> CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/FileStoreDiff.cc.o
>   -o ../../../bin/ceph_test_filestore_idempotent_sequence
> -L/usr/local/lib ../../../lib/libos.a ../../../lib/libglobal.a -lrt
> /usr/local/lib/libatomic_ops.a ../../../lib/libkv.a
> /usr/local/lib/libleveldb.so ../../rocksdb/librocksdb.a
> /usr/local/lib/libtcmalloc.so /usr/local/lib/libsnappy.so -lz -lbz2
> /usr/local/lib/liblz4.so ../../../lib/libceph-common.so.0 -lrt
> ../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a
> ../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so
> /usr/local/lib/libboost_system.so /usr/local/lib/libboost_regex.so
> /usr/local/lib/libboost_random.so
> /usr/local/lib/libboost_program_options.so
> /usr/local/lib/libboost_date_time.so
> /usr/local/lib/libboost_iostreams.so -lexecinfo
> /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so
> /usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so
> /usr/local/lib/libplds4.so /usr/local/lib/libplc4.so
> /usr/local/lib/libnspr4.so -lpthread
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss:
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 75%] Built target ceph_test_filestore_idempotent_sequence
> [ 75%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/object_map/test_mock_InvalidateRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_InvalidateRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/object_map/test_mock_InvalidateRequest.cc
> [ 75%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/object_map/test_mock_LockRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_LockRequest.cc.o -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/object_map/test_mock_LockRequest.cc
> [ 75%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/object_map/test_mock_RefreshRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_RefreshRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/object_map/test_mock_RefreshRequest.cc
> [ 76%] Linking CXX executable ../../../bin/unittest_ecbackend
> cd /home/jenkins/workspace/ceph-master/build/src/test/osd &&
> /usr/local/bin/cmake -E cmake_link_script
> CMakeFiles/unittest_ecbackend.dir/link.txt --verbose=1
> ccache /usr/bin/CC    -Wall -Wtype-limits -Wignored-qualifiers
> -Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing
> -fsigned-char -Wno-unused-function -Wno-unused-local-typedef
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g  -Wl,-export-dynamic
> CMakeFiles/unittest_ecbackend.dir/TestECBackend.cc.o  -o
> ../../../bin/unittest_ecbackend  -L/usr/local/lib
> ../../../lib/libgmock_main.a ../../../lib/libgmock.a
> ../../../lib/libgtest.a -lpthread ../../../lib/libosd.a
> ../../../lib/libglobal.a /usr/local/lib/libleveldb.so
> /usr/local/lib/libtcmalloc.so ../../../lib/libceph-common.so.0
> ../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a
> ../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so
> /usr/local/lib/libboost_system.so /usr/local/lib/libboost_regex.so
> /usr/local/lib/libboost_random.so
> /usr/local/lib/libboost_program_options.so
> /usr/local/lib/libboost_date_time.so
> /usr/local/lib/libboost_iostreams.so -lexecinfo
> /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so
> /usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so
> /usr/local/lib/libplds4.so /usr/local/lib/libplc4.so
> /usr/local/lib/libnspr4.so -lpthread -lrt /usr/local/lib/libatomic_ops.a
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 76%] Built target unittest_ecbackend
> [ 76%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/object_map/test_mock_ResizeRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_ResizeRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/object_map/test_mock_ResizeRequest.cc
> [ 76%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/object_map/test_mock_SnapshotCreateRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_SnapshotCreateRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/object_map/test_mock_SnapshotCreateRequest.cc
> [ 77%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/object_map/test_mock_SnapshotRemoveRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_SnapshotRemoveRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/object_map/test_mock_SnapshotRemoveRequest.cc
> [ 77%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/object_map/test_mock_SnapshotRollbackRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_SnapshotRollbackRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/object_map/test_mock_SnapshotRollbackRequest.cc
> [ 77%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/object_map/test_mock_UnlockRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_UnlockRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/object_map/test_mock_UnlockRequest.cc
> [ 77%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/object_map/test_mock_UpdateRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_UpdateRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/object_map/test_mock_UpdateRequest.cc
> [ 77%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/operation/test_mock_DisableFeaturesRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_DisableFeaturesRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/operation/test_mock_DisableFeaturesRequest.cc
> [ 77%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/operation/test_mock_EnableFeaturesRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_EnableFeaturesRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/operation/test_mock_EnableFeaturesRequest.cc
> [ 77%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/operation/test_mock_Request.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_Request.cc.o -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/operation/test_mock_Request.cc
> [ 77%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/operation/test_mock_ResizeRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_ResizeRequest.cc.o -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/operation/test_mock_ResizeRequest.cc
> [ 77%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/operation/test_mock_SnapshotCreateRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_SnapshotCreateRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/operation/test_mock_SnapshotCreateRequest.cc
> [ 77%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/operation/test_mock_SnapshotProtectRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_SnapshotProtectRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/operation/test_mock_SnapshotProtectRequest.cc
> [ 77%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/operation/test_mock_SnapshotRemoveRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_SnapshotRemoveRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/operation/test_mock_SnapshotRemoveRequest.cc
> [ 77%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/operation/test_mock_SnapshotRollbackRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_SnapshotRollbackRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/operation/test_mock_SnapshotRollbackRequest.cc
> [ 77%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/operation/test_mock_SnapshotUnprotectRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_SnapshotUnprotectRequest.cc.o
> -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/operation/test_mock_SnapshotUnprotectRequest.cc
> [ 77%] Building CXX object
> src/test/librbd/CMakeFiles/unittest_librbd.dir/watcher/test_mock_RewatchRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd && ccache
> /usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -DTEST_LIBRBD_INTERNALS
> -I/home/jenkins/workspace/ceph-master/build/src/include
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
> -isystem /home/jenkins/workspace/ceph-master/build/include
> -I/home/jenkins/workspace/ceph-master/src/xxHash
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Werror=format-security -fno-strict-aliasing -fsigned-char
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g -fPIE   -DHAVE_CONFIG_H -D__CEPH__
> -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include
> -fno-strict-aliasing -std=c++11 -o
> CMakeFiles/unittest_librbd.dir/watcher/test_mock_RewatchRequest.cc.o -c
> /home/jenkins/workspace/ceph-master/src/test/librbd/watcher/test_mock_RewatchRequest.cc
> [ 77%] Linking CXX executable ../../../bin/unittest_librbd
> cd /home/jenkins/workspace/ceph-master/build/src/test/librbd &&
> /usr/local/bin/cmake -E cmake_link_script
> CMakeFiles/unittest_librbd.dir/link.txt --verbose=1
> ccache /usr/bin/CC    -Wall -Wtype-limits -Wignored-qualifiers
> -Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing
> -fsigned-char -Wno-unused-function -Wno-unused-local-typedef
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
> -Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
> -Wnon-virtual-dtor -Wno-inconsistent-missing-override
> -Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
> -I/usr/local/include/nss/nss -I/usr/local/include/nspr
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
> -fno-builtin-free  -O0 -g  -Wl,-export-dynamic
> CMakeFiles/unittest_librbd.dir/test_BlockGuard.cc.o
> CMakeFiles/unittest_librbd.dir/test_Groups.cc.o
> CMakeFiles/unittest_librbd.dir/test_main.cc.o
> CMakeFiles/unittest_librbd.dir/test_mock_fixture.cc.o
> CMakeFiles/unittest_librbd.dir/test_mock_ExclusiveLock.cc.o
> CMakeFiles/unittest_librbd.dir/test_mock_Journal.cc.o
> CMakeFiles/unittest_librbd.dir/test_mock_ManagedLock.cc.o
> CMakeFiles/unittest_librbd.dir/test_mock_ObjectMap.cc.o
> CMakeFiles/unittest_librbd.dir/exclusive_lock/test_mock_PreAcquireRequest.cc.o
> CMakeFiles/unittest_librbd.dir/exclusive_lock/test_mock_PostAcquireRequest.cc.o
> CMakeFiles/unittest_librbd.dir/exclusive_lock/test_mock_PreReleaseRequest.cc.o
> CMakeFiles/unittest_librbd.dir/image/test_mock_RefreshRequest.cc.o
> CMakeFiles/unittest_librbd.dir/image/test_mock_RemoveRequest.cc.o
> CMakeFiles/unittest_librbd.dir/io/test_mock_ImageRequest.cc.o
> CMakeFiles/unittest_librbd.dir/journal/test_mock_OpenRequest.cc.o
> CMakeFiles/unittest_librbd.dir/journal/test_mock_PromoteRequest.cc.o
> CMakeFiles/unittest_librbd.dir/journal/test_mock_Replay.cc.o
> CMakeFiles/unittest_librbd.dir/managed_lock/test_mock_AcquireRequest.cc.o
> CMakeFiles/unittest_librbd.dir/managed_lock/test_mock_BreakRequest.cc.o
> CMakeFiles/unittest_librbd.dir/managed_lock/test_mock_GetLockerRequest.cc.o
> CMakeFiles/unittest_librbd.dir/managed_lock/test_mock_ReacquireRequest.cc.o
> CMakeFiles/unittest_librbd.dir/managed_lock/test_mock_ReleaseRequest.cc.o
> CMakeFiles/unittest_librbd.dir/mirror/test_mock_DisableRequest.cc.o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_InvalidateRequest.cc.o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_LockRequest.cc.o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_RefreshRequest.cc.o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_ResizeRequest.cc.o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_SnapshotCreateRequest.cc.o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_SnapshotRemoveRequest.cc.o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_SnapshotRollbackRequest.cc.o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_UnlockRequest.cc.o
> CMakeFiles/unittest_librbd.dir/object_map/test_mock_UpdateRequest.cc.o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_DisableFeaturesRequest.cc.o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_EnableFeaturesRequest.cc.o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_Request.cc.o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_ResizeRequest.cc.o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_SnapshotCreateRequest.cc.o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_SnapshotProtectRequest.cc.o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_SnapshotRemoveRequest.cc.o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_SnapshotRollbackRequest.cc.o
> CMakeFiles/unittest_librbd.dir/operation/test_mock_SnapshotUnprotectRequest.cc.o
> CMakeFiles/unittest_librbd.dir/watcher/test_mock_RewatchRequest.cc.o
> ../../CMakeFiles/common_texttable_obj.dir/common/TextTable.cc.o  -o
> ../../../bin/unittest_librbd  -L/usr/local/lib
> ../../../lib/libcls_rbd.so.1.0.0 ../../../lib/libcls_rbd_client.a
> ../../../lib/libcls_lock.so.1.0.0 ../../../lib/libcls_lock_client.a
> ../../../lib/libjournal.a ../../../lib/libjournal_test_mock.a
> ../../../lib/libcls_journal.so.1.0.0
> ../../../lib/libcls_journal_client.a ../../../lib/librados_test_stub.a
> ../../../lib/librados.so.2.0.0 ../../../lib/librbd_test.a
> ../../../lib/librbd_test_mock.a ../../../lib/librbd_api.a
> ../../../lib/librbd_internal.a ../../../lib/librbd_types.a
> ../../../lib/libosdc.a ../../../lib/libglobal.a
> ../../../lib/libgmock_main.a ../../../lib/libgmock.a
> ../../../lib/libgtest.a -lpthread ../../../lib/libradostest.a
> ../../../lib/libceph-common.so.0 ../../../lib/liberasure_code.a
> /usr/local/lib/libboost_thread.so /usr/local/lib/libboost_system.so
> /usr/local/lib/libboost_regex.so /usr/local/lib/libboost_random.so
> /usr/local/lib/libboost_program_options.so
> /usr/local/lib/libboost_date_time.so
> /usr/local/lib/libboost_iostreams.so -lexecinfo
> /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so
> /usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so
> /usr/local/lib/libplds4.so /usr/local/lib/libplc4.so
> /usr/local/lib/libnspr4.so -lpthread -lrt /usr/local/lib/libatomic_ops.a
> ../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 77%] Built target unittest_librbd
> gmake[1]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake: *** [Makefile:139: all] Error 2
> Build step 'Execute shell' marked build as failure

