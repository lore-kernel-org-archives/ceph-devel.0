From: Willem Jan Withagen <wjw@digiware.nl>
Subject: FreeBSD Building and Testing
Date: Sun, 20 Dec 2015 17:10:01 +0100
Message-ID: <5676D2D9.5010600@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:45452 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709AbbLTQKR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 20 Dec 2015 11:10:17 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 6841A153430
	for <ceph-devel@vger.kernel.org>; Sun, 20 Dec 2015 17:10:14 +0100 (CET)
Received: from [IPv6:2001:4cb8:3:1:953f:f3db:1564:452f] (unknown [IPv6:2001:4cb8:3:1:953f:f3db:1564:452f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 51A70153416
	for <ceph-devel@vger.kernel.org>; Sun, 20 Dec 2015 17:10:01 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Most of the Ceph is getting there in the most crude and rough state.
So beneath is a status update on what is not working for me jet.

Especially help with the aligment problem in os/FileJournal.cc would be
appricated... It would allow me to run ceph-osd and run more tests to
completion.

What would happen if I comment out this test, and ignore the fact that
thing might be unaligned?
Is it a performance/paging issue?
Or is data going to be corrupted?

--WjW

PASS: src/test/run-cli-tests
============================================================================
Testsuite summary for ceph 10.0.0
============================================================================
# TOTAL: 1
# PASS:  1
# SKIP:  0
# XFAIL: 0
# FAIL:  0
# XPASS: 0
# ERROR: 0
============================================================================

gmake test:
============================================================================
Testsuite summary for ceph 10.0.0
============================================================================
# TOTAL: 119
# PASS:  95
# SKIP:  0
# XFAIL: 0
# FAIL:  24
# XPASS: 0
# ERROR: 0
============================================================================

The folowing notes can be made with this:
1) the run-cli-tests run to completion because I excluded the RBD tests
2) gmake test has the following tests FAIL:
FAIL: unittest_erasure_code_plugin
FAIL: ceph-detect-init/run-tox.sh
FAIL: test/erasure-code/test-erasure-code.sh
FAIL: test/erasure-code/test-erasure-eio.sh
FAIL: test/run-rbd-unit-tests.sh
FAIL: test/ceph_objectstore_tool.py
FAIL: test/test-ceph-helpers.sh
FAIL: test/cephtool-test-osd.sh
FAIL: test/cephtool-test-mon.sh
FAIL: test/cephtool-test-mds.sh
FAIL: test/cephtool-test-rados.sh
FAIL: test/mon/osd-crush.sh
FAIL: test/osd/osd-scrub-repair.sh
FAIL: test/osd/osd-scrub-snaps.sh
FAIL: test/osd/osd-config.sh
FAIL: test/osd/osd-bench.sh
FAIL: test/osd/osd-reactivate.sh
FAIL: test/osd/osd-copy-from.sh
FAIL: test/libradosstriper/rados-striper.sh
FAIL: test/test_objectstore_memstore.sh
FAIL: test/ceph-disk.sh
FAIL: test/pybind/test_ceph_argparse.py
FAIL: test/pybind/test_ceph_daemon.py
FAIL: ../qa/workunits/erasure-code/encode-decode-non-regression.sh

Most of the fails are because ceph-osd crashed consistently on:
-1 journal  bl.is_aligned(block_size) 0
bl.is_n_align_sized(CEPH_MINIMUM_BLOCK_SIZE) 1
-1 journal  block_size 131072 CEPH_MINIMUM_BLOCK_SIZE 4096
CEPH_PAGE_SIZE 4096 header.alignment 131072
bl buffer::list(len=131072, buffer::ptr(0~131072 0x805319000 in raw
0x805319000 len 131072 nref 1))
os/FileJournal.cc: In function 'void FileJournal::align_bl(off64_t,
bufferlist &)' thread 805217400 time 2015-12-19 13:43:06.706797
os/FileJournal.cc: 1045: FAILED assert(0 == "bl should be align")

This is bugging me already for a few days, but I haven't found an easy
way to debug this, run it in gdb while being live or in post-mortum.

Further:
A) unittest_erasure_code_plugin failes on the fact that there is a
different error code returned when dlopen-ing a non existent library.
load dlopen(.libs/libec_invalid.so): Cannot open
".libs/libec_invalid.so"load dlsym(.libs/libec_missing_version.so, _
_erasure_code_init): Undefined symbol
"__erasure_code_init"test/erasure-code/TestErasureCodePlugin.cc:88: Failure
Value of: instance.factory("missing_version", g_conf->erasure_code_dir,
profile, &erasure_code, &cerr)
  Actual: -2
Expected: -18
load dlsym(.libs/libec_missing_entry_point.so, __erasure_code_init):
Undefined symbol "__erasure_code_init"erasure_co
de_init(fail_to_initialize,.libs): (3) No such processload
__erasure_code_init()did not register fail_to_registerload
: example erasure_code_init(example,.libs): (17) File existsload:
example [  FAILED  ] ErasureCodePluginRegistryTest.
all (330 ms)

B) ceph-detect-init/run-tox.sh failes on the fact that I need to work in
FreeBSD in the tests.

C) ./gtest/include/gtest/internal/gtest-port.h:1358:: Condition
has_owner_ && pthread_equal(owner_, pthread_se
lf()) failed. The current thread is not holding the mutex @0x161ef20
./test/run-rbd-unit-tests.sh: line 9: 78053 Abort trap
(core dumped) unittest_librbd

Which I think I found some commit comments about in either trac or git
about FreeBSD not being able to do things to its own thread. Got to look
into this.

D) Fix some of the other python code to work as expected.
