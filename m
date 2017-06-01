From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Crashes with unittest_dencoder
Date: Fri, 2 Jun 2017 09:27:08 +1000
Message-ID: <CAF-wwdF9QXMg6EzKU=HoG8e6K5+SMSu-ZU3rHVtrYMVJVpJjUQ@mail.gmail.com>
References: <66fafc3c-a5dd-405d-a521-597fe524d1e3@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:38776 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdFAX1L (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 19:27:11 -0400
Received: by mail-it0-f54.google.com with SMTP id r63so3278538itc.1
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jun 2017 16:27:11 -0700 (PDT)
In-Reply-To: <66fafc3c-a5dd-405d-a521-597fe524d1e3@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

The first guess I would have is that this may have something to do
with https://github.com/ceph/ceph/pull/15352

Could you try backing that change out Willem and let us know how that goes?

On Fri, Jun 2, 2017 at 9:00 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Any hints on what changes in the current code generates the illegal
> memaccess in the trace below?
>
> Lots of tests fail, and I guess that mst have to do with this.
>
> --WjW
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x00000008025e693e in std::__1::__atomic_base<unsigned long,
> true>::fetch_add (this=0x108803637688,
>     __op=1, __m=std::__1::memory_order_seq_cst) at
> /usr/include/c++/v1/atomic:980
> 980             {return __c11_atomic_fetch_add(&this->__a_, __op, __m);}
> (gdb) bt
> #0  0x00000008025e693e in std::__1::__atomic_base<unsigned long,
> true>::fetch_add (this=0x108803637688,
>     __op=1, __m=std::__1::memory_order_seq_cst) at
> /usr/include/c++/v1/atomic:980
> #1  std::__1::__atomic_base<unsigned long, true>::operator+=
> (this=0x108803637688, __op=1)
>     at /usr/include/c++/v1/atomic:1025
> #2  mempool::pool_t::adjust_count (this=0x108803637680, items=1, bytes=42)
>     at /home/jenkins/workspace/ceph-master/src/common/mempool.cc:85
> #3  0x00000008024f1bfb in ceph::buffer::raw::reassign_to_mempool
> (this=0x1076130, pool=-1)
>     at /home/jenkins/workspace/ceph-master/src/common/buffer.cc:196
> #4  0x00000008024e1b19 in ceph::buffer::list::reserve
> (this=0x7fffffffd040, prealloc=42)
>     at /home/jenkins/workspace/ceph-master/src/common/buffer.cc:1772
> #5  0x00000000004d0ad5 in ceph::buffer::list::list (this=0x7fffffffd040,
> prealloc=42)
>     at /home/jenkins/workspace/ceph-master/src/include/buffer.h:662
> #6  0x00000000004b4114 in Legacy::encode_n (n=42, segments=...)
>     at /home/jenkins/workspace/ceph-master/src/test/test_denc.cc:610
> #7  0x00000000004b4d22 in
> denc_no_copy_if_segmented_and_lengthy_Test::TestBody (this=0x1068070)
>     at /home/jenkins/workspace/ceph-master/src/test/test_denc.cc:633
> #8  0x00000000005ea62e in
> testing::internal::HandleSehExceptionsInMethodIfSupported<testing::Test,
> void> (
>     object=0x1068070, method=&virtual testing::Test::TestBody(),
> location=0x6156ee "the test body")
>     at
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/src/gtest.cc:2402
> #9  0x00000000005ccabb in
> testing::internal::HandleExceptionsInMethodIfSupported<testing::Test,
> void> (
>     object=0x1068070, method=&virtual testing::Test::TestBody(),
> location=0x6156ee "the test body")
>     at
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/src/gtest.cc:2438
> #10 0x00000000005885c6 in testing::Test::Run (this=0x1068070)
>     at
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/src/gtest.cc:2474
> #11 0x000000000058ad0d in testing::TestInfo::Run (this=0x106edd0)
>     at
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/src/gtest.cc:2656
> #12 0x000000000058bfcc in testing::TestCase::Run (this=0x106e0d0)
>     at
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/src/gtest.cc:2774
> #13 0x00000000005a2e8c in testing::internal::UnitTestImpl::RunAllTests
> (this=0x1072000)
>     at
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/src/gtest.cc:4649
> #14 0x00000000005ed4be in
> testing::internal::HandleSehExceptionsInMethodIfSupported<testing::internal::UnitTestImpl,
> bool> (object=0x1072000,
>     method=(bool
> (testing::internal::UnitTestImpl::*)(testing::internal::UnitTestImpl *
> const)) 0x5a2af0 <testing::internal::UnitTestImpl::RunAllTests()>,
>     location=0x615d71 "auxiliary test code (environments or event
> listeners)")
>     at
> /home/jenkins/workspace/ceph-master/src/googletest/googletest/src/gtest.cc:2402
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
