From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: FreeBSD Building and Testing
Date: Mon, 21 Dec 2015 21:14:18 +0100
Message-ID: <56785D9A.2020701@digiware.nl>
References: <5676D2D9.5010600@digiware.nl>
 <CANE=7sVw1zhxYzT9q6WKkUV5tCioLuO0J_ZKCkdKXR5jFDHsKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:57758 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbbLUUOh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 21 Dec 2015 15:14:37 -0500
In-Reply-To: <CANE=7sVw1zhxYzT9q6WKkUV5tCioLuO0J_ZKCkdKXR5jFDHsKg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 21-12-2015 01:45, Xinze Chi (=E4=BF=A1=E6=B3=BD) wrote:
> sorry for delay reply. Please have a try
> https://github.com/ceph/ceph/commit/ae4a8162eacb606a7f65259c6ac236e14=
4bfef0a.

Tried this one first:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Testsuite summary for ceph 10.0.1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
# TOTAL: 120
# PASS:  100
# SKIP:  0
# XFAIL: 0
# FAIL:  20
# XPASS: 0
# ERROR: 0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

So that certainly helps.
Have not yet analyzed the log files... But is seems we are getting=20
somewhere.
Needed to manually kill a rados access in:
  | |     |             \-+- 09792 wjw /bin/sh ../test-driver=20
=2E/test/ceph_objectstore_tool.py
  | |     |               \-+- 09807 wjw python=20
=2E/test/ceph_objectstore_tool.py (python2.7)
  | |     |                 \--- 11406 wjw=20
/usr/srcs/Ceph/wip-freebsd-wjw/ceph/src/.libs/rados -p rep_pool -N put=20
REPobject1 /tmp/data.9807/-REPobject1__head

But also 2 mon-osd's were running, and perhaps ine was nog belonging
with that test. So they could be in each others way.

=46ound some fails in OSD's at:

=2E/test-suite.log:osd/ECBackend.cc: 201: FAILED assert(res.errors.empt=
y())
=2E/test-suite.log:osd/ECBackend.cc: 201: FAILED assert(res.errors.empt=
y())

struct OnRecoveryReadComplete :
   public GenContext<pair<RecoveryMessages*, ECBackend::read_result_t& =
>=20
&> {
   ECBackend *pg;
   hobject_t hoid;
   set<int> want;
   OnRecoveryReadComplete(ECBackend *pg, const hobject_t &hoid)
     : pg(pg), hoid(hoid) {}
   void finish(pair<RecoveryMessages *, ECBackend::read_result_t &> &in=
) {
     ECBackend::read_result_t &res =3D in.second;
     // FIXME???
     assert(res.r =3D=3D 0);
201:    assert(res.errors.empty());
     assert(res.returned.size() =3D=3D 1);
     pg->handle_recovery_read_complete(
       hoid,
       res.returned.back(),
       res.attrs,
       in.first);
   }
};

Given the FIXME?? the code here could be fishy??

I would say that just this patch would be sufficient.
The second patch also looks like it is could be useful since it
lowers the bar on being tested. And when just aligning is required
because of (a)iovec processing that 4096 will likely suffice.

Thanx you very much for the help.

--WjW


> 2015-12-21 0:10 GMT+08:00 Willem Jan Withagen <wjw@digiware.nl>:
>> Hi,
>>
>> Most of the Ceph is getting there in the most crude and rough state.
>> So beneath is a status update on what is not working for me jet.
>>
>> Especially help with the aligment problem in os/FileJournal.cc would=
 be
>> appricated... It would allow me to run ceph-osd and run more tests t=
o
>> completion.
>>
>> What would happen if I comment out this test, and ignore the fact th=
at
>> thing might be unaligned?
>> Is it a performance/paging issue?
>> Or is data going to be corrupted?
>>
>> --WjW
>>
>> PASS: src/test/run-cli-tests
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> Testsuite summary for ceph 10.0.0
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> # TOTAL: 1
>> # PASS:  1
>> # SKIP:  0
>> # XFAIL: 0
>> # FAIL:  0
>> # XPASS: 0
>> # ERROR: 0
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>
>> gmake test:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> Testsuite summary for ceph 10.0.0
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> # TOTAL: 119
>> # PASS:  95
>> # SKIP:  0
>> # XFAIL: 0
>> # FAIL:  24
>> # XPASS: 0
>> # ERROR: 0
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>
>> The folowing notes can be made with this:
>> 1) the run-cli-tests run to completion because I excluded the RBD te=
sts
>> 2) gmake test has the following tests FAIL:
>> FAIL: unittest_erasure_code_plugin
>> FAIL: ceph-detect-init/run-tox.sh
>> FAIL: test/erasure-code/test-erasure-code.sh
>> FAIL: test/erasure-code/test-erasure-eio.sh
>> FAIL: test/run-rbd-unit-tests.sh
>> FAIL: test/ceph_objectstore_tool.py
>> FAIL: test/test-ceph-helpers.sh
>> FAIL: test/cephtool-test-osd.sh
>> FAIL: test/cephtool-test-mon.sh
>> FAIL: test/cephtool-test-mds.sh
>> FAIL: test/cephtool-test-rados.sh
>> FAIL: test/mon/osd-crush.sh
>> FAIL: test/osd/osd-scrub-repair.sh
>> FAIL: test/osd/osd-scrub-snaps.sh
>> FAIL: test/osd/osd-config.sh
>> FAIL: test/osd/osd-bench.sh
>> FAIL: test/osd/osd-reactivate.sh
>> FAIL: test/osd/osd-copy-from.sh
>> FAIL: test/libradosstriper/rados-striper.sh
>> FAIL: test/test_objectstore_memstore.sh
>> FAIL: test/ceph-disk.sh
>> FAIL: test/pybind/test_ceph_argparse.py
>> FAIL: test/pybind/test_ceph_daemon.py
>> FAIL: ../qa/workunits/erasure-code/encode-decode-non-regression.sh
>>
>> Most of the fails are because ceph-osd crashed consistently on:
>> -1 journal  bl.is_aligned(block_size) 0
>> bl.is_n_align_sized(CEPH_MINIMUM_BLOCK_SIZE) 1
>> -1 journal  block_size 131072 CEPH_MINIMUM_BLOCK_SIZE 4096
>> CEPH_PAGE_SIZE 4096 header.alignment 131072
>> bl buffer::list(len=3D131072, buffer::ptr(0~131072 0x805319000 in ra=
w
>> 0x805319000 len 131072 nref 1))
>> os/FileJournal.cc: In function 'void FileJournal::align_bl(off64_t,
>> bufferlist &)' thread 805217400 time 2015-12-19 13:43:06.706797
>> os/FileJournal.cc: 1045: FAILED assert(0 =3D=3D "bl should be align"=
)
>>
>> This is bugging me already for a few days, but I haven't found an ea=
sy
>> way to debug this, run it in gdb while being live or in post-mortum.
>>
>> Further:
>> A) unittest_erasure_code_plugin failes on the fact that there is a
>> different error code returned when dlopen-ing a non existent library=
=2E
>> load dlopen(.libs/libec_invalid.so): Cannot open
>> ".libs/libec_invalid.so"load dlsym(.libs/libec_missing_version.so, _
>> _erasure_code_init): Undefined symbol
>> "__erasure_code_init"test/erasure-code/TestErasureCodePlugin.cc:88: =
=46ailure
>> Value of: instance.factory("missing_version", g_conf->erasure_code_d=
ir,
>> profile, &erasure_code, &cerr)
>>    Actual: -2
>> Expected: -18
>> load dlsym(.libs/libec_missing_entry_point.so, __erasure_code_init):
>> Undefined symbol "__erasure_code_init"erasure_co
>> de_init(fail_to_initialize,.libs): (3) No such processload
>> __erasure_code_init()did not register fail_to_registerload
>> : example erasure_code_init(example,.libs): (17) File existsload:
>> example [  FAILED  ] ErasureCodePluginRegistryTest.
>> all (330 ms)
>>
>> B) ceph-detect-init/run-tox.sh failes on the fact that I need to wor=
k in
>> FreeBSD in the tests.
>>
>> C) ./gtest/include/gtest/internal/gtest-port.h:1358:: Condition
>> has_owner_ && pthread_equal(owner_, pthread_se
>> lf()) failed. The current thread is not holding the mutex @0x161ef20
>> ./test/run-rbd-unit-tests.sh: line 9: 78053 Abort trap
>> (core dumped) unittest_librbd
>>
>> Which I think I found some commit comments about in either trac or g=
it
>> about FreeBSD not being able to do things to its own thread. Got to =
look
>> into this.
>>
>> D) Fix some of the other python code to work as expected.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
