From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Fwd: Build failed in Jenkins: ceph-master #1762
Date: Fri, 9 Feb 2018 09:54:53 +0100
Message-ID: <36698607-d1d7-fe7d-c887-a7190b548791@digiware.nl>
References: <333349266.59.1518165404718.JavaMail.jenkins@cephdev.digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:48022 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbeBIIzB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 9 Feb 2018 03:55:01 -0500
In-Reply-To: <333349266.59.1518165404718.JavaMail.jenkins@cephdev.digiware.nl>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Gregory Farnum <gfarnum@redhat.com>

Hi Greg,

Clang is rather picky on not initing foo and bar...
Suggestion for fixing this?

Thanx,
--WjW


-------- Forwarded Message --------
Subject: Build failed in Jenkins: ceph-master #1762
Date: Fri, 9 Feb 2018 09:36:44 +0100 (CET)
From: jenkins@digiware.nl
Reply-To: jenkins@digiware.nl
To: wjw@digiware.nl

See 
<http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/1762/display/redirect>

------------------------------------------
[...truncated 2.15 MB...]
[ 59%] Built target unittest_erasure_code
[ 59%] Built target unittest_mds_authcap
gmake -f 
src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/build.make 
src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/depend
gmake -f 
src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent.dir/build.make 
src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent.dir/depend
[ 59%] Built target unittest_erasure_code_isa
gmake -f 
src/test/objectstore/CMakeFiles/ceph_test_keyvaluedb.dir/build.make 
src/test/objectstore/CMakeFiles/ceph_test_keyvaluedb.dir/depend
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/unittest_chain_xattr.dir/DependInfo.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/unittest_chain_xattr.dir/depend.internal".
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/CMakeDirectoryInformation.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/unittest_chain_xattr.dir/depend.internal".
[ 59%] Built target ceph_test_keyvaluedb_atomicity
gmake -f 
src/test/objectstore/CMakeFiles/ceph_test_objectstore.dir/build.make 
src/test/objectstore/CMakeFiles/ceph_test_objectstore.dir/depend
[ 59%] Built target ceph_test_async_driver
gmake -f 
src/test/objectstore/CMakeFiles/unittest_rocksdb_option.dir/build.make 
src/test/objectstore/CMakeFiles/unittest_rocksdb_option.dir/depend
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake -E 
cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
/home/jenkins/workspace/ceph-master/src/test/objectstore 
/home/jenkins/workspace/ceph-master/build 
/home/jenkins/workspace/ceph-master/build/src/test/objectstore 
/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent.dir/DependInfo.cmake 
--color=
gmake -f 
src/test/objectstore/CMakeFiles/ceph_perf_objectstore.dir/build.make 
src/test/objectstore/CMakeFiles/ceph_perf_objectstore.dir/depend
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake -E 
cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
/home/jenkins/workspace/ceph-master/src/test/objectstore 
/home/jenkins/workspace/ceph-master/build 
/home/jenkins/workspace/ceph-master/build/src/test/objectstore 
/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/DependInfo.cmake 
--color=
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake -E 
cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
/home/jenkins/workspace/ceph-master/src/test/objectstore 
/home/jenkins/workspace/ceph-master/build 
/home/jenkins/workspace/ceph-master/build/src/test/objectstore 
/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_test_keyvaluedb.dir/DependInfo.cmake 
--color=
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake -E 
cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
/home/jenkins/workspace/ceph-master/src/test/objectstore 
/home/jenkins/workspace/ceph-master/build 
/home/jenkins/workspace/ceph-master/build/src/test/objectstore 
/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_test_objectstore.dir/DependInfo.cmake 
--color=
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake -E 
cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
/home/jenkins/workspace/ceph-master/src/test/objectstore 
/home/jenkins/workspace/ceph-master/build 
/home/jenkins/workspace/ceph-master/build/src/test/objectstore 
/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/unittest_rocksdb_option.dir/DependInfo.cmake 
--color=
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake -E 
cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
/home/jenkins/workspace/ceph-master/src/test/objectstore 
/home/jenkins/workspace/ceph-master/build 
/home/jenkins/workspace/ceph-master/build/src/test/objectstore 
/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_perf_objectstore.dir/DependInfo.cmake 
--color=
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent.dir/DependInfo.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent.dir/depend.internal".
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/CMakeDirectoryInformation.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent.dir/depend.internal".
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/DependInfo.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/depend.internal".
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/CMakeDirectoryInformation.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/depend.internal".
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_perf_objectstore.dir/DependInfo.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_perf_objectstore.dir/depend.internal".
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/CMakeDirectoryInformation.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_perf_objectstore.dir/depend.internal".
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/unittest_rocksdb_option.dir/DependInfo.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/unittest_rocksdb_option.dir/depend.internal".
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_test_objectstore.dir/DependInfo.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_test_objectstore.dir/depend.internal".
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/CMakeDirectoryInformation.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/unittest_rocksdb_option.dir/depend.internal".
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/CMakeDirectoryInformation.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_test_objectstore.dir/depend.internal".
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_test_keyvaluedb.dir/DependInfo.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_test_keyvaluedb.dir/depend.internal".
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/CMakeDirectoryInformation.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/objectstore/CMakeFiles/ceph_test_keyvaluedb.dir/depend.internal".
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
[ 59%] Building CXX object 
src/test/objectstore/CMakeFiles/unittest_transaction.dir/test_transaction.cc.o
[ 59%] Building CXX object 
src/test/objectstore/CMakeFiles/unittest_memstore_clone.dir/test_memstore_clone.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include  -Wall 
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
-fno-strict-aliasing -std=c++1z -o 
CMakeFiles/unittest_transaction.dir/test_transaction.cc.o -c 
/home/jenkins/workspace/ceph-master/src/test/objectstore/test_transaction.cc
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include  -Wall 
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
-fno-strict-aliasing -std=c++1z -o 
CMakeFiles/unittest_memstore_clone.dir/test_memstore_clone.cc.o -c 
/home/jenkins/workspace/ceph-master/src/test/objectstore/test_memstore_clone.cc
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
[ 59%] Building CXX object 
src/test/ObjectMap/CMakeFiles/ceph_test_object_map.dir/test_object_map.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/ObjectMap && 
ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include  -Wall 
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
-fno-strict-aliasing -std=c++1z -o 
CMakeFiles/ceph_test_object_map.dir/test_object_map.cc.o -c 
/home/jenkins/workspace/ceph-master/src/test/ObjectMap/test_object_map.cc
Scanning dependencies of target ceph_test_objectstore
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
gmake -f 
src/test/objectstore/CMakeFiles/ceph_test_objectstore.dir/build.make 
src/test/objectstore/CMakeFiles/ceph_test_objectstore.dir/build
[ 60%] Linking CXX executable ../../../bin/ceph_perf_msgr_client
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
cd /home/jenkins/workspace/ceph-master/build/src/test/msgr && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/ceph_perf_msgr_client.dir/link.txt --verbose=1
[ 60%] Building CXX object 
src/test/objectstore/CMakeFiles/ceph_test_objectstore.dir/store_test.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
-fno-strict-aliasing -std=c++1z -o 
CMakeFiles/ceph_test_objectstore.dir/store_test.cc.o -c 
/home/jenkins/workspace/ceph-master/src/test/objectstore/store_test.cc
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/ceph_perf_msgr_client.dir/perf_msgr_client.cc.o  -o 
../../../bin/ceph_perf_msgr_client  -L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss: 
../../../lib/libos.a ../../../lib/libglobal.a 
../../../lib/libgmock_main.a ../../../lib/libgmock.a 
../../../lib/libgtest.a -lpthread /usr/local/lib/libfuse.so 
../../../lib/libkv.a /usr/local/lib/libleveldb.so 
../../rocksdb/librocksdb.a /usr/local/lib/libsnappy.so -lz 
../../../lib/libceph-common.so.0 ../../../lib/libjson_spirit.a 
../../../lib/libcommon_utf8.a ../../../lib/liberasure_code.a 
/usr/local/lib/libboost_thread.so /usr/local/lib/libboost_chrono.so 
/usr/local/lib/libboost_atomic.so /usr/local/lib/libboost_random.so 
/usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lrt -lpthread Scanning dependencies of 
target unittest_chain_xattr
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
gmake -f 
src/test/objectstore/CMakeFiles/unittest_chain_xattr.dir/build.make 
src/test/objectstore/CMakeFiles/unittest_chain_xattr.dir/build
Scanning dependencies of target ceph_test_keyvaluedb
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
gmake -f 
src/test/objectstore/CMakeFiles/ceph_test_keyvaluedb.dir/build.make 
src/test/objectstore/CMakeFiles/ceph_test_keyvaluedb.dir/build
Scanning dependencies of target unittest_rocksdb_option
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
gmake -f 
src/test/objectstore/CMakeFiles/unittest_rocksdb_option.dir/build.make 
src/test/objectstore/CMakeFiles/unittest_rocksdb_option.dir/build
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
[ 60%] Building CXX object 
src/test/objectstore/CMakeFiles/unittest_chain_xattr.dir/chain_xattr.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include  -Wall 
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
-fno-strict-aliasing -std=c++1z -o 
CMakeFiles/unittest_chain_xattr.dir/chain_xattr.cc.o -c 
/home/jenkins/workspace/ceph-master/src/test/objectstore/chain_xattr.cc
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
[ 60%] Building CXX object 
src/test/objectstore/CMakeFiles/ceph_test_keyvaluedb.dir/test_kv.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
-fno-strict-aliasing -std=c++1z -o 
CMakeFiles/ceph_test_keyvaluedb.dir/test_kv.cc.o -c 
/home/jenkins/workspace/ceph-master/src/test/objectstore/test_kv.cc
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
[ 60%] Building CXX object 
src/test/objectstore/CMakeFiles/unittest_rocksdb_option.dir/TestRocksdbOptionParse.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include  -Wall 
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
-fno-strict-aliasing -std=c++1z -o 
CMakeFiles/unittest_rocksdb_option.dir/TestRocksdbOptionParse.cc.o -c 
/home/jenkins/workspace/ceph-master/src/test/objectstore/TestRocksdbOptionParse.cc
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
[ 60%] Built target ceph_perf_msgr_client
[ 60%] Building CXX object 
src/test/ObjectMap/CMakeFiles/ceph_test_object_map.dir/KeyValueDBMemory.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/ObjectMap && 
ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include  -Wall 
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
-fno-strict-aliasing -std=c++1z -o 
CMakeFiles/ceph_test_object_map.dir/KeyValueDBMemory.cc.o -c 
/home/jenkins/workspace/ceph-master/src/test/ObjectMap/KeyValueDBMemory.cc
Scanning dependencies of target ceph_perf_objectstore
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
Scanning dependencies of target ceph_test_filestore_idempotent
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
[ 60%] Linking CXX executable ../../../bin/ceph_perf_msgr_server
cd /home/jenkins/workspace/ceph-master/build/src/test/msgr && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/ceph_perf_msgr_server.dir/link.txt --verbose=1
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/ceph_perf_msgr_server.dir/perf_msgr_server.cc.o  -o 
../../../bin/ceph_perf_msgr_server  -L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss: 
../../../lib/libos.a ../../../lib/libglobal.a 
../../../lib/libgmock_main.a ../../../lib/libgmock.a 
../../../lib/libgtest.a -lpthread /usr/local/lib/libfuse.so 
../../../lib/libkv.a /usr/local/lib/libleveldb.so 
../../rocksdb/librocksdb.a /usr/local/lib/libsnappy.so -lz 
../../../lib/libceph-common.so.0 ../../../lib/libjson_spirit.a 
../../../lib/libcommon_utf8.a ../../../lib/liberasure_code.a 
/usr/local/lib/libboost_thread.so /usr/local/lib/libboost_chrono.so 
/usr/local/lib/libboost_atomic.so /usr/local/lib/libboost_random.so 
/usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lrt -lpthread Scanning dependencies of 
target ceph_test_filestore_idempotent_sequence
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
[ 60%] Linking CXX executable ../../../bin/ceph_test_keyvaluedb_iterators
cd /home/jenkins/workspace/ceph-master/build/src/test/ObjectMap && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/ceph_test_keyvaluedb_iterators.dir/link.txt --verbose=1
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/ceph_test_keyvaluedb_iterators.dir/test_keyvaluedb_iterators.cc.o 
CMakeFiles/ceph_test_keyvaluedb_iterators.dir/KeyValueDBMemory.cc.o  -o 
../../../bin/ceph_test_keyvaluedb_iterators  -L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
../../../lib/libos.a ../../../lib/libgmock_main.a 
../../../lib/libgmock.a ../../../lib/libgtest.a -lpthread 
../../../lib/libglobal.a -lrt /usr/local/lib/libfuse.so 
../../../lib/libkv.a /usr/local/lib/libleveldb.so 
../../rocksdb/librocksdb.a /usr/local/lib/libsnappy.so -lz 
../../../lib/libceph-common.so.0 ../../../lib/libjson_spirit.a 
../../../lib/libcommon_utf8.a ../../../lib/liberasure_code.a 
/usr/local/lib/libboost_thread.so /usr/local/lib/libboost_chrono.so 
/usr/local/lib/libboost_atomic.so /usr/local/lib/libboost_random.so 
/usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lpthread gmake -f 
src/test/os/CMakeFiles/unittest_lfnindex.dir/build.make 
src/test/os/CMakeFiles/unittest_lfnindex.dir/depend
gmake -f 
src/test/objectstore/CMakeFiles/ceph_perf_objectstore.dir/build.make 
src/test/objectstore/CMakeFiles/ceph_perf_objectstore.dir/build
gmake -f 
src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent.dir/build.make 
src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent.dir/build
gmake -f 
src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/build.make 
src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/build
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake -E 
cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
/home/jenkins/workspace/ceph-master/src/test/os 
/home/jenkins/workspace/ceph-master/build 
/home/jenkins/workspace/ceph-master/build/src/test/os 
/home/jenkins/workspace/ceph-master/build/src/test/os/CMakeFiles/unittest_lfnindex.dir/DependInfo.cmake 
--color=
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/os/CMakeFiles/unittest_lfnindex.dir/DependInfo.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/os/CMakeFiles/unittest_lfnindex.dir/depend.internal".
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/os/CMakeFiles/CMakeDirectoryInformation.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/os/CMakeFiles/unittest_lfnindex.dir/depend.internal".
[ 60%] Built target ceph_perf_msgr_server
gmake -f 
src/test/osd/CMakeFiles/unittest_mclock_client_queue.dir/build.make 
src/test/osd/CMakeFiles/unittest_mclock_client_queue.dir/depend
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake -E 
cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
/home/jenkins/workspace/ceph-master/src/test/osd 
/home/jenkins/workspace/ceph-master/build 
/home/jenkins/workspace/ceph-master/build/src/test/osd 
/home/jenkins/workspace/ceph-master/build/src/test/osd/CMakeFiles/unittest_mclock_client_queue.dir/DependInfo.cmake 
--color=
[ 60%] Building CXX object 
src/test/objectstore/CMakeFiles/ceph_perf_objectstore.dir/ObjectStoreTransactionBenchmark.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
-fno-strict-aliasing -std=c++1z -o 
CMakeFiles/ceph_perf_objectstore.dir/ObjectStoreTransactionBenchmark.cc.o 
-c 
/home/jenkins/workspace/ceph-master/src/test/objectstore/ObjectStoreTransactionBenchmark.cc
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/osd/CMakeFiles/unittest_mclock_client_queue.dir/DependInfo.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/osd/CMakeFiles/unittest_mclock_client_queue.dir/depend.internal".
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/osd/CMakeFiles/CMakeDirectoryInformation.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/osd/CMakeFiles/unittest_mclock_client_queue.dir/depend.internal".
[ 60%] Building CXX object 
src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent.dir/test_idempotent.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include  -Wall 
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS -std=c++1z -o 
CMakeFiles/ceph_test_filestore_idempotent.dir/test_idempotent.cc.o -c 
/home/jenkins/workspace/ceph-master/src/test/objectstore/test_idempotent.cc
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
[ 61%] Building CXX object 
src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/test_idempotent_sequence.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include  -Wall 
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS -std=c++1z -o 
CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/test_idempotent_sequence.cc.o 
-c 
/home/jenkins/workspace/ceph-master/src/test/objectstore/test_idempotent_sequence.cc
[ 62%] Linking CXX executable ../../../bin/ceph_test_mon_msg
cd /home/jenkins/workspace/ceph-master/build/src/test/mon && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/ceph_test_mon_msg.dir/link.txt --verbose=1
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/ceph_test_mon_msg.dir/test-mon-msg.cc.o  -o 
../../../bin/ceph_test_mon_msg  -L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
../../../lib/libos.a ../../../lib/libosdc.a ../../../lib/libglobal.a 
../../../lib/libgmock_main.a ../../../lib/libgmock.a 
../../../lib/libgtest.a -lpthread /usr/local/lib/libfuse.so 
../../../lib/libkv.a /usr/local/lib/libleveldb.so 
../../rocksdb/librocksdb.a /usr/local/lib/libsnappy.so -lz 
../../../lib/libdmclock.a ../../../lib/libceph-common.so.0 
../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a 
../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
/usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
/usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lrt -lpthread gmake[2]: Leaving directory 
'/home/jenkins/workspace/ceph-master/build'
[ 62%] Built target ceph_test_mon_msg
[ 62%] Building CXX object 
src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent.dir/FileStoreTracker.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include  -Wall 
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS -std=c++1z -o 
CMakeFiles/ceph_test_filestore_idempotent.dir/FileStoreTracker.cc.o -c 
/home/jenkins/workspace/ceph-master/src/test/objectstore/FileStoreTracker.cc
/home/jenkins/workspace/ceph-master/src/test/fs/mds_types.cc:23:11: 
error: declaration of variable 'foo' with deduced type 'inode_t' 
requires an initializer
   inode_t foo;
           ^
/home/jenkins/workspace/ceph-master/src/test/fs/mds_types.cc:24:11: 
error: declaration of variable 'bar' with deduced type 'inode_t' 
requires an initializer
   inode_t bar;
           ^
/home/jenkins/workspace/ceph-master/src/test/fs/mds_types.cc:54:11: 
error: declaration of variable 'foo' with deduced type 'inode_t' 
requires an initializer
   inode_t foo;
           ^
/home/jenkins/workspace/ceph-master/src/test/fs/mds_types.cc:55:11: 
error: declaration of variable 'bar' with deduced type 'inode_t' 
requires an initializer
   inode_t bar;
           ^
/home/jenkins/workspace/ceph-master/src/test/fs/mds_types.cc:81:11: 
error: declaration of variable 'foo' with deduced type 'inode_t' 
requires an initializer
   inode_t foo;
           ^
/home/jenkins/workspace/ceph-master/src/test/fs/mds_types.cc:82:11: 
error: declaration of variable 'bar' with deduced type 'inode_t' 
requires an initializer
   inode_t bar;
           ^
6 errors generated.
gmake[2]: *** 
[src/test/fs/CMakeFiles/unittest_mds_types.dir/build.make:63: 
src/test/fs/CMakeFiles/unittest_mds_types.dir/mds_types.cc.o] Error 1
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
Scanning dependencies of target unittest_lfnindex
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
Scanning dependencies of target unittest_mclock_client_queue
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
[ 62%] Linking CXX executable ../../../bin/unittest_chain_xattr
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/unittest_chain_xattr.dir/link.txt --verbose=1
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/unittest_chain_xattr.dir/chain_xattr.cc.o  -o 
../../../bin/unittest_chain_xattr  -L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
../../../lib/libgmock_main.a ../../../lib/libgmock.a 
../../../lib/libgtest.a -lpthread ../../../lib/libos.a 
../../../lib/libglobal.a /usr/local/lib/libfuse.so ../../../lib/libkv.a 
/usr/local/lib/libleveldb.so ../../rocksdb/librocksdb.a 
/usr/local/lib/libsnappy.so -lz ../../../lib/libceph-common.so.0 
../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a 
../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
/usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
/usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lpthread -lrt gmake[2]: Leaving directory 
'/home/jenkins/workspace/ceph-master/build'
[ 62%] Linking CXX executable ../../../bin/ceph_test_keyvaluedb
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/ceph_test_keyvaluedb.dir/link.txt --verbose=1
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/ceph_test_keyvaluedb.dir/test_kv.cc.o  -o 
../../../bin/ceph_test_keyvaluedb  -L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss: 
../../../lib/libos.a ../../../lib/libgmock_main.a 
../../../lib/libgmock.a ../../../lib/libgtest.a -lpthread 
../../../lib/libglobal.a -lrt /usr/local/lib/libfuse.so 
../../../lib/libkv.a /usr/local/lib/libleveldb.so 
../../rocksdb/librocksdb.a /usr/local/lib/libsnappy.so -lz 
../../../lib/libceph-common.so.0 ../../../lib/libjson_spirit.a 
../../../lib/libcommon_utf8.a ../../../lib/liberasure_code.a 
/usr/local/lib/libboost_thread.so /usr/local/lib/libboost_chrono.so 
/usr/local/lib/libboost_atomic.so /usr/local/lib/libboost_random.so 
/usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lpthread [ 62%] Linking CXX executable 
../../../bin/unittest_rocksdb_option
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/unittest_rocksdb_option.dir/link.txt --verbose=1
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/unittest_rocksdb_option.dir/TestRocksdbOptionParse.cc.o 
../CMakeFiles/unit-main.dir/unit.cc.o  -o 
../../../bin/unittest_rocksdb_option  -L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
../../../lib/libgmock_main.a ../../../lib/libgmock.a 
../../../lib/libgtest.a -lpthread ../../../lib/libglobal.a 
../../../lib/libos.a ../../../lib/libceph-common.so.0 
../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a 
../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
/usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
/usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lpthread -lrt /usr/local/lib/libfuse.so 
../../../lib/libkv.a /usr/local/lib/libleveldb.so 
../../rocksdb/librocksdb.a /usr/local/lib/libsnappy.so -lz gmake[2]: 
Leaving directory '/home/jenkins/workspace/ceph-master/build'
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
[ 62%] Linking CXX executable ../../../bin/unittest_memstore_clone
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/unittest_memstore_clone.dir/link.txt --verbose=1
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/unittest_memstore_clone.dir/test_memstore_clone.cc.o 
CMakeFiles/store_test_fixture.dir/store_test_fixture.cc.o  -o 
../../../bin/unittest_memstore_clone  -L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
../../../lib/libgmock_main.a ../../../lib/libgmock.a 
../../../lib/libgtest.a -lpthread ../../../lib/libos.a 
../../../lib/libglobal.a /usr/local/lib/libfuse.so ../../../lib/libkv.a 
/usr/local/lib/libleveldb.so ../../rocksdb/librocksdb.a 
/usr/local/lib/libsnappy.so -lz ../../../lib/libceph-common.so.0 
../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a 
../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
/usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
/usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lpthread -lrt [ 62%] Linking CXX executable 
../../../bin/unittest_transaction
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/unittest_transaction.dir/link.txt --verbose=1
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/unittest_transaction.dir/test_transaction.cc.o  -o 
../../../bin/unittest_transaction  -L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
../../../lib/libgmock_main.a ../../../lib/libgmock.a 
../../../lib/libgtest.a -lpthread ../../../lib/libos.a 
../../../lib/libceph-common.so.0 /usr/local/lib/libfuse.so 
../../../lib/libkv.a /usr/local/lib/libleveldb.so 
../../rocksdb/librocksdb.a /usr/local/lib/libsnappy.so -lz 
../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a 
../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
/usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
/usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lpthread gmake[2]: Leaving directory 
'/home/jenkins/workspace/ceph-master/build'
[ 62%] Linking CXX executable ../../../bin/ceph_test_object_map
cd /home/jenkins/workspace/ceph-master/build/src/test/ObjectMap && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/ceph_test_object_map.dir/link.txt --verbose=1
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/ceph_test_object_map.dir/test_object_map.cc.o 
CMakeFiles/ceph_test_object_map.dir/KeyValueDBMemory.cc.o  -o 
../../../bin/ceph_test_object_map  -L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
../../../lib/libgmock_main.a ../../../lib/libgmock.a 
../../../lib/libgtest.a -lpthread ../../../lib/libos.a 
../../../lib/libgmock_main.a ../../../lib/libgmock.a 
../../../lib/libgtest.a -lpthread ../../../lib/libglobal.a -lrt 
/usr/local/lib/libfuse.so ../../../lib/libkv.a 
/usr/local/lib/libleveldb.so ../../rocksdb/librocksdb.a 
/usr/local/lib/libsnappy.so -lz ../../../lib/libceph-common.so.0 
../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a 
../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
/usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
/usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lpthread gmake[2]: Leaving directory 
'/home/jenkins/workspace/ceph-master/build'
[ 62%] Linking CXX executable ../../../bin/ceph_perf_objectstore
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/ceph_perf_objectstore.dir/link.txt --verbose=1
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/ceph_perf_objectstore.dir/ObjectStoreTransactionBenchmark.cc.o 
  -o ../../../bin/ceph_perf_objectstore  -L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss: 
../../../lib/libos.a ../../../lib/libosdc.a ../../../lib/libglobal.a 
../../../lib/libgmock_main.a ../../../lib/libgmock.a 
../../../lib/libgtest.a -lpthread /usr/local/lib/libfuse.so 
../../../lib/libkv.a /usr/local/lib/libleveldb.so 
../../rocksdb/librocksdb.a /usr/local/lib/libsnappy.so -lz 
../../../lib/libdmclock.a ../../../lib/libceph-common.so.0 
../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a 
../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
/usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
/usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lrt -lpthread gmake[2]: Leaving directory 
'/home/jenkins/workspace/ceph-master/build'
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
[ 62%] Building CXX object 
src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent.dir/__/common/ObjectContents.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include  -Wall 
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS -std=c++1z -o 
CMakeFiles/ceph_test_filestore_idempotent.dir/__/common/ObjectContents.cc.o 
-c /home/jenkins/workspace/ceph-master/src/test/common/ObjectContents.cc
[ 62%] Building CXX object 
src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/DeterministicOpSequence.cc.o
[ 62%] Building CXX object 
src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/TestObjectStoreState.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include  -Wall 
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS -std=c++1z -o 
CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/DeterministicOpSequence.cc.o 
-c 
/home/jenkins/workspace/ceph-master/src/test/objectstore/DeterministicOpSequence.cc
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include  -Wall 
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS -std=c++1z -o 
CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/TestObjectStoreState.cc.o 
-c 
/home/jenkins/workspace/ceph-master/src/test/objectstore/TestObjectStoreState.cc
[ 62%] Linking CXX executable ../../../bin/ceph_test_filestore_idempotent
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/ceph_test_filestore_idempotent.dir/link.txt --verbose=1
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/ceph_test_filestore_idempotent.dir/test_idempotent.cc.o 
CMakeFiles/ceph_test_filestore_idempotent.dir/FileStoreTracker.cc.o 
CMakeFiles/ceph_test_filestore_idempotent.dir/__/common/ObjectContents.cc.o 
  -o ../../../bin/ceph_test_filestore_idempotent  -L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
../../../lib/libos.a ../../../lib/libglobal.a -lrt 
/usr/local/lib/libfuse.so ../../../lib/libkv.a 
/usr/local/lib/libleveldb.so ../../rocksdb/librocksdb.a 
/usr/local/lib/libsnappy.so -lz ../../../lib/libceph-common.so.0 
../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a 
../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
/usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
/usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lpthread gmake[2]: Leaving directory 
'/home/jenkins/workspace/ceph-master/build'
[ 62%] Linking CXX executable ../../../bin/ceph_test_objectstore
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/ceph_test_objectstore.dir/link.txt --verbose=1
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/ceph_test_objectstore.dir/store_test.cc.o 
CMakeFiles/store_test_fixture.dir/store_test_fixture.cc.o  -o 
../../../bin/ceph_test_objectstore  -L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss: 
../../../lib/libos.a ../../../lib/libgmock_main.a 
../../../lib/libgmock.a ../../../lib/libgtest.a -lpthread 
../../../lib/libglobal.a -lrt /usr/local/lib/libfuse.so 
../../../lib/libkv.a /usr/local/lib/libleveldb.so 
../../rocksdb/librocksdb.a /usr/local/lib/libsnappy.so -lz 
../../../lib/libceph-common.so.0 ../../../lib/libjson_spirit.a 
../../../lib/libcommon_utf8.a ../../../lib/liberasure_code.a 
/usr/local/lib/libboost_thread.so /usr/local/lib/libboost_chrono.so 
/usr/local/lib/libboost_atomic.so /usr/local/lib/libboost_random.so 
/usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lpthread [ 62%] Linking CXX executable 
../../../bin/ceph_test_mon_workloadgen
cd /home/jenkins/workspace/ceph-master/build/src/test/mon && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/ceph_test_mon_workloadgen.dir/link.txt --verbose=1
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/ceph_test_mon_workloadgen.dir/test_mon_workloadgen.cc.o  -o 
../../../bin/ceph_test_mon_workloadgen  -L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss: 
../../../lib/libos.a ../../../lib/libosdc.a ../../../lib/libglobal.a 
-lrt /usr/local/lib/libfuse.so ../../../lib/libkv.a 
/usr/local/lib/libleveldb.so ../../rocksdb/librocksdb.a 
/usr/local/lib/libsnappy.so -lz ../../../lib/libdmclock.a 
../../../lib/libceph-common.so.0 ../../../lib/libjson_spirit.a 
../../../lib/libcommon_utf8.a ../../../lib/liberasure_code.a 
/usr/local/lib/libboost_thread.so /usr/local/lib/libboost_chrono.so 
/usr/local/lib/libboost_atomic.so /usr/local/lib/libboost_random.so 
/usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lpthread gmake[2]: Leaving directory 
'/home/jenkins/workspace/ceph-master/build'
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
[ 62%] Building CXX object 
src/test/objectstore/CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/FileStoreDiff.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include  -Wall 
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS -std=c++1z -o 
CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/FileStoreDiff.cc.o 
-c /home/jenkins/workspace/ceph-master/src/test/objectstore/FileStoreDiff.cc
gmake -f 
src/test/osd/CMakeFiles/unittest_mclock_op_class_queue.dir/build.make 
src/test/osd/CMakeFiles/unittest_mclock_op_class_queue.dir/depend
gmake -f 
src/test/osd/CMakeFiles/unittest_mclock_client_queue.dir/build.make 
src/test/osd/CMakeFiles/unittest_mclock_client_queue.dir/build
gmake -f src/test/os/CMakeFiles/unittest_lfnindex.dir/build.make 
src/test/os/CMakeFiles/unittest_lfnindex.dir/build
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake -E 
cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
/home/jenkins/workspace/ceph-master/src/test/osd 
/home/jenkins/workspace/ceph-master/build 
/home/jenkins/workspace/ceph-master/build/src/test/osd 
/home/jenkins/workspace/ceph-master/build/src/test/osd/CMakeFiles/unittest_mclock_op_class_queue.dir/DependInfo.cmake 
--color=
gmake[1]: *** [CMakeFiles/Makefile2:12439: 
src/test/fs/CMakeFiles/unittest_mds_types.dir/all] Error 2
gmake[1]: *** Waiting for unfinished jobs....
[ 62%] Built target ceph_perf_objectstore
[ 62%] Built target unittest_transaction
[ 62%] Built target ceph_test_filestore_idempotent
[ 62%] Built target ceph_test_keyvaluedb
[ 62%] Built target ceph_test_keyvaluedb_iterators
[ 62%] Built target unittest_chain_xattr
[ 62%] Built target unittest_memstore_clone
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/osd/CMakeFiles/unittest_mclock_op_class_queue.dir/DependInfo.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/osd/CMakeFiles/unittest_mclock_op_class_queue.dir/depend.internal".
Dependee 
"/home/jenkins/workspace/ceph-master/build/src/test/osd/CMakeFiles/CMakeDirectoryInformation.cmake" 
is newer than depender 
"/home/jenkins/workspace/ceph-master/build/src/test/osd/CMakeFiles/unittest_mclock_op_class_queue.dir/depend.internal".
[ 62%] Built target ceph_test_objectstore
[ 62%] Built target unittest_rocksdb_option
[ 62%] Built target ceph_test_object_map
[ 62%] Built target ceph_test_mon_workloadgen
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
[ 63%] Building CXX object 
src/test/os/CMakeFiles/unittest_lfnindex.dir/TestLFNIndex.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/os && ccache 
/usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include  -Wall 
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
-fno-strict-aliasing -std=c++1z -o 
CMakeFiles/unittest_lfnindex.dir/TestLFNIndex.cc.o -c 
/home/jenkins/workspace/ceph-master/src/test/os/TestLFNIndex.cc
[ 63%] Building CXX object 
src/test/osd/CMakeFiles/unittest_mclock_client_queue.dir/TestMClockClientQueue.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/osd && ccache 
/usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include  -Wall 
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
-fno-strict-aliasing -std=c++1z -o 
CMakeFiles/unittest_mclock_client_queue.dir/TestMClockClientQueue.cc.o 
-c /home/jenkins/workspace/ceph-master/src/test/osd/TestMClockClientQueue.cc
Scanning dependencies of target unittest_mclock_op_class_queue
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
gmake -f 
src/test/osd/CMakeFiles/unittest_mclock_op_class_queue.dir/build.make 
src/test/osd/CMakeFiles/unittest_mclock_op_class_queue.dir/build
gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
[ 63%] Building CXX object 
src/test/osd/CMakeFiles/unittest_mclock_op_class_queue.dir/TestMClockOpClassQueue.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/osd && ccache 
/usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
-I/home/jenkins/workspace/ceph-master/build/src/include 
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
-isystem /home/jenkins/workspace/ceph-master/build/include 
-I/usr/local/include/nss/nss -I/usr/local/include/nspr -isystem 
/home/jenkins/workspace/ceph-master/src/xxHash -isystem 
/home/jenkins/workspace/ceph-master/src/rapidjson/include 
-I/home/jenkins/workspace/ceph-master/src/dmclock/src 
-I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-isystem /home/jenkins/workspace/ceph-master/src/rocksdb/include  -Wall 
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
-Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof 
-Wnon-virtual-dtor -Wno-unknown-pragmas 
-Wno-inconsistent-missing-override -Wno-mismatched-tags 
-Wno-unused-private-field -Wno-address-of-packed-member 
-fdiagnostics-color=auto  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
-DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
-D__STDC_FORMAT_MACROS 
-I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
-I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
-I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
-fno-strict-aliasing -std=c++1z -o 
CMakeFiles/unittest_mclock_op_class_queue.dir/TestMClockOpClassQueue.cc.o 
-c 
/home/jenkins/workspace/ceph-master/src/test/osd/TestMClockOpClassQueue.cc
[ 63%] Linking CXX executable ../../../bin/unittest_lfnindex
cd /home/jenkins/workspace/ceph-master/build/src/test/os && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/unittest_lfnindex.dir/link.txt --verbose=1
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/unittest_lfnindex.dir/TestLFNIndex.cc.o  -o 
../../../bin/unittest_lfnindex  -L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
../../../lib/libgmock_main.a ../../../lib/libgmock.a 
../../../lib/libgtest.a -lpthread ../../../lib/libos.a 
../../../lib/libglobal.a /usr/local/lib/libfuse.so ../../../lib/libkv.a 
/usr/local/lib/libleveldb.so ../../rocksdb/librocksdb.a 
/usr/local/lib/libsnappy.so -lz ../../../lib/libceph-common.so.0 
../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a 
../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
/usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
/usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lpthread -lrt gmake[2]: Leaving directory 
'/home/jenkins/workspace/ceph-master/build'
[ 63%] Built target unittest_lfnindex
[ 63%] Linking CXX executable 
../../../bin/ceph_test_filestore_idempotent_sequence
cd /home/jenkins/workspace/ceph-master/build/src/test/objectstore && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/link.txt --verbose=1
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/test_idempotent_sequence.cc.o 
CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/DeterministicOpSequence.cc.o 
CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/TestObjectStoreState.cc.o 
CMakeFiles/ceph_test_filestore_idempotent_sequence.dir/FileStoreDiff.cc.o 
  -o ../../../bin/ceph_test_filestore_idempotent_sequence 
-L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss: 
../../../lib/libos.a ../../../lib/libglobal.a -lrt 
/usr/local/lib/libfuse.so ../../../lib/libkv.a 
/usr/local/lib/libleveldb.so ../../rocksdb/librocksdb.a 
/usr/local/lib/libsnappy.so -lz ../../../lib/libceph-common.so.0 
../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a 
../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
/usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
/usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lpthread gmake[2]: Leaving directory 
'/home/jenkins/workspace/ceph-master/build'
[ 63%] Built target ceph_test_filestore_idempotent_sequence
[ 63%] Linking CXX executable ../../../bin/unittest_mclock_client_queue
cd /home/jenkins/workspace/ceph-master/build/src/test/osd && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/unittest_mclock_client_queue.dir/link.txt --verbose=1
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/unittest_mclock_client_queue.dir/TestMClockClientQueue.cc.o 
-o ../../../bin/unittest_mclock_client_queue  -L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
../../../lib/libgmock_main.a ../../../lib/libgmock.a 
../../../lib/libgtest.a -lpthread ../../../lib/libglobal.a 
../../../lib/libosd.a ../../../lib/libdmclock.a ../../../lib/libos.a 
../../../lib/libceph-common.so.0 ../../../lib/libjson_spirit.a 
../../../lib/libcommon_utf8.a ../../../lib/liberasure_code.a 
/usr/local/lib/libboost_thread.so /usr/local/lib/libboost_chrono.so 
/usr/local/lib/libboost_atomic.so /usr/local/lib/libboost_random.so 
/usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lpthread -lrt /usr/local/lib/libfuse.so 
../../../lib/libkv.a /usr/local/lib/libleveldb.so 
../../rocksdb/librocksdb.a /usr/local/lib/libsnappy.so -lz [ 64%] 
Linking CXX executable ../../../bin/unittest_mclock_op_class_queue
cd /home/jenkins/workspace/ceph-master/build/src/test/osd && 
/usr/local/bin/cmake -E cmake_link_script 
CMakeFiles/unittest_mclock_op_class_queue.dir/link.txt --verbose=1
ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
-Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
-fsigned-char -Wno-unknown-pragmas -Wno-unused-function 
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator 
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register 
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor 
-Wno-unknown-pragmas -Wno-inconsistent-missing-override 
-Wno-mismatched-tags -Wno-unused-private-field 
-Wno-address-of-packed-member -fdiagnostics-color=auto  -O0 -g 
-DBEAST_NO_BOOST_STRING_VIEW  -Wl,--export-dynamic 
CMakeFiles/unittest_mclock_op_class_queue.dir/TestMClockOpClassQueue.cc.o 
  -o ../../../bin/unittest_mclock_op_class_queue  -L/usr/local/lib 
-Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
../../../lib/libgmock_main.a ../../../lib/libgmock.a 
../../../lib/libgtest.a -lpthread ../../../lib/libglobal.a 
../../../lib/libosd.a ../../../lib/libdmclock.a ../../../lib/libos.a 
../../../lib/libceph-common.so.0 ../../../lib/libjson_spirit.a 
../../../lib/libcommon_utf8.a ../../../lib/liberasure_code.a 
/usr/local/lib/libboost_thread.so /usr/local/lib/libboost_chrono.so 
/usr/local/lib/libboost_atomic.so /usr/local/lib/libboost_random.so 
/usr/local/lib/libboost_system.so 
/usr/local/lib/libboost_program_options.so 
/usr/local/lib/libboost_date_time.so 
/usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
-lexecinfo /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so 
/usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so 
/usr/local/lib/libplds4.so /usr/local/lib/libplc4.so 
/usr/local/lib/libnspr4.so -lpthread -lrt /usr/local/lib/libfuse.so 
../../../lib/libkv.a /usr/local/lib/libleveldb.so 
../../rocksdb/librocksdb.a /usr/local/lib/libsnappy.so -lz gmake[2]: 
Leaving directory '/home/jenkins/workspace/ceph-master/build'
[ 64%] Built target unittest_mclock_client_queue
gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
[ 64%] Built target unittest_mclock_op_class_queue
gmake[1]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
gmake: *** [Makefile:141: all] Error 2
Build step 'Execute shell' marked build as failure


