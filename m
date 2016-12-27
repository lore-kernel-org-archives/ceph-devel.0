From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Clangs is complaining about type evaluations in test_mempool.cc
Date: Wed, 28 Dec 2016 00:29:17 +0100
Message-ID: <d8b38e75-71fc-42e0-6095-5c89994ed2ea@digiware.nl>
References: <a5128b5c-072c-6d86-63db-a54928bb8d9e@digiware.nl>
 <20161227161914.GA19064@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:49053 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753332AbcL0XkR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 27 Dec 2016 18:40:17 -0500
Received: from [192.168.10.10] (asus [192.168.10.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 2D08B34034
        for <ceph-devel@vger.kernel.org>; Wed, 28 Dec 2016 00:29:18 +0100 (CET)
In-Reply-To: <20161227161914.GA19064@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 27-12-2016 17:19, Adam C. Emerson wrote:
> On 27/12/2016, Willem Jan Withagen wrote:
>> Perhaps somebody has a suggestion on how to fix this??
> 
> I suspect that the container changes in
> https://github.com/ceph/ceph/pull/12626 will fix it. The denc container
> encodings in master always assume the default compare and allocator
> parameters.
> 

Eh, nope,....

Clang still complains about the same thing.
It is still complaining about a type comparison, and type not being
compatible.

--WjW

/usr/bin/CC   -DCEPH_LIBDIR=\"/usr/local/lib\"
-DCEPH_PKGLIBDIR=\"/usr/local/lib/ceph\"
-I/usr/srcs/Ceph/work/ceph/build/src/include
-I/usr/srcs/Ceph/work/ceph/src -isystem /usr/local/include -isystem
/usr/srcs/Ceph/work/ceph/build/include
-I/usr/srcs/Ceph/work/ceph/src/xxHash
-I/usr/srcs/Ceph/work/ceph/src/googletest/googlemock/include
-I/usr/srcs/Ceph/work/ceph/src/googletest/googletest/include  -Wall
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
-Werror=format-security -fno-strict-aliasing -fsigned-char
-Wno-unused-function -Wno-unused-local-typedef -Wno-varargs
-Wno-gnu-designator -Wno-missing-braces -Wno-parentheses
-Wno-deprecated-register  -ftemplate-depth-1024 -Wno-invalid-offsetof
-Wnon-virtual-dtor -Wno-inconsistent-missing-override
-Wno-mismatched-tags -Wno-unused-private-field -fdiagnostics-color=auto
-I/usr/local/include/nss/nss -I/usr/local/include/nspr
-fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc
-fno-builtin-free -Wno-null-dereference -O0 -g -fPIE   -DHAVE_CONFIG_H
-D__CEPH__ -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS
-I/usr/srcs/Ceph/work/ceph/src/googletest/googlemock/include
-I/usr/srcs/Ceph/work/ceph/build/src/googletest/googlemock/include
-I/usr/srcs/Ceph/work/ceph/src/googletest/googletest/include
-I/usr/srcs/Ceph/work/ceph/build/src/googletest/googletest/include
-fno-strict-aliasing -std=c++11 -o
CMakeFiles/unittest_mempool.dir/test_mempool.cc.o -c
/usr/srcs/Ceph/work/ceph/src/test/test_mempool.cc
In file included from /usr/srcs/Ceph/work/ceph/src/test/test_mempool.cc:20:
In file included from
/usr/srcs/Ceph/work/ceph/src/common/ceph_argparse.h:31:
In file included from /usr/srcs/Ceph/work/ceph/src/common/entity_name.h:22:
In file included from /usr/srcs/Ceph/work/ceph/src/include/encoding.h:25:
In file included from /usr/srcs/Ceph/work/ceph/src/include/denc.h:29:
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

