From: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Subject: Fwd: FreeBSD Building and Testing
Date: Mon, 21 Dec 2015 09:16:42 +0800
Message-ID: <CANE=7sU7vFf-iqmL_zrnBcHJAQQQnjP0AM1Pf5M-QXkaE9k0Pg@mail.gmail.com>
References: <5676D2D9.5010600@digiware.nl>
	<CANE=7sVw1zhxYzT9q6WKkUV5tCioLuO0J_ZKCkdKXR5jFDHsKg@mail.gmail.com>
	<CANE=7sU9QPH2uUS8A4xhPQ1j+jR6Fi88=PVvLRGEhzt2cmOceg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f194.google.com ([209.85.214.194]:36050 "EHLO
	mail-ob0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbbLUBQn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Dec 2015 20:16:43 -0500
Received: by mail-ob0-f194.google.com with SMTP id or18so76723obb.3
        for <ceph-devel@vger.kernel.org>; Sun, 20 Dec 2015 17:16:42 -0800 (PST)
In-Reply-To: <CANE=7sU9QPH2uUS8A4xhPQ1j+jR6Fi88=PVvLRGEhzt2cmOceg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

---------- Forwarded message ----------
=46rom: Xinze Chi (=E4=BF=A1=E6=B3=BD) <xmdxcxz@gmail.com>
Date: 2015-12-21 8:59 GMT+08:00
Subject: Re: FreeBSD Building and Testing
To: Willem Jan Withagen <wjw@digiware.nl>


Please try this patch
https://github.com/XinzeChi/ceph/commit/f4d5bd01a2e498e850e3a43fb1233ba=
40d8d1781
again. and tell me which patch could fix the bug.
Thanks.

2015-12-21 8:45 GMT+08:00 Xinze Chi (=E4=BF=A1=E6=B3=BD) <xmdxcxz@gmail=
=2Ecom>:
> sorry for delay reply. Please have a try
> https://github.com/ceph/ceph/commit/ae4a8162eacb606a7f65259c6ac236e14=
4bfef0a.
>
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
>>   Actual: -2
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
> --
> Regards,
> Xinze Chi



--
Regards,
Xinze Chi


--=20
Regards,
Xinze Chi
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
