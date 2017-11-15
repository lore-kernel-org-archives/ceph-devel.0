From: Casey Bodley <cbodley@redhat.com>
Subject: Re: Fwd: Build failed in Jenkins: ceph-master #1445
Date: Wed, 15 Nov 2017 16:37:11 -0500
Message-ID: <82f00bd8-51d2-fd9f-1478-ff84ada4aa8c@redhat.com>
References: <1228960304.1.1510773466154.JavaMail.jenkins@cephdev.digiware.nl>
 <a5f41084-8dc3-7b61-bfed-5f5a5fe5ae63@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:55094 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759456AbdKOVhP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Nov 2017 16:37:15 -0500
Received: by mail-qt0-f178.google.com with SMTP id h42so15998107qtk.11
        for <ceph-devel@vger.kernel.org>; Wed, 15 Nov 2017 13:37:15 -0800 (PST)
In-Reply-To: <a5f41084-8dc3-7b61-bfed-5f5a5fe5ae63@digiware.nl>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

Sorry! See https://github.com/ceph/ceph/pull/18953

p.s. compiler explorer is a wonderful tool for debugging issues like this


On 11/15/2017 03:11 PM, Willem Jan Withagen wrote:
> Hi Casey,
>
> One more Clang compaint....
> Can you help me fix it?
>
> --WjW
>
> In file included from 
> /home/jenkins/workspace/ceph-master/src/test/common/test_bounded_key_counter.cc:14:
> /home/jenkins/workspace/ceph-master/src/common/bounded_key_counter.h:154:14: 
> error: no matching member function for call to 'assign'
>       sorted.assign(const_pointer_iterator{counters.cbegin()},
>       ~~~~~~~^~~~~~
> /home/jenkins/workspace/ceph-master/src/test/common/test_bounded_key_counter.cc:24:11: 
> note: in instantiation of function template specialization 
> 'BoundedKeyCounter<int, int>::get_highest<(lambda at 
> /home/jenkins/workspace/ceph-master/src/test/common/test_bounded_key_counter.cc:24:30)>' 
> requested here
>   counter.get_highest(count, [&callbacks] (const Key& key, Count count) {
>           ^
> /home/jenkins/workspace/ceph-master/src/test/common/test_bounded_key_counter.cc:66:17: 
> note: in instantiation of function template specialization '(anonymous 
> namespace)::count_highest<int, int>' requested here
>   EXPECT_EQ(0u, count_highest(counter, 10));
>                 ^
> /usr/include/c++/v1/vector:588:10: note: candidate function not 
> viable: no known conversion from 'BoundedKeyCounter<int, 
> int>::const_pointer_iterator' to 'std::__1::vector<const 
> std::__1::pair<const int, int> *, std::__1::allocator<const 
> std::__1::pair<const int, int> *> >::size_type' (aka 'unsigned long') 
> for 1st argument
>     void assign(size_type __n, const_reference __u);
>          ^
> /usr/include/c++/v1/vector:576:9: note: candidate template ignored: 
> requirement '!__is_forward_iterator<const_pointer_iterator>::value' 
> was not satisfied [with _InputIterator = BoundedKeyCounter<int, 
> int>::const_pointer_iterator]
>         assign(_InputIterator __first, _InputIterator __last);
>         ^
> /usr/include/c++/v1/vector:586:9: note: candidate template ignored: 
> requirement 'is_constructible<value_type, typename 
> iterator_traits<const_pointer_iterator>::reference>::value' was not 
> satisfied [with _ForwardIterator = BoundedKeyCounter<int, 
> int>::const_pointer_iterator]
>         assign(_ForwardIterator __first, _ForwardIterator __last);
>         ^
> /usr/include/c++/v1/vector:592:10: note: candidate function not 
> viable: requires single argument '__il', but 2 arguments were provided
>     void assign(initializer_list<value_type> __il)
>          ^
> In file included from 
> /home/jenkins/workspace/ceph-master/src/test/common/test_bounded_key_counter.cc:14:
> /home/jenkins/workspace/ceph-master/src/common/bounded_key_counter.h:154:14: 
> error: no matching member function for call to 'assign'
>       sorted.assign(const_pointer_iterator{counters.cbegin()},
>       ~~~~~~~^~~~~~
> /home/jenkins/workspace/ceph-master/src/test/common/test_bounded_key_counter.cc:36:11: 
> note: in instantiation of function template specialization 
> 'BoundedKeyCounter<int, int>::get_highest<(lambda at 
> /home/jenkins/workspace/ceph-master/src/test/common/test_bounded_key_counter.cc:36:30)>' 
> requested here
>   counter.get_highest(count, [&results] (const Key& key, Count count) {
>           ^
> /home/jenkins/workspace/ceph-master/src/test/common/test_bounded_key_counter.cc:111:30: 
> note: in instantiation of function template specialization '(anonymous 
> namespace)::get_highest<int, int, std::__1::vector<std::__1::pair<int, 
> int>, std::__1::allocator<std::__1::pair<int, int> > > >' requested here
>   EXPECT_EQ(Vector({{1,1}}), get_highest(counter, 10));
>                              ^
> /usr/include/c++/v1/vector:588:10: note: candidate function not 
> viable: no known conversion from 'BoundedKeyCounter<int, 
> int>::const_pointer_iterator' to 'std::__1::vector<const 
> std::__1::pair<const int, int> *, std::__1::allocator<const 
> std::__1::pair<const int, int> *> >::size_type' (aka 'unsigned long') 
> for 1st argument
>     void assign(size_type __n, const_reference __u);
>          ^
> /usr/include/c++/v1/vector:576:9: note: candidate template ignored: 
> requirement '!__is_forward_iterator<const_pointer_iterator>::value' 
> was not satisfied [with _InputIterator = BoundedKeyCounter<int, 
> int>::const_pointer_iterator]
>         assign(_InputIterator __first, _InputIterator __last);
>         ^
> /usr/include/c++/v1/vector:586:9: note: candidate template ignored: 
> requirement 'is_constructible<value_type, typename 
> iterator_traits<const_pointer_iterator>::reference>::value' was not 
> satisfied [with _ForwardIterator = BoundedKeyCounter<int, 
> int>::const_pointer_iterator]
>         assign(_ForwardIterator __first, _ForwardIterator __last);
>         ^
> /usr/include/c++/v1/vector:592:10: note: candidate function not 
> viable: requires single argument '__il', but 2 arguments were provided
>     void assign(initializer_list<value_type> __il)
>          ^
> 2 errors generated.
> gmake[2]: *** 
> [src/test/common/CMakeFiles/unittest_bounded_key_counter.dir/build.make:63: 
> src/test/common/CMakeFiles/unittest_bounded_key_counter.dir/test_bounded_key_counter.cc.o] 
> Error 1
>
>
>
> -------- Forwarded Message --------
> Subject: Build failed in Jenkins: ceph-master #1445
> Date: Wed, 15 Nov 2017 20:17:44 +0100 (CET)
> From: jenkins@digiware.nl
> Reply-To: jenkins@digiware.nl
> To: wjw@digiware.nl
>
> See 
> <http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/1445/display/redirect?page=changes>
>
> Changes:
>
> [owasserm] rgw: use tenant when updating the reshard log
>
> [owasserm] rgw: allow tenant without user id for reshard commands
>
> [cbodley] rgw: MetadataManager interface takes const string refs
>
> [cbodley] rgw: introduce RGWRadosNotifyCR for aio_notify
>
> [cbodley] rgw: add skeleton for BucketTrimManager
>
> [cbodley] common: introduce BoundedKeyCounter and unit test
>
> [cbodley] rgw: BucketTrimManager implements BucketChangeObserver
>
> [cbodley] rgw: add BucketTrimWatcher to serve watch/notify apis
>
> [cbodley] rgw: add TrimCounters api to BucketTrimWatcher
>
> [cbodley] rgw: add BucketTrimPollCR for interval and lease logic
>
> [cbodley] rgw: add BucketTrimCR to spawn trim for active buckets
>
> [cbodley] rgw: add MetadataListCR to loop over bucket instances
>
> [cbodley] rgw: add BucketTrimStatus
>
> [cbodley] rgw: collect cold buckets for trim
>
> [cbodley] rgw: BucketTrimManager implements BucketTrimObserver
>
> [cbodley] rgw: add configure_bucket_trim()
>
> [cbodley] rgw: add 'radosgw-admin bilog autotrim'
>
> [cbodley] rgw: add rgw_bucket_sync_status() to bypass manager
>
> [cbodley] rgw: add json decoders for bucket sync status
>
> [cbodley] rgw: add /admin/log rest api for bucket sync status
>
> [cbodley] rgw: add RGWBucketInfo overload for BucketShard::init
>
> [cbodley] rgw: add RGWRadosBILogTrimCR
>
> [cbodley] rgw: RGWGetBucketInstanceInfoCR takes rgw_bucket or metadata 
> key
>
> [cbodley] rgw: add HTTPManager to BucketTrimManager
>
> [cbodley] rgw: add BucketTrimInstanceCR
>
> [cbodley] rgw: start BucketTrimManager in RGWRados
>
> [cbodley] rgw: RGWDataSyncSingleEntryCR calls BucketChangeObserver
>
> [cbodley] rgw: add TrimComplete to watch/notify api
>
> [cbodley] test/rgw: add test_bucket_index_log_trim()
>
> [cbodley] qa/rgw: add kwargs for debug output
>
> [cbodley] rgw: move shard marker helper into BucketIndexShardsManager
>
> [cbodley] rgw: add comment for bucket in BucketCounter
>
> [cbodley] rgw: hold cr reference in MetadataListCR callback
>
> [cbodley] rgw: BucketTrimWatcher checks handle in stop
>
> [cbodley] rgw: curly brace style for bilog trim classes
>
> [cbodley] rgw: fix notify timeout for BucketTrimWatcher
>
> [cbodley] rgw: more documentation for bilog trim config
>
> [zhangbingyin] rgw.iam: change '1' to '1ULL' in function print_actions
>
> [yaozongyou] ceph-dencoder: adding support for cls_rgw_lc_obj_head
>
> [to.my.trociny] test/librbd: valgrind warning in
>
> [lvshanchun] rgw: add metadata sync related cmd into radosgw-admin 
> help info
>
> [lvshanchun] rgw: add data sync related cmd into radosgw-admin help info
>
> [jcollin] .githubmap: Add cbodley
>
> ------------------------------------------
> [...truncated 1.98 MB...]
> [ 57%] Linking CXX executable ../../../bin/ceph_test_cls_statelog
> cd /home/jenkins/workspace/ceph-master/build/src/test/cls_statelog && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/ceph_test_cls_statelog.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW 
> -Wl,--export-dynamic 
> CMakeFiles/ceph_test_cls_statelog.dir/test_cls_statelog.cc.o  -o 
> ../../../bin/ceph_test_cls_statelog  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/usr/local/lib/nss:/home/jenkins/workspace/ceph-master/build/lib 
> ../../../lib/libcls_statelog_client.a ../../../lib/libglobal.a 
> ../../../lib/libgmock_main.a ../../../lib/libgmock.a 
> ../../../lib/libgtest.a -lpthread /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lrt 
> ../../../lib/libradostest.a ../../../lib/librados.so.2.0.0 -lrt 
> ../../../lib/libceph-common.so.0 ../../../lib/liberasure_code.a 
> /usr/local/lib/libboost_thread.so /usr/local/lib/libboost_chrono.so 
> /usr/local/lib/libboost_atomic.so /usr/local/lib/libboost_random.so 
> /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo -lpthread /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so 
> ../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a Scanning 
> dependencies of target ceph_test_cls_version
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f 
> src/test/cls_version/CMakeFiles/ceph_test_cls_version.dir/build.make 
> src/test/cls_version/CMakeFiles/ceph_test_cls_version.dir/build
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> [ 57%] Building CXX object 
> src/test/cls_version/CMakeFiles/ceph_test_cls_version.dir/test_cls_version.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/cls_version && 
> ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -o 
> CMakeFiles/ceph_test_cls_version.dir/test_cls_version.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/test/cls_version/test_cls_version.cc
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 57%] Built target ceph_test_cls_statelog
> gmake -f src/test/cls_lua/CMakeFiles/ceph_test_cls_lua.dir/build.make 
> src/test/cls_lua/CMakeFiles/ceph_test_cls_lua.dir/depend
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/test/cls_lua 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/test/cls_lua 
> /home/jenkins/workspace/ceph-master/build/src/test/cls_lua/CMakeFiles/ceph_test_cls_lua.dir/DependInfo.cmake 
> --color=
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/cls_lua/CMakeFiles/ceph_test_cls_lua.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/cls_lua/CMakeFiles/ceph_test_cls_lua.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/cls_lua/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/cls_lua/CMakeFiles/ceph_test_cls_lua.dir/depend.internal".
> Scanning dependencies of target ceph_test_cls_lua
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f src/test/cls_lua/CMakeFiles/ceph_test_cls_lua.dir/build.make 
> src/test/cls_lua/CMakeFiles/ceph_test_cls_lua.dir/build
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> [ 57%] Building CXX object 
> src/test/cls_lua/CMakeFiles/ceph_test_cls_lua.dir/test_cls_lua.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/cls_lua && 
> ccache /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/lua/src 
> -I/home/jenkins/workspace/ceph-master/build/src/lua 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -o 
> CMakeFiles/ceph_test_cls_lua.dir/test_cls_lua.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/test/cls_lua/test_cls_lua.cc
> [ 57%] Linking CXX executable ../../../bin/ceph_test_cls_version
> cd /home/jenkins/workspace/ceph-master/build/src/test/cls_version && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/ceph_test_cls_version.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW 
> -Wl,--export-dynamic 
> CMakeFiles/ceph_test_cls_version.dir/test_cls_version.cc.o  -o 
> ../../../bin/ceph_test_cls_version  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/usr/local/lib/nss:/home/jenkins/workspace/ceph-master/build/lib 
> ../../../lib/libcls_version_client.a ../../../lib/libglobal.a 
> ../../../lib/libgmock_main.a ../../../lib/libgmock.a 
> ../../../lib/libgtest.a -lpthread /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lrt 
> ../../../lib/libradostest.a ../../../lib/librados.so.2.0.0 -lrt 
> ../../../lib/libceph-common.so.0 ../../../lib/liberasure_code.a 
> /usr/local/lib/libboost_thread.so /usr/local/lib/libboost_chrono.so 
> /usr/local/lib/libboost_atomic.so /usr/local/lib/libboost_random.so 
> /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo -lpthread /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so 
> ../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a [ 57%] 
> Linking CXX executable ../../../bin/ceph_test_cls_rgw
> cd /home/jenkins/workspace/ceph-master/build/src/test/cls_rgw && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/ceph_test_cls_rgw.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW 
> -Wl,--export-dynamic 
> CMakeFiles/ceph_test_cls_rgw.dir/test_cls_rgw.cc.o  -o 
> ../../../bin/ceph_test_cls_rgw  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss: 
> ../../../lib/libcls_rgw_client.a ../../../lib/libglobal.a 
> ../../../lib/libgmock_main.a ../../../lib/libgmock.a 
> ../../../lib/libgtest.a -lpthread -lrt ../../../lib/libradostest.a 
> ../../../lib/librados.so.2.0.0 -lrt ../../../lib/libceph-common.so.0 
> ../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
> /usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
> /usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lpthread 
> ../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a gmake[2]: 
> Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 57%] Built target ceph_test_cls_version
> gmake -f 
> src/test/common/CMakeFiles/unittest_bounded_key_counter.dir/build.make 
> src/test/common/CMakeFiles/unittest_bounded_key_counter.dir/depend
> gmake -f src/test/common/CMakeFiles/unittest_iso_8601.dir/build.make 
> src/test/common/CMakeFiles/unittest_iso_8601.dir/depend
> gmake -f 
> src/test/common/CMakeFiles/unittest_convenience.dir/build.make 
> src/test/common/CMakeFiles/unittest_convenience.dir/depend
> gmake -f src/test/common/CMakeFiles/unittest_hostname.dir/build.make 
> src/test/common/CMakeFiles/unittest_hostname.dir/depend
> gmake -f src/test/common/CMakeFiles/unittest_back_trace.dir/build.make 
> src/test/common/CMakeFiles/unittest_back_trace.dir/depend
> gmake -f 
> src/test/common/CMakeFiles/unittest_dns_resolve.dir/build.make 
> src/test/common/CMakeFiles/unittest_dns_resolve.dir/depend
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/test/common 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/test/common 
> /home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_convenience.dir/DependInfo.cmake 
> --color=
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/test/common 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/test/common 
> /home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_bounded_key_counter.dir/DependInfo.cmake 
> --color=
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/test/common 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/test/common 
> /home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_hostname.dir/DependInfo.cmake 
> --color=
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/test/common 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/test/common 
> /home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_back_trace.dir/DependInfo.cmake 
> --color=
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/test/common 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/test/common 
> /home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_iso_8601.dir/DependInfo.cmake 
> --color=
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/test/common 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/test/common 
> /home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_dns_resolve.dir/DependInfo.cmake 
> --color=
> [ 57%] Building CXX object 
> src/librbd/CMakeFiles/rbd_internal.dir/operation/SnapshotRollbackRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/librbd && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIC 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS -std=c++11 -o 
> CMakeFiles/rbd_internal.dir/operation/SnapshotRollbackRequest.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/librbd/operation/SnapshotRollbackRequest.cc
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_convenience.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_convenience.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_bounded_key_counter.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_bounded_key_counter.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_convenience.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_bounded_key_counter.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_hostname.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_hostname.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_hostname.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_iso_8601.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_iso_8601.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_iso_8601.dir/depend.internal".
> [ 57%] Building CXX object 
> src/librbd/CMakeFiles/rbd_internal.dir/operation/SnapshotUnprotectRequest.cc.o
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_back_trace.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_back_trace.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_back_trace.dir/depend.internal".
> cd /home/jenkins/workspace/ceph-master/build/src/librbd && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIC 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS -std=c++11 -o 
> CMakeFiles/rbd_internal.dir/operation/SnapshotUnprotectRequest.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/librbd/operation/SnapshotUnprotectRequest.cc
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_dns_resolve.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_dns_resolve.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_dns_resolve.dir/depend.internal".
> Scanning dependencies of target unittest_bounded_key_counter
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f 
> src/test/common/CMakeFiles/unittest_bounded_key_counter.dir/build.make 
> src/test/common/CMakeFiles/unittest_bounded_key_counter.dir/build
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> Scanning dependencies of target unittest_hostname
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f src/test/common/CMakeFiles/unittest_hostname.dir/build.make 
> src/test/common/CMakeFiles/unittest_hostname.dir/build
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> [ 57%] Building CXX object 
> src/test/common/CMakeFiles/unittest_bounded_key_counter.dir/test_bounded_key_counter.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/common && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -o 
> CMakeFiles/unittest_bounded_key_counter.dir/test_bounded_key_counter.cc.o 
> -c 
> /home/jenkins/workspace/ceph-master/src/test/common/test_bounded_key_counter.cc
> [ 57%] Built target ceph_test_cls_rgw
> [ 57%] Building CXX object 
> src/test/common/CMakeFiles/unittest_hostname.dir/test_hostname.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/common && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -o 
> CMakeFiles/unittest_hostname.dir/test_hostname.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/test/common/test_hostname.cc
> [ 57%] Building CXX object 
> src/librbd/CMakeFiles/rbd_internal.dir/operation/SnapshotLimitRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/librbd && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIC 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS -std=c++11 -o 
> CMakeFiles/rbd_internal.dir/operation/SnapshotLimitRequest.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/librbd/operation/SnapshotLimitRequest.cc 
>
> Scanning dependencies of target unittest_iso_8601
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f src/test/common/CMakeFiles/unittest_iso_8601.dir/build.make 
> src/test/common/CMakeFiles/unittest_iso_8601.dir/build
> gmake -f src/test/common/CMakeFiles/unittest_mutex.dir/build.make 
> src/test/common/CMakeFiles/unittest_mutex.dir/depend
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/test/common 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/test/common 
> /home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_mutex.dir/DependInfo.cmake 
> --color=
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_mutex.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_mutex.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_mutex.dir/depend.internal".
> [ 57%] Building CXX object 
> src/test/common/CMakeFiles/unittest_iso_8601.dir/test_iso_8601.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/common && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -o 
> CMakeFiles/unittest_iso_8601.dir/test_iso_8601.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/test/common/test_iso_8601.cc
> gmake -f 
> src/test/common/CMakeFiles/unittest_perf_histogram.dir/build.make 
> src/test/common/CMakeFiles/unittest_perf_histogram.dir/depend
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/test/common 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/test/common 
> /home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_perf_histogram.dir/DependInfo.cmake 
> --color=
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_perf_histogram.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_perf_histogram.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_perf_histogram.dir/depend.internal".
> Scanning dependencies of target unittest_convenience
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f 
> src/test/common/CMakeFiles/unittest_convenience.dir/build.make 
> src/test/common/CMakeFiles/unittest_convenience.dir/build
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> [ 57%] Building CXX object 
> src/test/common/CMakeFiles/unittest_convenience.dir/test_convenience.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/common && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -o 
> CMakeFiles/unittest_convenience.dir/test_convenience.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/test/common/test_convenience.cc
> Scanning dependencies of target unittest_back_trace
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f src/test/common/CMakeFiles/unittest_back_trace.dir/build.make 
> src/test/common/CMakeFiles/unittest_back_trace.dir/build
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> Scanning dependencies of target unittest_dns_resolve
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f 
> src/test/common/CMakeFiles/unittest_dns_resolve.dir/build.make 
> src/test/common/CMakeFiles/unittest_dns_resolve.dir/build
> [ 57%] Building CXX object 
> src/test/common/CMakeFiles/unittest_back_trace.dir/test_back_trace.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/common && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -fno-inline -o 
> CMakeFiles/unittest_back_trace.dir/test_back_trace.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/test/common/test_back_trace.cc
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> [ 57%] Building CXX object 
> src/test/common/CMakeFiles/unittest_dns_resolve.dir/dns_resolve.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/common && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -o 
> CMakeFiles/unittest_dns_resolve.dir/dns_resolve.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/test/common/dns_resolve.cc
> Scanning dependencies of target unittest_mutex
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f src/test/common/CMakeFiles/unittest_mutex.dir/build.make 
> src/test/common/CMakeFiles/unittest_mutex.dir/build
> Scanning dependencies of target unittest_perf_histogram
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f 
> src/test/common/CMakeFiles/unittest_perf_histogram.dir/build.make 
> src/test/common/CMakeFiles/unittest_perf_histogram.dir/build
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> [ 57%] Building CXX object 
> src/test/common/CMakeFiles/unittest_perf_histogram.dir/test_perf_histogram.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/common && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -o 
> CMakeFiles/unittest_perf_histogram.dir/test_perf_histogram.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/test/common/test_perf_histogram.cc 
>
> [ 57%] Building CXX object 
> src/test/common/CMakeFiles/unittest_mutex.dir/test_mutex.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/common && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -o 
> CMakeFiles/unittest_mutex.dir/test_mutex.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/test/common/test_mutex.cc
> gmake -f 
> src/test/common/CMakeFiles/unittest_shunique_lock.dir/build.make 
> src/test/common/CMakeFiles/unittest_shunique_lock.dir/depend
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> cd /home/jenkins/workspace/ceph-master/build && /usr/local/bin/cmake 
> -E cmake_depends "Unix Makefiles" /home/jenkins/workspace/ceph-master 
> /home/jenkins/workspace/ceph-master/src/test/common 
> /home/jenkins/workspace/ceph-master/build 
> /home/jenkins/workspace/ceph-master/build/src/test/common 
> /home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_shunique_lock.dir/DependInfo.cmake 
> --color=
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_shunique_lock.dir/DependInfo.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_shunique_lock.dir/depend.internal".
> Dependee 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/CMakeDirectoryInformation.cmake" 
> is newer than depender 
> "/home/jenkins/workspace/ceph-master/build/src/test/common/CMakeFiles/unittest_shunique_lock.dir/depend.internal".
> Scanning dependencies of target unittest_shunique_lock
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake -f 
> src/test/common/CMakeFiles/unittest_shunique_lock.dir/build.make 
> src/test/common/CMakeFiles/unittest_shunique_lock.dir/build
> gmake[2]: Entering directory '/home/jenkins/workspace/ceph-master/build'
> [ 57%] Building CXX object 
> src/test/common/CMakeFiles/unittest_shunique_lock.dir/test_shunique_lock.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/test/common && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIE 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googlemock/include 
> -I/home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -I/home/jenkins/workspace/ceph-master/build/src/googletest/googletest/include 
> -fno-strict-aliasing -std=c++11 -o 
> CMakeFiles/unittest_shunique_lock.dir/test_shunique_lock.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/test/common/test_shunique_lock.cc
> In file included from 
> /home/jenkins/workspace/ceph-master/src/test/common/test_bounded_key_counter.cc:14:
> /home/jenkins/workspace/ceph-master/src/common/bounded_key_counter.h:154:14: 
> error: no matching member function for call to 'assign'
>       sorted.assign(const_pointer_iterator{counters.cbegin()},
>       ~~~~~~~^~~~~~
> /home/jenkins/workspace/ceph-master/src/test/common/test_bounded_key_counter.cc:24:11: 
> note: in instantiation of function template specialization 
> 'BoundedKeyCounter<int, int>::get_highest<(lambda at 
> /home/jenkins/workspace/ceph-master/src/test/common/test_bounded_key_counter.cc:24:30)>' 
> requested here
>   counter.get_highest(count, [&callbacks] (const Key& key, Count count) {
>           ^
> /home/jenkins/workspace/ceph-master/src/test/common/test_bounded_key_counter.cc:66:17: 
> note: in instantiation of function template specialization '(anonymous 
> namespace)::count_highest<int, int>' requested here
>   EXPECT_EQ(0u, count_highest(counter, 10));
>                 ^
> /usr/include/c++/v1/vector:588:10: note: candidate function not 
> viable: no known conversion from 'BoundedKeyCounter<int, 
> int>::const_pointer_iterator' to 'std::__1::vector<const 
> std::__1::pair<const int, int> *, std::__1::allocator<const 
> std::__1::pair<const int, int> *> >::size_type' (aka 'unsigned long') 
> for 1st argument
>     void assign(size_type __n, const_reference __u);
>          ^
> /usr/include/c++/v1/vector:576:9: note: candidate template ignored: 
> requirement '!__is_forward_iterator<const_pointer_iterator>::value' 
> was not satisfied [with _InputIterator = BoundedKeyCounter<int, 
> int>::const_pointer_iterator]
>         assign(_InputIterator __first, _InputIterator __last);
>         ^
> /usr/include/c++/v1/vector:586:9: note: candidate template ignored: 
> requirement 'is_constructible<value_type, typename 
> iterator_traits<const_pointer_iterator>::reference>::value' was not 
> satisfied [with _ForwardIterator = BoundedKeyCounter<int, 
> int>::const_pointer_iterator]
>         assign(_ForwardIterator __first, _ForwardIterator __last);
>         ^
> /usr/include/c++/v1/vector:592:10: note: candidate function not 
> viable: requires single argument '__il', but 2 arguments were provided
>     void assign(initializer_list<value_type> __il)
>          ^
> In file included from 
> /home/jenkins/workspace/ceph-master/src/test/common/test_bounded_key_counter.cc:14:
> /home/jenkins/workspace/ceph-master/src/common/bounded_key_counter.h:154:14: 
> error: no matching member function for call to 'assign'
>       sorted.assign(const_pointer_iterator{counters.cbegin()},
>       ~~~~~~~^~~~~~
> /home/jenkins/workspace/ceph-master/src/test/common/test_bounded_key_counter.cc:36:11: 
> note: in instantiation of function template specialization 
> 'BoundedKeyCounter<int, int>::get_highest<(lambda at 
> /home/jenkins/workspace/ceph-master/src/test/common/test_bounded_key_counter.cc:36:30)>' 
> requested here
>   counter.get_highest(count, [&results] (const Key& key, Count count) {
>           ^
> /home/jenkins/workspace/ceph-master/src/test/common/test_bounded_key_counter.cc:111:30: 
> note: in instantiation of function template specialization '(anonymous 
> namespace)::get_highest<int, int, std::__1::vector<std::__1::pair<int, 
> int>, std::__1::allocator<std::__1::pair<int, int> > > >' requested here
>   EXPECT_EQ(Vector({{1,1}}), get_highest(counter, 10));
>                              ^
> /usr/include/c++/v1/vector:588:10: note: candidate function not 
> viable: no known conversion from 'BoundedKeyCounter<int, 
> int>::const_pointer_iterator' to 'std::__1::vector<const 
> std::__1::pair<const int, int> *, std::__1::allocator<const 
> std::__1::pair<const int, int> *> >::size_type' (aka 'unsigned long') 
> for 1st argument
>     void assign(size_type __n, const_reference __u);
>          ^
> /usr/include/c++/v1/vector:576:9: note: candidate template ignored: 
> requirement '!__is_forward_iterator<const_pointer_iterator>::value' 
> was not satisfied [with _InputIterator = BoundedKeyCounter<int, 
> int>::const_pointer_iterator]
>         assign(_InputIterator __first, _InputIterator __last);
>         ^
> /usr/include/c++/v1/vector:586:9: note: candidate template ignored: 
> requirement 'is_constructible<value_type, typename 
> iterator_traits<const_pointer_iterator>::reference>::value' was not 
> satisfied [with _ForwardIterator = BoundedKeyCounter<int, 
> int>::const_pointer_iterator]
>         assign(_ForwardIterator __first, _ForwardIterator __last);
>         ^
> /usr/include/c++/v1/vector:592:10: note: candidate function not 
> viable: requires single argument '__il', but 2 arguments were provided
>     void assign(initializer_list<value_type> __il)
>          ^
> 2 errors generated.
> gmake[2]: *** 
> [src/test/common/CMakeFiles/unittest_bounded_key_counter.dir/build.make:63: 
> src/test/common/CMakeFiles/unittest_bounded_key_counter.dir/test_bounded_key_counter.cc.o] 
> Error 1
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake[1]: *** [CMakeFiles/Makefile2:9674: 
> src/test/common/CMakeFiles/unittest_bounded_key_counter.dir/all] Error 2
> gmake[1]: *** Waiting for unfinished jobs....
> [ 57%] Building CXX object 
> src/librbd/CMakeFiles/rbd_internal.dir/operation/TrimRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/librbd && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIC 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS -std=c++11 -o 
> CMakeFiles/rbd_internal.dir/operation/TrimRequest.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/librbd/operation/TrimRequest.cc
> [ 57%] Linking CXX executable ../../../bin/ceph_test_cls_lua
> cd /home/jenkins/workspace/ceph-master/build/src/test/cls_lua && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/ceph_test_cls_lua.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW 
> -Wl,--export-dynamic 
> CMakeFiles/ceph_test_cls_lua.dir/test_cls_lua.cc.o  -o 
> ../../../bin/ceph_test_cls_lua  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss: 
> ../../../lib/libcls_lua_client.a ../../../lib/liblua.a 
> ../../../lib/libglobal.a ../../../lib/libgmock_main.a 
> ../../../lib/libgmock.a ../../../lib/libgtest.a -lpthread -lrt 
> ../../../lib/libradostest.a -lm ../../../lib/librados.so.2.0.0 -lrt 
> ../../../lib/libceph-common.so.0 ../../../lib/liberasure_code.a 
> /usr/local/lib/libboost_thread.so /usr/local/lib/libboost_chrono.so 
> /usr/local/lib/libboost_atomic.so /usr/local/lib/libboost_random.so 
> /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lpthread 
> ../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a gmake[2]: 
> Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 57%] Built target ceph_test_cls_lua
> [ 57%] Linking CXX executable ../../../bin/unittest_hostname
> cd /home/jenkins/workspace/ceph-master/build/src/test/common && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/unittest_hostname.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW 
> -Wl,--export-dynamic 
> CMakeFiles/unittest_hostname.dir/test_hostname.cc.o  -o 
> ../../../bin/unittest_hostname  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
> ../../../lib/libceph-common.so.0 ../../../lib/libgmock_main.a 
> ../../../lib/libgmock.a ../../../lib/libgtest.a -lpthread 
> ../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a 
> ../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
> /usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
> /usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lpthread [ 57%] 
> Building CXX object 
> src/librbd/CMakeFiles/rbd_internal.dir/watcher/Notifier.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/librbd && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIC 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS -std=c++11 -o 
> CMakeFiles/rbd_internal.dir/watcher/Notifier.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/librbd/watcher/Notifier.cc
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 57%] Built target unittest_hostname
> [ 57%] Building CXX object 
> src/librbd/CMakeFiles/rbd_internal.dir/watcher/RewatchRequest.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/librbd && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIC 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS -std=c++11 -o 
> CMakeFiles/rbd_internal.dir/watcher/RewatchRequest.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/librbd/watcher/RewatchRequest.cc
> [ 57%] Linking CXX executable ../../../bin/unittest_convenience
> cd /home/jenkins/workspace/ceph-master/build/src/test/common && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/unittest_convenience.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW 
> -Wl,--export-dynamic 
> CMakeFiles/unittest_convenience.dir/test_convenience.cc.o  -o 
> ../../../bin/unittest_convenience  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
> ../../../lib/libceph-common.so.0 ../../../lib/libgmock_main.a 
> ../../../lib/libgmock.a ../../../lib/libgtest.a -lpthread 
> ../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a 
> ../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
> /usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
> /usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lpthread 
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 57%] Linking CXX executable ../../../bin/unittest_iso_8601
> [ 57%] Built target unittest_convenience
> cd /home/jenkins/workspace/ceph-master/build/src/test/common && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/unittest_iso_8601.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW 
> -Wl,--export-dynamic 
> CMakeFiles/unittest_iso_8601.dir/test_iso_8601.cc.o  -o 
> ../../../bin/unittest_iso_8601  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
> ../../../lib/libceph-common.so.0 ../../../lib/libgmock_main.a 
> ../../../lib/libgmock.a ../../../lib/libgtest.a -lpthread 
> ../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a 
> ../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
> /usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
> /usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lpthread [ 57%] 
> Building CXX object 
> src/librbd/CMakeFiles/rbd_internal.dir/__/common/ContextCompletion.cc.o
> cd /home/jenkins/workspace/ceph-master/build/src/librbd && ccache 
> /usr/bin/c++  -DCEPH_LIBDIR=\"/usr/local/lib\" 
> -DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\" -D_FILE_OFFSET_BITS=64 
> -I/home/jenkins/workspace/ceph-master/build/src/include 
> -I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include 
> -isystem /home/jenkins/workspace/ceph-master/build/include -isystem 
> /home/jenkins/workspace/ceph-master/src/xxHash -isystem 
> /home/jenkins/workspace/ceph-master/src/rapidjson/include 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/src 
> -I/home/jenkins/workspace/ceph-master/src/dmclock/support/src -isystem 
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/include 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char 
> -Wno-unknown-pragmas -Wno-unused-function -Wno-unused-local-typedef 
> -Wno-varargs -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW -fPIC 
> -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE 
> -D__STDC_FORMAT_MACROS -std=c++11 -o 
> CMakeFiles/rbd_internal.dir/__/common/ContextCompletion.cc.o -c 
> /home/jenkins/workspace/ceph-master/src/common/ContextCompletion.cc
> [ 57%] Linking CXX executable ../../../bin/unittest_perf_histogram
> cd /home/jenkins/workspace/ceph-master/build/src/test/common && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/unittest_perf_histogram.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW 
> -Wl,--export-dynamic 
> CMakeFiles/unittest_perf_histogram.dir/test_perf_histogram.cc.o -o 
> ../../../bin/unittest_perf_histogram  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
> ../../../lib/libgmock_main.a ../../../lib/libgmock.a 
> ../../../lib/libgtest.a -lpthread ../../../lib/libceph-common.so.0 
> ../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a 
> ../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
> /usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
> /usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lpthread 
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 57%] Built target unittest_iso_8601
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 57%] Built target unittest_perf_histogram
> [ 57%] Linking CXX executable ../../../bin/unittest_mutex
> cd /home/jenkins/workspace/ceph-master/build/src/test/common && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/unittest_mutex.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW 
> -Wl,--export-dynamic CMakeFiles/unittest_mutex.dir/test_mutex.cc.o  -o 
> ../../../bin/unittest_mutex  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
> ../../../lib/libgmock_main.a ../../../lib/libgmock.a 
> ../../../lib/libgtest.a -lpthread ../../../lib/libceph-common.so.0 
> ../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a 
> ../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
> /usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
> /usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lpthread 
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 57%] Built target unittest_mutex
> [ 58%] Linking CXX executable ../../../bin/unittest_back_trace
> cd /home/jenkins/workspace/ceph-master/build/src/test/common && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/unittest_back_trace.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW 
> -Wl,--export-dynamic 
> CMakeFiles/unittest_back_trace.dir/test_back_trace.cc.o  -o 
> ../../../bin/unittest_back_trace  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
> ../../../lib/libceph-common.so.0 ../../../lib/libgmock_main.a 
> ../../../lib/libgmock.a ../../../lib/libgtest.a -lpthread 
> ../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a 
> ../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
> /usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
> /usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lpthread 
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 58%] Built target unittest_back_trace
> [ 59%] Linking CXX executable ../../../bin/unittest_shunique_lock
> cd /home/jenkins/workspace/ceph-master/build/src/test/common && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/unittest_shunique_lock.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW 
> -Wl,--export-dynamic 
> CMakeFiles/unittest_shunique_lock.dir/test_shunique_lock.cc.o  -o 
> ../../../bin/unittest_shunique_lock  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
> ../../../lib/libgmock_main.a ../../../lib/libgmock.a 
> ../../../lib/libgtest.a -lpthread ../../../lib/libceph-common.so.0 
> ../../../lib/libjson_spirit.a ../../../lib/libcommon_utf8.a 
> ../../../lib/liberasure_code.a /usr/local/lib/libboost_thread.so 
> /usr/local/lib/libboost_chrono.so /usr/local/lib/libboost_atomic.so 
> /usr/local/lib/libboost_random.so /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lpthread 
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 59%] Built target unittest_shunique_lock
> [ 59%] Linking CXX executable ../../../bin/unittest_dns_resolve
> cd /home/jenkins/workspace/ceph-master/build/src/test/common && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/unittest_dns_resolve.dir/link.txt --verbose=1
> ccache /usr/bin/c++   -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security 
> -fno-strict-aliasing -fsigned-char -Wno-unknown-pragmas 
> -Wno-unused-function -Wno-unused-local-typedef -Wno-varargs 
> -Wno-gnu-designator -Wno-missing-braces -Wno-parentheses 
> -Wno-deprecated-register -ftemplate-depth-1024 -Wno-invalid-offsetof 
> -Wnon-virtual-dtor -Wno-unknown-pragmas 
> -Wno-inconsistent-missing-override -Wno-mismatched-tags 
> -Wno-unused-private-field -Wno-address-of-packed-member 
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss 
> -I/usr/local/include/nspr  -O0 -g -DBEAST_NO_BOOST_STRING_VIEW 
> -Wl,--export-dynamic 
> CMakeFiles/unittest_dns_resolve.dir/dns_resolve.cc.o 
> ../CMakeFiles/unit-main.dir/unit.cc.o  -o 
> ../../../bin/unittest_dns_resolve  -L/usr/local/lib 
> -Wl,-rpath,/usr/local/lib:/home/jenkins/workspace/ceph-master/build/lib:/usr/local/lib/nss 
> ../../../lib/libglobal.a ../../../lib/libgmock_main.a 
> ../../../lib/libgmock.a ../../../lib/libgtest.a -lpthread 
> ../../../lib/libceph-common.so.0 ../../../lib/libjson_spirit.a 
> ../../../lib/libcommon_utf8.a ../../../lib/liberasure_code.a 
> /usr/local/lib/libboost_thread.so /usr/local/lib/libboost_chrono.so 
> /usr/local/lib/libboost_atomic.so /usr/local/lib/libboost_random.so 
> /usr/local/lib/libboost_system.so 
> /usr/local/lib/libboost_program_options.so 
> /usr/local/lib/libboost_date_time.so 
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_regex.so 
> -lexecinfo /usr/local/lib/nss/libssl3.so 
> /usr/local/lib/nss/libsmime3.so /usr/local/lib/nss/libnss3.so 
> /usr/local/lib/nss/libnssutil3.so /usr/local/lib/libplds4.so 
> /usr/local/lib/libplc4.so /usr/local/lib/libnspr4.so -lrt -lpthread 
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 59%] Built target unittest_dns_resolve
> [ 59%] Linking CXX static library ../../lib/librbd_internal.a
> cd /home/jenkins/workspace/ceph-master/build/src/librbd && 
> /usr/local/bin/cmake -P 
> CMakeFiles/rbd_internal.dir/cmake_clean_target.cmake
> cd /home/jenkins/workspace/ceph-master/build/src/librbd && 
> /usr/local/bin/cmake -E cmake_link_script 
> CMakeFiles/rbd_internal.dir/link.txt --verbose=1
> ccache /usr/bin/ar qc ../../lib/librbd_internal.a 
> CMakeFiles/rbd_internal.dir/AsyncObjectThrottle.cc.o 
> CMakeFiles/rbd_internal.dir/AsyncRequest.cc.o 
> CMakeFiles/rbd_internal.dir/DeepCopyRequest.cc.o 
> CMakeFiles/rbd_internal.dir/ExclusiveLock.cc.o 
> CMakeFiles/rbd_internal.dir/ImageCtx.cc.o 
> CMakeFiles/rbd_internal.dir/ImageState.cc.o 
> CMakeFiles/rbd_internal.dir/ImageWatcher.cc.o 
> CMakeFiles/rbd_internal.dir/internal.cc.o 
> CMakeFiles/rbd_internal.dir/Journal.cc.o 
> CMakeFiles/rbd_internal.dir/LibrbdAdminSocketHook.cc.o 
> CMakeFiles/rbd_internal.dir/LibrbdWriteback.cc.o 
> CMakeFiles/rbd_internal.dir/ManagedLock.cc.o 
> CMakeFiles/rbd_internal.dir/MirroringWatcher.cc.o 
> CMakeFiles/rbd_internal.dir/ObjectMap.cc.o 
> CMakeFiles/rbd_internal.dir/Operations.cc.o 
> CMakeFiles/rbd_internal.dir/Utils.cc.o 
> CMakeFiles/rbd_internal.dir/Watcher.cc.o 
> CMakeFiles/rbd_internal.dir/api/DiffIterate.cc.o 
> CMakeFiles/rbd_internal.dir/api/Group.cc.o 
> CMakeFiles/rbd_internal.dir/api/Image.cc.o 
> CMakeFiles/rbd_internal.dir/api/Mirror.cc.o 
> CMakeFiles/rbd_internal.dir/cache/ImageWriteback.cc.o 
> CMakeFiles/rbd_internal.dir/cache/PassthroughImageCache.cc.o 
> CMakeFiles/rbd_internal.dir/deep_copy/ImageCopyRequest.cc.o 
> CMakeFiles/rbd_internal.dir/deep_copy/MetadataCopyRequest.cc.o 
> CMakeFiles/rbd_internal.dir/deep_copy/ObjectCopyRequest.cc.o 
> CMakeFiles/rbd_internal.dir/deep_copy/SetHeadRequest.cc.o 
> CMakeFiles/rbd_internal.dir/deep_copy/SnapshotCopyRequest.cc.o 
> CMakeFiles/rbd_internal.dir/deep_copy/SnapshotCreateRequest.cc.o 
> CMakeFiles/rbd_internal.dir/deep_copy/Utils.cc.o 
> CMakeFiles/rbd_internal.dir/exclusive_lock/AutomaticPolicy.cc.o 
> CMakeFiles/rbd_internal.dir/exclusive_lock/PreAcquireRequest.cc.o 
> CMakeFiles/rbd_internal.dir/exclusive_lock/PostAcquireRequest.cc.o 
> CMakeFiles/rbd_internal.dir/exclusive_lock/PreReleaseRequest.cc.o 
> CMakeFiles/rbd_internal.dir/exclusive_lock/StandardPolicy.cc.o 
> CMakeFiles/rbd_internal.dir/image/CloneRequest.cc.o 
> CMakeFiles/rbd_internal.dir/image/CloseRequest.cc.o 
> CMakeFiles/rbd_internal.dir/image/CreateRequest.cc.o 
> CMakeFiles/rbd_internal.dir/image/OpenRequest.cc.o 
> CMakeFiles/rbd_internal.dir/image/RefreshParentRequest.cc.o 
> CMakeFiles/rbd_internal.dir/image/RefreshRequest.cc.o 
> CMakeFiles/rbd_internal.dir/image/RemoveRequest.cc.o 
> CMakeFiles/rbd_internal.dir/image/SetFlagsRequest.cc.o 
> CMakeFiles/rbd_internal.dir/image/SetSnapRequest.cc.o 
> CMakeFiles/rbd_internal.dir/image_watcher/NotifyLockOwner.cc.o 
> CMakeFiles/rbd_internal.dir/io/AioCompletion.cc.o 
> CMakeFiles/rbd_internal.dir/io/AsyncOperation.cc.o 
> CMakeFiles/rbd_internal.dir/io/CopyupRequest.cc.o 
> CMakeFiles/rbd_internal.dir/io/ImageRequest.cc.o 
> CMakeFiles/rbd_internal.dir/io/ImageRequestWQ.cc.o 
> CMakeFiles/rbd_internal.dir/io/ObjectRequest.cc.o 
> CMakeFiles/rbd_internal.dir/io/ReadResult.cc.o 
> CMakeFiles/rbd_internal.dir/journal/CreateRequest.cc.o 
> CMakeFiles/rbd_internal.dir/journal/DemoteRequest.cc.o 
> CMakeFiles/rbd_internal.dir/journal/OpenRequest.cc.o 
> CMakeFiles/rbd_internal.dir/journal/PromoteRequest.cc.o 
> CMakeFiles/rbd_internal.dir/journal/RemoveRequest.cc.o 
> CMakeFiles/rbd_internal.dir/journal/Replay.cc.o 
> CMakeFiles/rbd_internal.dir/journal/StandardPolicy.cc.o 
> CMakeFiles/rbd_internal.dir/journal/Utils.cc.o 
> CMakeFiles/rbd_internal.dir/managed_lock/AcquireRequest.cc.o 
> CMakeFiles/rbd_internal.dir/managed_lock/BreakRequest.cc.o 
> CMakeFiles/rbd_internal.dir/managed_lock/GetLockerRequest.cc.o 
> CMakeFiles/rbd_internal.dir/managed_lock/ReacquireRequest.cc.o 
> CMakeFiles/rbd_internal.dir/managed_lock/ReleaseRequest.cc.o 
> CMakeFiles/rbd_internal.dir/managed_lock/Utils.cc.o 
> CMakeFiles/rbd_internal.dir/mirror/DemoteRequest.cc.o 
> CMakeFiles/rbd_internal.dir/mirror/DisableRequest.cc.o 
> CMakeFiles/rbd_internal.dir/mirror/EnableRequest.cc.o 
> CMakeFiles/rbd_internal.dir/mirror/GetInfoRequest.cc.o 
> CMakeFiles/rbd_internal.dir/mirror/GetStatusRequest.cc.o 
> CMakeFiles/rbd_internal.dir/mirror/PromoteRequest.cc.o 
> CMakeFiles/rbd_internal.dir/object_map/CreateRequest.cc.o 
> CMakeFiles/rbd_internal.dir/object_map/InvalidateRequest.cc.o 
> CMakeFiles/rbd_internal.dir/object_map/LockRequest.cc.o 
> CMakeFiles/rbd_internal.dir/object_map/RefreshRequest.cc.o 
> CMakeFiles/rbd_internal.dir/object_map/RemoveRequest.cc.o 
> CMakeFiles/rbd_internal.dir/object_map/Request.cc.o 
> CMakeFiles/rbd_internal.dir/object_map/ResizeRequest.cc.o 
> CMakeFiles/rbd_internal.dir/object_map/SnapshotCreateRequest.cc.o 
> CMakeFiles/rbd_internal.dir/object_map/SnapshotRemoveRequest.cc.o 
> CMakeFiles/rbd_internal.dir/object_map/SnapshotRollbackRequest.cc.o 
> CMakeFiles/rbd_internal.dir/object_map/UnlockRequest.cc.o 
> CMakeFiles/rbd_internal.dir/object_map/UpdateRequest.cc.o 
> CMakeFiles/rbd_internal.dir/operation/DisableFeaturesRequest.cc.o 
> CMakeFiles/rbd_internal.dir/operation/EnableFeaturesRequest.cc.o 
> CMakeFiles/rbd_internal.dir/operation/FlattenRequest.cc.o 
> CMakeFiles/rbd_internal.dir/operation/MetadataRemoveRequest.cc.o 
> CMakeFiles/rbd_internal.dir/operation/MetadataSetRequest.cc.o 
> CMakeFiles/rbd_internal.dir/operation/ObjectMapIterate.cc.o 
> CMakeFiles/rbd_internal.dir/operation/RebuildObjectMapRequest.cc.o 
> CMakeFiles/rbd_internal.dir/operation/RenameRequest.cc.o 
> CMakeFiles/rbd_internal.dir/operation/Request.cc.o 
> CMakeFiles/rbd_internal.dir/operation/ResizeRequest.cc.o 
> CMakeFiles/rbd_internal.dir/operation/SnapshotCreateRequest.cc.o 
> CMakeFiles/rbd_internal.dir/operation/SnapshotProtectRequest.cc.o 
> CMakeFiles/rbd_internal.dir/operation/SnapshotRemoveRequest.cc.o 
> CMakeFiles/rbd_internal.dir/operation/SnapshotRenameRequest.cc.o 
> CMakeFiles/rbd_internal.dir/operation/SnapshotRollbackRequest.cc.o 
> CMakeFiles/rbd_internal.dir/operation/SnapshotUnprotectRequest.cc.o 
> CMakeFiles/rbd_internal.dir/operation/SnapshotLimitRequest.cc.o 
> CMakeFiles/rbd_internal.dir/operation/TrimRequest.cc.o 
> CMakeFiles/rbd_internal.dir/watcher/Notifier.cc.o 
> CMakeFiles/rbd_internal.dir/watcher/RewatchRequest.cc.o 
> CMakeFiles/rbd_internal.dir/__/common/ContextCompletion.cc.o 
> ../CMakeFiles/rados_snap_set_diff_obj.dir/librados/snap_set_diff.cc.o
> ccache /usr/bin/ranlib ../../lib/librbd_internal.a
> gmake[2]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> [ 59%] Built target rbd_internal
> gmake[1]: Leaving directory '/home/jenkins/workspace/ceph-master/build'
> gmake: *** [Makefile:141: all] Error 2
> Build step 'Execute shell' marked build as failure
>
>

