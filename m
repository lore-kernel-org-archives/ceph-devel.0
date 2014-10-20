From: Aanchal Agrawal <Aanchal.Agrawal@sandisk.com>
Subject: Teuthology smoke test case(tasks/rados_python.yaml) failed on giant
Date: Mon, 20 Oct 2014 06:04:16 +0000
Message-ID: <7F4FDDF05D5B3241ABA5EB82D169E31E090E9031@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0090.outbound.protection.outlook.com ([65.55.169.90]:4893
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751493AbaJTHh7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Oct 2014 03:37:59 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi All,

I am using giant branch for the development purpose.
One of the teuthology smoke test case 'ceph-qa-suite/suites/smoke/basic/tasks/rados_python.yaml' is failing on it.

From teuthology.log
==========================
2014-10-14T11:31:09.461 INFO:teuthology.task.workunit.client.0.plana02.stderr:test_rados.test_rados_init ... ok
2014-10-14T11:31:09.489 INFO:teuthology.task.workunit.client.0.plana02.stderr:test_rados.test_ioctx_context_manager ... ok
2014-10-14T11:31:09.490 INFO:teuthology.task.workunit.client.0.plana02.stderr:
2014-10-14T11:31:09.490 INFO:teuthology.task.workunit.client.0.plana02.stderr:======================================================================
2014-10-14T11:31:09.490 INFO:teuthology.task.workunit.client.0.plana02.stderr:ERROR: test_rados.TestRados.test_get_pool_base_tier
2014-10-14T11:31:09.490 INFO:teuthology.task.workunit.client.0.plana02.stderr:----------------------------------------------------------------------
2014-10-14T11:31:09.490 INFO:teuthology.task.workunit.client.0.plana02.stderr:Traceback (most recent call last):
2014-10-14T11:31:09.491 INFO:teuthology.task.workunit.client.0.plana02.stderr:  File "/usr/local/lib/python2.7/dist-packages/nose/case.py", line 197, in runTest
2014-10-14T11:31:09.491 INFO:teuthology.task.workunit.client.0.plana02.stderr:    self.test(*self.arg)
2014-10-14T11:31:09.491 INFO:teuthology.task.workunit.client.0.plana02.stderr:  File "/home/ubuntu/cephtest/mnt.0/client.0/tmp/test_rados.py", line 96, in test_get_pool_base_tier
2014-10-14T11:31:09.491 INFO:teuthology.task.workunit.client.0.plana02.stderr:    pool_id = self.rados.pool_lookup('foo')
2014-10-14T11:31:09.491 INFO:teuthology.task.workunit.client.0.plana02.stderr:AttributeError: 'Rados' object has no attribute 'pool_lookup'
2014-10-14T11:31:09.491 INFO:teuthology.task.workunit.client.0.plana02.stderr:
2014-10-14T11:31:09.491 INFO:teuthology.task.workunit.client.0.plana02.stderr:----------------------------------------------------------------------
2014-10-14T11:31:09.492 INFO:teuthology.task.workunit.client.0.plana02.stderr:Ran 36 tests in 98.393s
2014-10-14T11:31:09.492 INFO:teuthology.task.workunit.client.0.plana02.stderr:
2014-10-14T11:31:09.492 INFO:teuthology.task.workunit.client.0.plana02.stderr:FAILED (errors=1)
============================

"self.rados.pool_lookup()" is a part of file 'src/test/pybind/test_rados.py'.
=======================================
91    def test_get_pool_base_tier(self):

95          try:
96                           pool_id = self.rados.pool_lookup('foo')
===============================================

Failure is due to latest commits on '/src/pybind/rados.py' which is in master and not present in giant.
It defines 'pool_lookup()' for rados object .

Following is a commit:
commit : d8ae14f48965e2aff191d67fda7b5ffd85840d47 to master.

We need to have this commit in giant branch in order to pass the test case.
Can anyone pull it to giant?

Thanks,
Aanchal

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

