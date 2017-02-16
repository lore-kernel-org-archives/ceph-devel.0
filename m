From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Clang on FreeBSD jenkins unhappy
Date: Thu, 16 Feb 2017 17:06:18 +0100
Message-ID: <4817fe9a-8831-4986-59ec-ed2c334271d1@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:43334 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751930AbdBTAkf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 19 Feb 2017 19:40:35 -0500
Received: from [192.168.101.50] (vpn.ecoracks.nl [176.74.240.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id F26F9375FD
        for <ceph-devel@vger.kernel.org>; Thu, 16 Feb 2017 17:06:23 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

My FreeBSD jenkins build complains on 2 things I think.

Below part of the error output.

1) A typing problem, could be likely in bluestore includes.

2) Some bluestore code is unconditionally included into ceph_test_rados
code. And FreeBSD does not do Bluestore yet, because of AIO
incompatabilities.

Appriciated if somebody could have a look at it.

Thanx
--WjW


[ 75%] Building CXX object
src/test/osd/CMakeFiles/ceph_test_rados.dir/TestRados.cc.o
cd /home/jenkins/workspace/ceph-master/build/src/test/osd && ccache
/usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\"
-I/home/jenkins/workspace/ceph-master/build/src/include
-I/home/jenkins/workspace/ceph-master/src -isystem /usr/local/include
-isystem /home/jenkins/workspace/ceph-master/build/include
-I/home/jenkins/workspace/ceph-master/src/xxHash  -Wall -Wtype-limits
-Wignored-qualifiers -Winit-self -Wpointer-arith -Werror=format-security
-fno-strict-aliasing -fsigned-char -Wno-unused-function
-Wno-unused-local-typedef -Wno-varargs -Wno-gnu-designator
-Wno-missing-braces -Wno-parentheses -Wno-deprecated-register
-ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor
-Wno-inconsistent-missing-override -Wno-mismatched-tags
-Wno-unused-private-field -fdiagnostics-color=auto
-I/usr/local/include/nss/nss -I/usr/local/include/nspr
-fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
-fno-builtin-free -Wno-null-dereference -Wno-expansion-to-defined -O0 -g
-fPIE   -DHAVE_CONFIG_H -D__CEPH__ -D_REENTRANT -D_THREAD_SAFE
-D__STDC_FORMAT_MACROS -std=c++11 -o
CMakeFiles/ceph_test_rados.dir/TestRados.cc.o -c
/home/jenkins/workspace/ceph-master/src/test/osd/TestRados.cc
In file included from
/home/jenkins/workspace/ceph-master/src/test/objectstore/store_test.cc:21:
In file included from
/home/jenkins/workspace/ceph-master/src/os/ObjectStore.h:17:
In file included from
/home/jenkins/workspace/ceph-master/src/include/Context.h:19:
In file included from
/home/jenkins/workspace/ceph-master/src/common/dout.h:20:
In file included from
/home/jenkins/workspace/ceph-master/src/common/config.h:21:
/usr/include/c++/v1/map:820:5: error: static_assert failed
"Allocator::value_type must be same type as value_type"
    static_assert((is_same<typename allocator_type::value_type,
value_type>::value),
    ^
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/jenkins/workspace/ceph-master/src/os/bluestore/bluestore_types.h:204:9:
note: in instantiation of template class 'std::__1::map<unsigned long,
bluestore_extent_ref_map_t::record_t, std::__1::less<unsigned long>,
mempool::pool_allocator<mempool::pool_index_t::mempool_bluestore_meta_other,
std::__1::pair<unsigned long, bluestore_extent_ref_map_t::record_t> > >'
requested here
  map_t ref_map;
        ^
/home/jenkins/workspace/ceph-master/src/os/bluestore/bluestore_types.h:207:26:
error: no type named 'iterator' in 'std::__1::map<unsigned long,
bluestore_extent_ref_map_t::record_t, std::__1::less<unsigned long>,
mempool::pool_allocator<mempool::pool_index_t::mempool_bluestore_meta_other,
std::__1::pair<unsigned long, bluestore_extent_ref_map_t::record_t> >
>'; did you mean 'KeyValueDB::Iterator'?
  void _maybe_merge_left(map_t::iterator& p);
                         ^~~~~~~~~~~~~~~
                         KeyValueDB::Iterator
/home/jenkins/workspace/ceph-master/src/kv/KeyValueDB.h:286:44: note:
'KeyValueDB::Iterator' declared here
  typedef ceph::shared_ptr< IteratorImpl > Iterator;
                                           ^
In file included from
/home/jenkins/workspace/ceph-master/src/test/objectstore/store_test.cc:23:
In file included from
/home/jenkins/workspace/ceph-master/src/os/bluestore/BlueStore.h:42:
/home/jenkins/workspace/ceph-master/src/os/bluestore/BlockDevice.h:41:12:
error: no member named 'aio_t' in 'FS'
  list<FS::aio_t> pending_aios;    ///< not yet submitted
       ~~~~^
/home/jenkins/workspace/ceph-master/src/os/bluestore/BlockDevice.h:42:12:
error: no member named 'aio_t' in 'FS'
  list<FS::aio_t> running_aios;    ///< submitting or submitted
       ~~~~^
In file included from
/home/jenkins/workspace/ceph-master/src/test/objectstore/store_test.cc:21:
In file included from
/home/jenkins/workspace/ceph-master/src/os/ObjectStore.h:17:
In file included from
/home/jenkins/workspace/ceph-master/src/include/Context.h:19:
In file included from
/home/jenkins/workspace/ceph-master/src/common/dout.h:20:
In file included from
/home/jenkins/workspace/ceph-master/src/common/config.h:21:
/usr/include/c++/v1/map:820:5: error: static_assert failed
"Allocator::value_type must be same type as value_type"
    static_assert((is_same<typename allocator_type::value_type,
value_type>::value),
    ^
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/jenkins/workspace/ceph-master/src/os/bluestore/BlueStore.h:231:7:
note: in instantiation of template class 'std::__1::map<unsigned int,
std::__1::unique_ptr<BlueStore::Buffer,
std::__1::default_delete<BlueStore::Buffer> >, std::__1::less<unsigned
int>,
mempool::pool_allocator<mempool::pool_index_t::mempool_bluestore_meta_other,
std::__1::pair<unsigned int, std::__1::unique_ptr<BlueStore::Buffer,
std::__1::default_delete<BlueStore::Buffer> > > > >' requested here
      buffer_map;
      ^
