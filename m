From: Matt Benjamin <mbenjamin@redhat.com>
Subject: clang builds failing for me (cmake)--rocksdb and (I had forgotten)
 also leveldb
Date: Thu, 21 Jan 2016 11:27:42 -0500 (EST)
Message-ID: <1307627579.21914617.1453393662272.JavaMail.zimbra@redhat.com>
References: <1364796719.21886735.1453391951145.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:53849 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759312AbcAUQ1m convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jan 2016 11:27:42 -0500
In-Reply-To: <1364796719.21886735.1453391951145.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Ali Maredia <amaredia@redhat.com>

Hi CMake/C++ Devs,

Ok, so I tried to build w/clang 3.9 yesterday, and ran into problems linking (on master) rocksdb and leveldb and (on older rgw branch), still have problems with leveldb.

Marcus and I pored over it a bit.  What I think I see as the immediate problem is:

[ 42%] Linking CXX executable ceph-dencoder
cd /home/mbenjamin/dev/rgw/ceph/build/src && /usr/bin/cmake -E cmake_link_script CMakeFiles/ceph-dencoder.dir/link.txt --verbose=1
/opt/clang/bin/clang++   -O0 -g3 -gdwarf-4 -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing -fsigned-char -fPIC -ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor -Wno-invalid-offsetof  -Woverloaded-virtual -std=c++11 -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc -fno-builtin-free   CMakeFiles/ceph-dencoder.dir/test/encoding/ceph_dencoder.cc.o CMakeFiles/ceph-dencoder.dir/krbd.cc.o CMakeFiles/ceph-dencoder.dir/common/secret.c.o CMakeFiles/ceph-dencoder.dir/common/TextTable.cc.o CMakeFiles/ceph-dencoder.dir/rgw/rgw_dencoder.cc.o CMakeFiles/ceph-dencoder.dir/rgw/rgw_acl.cc.o CMakeFiles/ceph-dencoder.dir/rgw/rgw_common.cc.o CMakeFiles/ceph-dencoder.dir/rgw/rgw_env.cc.o CMakeFiles/ceph-dencoder.dir/rgw/
 rgw_json_enc.cc.o CMakeFiles/heap_profiler_objs.dir/perfglue/heap_profiler.cc.o  -o ceph-dencoder -rdynamic librbd.so.1.0.0 libceph-global.a libosd.a libmds.a libmon.a libosdc.a cls/libcls_lock_client.a cls/libcls_refcount_client.a cls/libcls_log_client.a cls/libcls_statelog_client.a cls/libcls_version_client.a cls/libcls_replica_log_client.a libcls_kvs.so.1.0.0 cls/libcls_user_client.a librgw_a.a cls/libcls_rgw_client.a -lcurl -lexpat -lfcgi -lresolv -lblkid -ludev -lkeyutils -latomic_ops -luuid -lrt -ldl -lprofiler -ltcmalloc -ldl librados.so.2.0.0 libcommon.a json_spirit/libjson_spirit.a libcommon_utf8.a erasure-code/liberasure_code.a -lboost_thread -lboost_system -lboost_regex -lpthread -lcryptopp -lleveldb -latomic_ops -luuid -lrt -lprofiler -ldl -Wl,-rpath,/home/mbenjamin/dev/rgw/c
 eph/build/src 
librados.so.2.0.0: undefined reference to `leveldb::Status::ToString() const'
clang-3.9: error: linker command failed with exit code 1 (use -v to see invocation)
src/CMakeFiles/ceph-dencoder.dir/build.make:330: recipe for target 'src/ceph-dencoder' failed

This is the leveldb version.  There's something similar with rocksdb.  In this case, I've verified that librados.so was linked dynamically with libleveldb, and we've even added it to the ceph-dencoder link line, redundantly.

I'm guessing that this is just a straight-up C++ ABI issue preventing us from mixing g++- and clang++-compiled versions of leveldb and it's friend rocksdb, since these libraries have C++ mangled names in the interface:

[mbenjamin@lemon build]$ nm -D /usr/lib64/libleveldb.so | grep Status::To
[mbenjamin@lemon build]$ nm -D /usr/lib64/libleveldb.so | grep ToString
000000000004aea0 T _ZN7leveldb14NumberToStringB5cxx11Em
00000000000466d0 T _ZN7leveldb16ReadFileToStringEPNS_3EnvERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEPS7_
000000000004b1f0 T _ZNK7leveldb6Status8ToStringB5cxx11Ev
000000000004a860 T _ZNK7leveldb9Histogram8ToStringB5cxx11Ev

Am I correct that we can't actually rely on this?

Marcus noted, the issues with rocksdb currently a bit more broad.  One, we are building it in-tree.  Two, we are building a static library, and seemingly not linking it in every shared library where it is used (that is easy to fix, of course).

Matt

-- 
-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
