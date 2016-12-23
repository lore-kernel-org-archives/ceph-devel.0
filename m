From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: An empty vptr in an raw object
Date: Fri, 23 Dec 2016 10:32:31 +1000
Message-ID: <CAF-wwdH5wQP11gQKcwoh0uVQpVHQXw=8XYCj+t=mhx0rfFSJSg@mail.gmail.com>
References: <4aeb9ff1-367c-f31e-fc0c-5f08dcdcfe0e@digiware.nl>
 <7754eadf-5f8c-ade3-1634-486fff240adf@digiware.nl> <EB02EE10422E4A40A1EE787A4AC27FBE044D2A@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <e1bdab0b-ec02-819e-e6fe-4e07baa235be@digiware.nl> <EB02EE10422E4A40A1EE787A4AC27FBE045604@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <CAF-wwdHbSejTSYGDvRdYcu03Dz=22wMP619cWfCcO1sx9h+wTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wj0-f173.google.com ([209.85.210.173]:32923 "EHLO
        mail-wj0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754087AbcLWAce (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2016 19:32:34 -0500
Received: by mail-wj0-f173.google.com with SMTP id tq7so3789699wjb.0
        for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2016 16:32:33 -0800 (PST)
In-Reply-To: <CAF-wwdHbSejTSYGDvRdYcu03Dz=22wMP619cWfCcO1sx9h+wTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

Checked this myself and valgrind shows numerous problems of this type.

==10312== Mismatched free() / delete / delete []
==10312==    at 0x4C2ED4A: free (vg_replace_malloc.c:530)
==10312==    by 0x160117: deallocate (new_allocator.h:110)
==10312==    by 0x160117: deallocate (alloc_traits.h:442)
==10312==    by 0x160117: _M_put_node (stl_list.h:387)
==10312==    by 0x160117: _M_clear (list.tcc:80)
==10312==    by 0x160117: ~_List_base (stl_list.h:442)
==10312==    by 0x160117: ~list (stl_list.h:503)
==10312==    by 0x160117: denc_list_Test::TestBody() (test_denc.cc:282)
==10312==    by 0x19D203:
HandleSehExceptionsInMethodIfSupported<testing::Test, void>
(gtest.cc:2402)
==10312==    by 0x19D203: void
testing::internal::HandleExceptionsInMethodIfSupported<testing::Test,
void>(testing::Test*, void (testing::Test::*)(), char const*)
(gtest.cc:2438)
==10312==    by 0x194029: testing::Test::Run() (gtest.cc:2475)
==10312==    by 0x194177: testing::TestInfo::Run() (gtest.cc:2656)
==10312==    by 0x194254: testing::TestCase::Run() (gtest.cc:2774)
==10312==    by 0x194536:
testing::internal::UnitTestImpl::RunAllTests() (gtest.cc:4649)
==10312==    by 0x19D6B3:
HandleSehExceptionsInMethodIfSupported<testing::internal::UnitTestImpl,
bool> (gtest.cc:2402)
==10312==    by 0x19D6B3: bool
testing::internal::HandleExceptionsInMethodIfSupported<testing::internal::UnitTestImpl,
bool>(testing::internal::UnitTestImpl*, bool
(testing::internal::UnitTestImpl::*)(), char const*) (gtest.cc:2438)
==10312==    by 0x194853: testing::UnitTest::Run() (gtest.cc:4257)
==10312==    by 0x15A7D8: RUN_ALL_TESTS (gtest.h:2233)
==10312==    by 0x15A7D8: main (gmock_main.cc:53)
==10312==  Address 0x8ad31a0 is 0 bytes inside a block of size 24 alloc'd
==10312==    at 0x4C2E8E9: operator new[](unsigned long)
(vg_replace_malloc.c:423)
==10312==    by 0x15FDF1: allocate (new_allocator.h:104)
==10312==    by 0x15FDF1: allocate (alloc_traits.h:416)
==10312==    by 0x15FDF1: _M_get_node (stl_list.h:383)
==10312==    by 0x15FDF1: _M_create_node<denc_counter_bounded_t>
(stl_list.h:568)
==10312==    by 0x15FDF1: _M_insert<denc_counter_bounded_t> (stl_list.h:1770)
==10312==    by 0x15FDF1: emplace_back<denc_counter_bounded_t> (stl_list.h:1108)
==10312==    by 0x15FDF1: decode (denc.h:716)
==10312==    by 0x15FDF1:
decode<std::__cxx11::list<denc_counter_bounded_t> > (denc.h:1289)
==10312==    by 0x15FDF1:
decode<std::__cxx11::list<denc_counter_bounded_t> > (encoding.h:289)
==10312==    by 0x15FDF1: denc_list_Test::TestBody() (test_denc.cc:289)
==10312==    by 0x19D203:
HandleSehExceptionsInMethodIfSupported<testing::Test, void>
(gtest.cc:2402)
==10312==    by 0x19D203: void
testing::internal::HandleExceptionsInMethodIfSupported<testing::Test,
void>(testing::Test*, void (testing::Test::*)(), char const*)
(gtest.cc:2438)
==10312==    by 0x194029: testing::Test::Run() (gtest.cc:2475)
==10312==    by 0x194177: testing::TestInfo::Run() (gtest.cc:2656)
==10312==    by 0x194254: testing::TestCase::Run() (gtest.cc:2774)
==10312==    by 0x194536:
testing::internal::UnitTestImpl::RunAllTests() (gtest.cc:4649)
==10312==    by 0x19D6B3:
HandleSehExceptionsInMethodIfSupported<testing::internal::UnitTestImpl,
bool> (gtest.cc:2402)
==10312==    by 0x19D6B3: bool
testing::internal::HandleExceptionsInMethodIfSupported<testing::internal::UnitTestImpl,
bool>(testing::internal::UnitTestImpl*, bool
(testing::internal::UnitTestImpl::*)(), char const*) (gtest.cc:2438)
==10312==    by 0x194853: testing::UnitTest::Run() (gtest.cc:4257)
==10312==    by 0x15A7D8: RUN_ALL_TESTS (gtest.h:2233)
==10312==    by 0x15A7D8: main (gmock_main.cc:53)

On Fri, Dec 23, 2016 at 10:19 AM, Brad Hubbard <bhubbard@redhat.com> wrote:
> Any clue from Valgrind?
>
> Did you say this only happens with clang or doesn't happen with clang?
>
> On Fri, Dec 23, 2016 at 8:01 AM, Allen Samuels
> <Allen.Samuels@sandisk.com> wrote:
>> I believe I mis-read the data. What I've seen before doesn't fit this data.
>>
>> If it fails in unit test, it shouldn't be hard to just set a HW breakpoint on the vptr and see who the culprit is.
>>
>>
>> Allen Samuels
>> SanDisk |a Western Digital brand
>> 2880 Junction Avenue, San Jose, CA 95134
>> T: +1 408 801 7030| M: +1 408 780 6416
>> allen.samuels@SanDisk.com
>>
>>
>>> -----Original Message-----
>>> From: Willem Jan Withagen [mailto:wjw@digiware.nl]
>>> Sent: Thursday, December 22, 2016 10:37 AM
>>> To: Allen Samuels <Allen.Samuels@sandisk.com>; Ceph Development
>>> <ceph-devel@vger.kernel.org>
>>> Subject: Re: An empty vptr in an raw object
>>>
>>> On 22-12-2016 19:02, Allen Samuels wrote:
>>> > I have seen cases of null vptr due to an incompletely constructed object,
>>> i.e., an object that's in the middle of being constructed.
>>>
>>> I going to believe you right away.
>>> But I'm having a hard time imagining such a case.
>>>
>>> Are you suggesting a object is referenced, whilest it is not yet complete. who
>>> does the referencing then? due to threading?
>>> That would be even harder to find.
>>>
>>> --WjW
>>>
>>>
>>> > Allen Samuels
>>> > SanDisk |a Western Digital brand
>>> > 951 SanDisk Drive, Milpitas, CA 95035
>>> > T: +1 408 801 7030| M: +1 408 780 6416 allen.samuels@SanDisk.com
>>> >
>>> >
>>> >> -----Original Message-----
>>> >> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>> >> owner@vger.kernel.org] On Behalf Of Willem Jan Withagen
>>> >> Sent: Thursday, December 22, 2016 9:41 AM
>>> >> To: Ceph Development <ceph-devel@vger.kernel.org>
>>> >> Subject: An empty vptr in an raw object
>>> >>
>>> >>> I have a piece of code that actually seem to crash because the vptr
>>> >>> is not set:
>>> >>> (gdb) p *_raw
>>> >>> $2 = {_vptr$raw = 0x0, data = 0x10cc000 "\003", len = 72, nref =
>>> >>> {val = 1}, crc_spinlock = 0, crc_map = {__tree_ = {
>>> >>>       __begin_node_ = 0x10cc078,
>>> >>>       __pair1_ =
>>> >>>
>>> >>
>>> {<std::__1::__libcpp_compressed_pair_imp<std::__1::__tree_end_node<st
>>> >> d::__1::__tree_node_base<void*>*>,
>>> >>>
>>> >> std::__1::allocator<std::__1::__tree_node<std::__1::__value_type<std:
>>> >> :__1
>>> >> ::pair<unsigned
>>> >>> long, unsigned long>, std::__1::pair<unsigned int, unsigned int> >,
>>> >>> void*> >, 2>> =
>>> >>>
>>> >> {<std::__1::allocator<std::__1::__tree_node<std::__1::__value_type<st
>>> >> d::_
>>> >> _1::pair<unsigned
>>> >>> long, unsigned long>, std::__1::pair<unsigned int, unsigned int> >,
>>> >>> void*> >> = {<No data fields>}, __first_ = {
>>> >>>             __left_ = 0x0}}, <No data fields>},
>>> >>>
>>> >>> The function that crashes:
>>> >>>  char *buffer::ptr::c_str() {
>>> >>>     assert(_raw);
>>> >>>     if (buffer_track_c_str)
>>> >>>       buffer_c_str_accesses.inc();
>>> >>>     char *p =  _raw->get_data();
>>> >>>     return p + _off;
>>> >>>   }
>>> >>>
>>> >>> And crash is actually on the return line.
>>> >>>
>>> >>> Any ideas as how the vptr can be empty?
>>> >>
>>> >> Now the _vptr$raw point is part of the internal code of the clang
>>> >> class function table/constructor. Overwriting that means that
>>> >> class-function references are problematic to say the least. (in this
>>> example get_data()).
>>> >>
>>> >> The major reason why this occurs is because an object is being zeroed
>>> >> in C-style way: memset( &obj, 0, sizeof(obj)) And thus overwriting
>>> >> the _vptr.
>>> >>
>>> >> Note that this does not bite the FreeBSD compilation, but also any
>>> >> other attempts to build Ceph with clang.
>>> >>
>>> >> Now the strange thing is that this does not bite Clang compilation
>>> >> much more. But the only test that fails is unittest_denc. So I guess
>>> >> that most of the code is rather well behaved.
>>> >>
>>> >> And I'm off on a search to find the culprit.
>>> >>
>>> >> --WjW
>>> >>
>>> >>
>>> >>
>>> >> --
>>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> >> in the body of a message to majordomo@vger.kernel.org More
>>> majordomo
>>> >> info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> --
> Cheers,
> Brad



-- 
Cheers,
Brad
