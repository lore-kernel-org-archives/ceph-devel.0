From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Clang complains about mismatiching types.
Date: Sat, 18 Feb 2017 23:52:48 +0100
Message-ID: <5ad4a660-692c-130e-7dcd-89fd1565c19a@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:43337 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751930AbdBTAkj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 19 Feb 2017 19:40:39 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>

I "fixed" the the bluestore inclusion, but hten still run into this type
mismatch in Clang.

--WjW

In file included from
/home/jenkins/workspace/ceph-master/src/osd/OSDMapMapping.cc:4:
In file included from
/home/jenkins/workspace/ceph-master/src/osd/OSDMapMapping.h:9:
/usr/include/c++/v1/map:820:5: error: static_assert failed
"Allocator::value_type must be same type as value_type"
    static_assert((is_same<typename allocator_type::value_type,
value_type>::value),
    ^
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/jenkins/workspace/ceph-master/src/osd/OSDMapMapping.h:242:49:
note: in instantiation of template class 'std::__1::map<int,
OSDMapMapping::PoolMapping, std::__1::less<int>,
mempool::pool_allocator<mempool::pool_index_t::mempool_osdmap_mapping,
std::__1::pair<int, OSDMapMapping::PoolMapping> > >' requested here
  mempool::osdmap_mapping::map<int,PoolMapping> pools;
                                                ^
1 error generated.
gmake[2]: *** [src/CMakeFiles/common-objs.dir/build.make:1992:
src/CMakeFiles/common-objs.dir/osd/OSDMapMapping.cc.o] Error 1
gmake[2]: *** Waiting for unfinished jobs....
Scanning dependencies of target rbd_test_mock
[ 21%] Building CXX object src/librbd/CMakeFiles/rbd_api.dir/librbd.cc.o
[ 22%] Building CXX object
src/test/librbd/CMakeFiles/rbd_test.dir/test_fixture.cc.o
[ 22%] Linking
