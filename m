From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Glang: Still compiling HEAD with a hack in test_mempool.c
Date: Tue, 7 Feb 2017 17:00:27 +0100
Message-ID: <fdcfc43e-91ef-4f85-d042-961eedd544e2@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:15764 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754857AbdBGQAc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Feb 2017 11:00:32 -0500
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 29A453818B
        for <ceph-devel@vger.kernel.org>; Tue,  7 Feb 2017 17:00:29 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

This is on FreeBSD.

I'm cleaning up patches that I have in Jenkins to actually build and
test HEAD, so I can prepare the submission of a FreeBSD port.

And it complains on things like:
	mempool::unittest_1::map<int,int> v;
or
	mempool::unittest_2::unordered_map<int,obj> h;

Any suggestions on how to fix this.

Thanx,
--WjW

[100%] Building CXX object
src/test/CMakeFiles/unittest_mempool.dir/test_mempool.cc.o
In file included from
/home/jenkins/workspace/ceph-master/src/test/test_mempool.cc:20:
In file included from
/home/jenkins/workspace/ceph-master/src/common/ceph_argparse.h:31:
In file included from
/home/jenkins/workspace/ceph-master/src/common/entity_name.h:22:
In file included from
/home/jenkins/workspace/ceph-master/src/include/encoding.h:25:
In file included from
/home/jenkins/workspace/ceph-master/src/include/denc.h:29:
/usr/include/c++/v1/map:820:5: error: static_assert failed
"Allocator::value_type must be same type as value_type"
    static_assert((is_same<typename allocator_type::value_type,
value_type>::value),
    ^
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/jenkins/workspace/ceph-master/src/test/test_mempool.cc:235:39:
note: in instantiation of template class 'std::__1::map<int, int,
std::__1::less<int>,
mempool::pool_allocator<mempool::pool_index_t::mempool_unittest_1,
std::__1::pair<int, int> > >' requested here
    mempool::unittest_1::map<int,int> v;
                                      ^
