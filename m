From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Bluestore crash in mkfs
Date: Sat, 18 Jun 2016 07:59:29 +1000
Message-ID: <CAF-wwdFRXi3VM9r1r9jynV+KqBXDwZiYoZp3ZF-Ytuz+ah6Ogg@mail.gmail.com>
References: <BL2PR02MB21151DAE1DAF64B6CC74D01FF45A0@BL2PR02MB2115.namprd02.prod.outlook.com>
	<CAB=cV2Tp9ASRHxLSw5H3K=4PbrxrFkF4sARsfDRxDVqJpQ8ZHg@mail.gmail.com>
	<BL2PR02MB2115840732283AC0927974AEF45A0@BL2PR02MB2115.namprd02.prod.outlook.com>
	<alpine.DEB.2.11.1606042235220.6221@cpach.fuggernut.com>
	<A1E209ED-AE9D-4C72-AFA9-B80AF9CDA280@sandisk.com>
	<6545776f-0836-3199-c6f7-4625113f5d75@redhat.com>
	<BL2PR02MB2115B14E1C58431AF24E7697F45C0@BL2PR02MB2115.namprd02.prod.outlook.com>
	<88b672a8-ac9c-65d3-26ea-a1dfc56a866f@redhat.com>
	<52c1284f-54ee-af60-42f5-c89c5208dd19@redhat.com>
	<CAF-wwdHALUBccGokgNUG4dWtamMLVV8Q-CmaAW5eV_jmwvVx_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38465 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964777AbcFQV7b convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jun 2016 17:59:31 -0400
Received: by mail-wm0-f42.google.com with SMTP id m124so5148701wme.1
        for <ceph-devel@vger.kernel.org>; Fri, 17 Jun 2016 14:59:30 -0700 (PDT)
In-Reply-To: <CAF-wwdHALUBccGokgNUG4dWtamMLVV8Q-CmaAW5eV_jmwvVx_g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@newdream.net>, Jianjian Huo <samuel.huo@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jun 15, 2016 at 8:10 PM, Brad Hubbard <bhubbard@redhat.com> wro=
te:
> Sorry to those that recieve this twice but the initial message bounce=
d
> from the list because some HTML slipped in (thanks Google!).
>
> On Tue, Jun 7, 2016 at 1:32 PM, Mark Nelson <mnelson@redhat.com> wrot=
e:
>>
>> After running a bisect I'm semi-confident that this was a result of =
the rocksdb pull up to latest master in #9466:
>>
>> https://github.com/ceph/ceph/commit/f485596dd0656b01ba130b4e5040fcd4=
c02d1a31
>
>
> I'm hitting something very similar while running unittest_rocksdb_opt=
ion_static.

Embarassingly and frustratingly this turned out to be an affect of
some artifact in the rocksdb
subdirectory. After running a make clean in that directory the
segfault disappeared.

Sorry for the noise,
Brad

>
> (gdb) bt
> #0  __atomic_add_dispatch (__val=3D1, __mem=3D0x7ffff5f774d5 <operato=
r
> new(unsigned long)+37>) at /usr/include/c++/4.8.3/ext/atomicity.h:96
> #1  _M_add_ref_copy (this=3D0x7ffff5f774cd <operator new(unsigned
> long)+29>) at /usr/include/c++/4.8.3/bits/shared_ptr_base.h:131
> #2  __shared_count (__r=3D..., this=3D0x7fffffffd180) at
> /usr/include/c++/4.8.3/bits/shared_ptr_base.h:553
> #3  __shared_ptr (this=3D0x7fffffffd178) at
> /usr/include/c++/4.8.3/bits/shared_ptr_base.h:779
> #4  shared_ptr (this=3D0x7fffffffd178) at
> /usr/include/c++/4.8.3/bits/shared_ptr.h:103
> #5  rocksdb::ColumnFamilyOptions::ColumnFamilyOptions
> (this=3D0x7fffffffd170, options=3D...) at util/options.cc:201
> #6  0x0000555555804c6a in rocksdb::GetOptionsFromString
> (base_options=3D..., opts_str=3D"compression=3DkNoCompression",
> new_options=3Dnew_options@entry=3D0x7fffffffdad0) at
> util/options_helper.cc:1327
> #7  0x0000555555734b19 in RocksDBStore::ParseOptionsFromString
> (this=3D0x55555deefa40, opt_str=3D..., opt=3D...) at kv/RocksDBStore.=
cc:188
> #8  0x000055555572b361 in RocksDBOption_simple_Test::TestBody
> (this=3D<optimized out>) at
> test/objectstore/TestRocksdbOptionParse.cc:31
> #9  0x0000555555874b14 in
> testing::internal::HandleSehExceptionsInMethodIfSupported<testing::Te=
st,
> void> (object=3D0x55555deee060, method=3D&virtual
> testing::Test::TestBody(), location=3D0x55555596c7db "the test body")=
 at
> ./src/gtest.cc:2078
> #10 0x000055555586fc16 in
> testing::internal::HandleExceptionsInMethodIfSupported<testing::Test,
> void> (object=3D0x55555deee060, method=3D&virtual
> testing::Test::TestBody(), location=3D0x55555596c7db "the test body")=
 at
> ./src/gtest.cc:2114
> #11 0x000055555585688f in testing::Test::Run (this=3D0x55555deee060) =
at
> ./src/gtest.cc:2151
> #12 0x0000555555857088 in testing::TestInfo::Run (this=3D0x55555de581=
e0)
> at ./src/gtest.cc:2326
> #13 0x000055555585774c in testing::TestCase::Run (this=3D0x55555de586=
00)
> at ./src/gtest.cc:2444
> #14 0x000055555585e214 in testing::internal::UnitTestImpl::RunAllTest=
s
> (this=3D0x55555de582a0) at ./src/gtest.cc:4315
> #15 0x0000555555875efa in
> testing::internal::HandleSehExceptionsInMethodIfSupported<testing::in=
ternal::UnitTestImpl,
> bool> (object=3D0x55555de582a0,
>     method=3D(bool
> (testing::internal::UnitTestImpl::*)(testing::internal::UnitTestImpl =
*
> const)) 0x55555585df7c
> <testing::internal::UnitTestImpl::RunAllTests()>,
>     location=3D0x55555596d030 "auxiliary test code (environments or
> event listeners)") at ./src/gtest.cc:2078
> #16 0x0000555555870a70 in
> testing::internal::HandleExceptionsInMethodIfSupported<testing::inter=
nal::UnitTestImpl,
> bool> (object=3D0x55555de582a0,
>     method=3D(bool
> (testing::internal::UnitTestImpl::*)(testing::internal::UnitTestImpl =
*
> const)) 0x55555585df7c
> <testing::internal::UnitTestImpl::RunAllTests()>,
>     location=3D0x55555596d030 "auxiliary test code (environments or
> event listeners)") at ./src/gtest.cc:2114
> #17 0x000055555585cde4 in testing::UnitTest::Run (this=3D0x555555c569=
a0
> <testing::UnitTest::GetInstance()::instance>) at ./src/gtest.cc:3929
> #18 0x00005555556e86c6 in RUN_ALL_TESTS () at
> ../src/gmock/gtest/include/gtest/gtest.h:2288
> #19 main (argc=3D1, argv=3D0x7fffffffe308) at
> test/objectstore/TestRocksdbOptionParse.cc:84
> (gdb) f 5
> #5  rocksdb::ColumnFamilyOptions::ColumnFamilyOptions
> (this=3D0x7fffffffd170, options=3D...) at util/options.cc:201
> 201           paranoid_file_checks(options.paranoid_file_checks),
>
> That line is part of the initialiser list for the ColumnFamilyOptions
> struct which has changed rescently according to git blame.
>
> (gdb) up
> #6  0x0000555555804c6a in rocksdb::GetOptionsFromString
> (base_options=3D..., opts_str=3D"compression=3DkNoCompression",
> new_options=3Dnew_options@entry=3D0x7fffffffdad0) at
> util/options_helper.cc:1327
> 1327    }
> (gdb) l
> 1322      Status s =3D StringToMap(opts_str, &opts_map);
> 1323      if (!s.ok()) {
> 1324        return s;
> 1325      }
> 1326      return GetColumnFamilyOptionsFromMap(base_options, opts_map=
,
> new_options);
> 1327    }
>
> I believe this is related to base_options and new_options which are
> the same object of type rocksdb::Options.
>
> Valgrind has this to say.
>
> =3D=3D26974=3D=3D Conditional jump or move depends on uninitialised v=
alue(s)
> =3D=3D26974=3D=3D    at 0x3B09A6:
> rocksdb::ColumnFamilyOptions::ColumnFamilyOptions(rocksdb::Options
> const&) (shared_ptr_base.h:552)
> =3D=3D26974=3D=3D    by 0x3B8C69:
> rocksdb::GetOptionsFromString(rocksdb::Options const&, std::string
> const&, rocksdb::Options*) (options_helper.cc:1327)
> =3D=3D26974=3D=3D    by 0x2E8B18:
> RocksDBStore::ParseOptionsFromString(std::string, rocksdb::Options&)
> (RocksDBStore.cc:188)
> =3D=3D26974=3D=3D    by 0x2DF360: RocksDBOption_simple_Test::TestBody=
()
> (TestRocksdbOptionParse.cc:31)
> =3D=3D26974=3D=3D    by 0x428B13: void
> testing::internal::HandleSehExceptionsInMethodIfSupported<testing::Te=
st,
> void>(testing::Test*, void (testing::Test::*)(), char const*)
> (gtest.cc:2078)
> =3D=3D26974=3D=3D    by 0x423C15: void
> testing::internal::HandleExceptionsInMethodIfSupported<testing::Test,
> void>(testing::Test*, void (testing::Test::*)(), char const*)
> (gtest.cc:2114)
> =3D=3D26974=3D=3D    by 0x40A88E: testing::Test::Run() (gtest.cc:2151=
)
> =3D=3D26974=3D=3D    by 0x40B087: testing::TestInfo::Run() (gtest.cc:=
2326)
> =3D=3D26974=3D=3D    by 0x40B74B: testing::TestCase::Run() (gtest.cc:=
2444)
> =3D=3D26974=3D=3D    by 0x412213:
> testing::internal::UnitTestImpl::RunAllTests() (gtest.cc:4315)
> =3D=3D26974=3D=3D    by 0x429EF9: bool
> testing::internal::HandleSehExceptionsInMethodIfSupported<testing::in=
ternal::UnitTestImpl,
> bool>(testing::internal::UnitTestImpl*, bool
> (testing::internal::UnitTestImpl::*)(), char const*) (gtest.cc:2078)
> =3D=3D26974=3D=3D    by 0x424A6F: bool
> testing::internal::HandleExceptionsInMethodIfSupported<testing::inter=
nal::UnitTestImpl,
> bool>(testing::internal::UnitTestImpl*, bool
> (testing::internal::UnitTestImpl::*)(), char const*) (gtest.cc:2114)
> =3D=3D26974=3D=3D    by 0x410DE3: testing::UnitTest::Run() (gtest.cc:=
3929)
> =3D=3D26974=3D=3D    by 0x29C6C5: main (gtest.h:2288)
> =3D=3D26974=3D=3D  Uninitialised value was created by a stack allocat=
ion
> =3D=3D26974=3D=3D    at 0x2DF1AC: RocksDBOption_simple_Test::TestBody=
() (options.h:1350)
>
> That's this line.
>
> 1347 // Options to control the behavior of a database (passed to DB::=
Open)
> 1348 struct Options : public DBOptions, public ColumnFamilyOptions {
> 1349   // Create an Options object with default values for all fields=
=2E
> 1350   Options() : DBOptions(), ColumnFamilyOptions() {}
> <----------- HERE
>
> It then gives two more errors before the crash.
>
> =3D=3D26974=3D=3D Invalid read of size 8
> =3D=3D26974=3D=3D    at 0x94162B2: memcpy@GLIBC_2.2.5 (in
> /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D26974=3D=3D    by 0x3B0A99:
> rocksdb::ColumnFamilyOptions::ColumnFamilyOptions(rocksdb::Options
> const&) (stl_algobase.h:372)
> =3D=3D26974=3D=3D    by 0x3B8C69:
> rocksdb::GetOptionsFromString(rocksdb::Options const&, std::string
> const&, rocksdb::Options*) (options_helper.cc:1327)
> =3D=3D26974=3D=3D    by 0x2E8B18:
> RocksDBStore::ParseOptionsFromString(std::string, rocksdb::Options&)
> (RocksDBStore.cc:188)
> =3D=3D26974=3D=3D    by 0x2DF360: RocksDBOption_simple_Test::TestBody=
()
> (TestRocksdbOptionParse.cc:31)
> =3D=3D26974=3D=3D    by 0x428B13: void
> testing::internal::HandleSehExceptionsInMethodIfSupported<testing::Te=
st,
> void>(testing::Test*, void (testing::Test::*)(), char const*)
> (gtest.cc:2078)
> =3D=3D26974=3D=3D    by 0x423C15: void
> testing::internal::HandleExceptionsInMethodIfSupported<testing::Test,
> void>(testing::Test*, void (testing::Test::*)(), char const*)
> (gtest.cc:2114)
> =3D=3D26974=3D=3D    by 0x40A88E: testing::Test::Run() (gtest.cc:2151=
)
> =3D=3D26974=3D=3D    by 0x40B087: testing::TestInfo::Run() (gtest.cc:=
2326)
> =3D=3D26974=3D=3D    by 0x40B74B: testing::TestCase::Run() (gtest.cc:=
2444)
> =3D=3D26974=3D=3D    by 0x412213:
> testing::internal::UnitTestImpl::RunAllTests() (gtest.cc:4315)
> =3D=3D26974=3D=3D    by 0x429EF9: bool
> testing::internal::HandleSehExceptionsInMethodIfSupported<testing::in=
ternal::UnitTestImpl,
> bool>(testing::internal::UnitTestImpl*, bool
> (testing::internal::UnitTestImpl::*)(), char const*) (gtest.cc:2078)
> =3D=3D26974=3D=3D    by 0x424A6F: bool
> testing::internal::HandleExceptionsInMethodIfSupported<testing::inter=
nal::UnitTestImpl,
> bool>(testing::internal::UnitTestImpl*, bool
> (testing::internal::UnitTestImpl::*)(), char const*) (gtest.cc:2114)
> =3D=3D26974=3D=3D    by 0x410DE3: testing::UnitTest::Run() (gtest.cc:=
3929)
> =3D=3D26974=3D=3D    by 0x29C6C5: main (gtest.h:2288)
> =3D=3D26974=3D=3D  Address 0x39fe1038 is 8 bytes before a block of si=
ze
> 4,290,772,994 alloc'd
> =3D=3D26974=3D=3D    at 0x9412965: operator new(unsigned long) (in
> /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D26974=3D=3D    by 0x3B0FD7:
> rocksdb::ColumnFamilyOptions::ColumnFamilyOptions(rocksdb::Options
> const&) (new_allocator.h:104)
> =3D=3D26974=3D=3D    by 0x3B8C69:
> rocksdb::GetOptionsFromString(rocksdb::Options const&, std::string
> const&, rocksdb::Options*) (options_helper.cc:1327)
> =3D=3D26974=3D=3D    by 0x2E8B18:
> RocksDBStore::ParseOptionsFromString(std::string, rocksdb::Options&)
> (RocksDBStore.cc:188)
> =3D=3D26974=3D=3D    by 0x2DF360: RocksDBOption_simple_Test::TestBody=
()
> (TestRocksdbOptionParse.cc:31)
> =3D=3D26974=3D=3D    by 0x428B13: void
> testing::internal::HandleSehExceptionsInMethodIfSupported<testing::Te=
st,
> void>(testing::Test*, void (testing::Test::*)(), char const*)
> (gtest.cc:2078)
> =3D=3D26974=3D=3D    by 0x423C15: void
> testing::internal::HandleExceptionsInMethodIfSupported<testing::Test,
> void>(testing::Test*, void (testing::Test::*)(), char const*)
> (gtest.cc:2114)
> =3D=3D26974=3D=3D    by 0x40A88E: testing::Test::Run() (gtest.cc:2151=
)
> =3D=3D26974=3D=3D    by 0x40B087: testing::TestInfo::Run() (gtest.cc:=
2326)
> =3D=3D26974=3D=3D    by 0x40B74B: testing::TestCase::Run() (gtest.cc:=
2444)
> =3D=3D26974=3D=3D    by 0x412213:
> testing::internal::UnitTestImpl::RunAllTests() (gtest.cc:4315)
> =3D=3D26974=3D=3D    by 0x429EF9: bool
> testing::internal::HandleSehExceptionsInMethodIfSupported<testing::in=
ternal::UnitTestImpl,
> bool>(testing::internal::UnitTestImpl*, bool
> (testing::internal::UnitTestImpl::*)(), char const*) (gtest.cc:2078)
> =3D=3D26974=3D=3D    by 0x424A6F: bool
> testing::internal::HandleExceptionsInMethodIfSupported<testing::inter=
nal::UnitTestImpl,
> bool>(testing::internal::UnitTestImpl*, bool
> (testing::internal::UnitTestImpl::*)(), char const*) (gtest.cc:2114)
> =3D=3D26974=3D=3D    by 0x410DE3: testing::UnitTest::Run() (gtest.cc:=
3929)
> =3D=3D26974=3D=3D    by 0x29C6C5: main (gtest.h:2288)
>
> =3D=3D26974=3D=3D Invalid read of size 8
> =3D=3D26974=3D=3D    at 0x94162A0: memcpy@GLIBC_2.2.5 (in
> /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D26974=3D=3D    by 0x3B0A99:
> rocksdb::ColumnFamilyOptions::ColumnFamilyOptions(rocksdb::Options
> const&) (stl_algobase.h:372)
> =3D=3D26974=3D=3D    by 0x3B8C69:
> rocksdb::GetOptionsFromString(rocksdb::Options const&, std::string
> const&, rocksdb::Options*) (options_helper.cc:1327)
> =3D=3D26974=3D=3D    by 0x2E8B18:
> RocksDBStore::ParseOptionsFromString(std::string, rocksdb::Options&)
> (RocksDBStore.cc:188)
> =3D=3D26974=3D=3D    by 0x2DF360: RocksDBOption_simple_Test::TestBody=
()
> (TestRocksdbOptionParse.cc:31)
> =3D=3D26974=3D=3D    by 0x428B13: void
> testing::internal::HandleSehExceptionsInMethodIfSupported<testing::Te=
st,
> void>(testing::Test*, void (testing::Test::*)(), char const*)
> (gtest.cc:2078)
> =3D=3D26974=3D=3D    by 0x423C15: void
> testing::internal::HandleExceptionsInMethodIfSupported<testing::Test,
> void>(testing::Test*, void (testing::Test::*)(), char const*)
> (gtest.cc:2114)
> =3D=3D26974=3D=3D    by 0x40A88E: testing::Test::Run() (gtest.cc:2151=
)
> =3D=3D26974=3D=3D    by 0x40B087: testing::TestInfo::Run() (gtest.cc:=
2326)
> =3D=3D26974=3D=3D    by 0x40B74B: testing::TestCase::Run() (gtest.cc:=
2444)
> =3D=3D26974=3D=3D    by 0x412213:
> testing::internal::UnitTestImpl::RunAllTests() (gtest.cc:4315)
> =3D=3D26974=3D=3D    by 0x429EF9: bool
> testing::internal::HandleSehExceptionsInMethodIfSupported<testing::in=
ternal::UnitTestImpl,
> bool>(testing::internal::UnitTestImpl*, bool
> (testing::internal::UnitTestImpl::*)(), char const*) (gtest.cc:2078)
> =3D=3D26974=3D=3D    by 0x424A6F: bool
> testing::internal::HandleExceptionsInMethodIfSupported<testing::inter=
nal::UnitTestImpl,
> bool>(testing::internal::UnitTestImpl*, bool
> (testing::internal::UnitTestImpl::*)(), char const*) (gtest.cc:2114)
> =3D=3D26974=3D=3D    by 0x410DE3: testing::UnitTest::Run() (gtest.cc:=
3929)
> =3D=3D26974=3D=3D    by 0x29C6C5: main (gtest.h:2288)
> =3D=3D26974=3D=3D  Address 0x39fe1030 is 16 bytes before a block of s=
ize
> 4,290,772,994 alloc'd
> =3D=3D26974=3D=3D    at 0x9412965: operator new(unsigned long) (in
> /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D26974=3D=3D    by 0x3B0FD7:
> rocksdb::ColumnFamilyOptions::ColumnFamilyOptions(rocksdb::Options
> const&) (new_allocator.h:104)
> =3D=3D26974=3D=3D    by 0x3B8C69:
> rocksdb::GetOptionsFromString(rocksdb::Options const&, std::string
> const&, rocksdb::Options*) (options_helper.cc:1327)
> =3D=3D26974=3D=3D    by 0x2E8B18:
> RocksDBStore::ParseOptionsFromString(std::string, rocksdb::Options&)
> (RocksDBStore.cc:188)
> =3D=3D26974=3D=3D    by 0x2DF360: RocksDBOption_simple_Test::TestBody=
()
> (TestRocksdbOptionParse.cc:31)
> =3D=3D26974=3D=3D    by 0x428B13: void
> testing::internal::HandleSehExceptionsInMethodIfSupported<testing::Te=
st,
> void>(testing::Test*, void (testing::Test::*)(), char const*)
> (gtest.cc:2078)
> =3D=3D26974=3D=3D    by 0x423C15: void
> testing::internal::HandleExceptionsInMethodIfSupported<testing::Test,
> void>(testing::Test*, void (testing::Test::*)(), char const*)
> (gtest.cc:2114)
> =3D=3D26974=3D=3D    by 0x40A88E: testing::Test::Run() (gtest.cc:2151=
)
> =3D=3D26974=3D=3D    by 0x40B087: testing::TestInfo::Run() (gtest.cc:=
2326)
> =3D=3D26974=3D=3D    by 0x40B74B: testing::TestCase::Run() (gtest.cc:=
2444)
> =3D=3D26974=3D=3D    by 0x412213:
> testing::internal::UnitTestImpl::RunAllTests() (gtest.cc:4315)
> =3D=3D26974=3D=3D    by 0x429EF9: bool
> testing::internal::HandleSehExceptionsInMethodIfSupported<testing::in=
ternal::UnitTestImpl,
> bool>(testing::internal::UnitTestImpl*, bool
> (testing::internal::UnitTestImpl::*)(), char const*) (gtest.cc:2078)
> =3D=3D26974=3D=3D    by 0x424A6F: bool
> testing::internal::HandleExceptionsInMethodIfSupported<testing::inter=
nal::UnitTestImpl,
> bool>(testing::internal::UnitTestImpl*, bool
> (testing::internal::UnitTestImpl::*)(), char const*) (gtest.cc:2114)
> =3D=3D26974=3D=3D    by 0x410DE3: testing::UnitTest::Run() (gtest.cc:=
3929)
> =3D=3D26974=3D=3D    by 0x29C6C5: main (gtest.h:2288)
>
> Note, for what it's worth, that we've done two reads of size 8 at 8
> and 16 bytes before a valid block respectively.
>
> The last line that is not in teh STL is the line we eventually crash =
on.
>
> 1317 Status GetColumnFamilyOptionsFromString(
> 1318     const ColumnFamilyOptions& base_options,
> 1319     const std::string& opts_str,
> 1320     ColumnFamilyOptions* new_options) {
> 1321   std::unordered_map<std::string, std::string> opts_map;
> 1322   Status s =3D StringToMap(opts_str, &opts_map);
> 1323   if (!s.ok()) {
> 1324     return s;
> 1325   }
> 1326   return GetColumnFamilyOptionsFromMap(base_options, opts_map,
> new_options);
> 1327 }
>
> I think this has something to do with the changes in the
> ColumnFamilyOptions struct and the fact that there is a conversion
> happening from an Options object to a ColumnFamilyOptions object.
>
> That's the feeling I get from poking around in this for a while but I
> can't nail exactly what's happening here and, of course, I could very
> well be wrong.
>
> HTH,
> Brad
>
>>
>>
>>
>> Next need to track down the commit in rocksdb.
>>
>> Mark
>>
>>
>> On 06/06/2016 06:53 PM, Mark Nelson wrote:
>>>
>>> Looks like memory is being corrupted.  One example:
>>>
>>> (gdb) info locals
>>>
>>> <snip>
>>> max_bytes_for_level_multiplier_additional =3D std::vector of length
>>> 35181114486204, capacity -33 =3D {<error reading variable>
>>>
>>> Running through valgrind now to see if I can track it down.
>>>
>>> Mark
>>>
>>> On 06/06/2016 11:38 AM, Somnath Roy wrote:
>>>>
>>>> Thanks Mark for confirming this !
>>>> May be we pulled latest rocksdb that are causing some incompatibil=
ity
>>>> on option parsing ?
>>>>
>>>> Regards
>>>> Somnath
>>>>
>>>> -----Original Message-----
>>>> From: Mark Nelson [mailto:mnelson@redhat.com]
>>>> Sent: Monday, June 06, 2016 9:35 AM
>>>> To: Somnath Roy; Sage Weil
>>>> Cc: Jianjian Huo; ceph-devel
>>>> Subject: Re: Bluestore crash in mkfs
>>>>
>>>> I'm hitting this after upgrading to master.  Probably something th=
at
>>>> got merged on the 2nd or 3rd.  I'll see if I can track it down.
>>>>
>>>> Mark
>>>>
>>>> On 06/04/2016 09:41 PM, Somnath Roy wrote:
>>>>>
>>>>> Here is the steps I did..
>>>>> 1. Git pull
>>>>> 2. Make clean
>>>>> 3. Do_autogen -j o3
>>>>> 4. Make install
>>>>> 5. Mkcephfs to install, I still prefer it
>>>>>
>>>>> I will debug more and update
>>>>>
>>>>> Thanks & Regards
>>>>> Somnath
>>>>>
>>>>> Sent from my iPhone
>>>>>
>>>>>> On Jun 4, 2016, at 7:35 PM, Sage Weil <sage@newdream.net> wrote:
>>>>>>
>>>>>>> On Sat, 4 Jun 2016, Somnath Roy wrote:
>>>>>>> Same conf file worked for me sometimes back. I think db path/wa=
l
>>>>>>> path is optional and if you don't mention anything, it will coe=
xist
>>>>>>> on the block partition.
>>>>>>> Not sure if this is something changed recently though..
>>>>>>> The trace is also not complaining about db path , it is getting=
 a
>>>>>>> seg fault while parsing rocksdb option.
>>>>>>
>>>>>>
>>>>>> Hmm, I haven't seen this.
>>>>>>
>>>>>> Note that you don't need 'devs'.  And you're right that just
>>>>>> specifying the block path is enough.  If you're doing a manual b=
uild,
>>>>>> is it possible you're dynamically linking rocksdb or something?
>>>>>>
>>>>>> sage
>>>>>>
>>>>>>>
>>>>>>> Thanks & Regards
>>>>>>> Somnath
>>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Jianjian Huo [mailto:samuel.huo@gmail.com]
>>>>>>> Sent: Friday, June 03, 2016 9:29 PM
>>>>>>> To: Somnath Roy
>>>>>>> Cc: Sage Weil (sage@newdream.net); ceph-devel
>>>>>>> Subject: Re: Bluestore crash in mkfs
>>>>>>>
>>>>>>>> On Fri, Jun 3, 2016 at 7:16 PM, Somnath Roy
>>>>>>>> <Somnath.Roy@sandisk.com> wrote:
>>>>>>>> Sage,
>>>>>>>> Latest code in Bluestore is crashing on me during mkfs. Here i=
s
>>>>>>>> the dump.
>>>>>>>>
>>>>>>>> ceph version 10.2.0-1809-gac8c40f
>>>>>>>> (ac8c40f3e3257517f71d2af8bd26dcd264887b7f)
>>>>>>>> 1: (()+0x99e65e) [0x55cf5263565e]
>>>>>>>> 2: (()+0x113d0) [0x7f323526f3d0]
>>>>>>>> 3:
>>>>>>>> (rocksdb::ColumnFamilyOptions::ColumnFamilyOptions(rocksdb::Op=
tions
>>>>>>>> const&)+0x59) [0x55cf525d4ce9]
>>>>>>>> 4: (rocksdb::GetOptionsFromString(rocksdb::Options const&,
>>>>>>>> std::__cxx11::basic_string<char, std::char_traits<char>,
>>>>>>>> std::allocator<char> > const&, rocksdb::Options*)+0x15a)
>>>>>>>> [0x55cf525dc74a]
>>>>>>>> 5:
>>>>>>>> (RocksDBStore::ParseOptionsFromString(std::__cxx11::basic_stri=
ng<ch
>>>>>>>> ar, std::char_traits<char>, std::allocator<char> >,
>>>>>>>> rocksdb::Options&)+0x22e) [0x55cf524f58be]
>>>>>>>> 6: (RocksDBStore::init(std::__cxx11::basic_string<char,
>>>>>>>> std::char_traits<char>, std::allocator<char> >)+0x77)
>>>>>>>> [0x55cf524f5f17]
>>>>>>>> 7: (BlueStore::_open_db(bool)+0x274) [0x55cf5234b9e4]
>>>>>>>> 8: (BlueStore::mkfs()+0x899) [0x55cf52361ad9]
>>>>>>>> 9: (OSD::mkfs(CephContext*, ObjectStore*,
>>>>>>>> std::__cxx11::basic_string<char, std::char_traits<char>,
>>>>>>>> std::allocator<char> > const&, uuid_d, int)+0x117) [0x55cf5200=
1427]
>>>>>>>> 10: (main()+0x1003) [0x55cf51f9f2e3]
>>>>>>>> 11: (__libc_start_main()+0xf0) [0x7f32331fa830]
>>>>>>>> 12: (_start()+0x29) [0x55cf51fe2719]
>>>>>>>> NOTE: a copy of the executable, or `objdump -rdS <executable>`=
 is
>>>>>>>> needed to interpret this.
>>>>>>>>
>>>>>>>>
>>>>>>>> I am using the following option :
>>>>>>>>
>>>>>>>>       devs =3D /dev/sdb1
>>>>>>>>       bluestore_block_path =3D /dev/sdb2
>>>>>>>>
>>>>>>>> Am I missing anything ?
>>>>>>>
>>>>>>>
>>>>>>> This is what Mark posted last time, you forgot db path?
>>>>>>> https://github.com/ceph/cbt/blob/master/example/bluestore/ceph.=
conf.
>>>>>>> bluestore_example
>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks & Regards
>>>>>>>> Somnath
>>>>>>>> PLEASE NOTE: The information contained in this electronic mail
>>>>>>>> message is intended only for the use of the designated
>>>>>>>> recipient(s) named above. If the reader of this message is not=
 the
>>>>>>>> intended recipient, you are hereby notified that you have rece=
ived
>>>>>>>> this message in error and that any review, dissemination,
>>>>>>>> distribution, or copying of this message is strictly prohibite=
d.
>>>>>>>> If you have received this communication in error, please notif=
y
>>>>>>>> the sender by telephone or e-mail (as shown above) immediately=
 and
>>>>>>>> destroy any and all copies of this message in your possession
>>>>>>>> (whether hard copies or electronically stored copies).
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph=
-devel"
>>>>>>>> in the body of a message to majordomo@vger.kernel.org More
>>>>>>>> majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>
>>>>>>> N?????r??y??????X??=C7=A7v???)=DE=BA{.n?????z?]z????ay? =CA=87=DA=
=99??j ??f???h?????
>>>>>>> ?w??? ???j:+v???w???????? ????zZ+???????j"????i
>>>>>
>>>>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay  =CA=87=DA=99=
 ,j   f   h   z   w
>>>>
>>>>    j:+v   w j m         zZ+     =DD=A2j"  !tml=3D
>>>>>
>>>>>
>>>> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=
=EF=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD=
^=EF=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=
=BF=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD =CA=87=DA=99=EF=BF=BD,j =EF=BF=BD=EF=
=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=
 =EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=
=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
>
> --
> Cheers,
> Brad



--=20
Cheers,
Brad
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
