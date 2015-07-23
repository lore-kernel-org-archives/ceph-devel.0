From: Gregory Meno <gmeno@redhat.com>
Subject: Re: vstart runner for cephfs tests
Date: Thu, 23 Jul 2015 17:15:12 +0000
Message-ID: <20150723171512.GB14211@brown-thrasher.redhat.com>
References: <55B0BB59.7010806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54322 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754172AbbGWRPN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 Jul 2015 13:15:13 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 86E56B7A9E
	for <ceph-devel@vger.kernel.org>; Thu, 23 Jul 2015 17:15:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <55B0BB59.7010806@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jul 23, 2015 at 11:00:57AM +0100, John Spray wrote:
> 
> Audience: anyone working on cephfs, general testing interest.
> 
> The tests in ceph-qa-suite/tasks/cephfs are growing in number, but kind of
> inconvenient to run because they require teuthology (and therefore require
> built packages, locked nodes, etc).  Most of them don't actually require
> anything beyond what you already have in a vstart cluster, so I've adapted
> them to optionally run that way.
> 
> The idea is that we can iterate a lot faster when writing new tests (one
> less excuse not to write them) and get better use out of the tests when
> debugging things and testing fixes.  teuthology is fine for mass-running the
> nightlies etc, but it's overkill for testing individual bits of MDS/client
> functionality.
> 
> The code is currently on the wip-vstart-runner ceph-qa-suite branch, and the
> two magic commands are:
> 
> 1. Start a vstart cluster with a couple of MDSs, as your normal user:
> $ make -j4 rados ceph-fuse ceph-mds ceph-mon ceph-osd cephfs-data-scan
> cephfs-journal-tool cephfs-table-tool && ./stop.sh ; rm -rf out dev ; MDS=2
> OSD=3 MON=1 ./vstart.sh -d -n
> 
> 2. Invoke the test runner, as root (replace paths, test name as appropriate.
> Leave of test name to run everything):
> # PYTHONPATH=/home/jspray/git/teuthology/:/home/jspray/git/ceph-qa-suite/
> python /home/jspray/git/ceph-qa-suite/tasks/cephfs/vstart_runner.py
> tasks.cephfs.test_strays.TestStrays.test_migration_on_shutdown
> 
> test_migration_on_shutdown (tasks.cephfs.test_strays.TestStrays) ... ok
> 
> ----------------------------------------------------------------------
> Ran 1 test in 121.982s
> 
> OK
> 
> 
> ^^^ see!  two minutes, and no waiting for gitbuilders!

You are a testing hero John!

-G
