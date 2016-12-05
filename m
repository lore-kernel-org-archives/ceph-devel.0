From: Willem Jan Withagen <wjw@digiware.nl>
Subject: FreeBSD-Ceph: Jenkins build is back to normal : ceph-master #70
Date: Mon, 5 Dec 2016 17:19:04 +0100
Message-ID: <d682db59-3c61-e53f-1145-f0f71fe4538c@digiware.nl>
References: <1011204597.37.1480951219760.JavaMail.jenkins@cephdev.digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:20320 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbcLEQTT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 5 Dec 2016 11:19:19 -0500
In-Reply-To: <1011204597.37.1480951219760.JavaMail.jenkins@cephdev.digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: FreeBSD Filesystems <freebsd-fs@freebsd.org>

Hi,

It been just a bit more than 1 year ago I started this undertaking:
	Ceph on FreeBSD.
So as sort as anniversary I'm sort of pleased to say that quite a lot of
the code in Ceph/ceph now actually builds/runs/tests according the
testset that comes with the repo.
(And tonight is sort of Dutch pre-Xmas: Sinterklaas, and we give away
presents. :D )

What I have not looked into are RBD, CephFS and fuse.
 * RBD has 2 sides: libRBD which is largely just userspace code.
   Porting that will not be a major undertaking. Kernel RBD might be
   possible, but then with largely different code.(more based on ggated)
 * CephFS and fuse are  still uncharted territory so I'll have to see
   what is going to happen there.

The code has not been stress tested at all. Like I said: it gets thru
the testset. But it requires ZFS and some hand holding. Certainly
ceph-disk will not do all things it does on Linux. So most/all of the
setup needs to be done with care and double checking.

Building a FreeBSD package is in the works, but I've yet to learn how to
get the embedded Python parts installed in a way that they work.
And some tweaks are needed to DIY.

For those interested, I've started Jenkins to build a FreeBSD version
once per day from master.... The results are public for everybody.

-------- Forwarded Message --------
Subject: Jenkins build is back to normal : ceph-master #70
Date: Mon, 5 Dec 2016 16:20:19 +0100 (CET)
From: jenkins@digiware.nl
Reply-To: jenkins@digiware.nl
To: wjw@digiware.nl

http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/70/

-------------------------------

To get here there are still a few patches required. This you see
happening at the beginning of the jobs.

The following patches are still under review, but applied here:
Buildsystem:
	CMakeLists.txt-boost.diff

Subsystem:
	src_rocksdb_CMakeText.txt.diff

Code:
	msg_async_AsyncMessenger.cc.diff
	src_rgw_rgw_file.cc.diff

Code/compiler-bug:
	test_test_denc.cc.diff
	test_test_mempool.cc.diff

Tests:
	qa_workunits_ceph-disk.diff
	src_ceph-disk_tests_ceph-disk.sh.diff
	src_ceph-disk_tests_test_main.py.diff
	src_test_pybind_CMakeLists.txt.diff
	src_test_pybind_nosetests.diff

If anybody wants to have these patches, I'll put them online.
The alternative is to fetch my https://github.com/wjwithagen/ceph tree,
and checkout wip.FreeBSD.
But that is sort of a moving target and will not always compile.

Thanx to:
	Sage Weil
	Kefu Chai
	Haomai Wang
	and many more Ceph developers
that were patient enough with me, and helped me to get this far.

Thanx,
--WjW

--WjW

