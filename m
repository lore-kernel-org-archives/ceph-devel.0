From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: An empty vptr in an raw object
Date: Thu, 22 Dec 2016 20:44:43 +0100
Message-ID: <bfe430e9-eee1-9a6a-7878-b87c7853021f@digiware.nl>
References: <4aeb9ff1-367c-f31e-fc0c-5f08dcdcfe0e@digiware.nl>
 <7754eadf-5f8c-ade3-1634-486fff240adf@digiware.nl>
 <EB02EE10422E4A40A1EE787A4AC27FBE044D2A@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <e1bdab0b-ec02-819e-e6fe-4e07baa235be@digiware.nl>
 <alpine.DEB.2.11.1612221840330.10615@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:12463 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1766015AbcLVTow (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Dec 2016 14:44:52 -0500
In-Reply-To: <alpine.DEB.2.11.1612221840330.10615@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 22-12-2016 19:41, Sage Weil wrote:
> Oh.. if unittest_desc is the only culprit, it is probably easier to find.  
> Which test case fails?  Do you have a full backtrace?

Yes,
that was my idea as well. Could even try it without gtest stuff, but in
a main(). And reduce the number of threads.

I is also only in the maps test:
TEST(denc, map)
{
  {
    cout << "map<string,foo_t>" << std::endl;
    std::map<string,foo_t> s;
    s["foo"] = foo_t();
    s["bar"] = foo_t();
    s["baz"] = foo_t();
    test_denc(s);
  }
}

The backtrace is: (sorry for all the wrapping in 78chars)

#0  0x0000000804b9d16a in thr_kill () from /lib/libc.so.7
#1  0x0000000804b9d13b in __raise (s=6) at
/usr/srcs/head/src/lib/libc/gen/raise.c:52
#2  0x0000000804b9d0a9 in abort () at
/usr/srcs/head/src/lib/libc/stdlib/abort.c:65
#3  0x000000000052a3d6 in ceph::__ceph_assert_fail (assertion=0x5d3f52
"*((int*)*(&_raw))",
    file=0x5d3efb "/usr/srcs/Ceph/work/ceph/src/include/buffer.h", line=258,
    func=0x5d3f29 "bool ceph::buffer::ptr::have_raw() const") at
/usr/srcs/Ceph/work/ceph/src/common/assert.cc:78
#4  0x000000000049abc6 in ceph::buffer::ptr::have_raw (this=0x7fffffffd958)
    at /usr/srcs/Ceph/work/ceph/src/include/buffer.h:258
#5  0x00000000004945af in
ceph::buffer::list::contiguous_appender::~contiguous_appender
(this=0x7fffffffd948)
    at /usr/srcs/Ceph/work/ceph/src/include/buffer.h:525
#6  0x0000000000490fc2 in
test_denc<std::__1::map<std::__1::basic_string<char,
std::__1::char_traits<char>, std::__1::allocator<char> >, foo_t,
std::__1::less<std::__1::basic_string<char, std::__1::char_traits<char>,
std::__1::allocator<char> > >,
std::__1::allocator<std::__1::pair<std::__1::basic_string<char,
std::__1::char_traits<char>, std::__1::allocator<char> > const, foo_t> >
> > (v=...) at /usr/srcs/Ceph/work/ceph/src/test/test_denc.cc:50
#7  0x00000000004904e0 in denc_map_Test::TestBody (this=0x1038030) at
/usr/srcs/Ceph/work/ceph/src/test/test_denc.cc:206
#8  0x000000000050476a in
testing::internal::HandleSehExceptionsInMethodIfSupported<testing::Test,
void> (object=0x1038030,
    method=&virtual testing::Test::TestBody(), location=0x5d561c "the
test body")
    at /usr/srcs/Ceph/work/ceph/src/googletest/googletest/src/gtest.cc:2402
#9  0x00000000004e8b07 in
testing::internal::HandleExceptionsInMethodIfSupported<testing::Test,
void> (object=0x1038030,
    method=&virtual testing::Test::TestBody(), location=0x5d561c "the
test body")
    at /usr/srcs/Ceph/work/ceph/src/googletest/googletest/src/gtest.cc:2438
#10 0x00000000004b7b25 in testing::Test::Run (this=0x1038030)
    at /usr/srcs/Ceph/work/ceph/src/googletest/googletest/src/gtest.cc:2474
#11 0x00000000004b9008 in testing::TestInfo::Run (this=0x1040000)
    at /usr/srcs/Ceph/work/ceph/src/googletest/googletest/src/gtest.cc:2656
#12 0x00000000004b9b87 in testing::TestCase::Run (this=0x10400d0)
    at /usr/srcs/Ceph/work/ceph/src/googletest/googletest/src/gtest.cc:2774
#13 0x00000000004c779c in testing::internal::UnitTestImpl::RunAllTests
(this=0x1044000)
    at /usr/srcs/Ceph/work/ceph/src/googletest/googletest/src/gtest.cc:4649
#14 0x00000000005081ba in
testing::internal::HandleSehExceptionsInMethodIfSupported<testing::internal::UnitTestImpl,
bool> (
    object=0x1044000,
    method=(bool
(testing::internal::UnitTestImpl::*)(testing::internal::UnitTestImpl *
const)) 0x4c7400 <testing::internal::UnitTestImpl::RunAllTests()>,
location=0x5d5ca2 "auxiliary test code (environments or event listeners)")
    at /usr/srcs/Ceph/work/ceph/src/googletest/googletest/src/gtest.cc:2402
#15 0x00000000004eb397 in
testing::internal::HandleExceptionsInMethodIfSupported<testing::internal::UnitTestImpl,
bool> (
    object=0x1044000,
    method=(bool
(testing::internal::UnitTestImpl::*)(testing::internal::UnitTestImpl *
const)) 0x4c7400 <testing::internal::UnitTestImpl::RunAllTests()>,
location=0x5d5ca2 "auxiliary test code (environments or event listeners)")
    at /usr/srcs/Ceph/work/ceph/src/googletest/googletest/src/gtest.cc:2438

And it traps on the fact that _raw has a null _vptr$raw.
In the mean time I have extended the asserts in buffer.{cc,h} with an
assert on **_raw (being the _vptr). But the point of traps has not
changed significantly (yet).

(gdb) p (*_raw)
$3 = {_vptr$raw = 0x0, data = 0x1052000 "\003", len = 72, nref = {val =
1}, crc_spinlock = 0, crc_map = {__tree_ = {__begin_node
      __pair1_ =
{<std::__1::__libcpp_compressed_pair_imp<std::__1::__tree_end_node<std::__1::__tree_node_base<void*>*>,
std::__lue_type<std::__1::pair<unsigned long, unsigned long>,
std::__1::pair<unsigned int, unsigned int> >, void*> >, 2>> =
{<std::__1:e_type<std::__1::pair<unsigned long, unsigned long>,
std::__1::pair<unsigned int, unsigned int> >, void*> >> = {<No data fields>
            __left_ = 0x0}}, <No data fields>},
      __pair3_ = {<std::__1::__libcpp_compressed_pair_imp<unsigned long,
std::__1::__map_value_compare<std::__1::pair<unsigned
l__1::pair<unsigned long, unsigned long>, std::__1::pair<unsigned int,
unsigned int> >, std::__1::less<std::__1::pair<unsigned
lomap_value_compare<std::__1::pair<unsigned long, unsigned long>,
std::__1::__value_type<std::__1::pair<unsigned long, unsigned lo,
std::__1::less<std::__1::pair<unsigned long, unsigned long> >, true>> =
{<std::__1::less<std::__1::pair<unsigned long, unsigne::pair<unsigned
long, unsigned long>, std::__1::pair<unsigned long, unsigned long>,
bool>> = {<No data fields>}, <No data fields
          __first_ = 0}, <No data fields>}}}}


If more data is needed, just let me know.

--WjW
