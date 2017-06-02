From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Crashes with unittest_dencoder
Date: Fri, 2 Jun 2017 02:46:53 +0200
Message-ID: <46da372a-cd7e-32b5-38c6-98aa94d13780@digiware.nl>
References: <66fafc3c-a5dd-405d-a521-597fe524d1e3@digiware.nl>
 <CAF-wwdF9QXMg6EzKU=HoG8e6K5+SMSu-ZU3rHVtrYMVJVpJjUQ@mail.gmail.com>
 <6d384986-a2b8-7b5e-4098-80b9d2a98f99@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:10460 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750851AbdFBAq4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Jun 2017 20:46:56 -0400
In-Reply-To: <6d384986-a2b8-7b5e-4098-80b9d2a98f99@digiware.nl>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 02/06/2017 02:23, Willem Jan Withagen wrote:
> On 02/06/2017 01:27, Brad Hubbard wrote:
>> The first guess I would have is that this may have something to do
>> with https://github.com/ceph/ceph/pull/15352
> 
> Reverting 15402 and 15403 get me back to normal builds.
> 
> And was only having trouble with osd-scrib-repair.sh until this morning,
> and then six showed up, preventing compilation. And somewhere in between
> the problem with dencoder started.
> So I'd execpt it to be one these to actually expect 15402, but I'd
> expect that 15403 cannot do without 15402.
>

Actually it is 15403, if I undo that PR unittest_denc starts producing
errors.

--WjW

> --WjW
>> Could you try backing that change out Willem and let us know how that goes?
>>
>> On Fri, Jun 2, 2017 at 9:00 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> Any hints on what changes in the current code generates the illegal
>>> memaccess in the trace below?
>>>
>>> Lots of tests fail, and I guess that mst have to do with this.
>>>
>>> --WjW
>>>
>>> Program received signal SIGSEGV, Segmentation fault.
>>> 0x00000008025e693e in std::__1::__atomic_base<unsigned long,
>>> true>::fetch_add (this=0x108803637688,
>>>     __op=1, __m=std::__1::memory_order_seq_cst) at
>>> /usr/include/c++/v1/atomic:980
>>> 980             {return __c11_atomic_fetch_add(&this->__a_, __op, __m);}
>>> (gdb) bt
>>> #0  0x00000008025e693e in std::__1::__atomic_base<unsigned long,
>>> true>::fetch_add (this=0x108803637688,
>>>     __op=1, __m=std::__1::memory_order_seq_cst) at
>>> /usr/include/c++/v1/atomic:980
>>> #1  std::__1::__atomic_base<unsigned long, true>::operator+=
>>> (this=0x108803637688, __op=1)
>>>     at /usr/include/c++/v1/atomic:1025
>>> #2  mempool::pool_t::adjust_count (this=0x108803637680, items=1, bytes=42)
>>>     at /home/jenkins/workspace/ceph-master/src/common/mempool.cc:85
>>> #3  0x00000008024f1bfb in ceph::buffer::raw::reassign_to_mempool
>>> (this=0x1076130, pool=-1)
>>>     at /home/jenkins/workspace/ceph-master/src/common/buffer.cc:196
>>> #4  0x00000008024e1b19 in ceph::buffer::list::reserve
>>> (this=0x7fffffffd040, prealloc=42)
>>>     at /home/jenkins/workspace/ceph-master/src/common/buffer.cc:1772
>>> #5  0x00000000004d0ad5 in ceph::buffer::list::list (this=0x7fffffffd040,
>>> prealloc=42)
>>>     at /home/jenkins/workspace/ceph-master/src/include/buffer.h:662
>>> #6  0x00000000004b4114 in Legacy::encode_n (n=42, segments=...)
>>>     at /home/jenkins/workspace/ceph-master/src/test/test_denc.cc:610
>>> #7  0x00000000004b4d22 in
>>> denc_no_copy_if_segmented_and_lengthy_Test::TestBody (this=0x1068070)
>>>     at /home/jenkins/workspace/ceph-master/src/test/test_denc.cc:633
>>> #8  0x00000000005ea62e in
>>> testing::internal::HandleSehExceptionsInMethodIfSupported<testing::Test,
>>> void> (
>>>     object=0x1068070, method=&virtual testing::Test::TestBody(),
>>> location=0x6156ee "the test body")
>>>     at
>>> /home/jenkins/workspace/ceph-master/src/googletest/googletest/src/gtest.cc:2402
>>> #9  0x00000000005ccabb in
>>> testing::internal::HandleExceptionsInMethodIfSupported<testing::Test,
>>> void> (
>>>     object=0x1068070, method=&virtual testing::Test::TestBody(),
>>> location=0x6156ee "the test body")
>>>     at
>>> /home/jenkins/workspace/ceph-master/src/googletest/googletest/src/gtest.cc:2438
>>> #10 0x00000000005885c6 in testing::Test::Run (this=0x1068070)
>>>     at
>>> /home/jenkins/workspace/ceph-master/src/googletest/googletest/src/gtest.cc:2474
>>> #11 0x000000000058ad0d in testing::TestInfo::Run (this=0x106edd0)
>>>     at
>>> /home/jenkins/workspace/ceph-master/src/googletest/googletest/src/gtest.cc:2656
>>> #12 0x000000000058bfcc in testing::TestCase::Run (this=0x106e0d0)
>>>     at
>>> /home/jenkins/workspace/ceph-master/src/googletest/googletest/src/gtest.cc:2774
>>> #13 0x00000000005a2e8c in testing::internal::UnitTestImpl::RunAllTests
>>> (this=0x1072000)
>>>     at
>>> /home/jenkins/workspace/ceph-master/src/googletest/googletest/src/gtest.cc:4649
>>> #14 0x00000000005ed4be in
>>> testing::internal::HandleSehExceptionsInMethodIfSupported<testing::internal::UnitTestImpl,
>>> bool> (object=0x1072000,
>>>     method=(bool
>>> (testing::internal::UnitTestImpl::*)(testing::internal::UnitTestImpl *
>>> const)) 0x5a2af0 <testing::internal::UnitTestImpl::RunAllTests()>,
>>>     location=0x615d71 "auxiliary test code (environments or event
>>> listeners)")
>>>     at
>>> /home/jenkins/workspace/ceph-master/src/googletest/googletest/src/gtest.cc:2402
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

