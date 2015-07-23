From: John Spray <john.spray@redhat.com>
Subject: vstart runner for cephfs tests
Date: Thu, 23 Jul 2015 11:00:57 +0100
Message-ID: <55B0BB59.7010806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33188 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784AbbGWKA7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 Jul 2015 06:00:59 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id C4EDD2DC42E
	for <ceph-devel@vger.kernel.org>; Thu, 23 Jul 2015 10:00:58 +0000 (UTC)
Received: from siltstone.localdomain (vpn-57-106.rdu2.redhat.com [10.10.57.106])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t6NA0vvp031349
	for <ceph-devel@vger.kernel.org>; Thu, 23 Jul 2015 06:00:58 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Audience: anyone working on cephfs, general testing interest.

The tests in ceph-qa-suite/tasks/cephfs are growing in number, but kind 
of inconvenient to run because they require teuthology (and therefore 
require built packages, locked nodes, etc).  Most of them don't actually 
require anything beyond what you already have in a vstart cluster, so 
I've adapted them to optionally run that way.

The idea is that we can iterate a lot faster when writing new tests (one 
less excuse not to write them) and get better use out of the tests when 
debugging things and testing fixes.  teuthology is fine for mass-running 
the nightlies etc, but it's overkill for testing individual bits of 
MDS/client functionality.

The code is currently on the wip-vstart-runner ceph-qa-suite branch, and 
the two magic commands are:

1. Start a vstart cluster with a couple of MDSs, as your normal user:
$ make -j4 rados ceph-fuse ceph-mds ceph-mon ceph-osd cephfs-data-scan 
cephfs-journal-tool cephfs-table-tool && ./stop.sh ; rm -rf out dev ; 
MDS=2 OSD=3 MON=1 ./vstart.sh -d -n

2. Invoke the test runner, as root (replace paths, test name as 
appropriate.  Leave of test name to run everything):
# 
PYTHONPATH=/home/jspray/git/teuthology/:/home/jspray/git/ceph-qa-suite/ 
python /home/jspray/git/ceph-qa-suite/tasks/cephfs/vstart_runner.py 
tasks.cephfs.test_strays.TestStrays.test_migration_on_shutdown

test_migration_on_shutdown (tasks.cephfs.test_strays.TestStrays) ... ok

----------------------------------------------------------------------
Ran 1 test in 121.982s

OK


^^^ see!  two minutes, and no waiting for gitbuilders!

The main caveat here is that it needs to run as root in order to 
mount/unmount things, which is a little scary.  My plan is to split it 
out into a little root service for doing mount operations, and then let 
the main test part run as a normal user and call out to the mounter 
service when needed.

Cheers,
John
