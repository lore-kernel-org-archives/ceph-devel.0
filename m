From: Mark Nelson <mnelson@redhat.com>
Subject: Re: vstart runner for cephfs tests
Date: Thu, 23 Jul 2015 06:56:55 -0500
Message-ID: <55B0D687.1040403@redhat.com>
References: <55B0BB59.7010806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60299 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752406AbbGWL46 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 Jul 2015 07:56:58 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 0ADE92D4507
	for <ceph-devel@vger.kernel.org>; Thu, 23 Jul 2015 11:56:58 +0000 (UTC)
In-Reply-To: <55B0BB59.7010806@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>, ceph-devel@vger.kernel.org

Hi John,

I had similar thoughts on the benchmarking side, which is why I started 
writing cbt a couple years ago.  I needed the ability to quickly spin up 
clusters and run benchmarks on arbitrary sets of hardware.  The outcome 
isn't perfect, but it's been extremely useful for running benchmarks and 
sort of exists as a half-way point between vstart and teuthology.

The basic idea is that you give it a yaml file that looks a little bit 
like a teuthology yaml file and cbt will (optionally) build a cluster 
across a number of user defined nodes with pdsh, start various 
monitoring tools (this is ugly right now, I'm working on making it 
modular), and then sweep through user defined benchmarks and sets of 
parameter spaces.  I have a separate tool that will sweep through ceph 
parameters, create ceph.conf files for each space, and run cbt with each 
one, but the eventual goal is to integrate that into cbt itself.

Though I never really intended it to run functional tests, I just added 
something like looks very similar to the rados suite so I can benchmark 
ceph_test_rados for the new community lab hardware. I already had a 
mechanism to inject OSD down/out up/in events, so with a bit of 
squinting it can give you a very rough approximation of a workload using 
the osd thrasher.  If you are interested, I'd be game to see if we could 
integrate your cephfs tests as well (I eventually wanted to add cephfs 
benchmark capabilities anyway).

Mark

On 07/23/2015 05:00 AM, John Spray wrote:
>
> Audience: anyone working on cephfs, general testing interest.
>
> The tests in ceph-qa-suite/tasks/cephfs are growing in number, but kind
> of inconvenient to run because they require teuthology (and therefore
> require built packages, locked nodes, etc).  Most of them don't actually
> require anything beyond what you already have in a vstart cluster, so
> I've adapted them to optionally run that way.
>
> The idea is that we can iterate a lot faster when writing new tests (one
> less excuse not to write them) and get better use out of the tests when
> debugging things and testing fixes.  teuthology is fine for mass-running
> the nightlies etc, but it's overkill for testing individual bits of
> MDS/client functionality.
>
> The code is currently on the wip-vstart-runner ceph-qa-suite branch, and
> the two magic commands are:
>
> 1. Start a vstart cluster with a couple of MDSs, as your normal user:
> $ make -j4 rados ceph-fuse ceph-mds ceph-mon ceph-osd cephfs-data-scan
> cephfs-journal-tool cephfs-table-tool && ./stop.sh ; rm -rf out dev ;
> MDS=2 OSD=3 MON=1 ./vstart.sh -d -n
>
> 2. Invoke the test runner, as root (replace paths, test name as
> appropriate.  Leave of test name to run everything):
> #
> PYTHONPATH=/home/jspray/git/teuthology/:/home/jspray/git/ceph-qa-suite/
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
>
> The main caveat here is that it needs to run as root in order to
> mount/unmount things, which is a little scary.  My plan is to split it
> out into a little root service for doing mount operations, and then let
> the main test part run as a normal user and call out to the mounter
> service when needed.
>
> Cheers,
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
