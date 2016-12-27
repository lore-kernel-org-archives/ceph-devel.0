From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Clangs is complaining about type evaluations in test_mempool.cc
Date: Tue, 27 Dec 2016 10:35:03 +0100
Message-ID: <a5128b5c-072c-6d86-63db-a54928bb8d9e@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:65117 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751256AbcL0JpM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 27 Dec 2016 04:45:12 -0500
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id EA8B13471E
        for <ceph-devel@vger.kernel.org>; Tue, 27 Dec 2016 10:35:06 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

[100%] Building CXX object
src/test/CMakeFiles/unittest_mempool.dir/test_mempool.cc.o
In file included from /usr/srcs/Ceph/work/ceph/src/test/test_mempool.cc:20:
In file included from
/usr/srcs/Ceph/work/ceph/src/common/ceph_argparse.h:31:
In file included from /usr/srcs/Ceph/work/ceph/src/common/entity_name.h:22:
In file included from /usr/srcs/Ceph/work/ceph/src/include/encoding.h:25:
In file included from /usr/srcs/Ceph/work/ceph/src/include/denc.h:28:
/usr/include/c++/v1/map:837:5: error: static_assert failed
"Allocator::value_type must be same type as value_type"
    static_assert((is_same<typename allocator_type::value_type,
value_type>::value),
    ^
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/srcs/Ceph/work/ceph/src/test/test_mempool.cc:235:39: note: in
instantiation of template class 'std::__1::map<int, int,
std::__1::less<int>,
mempool::pool_allocator<mempool::pool_index_t::mempool_unittest_1,
std::__1::pair<int, int> > >' requested here
    mempool::unittest_1::map<int,int> v;
                                      ^
and more of the same on test_mempool.cc: 240 and 263.

Perhaps somebody has a suggestion on how to fix this??

--WjW
