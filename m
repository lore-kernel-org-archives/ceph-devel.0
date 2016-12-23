From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: An empty vptr in an raw object
Date: Fri, 23 Dec 2016 21:51:07 +0100
Message-ID: <8cf90468-c1ad-9453-5cb7-cf312c6f9246@digiware.nl>
References: <4aeb9ff1-367c-f31e-fc0c-5f08dcdcfe0e@digiware.nl>
 <7754eadf-5f8c-ade3-1634-486fff240adf@digiware.nl>
 <EB02EE10422E4A40A1EE787A4AC27FBE044D2A@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <e1bdab0b-ec02-819e-e6fe-4e07baa235be@digiware.nl>
 <EB02EE10422E4A40A1EE787A4AC27FBE045604@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <dd12b176-2294-72cd-c2b7-6fff709d44c6@digiware.nl>
 <alpine.DEB.2.11.1612231418570.10615@piezo.novalocal>
 <5eda2374-c9a8-a8c6-e925-c87320a326c4@digiware.nl>
 <alpine.DEB.2.11.1612231643450.10615@piezo.novalocal>
 <4a510a2f-1079-07d6-778c-90769f6434db@digiware.nl>
 <alpine.DEB.2.11.1612231659070.10615@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:22266 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941696AbcLWUvO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 23 Dec 2016 15:51:14 -0500
In-Reply-To: <alpine.DEB.2.11.1612231659070.10615@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 23-12-2016 17:59, Sage Weil wrote:
> On Fri, 23 Dec 2016, Willem Jan Withagen wrote:
>> On 23-12-2016 17:46, Sage Weil wrote:
>>> On Fri, 23 Dec 2016, Willem Jan Withagen wrote:
>>>> On 23-12-2016 15:26, Sage Weil wrote:
>>>>> On Fri, 23 Dec 2016, Willem Jan Withagen wrote:
>>>>>> On 22-12-2016 23:01, Allen Samuels wrote:
>>>>>>> I believe I mis-read the data. What I've seen before doesn't fit this data.
>>>>>>>
>>>>>>> If it fails in unit test, it shouldn't be hard to just set a HW breakpoint on the vptr and see who the culprit is.
>>>>>>
>>>>>> Well the _raw class is properly initialised:
>>>>>> $8 = {_vptr$raw = 0x817578 <vtable for ceph::buffer::raw+16>,
>>>>>>
>>>>>> And is "upgraded" to a different class:
>>>>>> 	ceph::buffer::raw_combined
>>>>>>
>>>>>> But here is the problem...
>>>>>>
>>>>>> Hardware watchpoint 5: *0x1054048
>>>>>>
>>>>>> Old value = 8484744
>>>>>> New value = 0
>>>>>> 0x000000000049ab29 in denc_traits<unsigned long, void>::encode
>>>>>> (o=@0x10501d0: 123, p=..., f=0) at
>>>>>> /usr/srcs/Ceph/work/ceph/src/include/denc.h:228
>>>>>> 228     WRITE_INT_DENC(uint64_t, __le64);
>>>>>
>>>>> Ah, okay, this is making a bit more sense now.
>>>>>
>>>>> raw_combined is trying to be clever.  It has a static create() method to
>>>>>
>>>>> - allocate an aligned buffer of size len + sizeof(raw_combined) (with some 
>>>>> rounding up), call it *ptr
>>>>> - in-place initiailize raw_combined at ptr + len (rounded up), call it *this
>>>>> - store the the actual data at ptr
>>>>> - return the raw_combined *this
>>>>>
>>>>> It has an overloaded delete operator to free the entire allocate 
>>>>> (roughly this - len) to make this work.
>>>>>
>>>>> It sounds a bit like the write into raw_combined's data portion (ptr) is 
>>>>> clobbering vptr.  Which probably suggests we wrote too much into the 
>>>>> buffer.  Can you print the contents of the raw_combined class and the 
>>>>> appender?
>>>>
>>>> Not sure if I understand the values you'd like, but this is a first attempt:
>>>> (gdb) p p
>>>> $1 = (ceph::buffer::list::contiguous_appender &) @0x7fffffffd948: {pbl =
>>>> 0x7fffffffd978, pos = 0x105404f "", bp = {_raw = 0x1054048, _off = 0,
>>>
>>>                         ^^                         ^^
>>>
>>> Yep, pos is advancing to far and clobbering _raw (the raw_combined).
>>>
>>> Try changing that sizeof(T) * 3 to s?  I can't tell from the stack 
>>> trace below what path this is.. line 206 on master is
>>>
>>>     s.push_back("foo");
>>>
>>> which is clearly not the code you're running.
>>
>> 'mmm, the version I have is already at '*3'
> 
> I mean s/sizeof(T) * 3/s/.
> 
> It makes sense that sizeof(std::string)*3 is unrelated to the encoded 
> size.

That works....

No crash, and the map test completes oke...

So are there more locations where this would be the case.
Otherwise it it just a PR for only this file...

--WjW

> 
>>
>> template<typename T>
>> void test_denc(T v) {
>>   // estimate
>>   size_t s = 0;
>>   denc(v, s);
>>   ASSERT_NE(s, 0u);
>>
>>   // encode
>>   bufferlist bl;
>>   {
>>     auto a = bl.get_contiguous_appender(sizeof(T) * 3);
>>     denc(v, a);
>>   }
>>   ASSERT_LE(bl.length(), s);
>>
>>   // decode
>>   bl.rebuild();
>>   T out;
>>   auto bpi = bl.front().begin();
>>   denc(out, bpi);
>>   ASSERT_EQ(v, out);
>>   ASSERT_EQ(bpi.get_pos(), bl.c_str() + bl.length());
>>
>>   // test glue
>>   test_encode_decode(v);
>> }
>>
>> BTW: I'm off to home. CET = 18:00, and I still have to do my shopping
>> for the backing pies and deserts for X-mas Eve.
>> So I'll be on and off-line on irregular basis, as I guess most will be.
>>
>> Happy hollidays,
>> --WjW
>>
>>
>>>
>>> sage
>>>
>>>> _len = 72}, deep = false,
>>>>   out_of_band_offset = 0}
>>>>
>>>> I do not know how to get to the raw_combined class
>>>>
>>>> But I also found this morning that pos is actually point to 0x105404f
>>>> after adding 8 bytes of size .
>>>> So writing any value to that pointer before incrementing will clobber
>>>> vptr, since it points to 0x1054047.
>>>>
>>>> --WjW
>>>>
>>>>>
>>>>> sage
>>>>>
>>>>>
>>>>>>
>>>>>> The traceback:
>>>>>> #0  0x000000000049ab29 in denc_traits<unsigned long, void>::encode
>>>>>> (o=@0x10501d0: 123, p=..., f=0) at
>>>>>> /usr/srcs/Ceph/work/ceph/src/include/denc.h:228
>>>>>> #1  0x000000000049a7a8 in denc<unsigned long, denc_traits<unsigned long,
>>>>>> void> > (o=@0x10501d0: 123, p=..., features=0) at
>>>>>> /usr/srcs/Ceph/work/ceph/src/include/denc.h:479
>>>>>> #2  0x000000000049a6a5 in _denc_friend<foo_t const,
>>>>>> ceph::buffer::list::contiguous_appender> (v=..., p=...) at
>>>>>> /usr/srcs/Ceph/work/ceph/src/test/test_denc.cc:155
>>>>>> #3  0x000000000049a62d in foo_t::encode (this=0x10501c8, p=...) at
>>>>>> /usr/srcs/Ceph/work/ceph/src/test/test_denc.cc:152
>>>>>> #4  0x000000000049a601 in denc_traits<foo_t, void>::encode (v=...,
>>>>>> p=..., f=0) at /usr/srcs/Ceph/work/ceph/src/test/test_denc.cc:163
>>>>>> #5  0x000000000049a188 in denc<foo_t, denc_traits<foo_t, void> > (o=...,
>>>>>> p=..., features=0) at /usr/srcs/Ceph/work/ceph/src/include/denc.h:479
>>>>>> #6  0x000000000049a0ac in
>>>>>> denc_traits<std::__1::map<std::__1::basic_string<char,
>>>>>> std::__1::char_traits<char>, std::__1::allocator<char> >, foo_t,
>>>>>> std::__1::less<std::__1::basic_string<char, std::__1::char_traits<char>,
>>>>>> std::__1::allocator<char> > >,
>>>>>> std::__1::allocator<std::__1::pair<std::__1::basic_string<char,
>>>>>> std::__1::char_traits<char>, std::__1::allocator<char> > const, foo_t> >
>>>>>>> , void>::encode<std::__1::basic_string<char,
>>>>>> std::__1::char_traits<char>, std::__1::allocator<char> > > (v=..., p=...)
>>>>>>     at /usr/srcs/Ceph/work/ceph/src/include/denc.h:1010
>>>>>> #7  0x0000000000494581 in
>>>>>> denc<std::__1::map<std::__1::basic_string<char,
>>>>>> std::__1::char_traits<char>, std::__1::allocator<char> >, foo_t,
>>>>>> std::__1::less<std::__1::basic_string<char, std::__1::char_traits<char>,
>>>>>> std::__1::allocator<char> > >,
>>>>>> std::__1::allocator<std::__1::pair<std::__1::basic_string<char,
>>>>>> std::__1::char_traits<char>, std::__1::allocator<char> > const, foo_t> >
>>>>>>> , denc_traits<std::__1::map<std::__1::basic_string<char,
>>>>>> std::__1::char_traits<char>, std::__1::allocator<char> >, foo_t,
>>>>>> std::__1::less<std::__1::basic_string<char, std::__1::char_traits<char>,
>>>>>> std::__1::allocator<char> > >,
>>>>>> std::__1::allocator<std::__1::pair<std::__1::basic_string<char,
>>>>>> std::__1::char_traits<char>, std::__1::allocator<char> > const, foo_t> >
>>>>>>> , void> > (o=..., p=..., features=0) at
>>>>>> /usr/srcs/Ceph/work/ceph/src/include/denc.h:479
>>>>>> #8  0x0000000000490fb1 in
>>>>>> test_denc<std::__1::map<std::__1::basic_string<char,
>>>>>> std::__1::char_traits<char>, std::__1::allocator<char> >, foo_t,
>>>>>> std::__1::less<std::__1::basic_string<char, std::__1::char_traits<char>,
>>>>>> std::__1::allocator<char> > >,
>>>>>> std::__1::allocator<std::__1::pair<std::__1::basic_string<char,
>>>>>> std::__1::char_traits<char>, std::__1::allocator<char> > const, foo_t> >
>>>>>>>> (v=...) at /usr/srcs/Ceph/work/ceph/src/test/test_denc.cc:49
>>>>>> #9  0x00000000004904e0 in denc_map_Test::TestBody (this=0x1038030) at
>>>>>> /usr/srcs/Ceph/work/ceph/src/test/test_denc.cc:206
>>>>>>
>>>>>> (gdb) p p
>>>>>> $10 = (ceph::buffer::list::contiguous_appender &) @0x7fffffffd948: {pbl
>>>>>> = 0x7fffffffd978, pos = 0x105404f "", bp = {_raw = 0x1054048, _off = 0,
>>>>>> _len = 72}, deep = false,
>>>>>>   out_of_band_offset = 0}
>>>>>> (gdb) p *p.bp._raw
>>>>>> $17 = {_vptr$raw = 0x0, data = 0x1054000 "\003", len = 72, nref = {val =
>>>>>> 1}, crc_spinlock = 0, crc_map = {__tree_ = {__begin_node_ = 0x1054078,
>>>>>>       __pair1_ =
>>>>>> {<std::__1::__libcpp_compressed_pair_imp<std::__1::__tree_end_node<std::__1::__tree_node_base<void*>*>,
>>>>>> std::__1::allocator<std::__1::__tree_node<std::__1::__value_type<std::__1::pair<unsigned
>>>>>> long, unsigned long>, std::__1::pair<unsigned int, unsigned int> >,
>>>>>> void*> >, 2>> =
>>>>>> {<std::__1::allocator<std::__1::__tree_node<std::__1::__value_type<std::__1::pair<unsigned
>>>>>> long, unsigned long>, std::__1::pair<unsigned int, unsigned int> >,
>>>>>> void*> >> = {<No data fields>}, __first_ = {
>>>>>>             __left_ = 0x0}}, <No data fields>},
>>>>>>       __pair3_ = {<std::__1::__libcpp_compressed_pair_imp<unsigned long,
>>>>>> std::__1::__map_value_compare<std::__1::pair<unsigned long, unsigned
>>>>>> long>, std::__1::__value_type<std::__1::pair<unsigned long, unsigned
>>>>>> long>, std::__1::pair<unsigned int, unsigned int> >,
>>>>>> std::__1::less<std::__1::pair<unsigned long, unsigned long> >, true>,
>>>>>> 2>> = {<std::__1::__map_value_compare<std::__1::pair<unsigned long,
>>>>>> unsigned long>, std::__1::__value_type<std::__1::pair<unsigned long,
>>>>>> unsigned long>, std::__1::pair<unsigned int, unsigned int> >,
>>>>>> std::__1::less<std::__1::pair<unsigned long, unsigned long> >, true>> =
>>>>>> {<std::__1::less<std::__1::pair<unsigned long, unsigned long> >> =
>>>>>> {<std::__1::binary_function<std::__1::pair<unsigned long, unsigned
>>>>>> long>, std::__1::pair<unsigned long, unsigned long>, bool>> = {<No data
>>>>>> fields>}, <No data fields>}, <No data fields>},
>>>>>>           __first_ = 0}, <No data fields>}}}}
>>>>>>
>>>>>> (gdb) disassemble
>>>>>> Dump of assembler code for function denc_traits<unsigned long,
>>>>>> void>::encode(unsigned long const&,
>>>>>> ceph::buffer::list::contiguous_appender&, unsigned long):
>>>>>>    0x000000000049aaf0 <+0>:     push   %rbp
>>>>>>    0x000000000049aaf1 <+1>:     mov    %rsp,%rbp
>>>>>>    0x000000000049aaf4 <+4>:     sub    $0x20,%rsp
>>>>>>    0x000000000049aaf8 <+8>:     mov    $0x8,%eax
>>>>>>    0x000000000049aafd <+13>:    mov    %eax,%ecx
>>>>>>    0x000000000049aaff <+15>:    mov    %rdi,-0x8(%rbp)
>>>>>>    0x000000000049ab03 <+19>:    mov    %rsi,-0x10(%rbp)
>>>>>>    0x000000000049ab07 <+23>:    mov    %rdx,-0x18(%rbp)
>>>>>>    0x000000000049ab0b <+27>:    mov    -0x8(%rbp),%rdx
>>>>>>    0x000000000049ab0f <+31>:    mov    (%rdx),%rdx
>>>>>>    0x000000000049ab12 <+34>:    mov    -0x10(%rbp),%rdi
>>>>>>    0x000000000049ab16 <+38>:    mov    %rcx,%rsi
>>>>>>    0x000000000049ab19 <+41>:    mov    %rdx,-0x20(%rbp)
>>>>>>    0x000000000049ab1d <+45>:    callq  0x49a1d0
>>>>>> <ceph::buffer::list::contiguous_appender::get_pos_add(unsigned long)>
>>>>>>    0x000000000049ab22 <+50>:    mov    -0x20(%rbp),%rcx
>>>>>>    0x000000000049ab26 <+54>:    mov    %rcx,(%rax)
>>>>>> => 0x000000000049ab29 <+57>:    add    $0x20,%rsp
>>>>>>    0x000000000049ab2d <+61>:    pop    %rbp
>>>>>>    0x000000000049ab2e <+62>:    retq
>>>>>> End of assembler dump.
>>>>>>
>>>>>> (gdb) info registers
>>>>>> rax            0x1054047        17121351
>>>>>> rbx            0x0      0
>>>>>> rcx            0x7b     123
>>>>>> rdx            0x7b     123
>>>>>> rsi            0x7fffffffd948   140737488345416
>>>>>> rdi            0x105404f        17121359
>>>>>> rbp            0x7fffffffd4f0   0x7fffffffd4f0
>>>>>> rsp            0x7fffffffd4d0   0x7fffffffd4d0
>>>>>> r8             0x0      0
>>>>>> r9             0x0      0
>>>>>> r10            0x0      0
>>>>>> r11            0x829100 8556800
>>>>>> r12            0x7fffffffe910   140737488349456
>>>>>> r13            0x7fffffffe928   140737488349480
>>>>>> r14            0x7fffffffe918   140737488349464
>>>>>> r15            0x1      1
>>>>>> rip            0x49ab29 0x49ab29 <denc_traits<unsigned long,
>>>>>> void>::encode(unsigned long const&,
>>>>>> ceph::buffer::list::contiguous_appender&, unsigned long)+57>
>>>>>>
>>>>>> And this is wierd:
>>>>>> 	%rax contains  0x1054047
>>>>>> 	_raw is  0x1054048
>>>>>>
>>>>>> So writing %rcx to (%rax) is definitly going to overwrite the larger
>>>>>> part of _raw.
>>>>>>
>>>>>> So now the question transforms into:
>>>>>>     Why does %rax hold this wierd value ??
>>>>>>     or Why does get_pos_add(sizeof(etype)) a negative offset ??
>>>>>>
>>>>>> Got to go and do real dayjob work.
>>>>>>
>>>>>> --WjW
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

