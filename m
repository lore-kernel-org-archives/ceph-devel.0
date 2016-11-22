From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology-suite --rerun puzzle (take 2)
Date: Tue, 22 Nov 2016 17:55:29 +0100
Message-ID: <ce65792a-3b57-3fc2-f38d-59b693bbaca3@dachary.org>
References: <CA+2bHPZwXDfWrjJ=i-QsAOWaZWVX+JFwmuvbkjh2mVgYQcWShA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:44073 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbcKVQzf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Nov 2016 11:55:35 -0500
In-Reply-To: <CA+2bHPZwXDfWrjJ=i-QsAOWaZWVX+JFwmuvbkjh2mVgYQcWShA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Patrick,

I'm getting consistent re-run using the following method (not --rerun):

paddles=paddles.front.sepia.ceph.com
run=loic-2016-11-10_10:23:37-rbd-jewel-backports---basic-smithi
eval filter=$(curl --silent http://$paddles/runs/$run/ | jq '.jobs[] | select(.status == "dead" or .status == "fail") | .description' | while read description ; do echo -n $description, ; done | sed -e 's/,$//')
teuthology-suite --priority 1000 --suite rbd --filter="$filter"  ...

Cheers

On 22/11/2016 16:44, Patrick Donnelly wrote:
> I'm trying to rerun failures from this test run:
> http://pulpito.ceph.com/pdonnell-2016-11-21_19:10:15-fs-master-distro-basic-mira/
> 
> However, I can't seem to get teuthology working right (it filters all jobs):
> 
> $ teuthology-suite --machine-type mira --ceph master --newest 20
> --suite-branch wip-fs-reorg-2 -p 80 -k distro --rerun
> pdonnell-2016-11-21_19:10:15-fs-master-distro-basic-mira
> {'suite': u'fs', 'descriptions': [u'fs/verify/{begin.yaml
> clusters/fixed-2-ucephfs.yaml fs/xfs.yaml mount/fuse.yaml
> overrides/{debug.yaml frag_enable.yaml mon-debug.yaml
> whitelist_wrongly_marked_down.yaml}
> tasks/cfuse_workunit_suites_fsstress.yaml validater/valgrind.yaml}',
> u'fs/basic/{begin.yaml clusters/fixed-2-ucephfs.yaml fs/xfs.yaml
> inline/no.yaml mount/fuse.yaml overrides/{debug.yaml frag_enable.yaml
> whitelist_wrongly_marked_down.yaml} tasks/libcephfs_python.yaml}',
> u'fs/verify/{begin.yaml clusters/fixed-2-ucephfs.yaml fs/xfs.yaml
> mount/fuse.yaml overrides/{debug.yaml frag_enable.yaml mon-debug.yaml
> whitelist_wrongly_marked_down.yaml}
> tasks/cfuse_workunit_suites_dbench.yaml validater/valgrind.yaml}',
> u'fs/verify/{begin.yaml clusters/fixed-2-ucephfs.yaml fs/xfs.yaml
> mount/fuse.yaml overrides/{debug.yaml frag_enable.yaml mon-debug.yaml
> whitelist_wrongly_marked_down.yaml}
> tasks/libcephfs_interface_tests.yaml validater/valgrind.yaml}',
> u'fs/basic/{begin.yaml clusters/fixed-2-ucephfs.yaml fs/xfs.yaml
> inline/yes.yaml mount/fuse.yaml overrides/{debug.yaml frag_enable.yaml
> whitelist_wrongly_marked_down.yaml} tasks/libcephfs_python.yaml}']}
> 2016-11-22 06:20:23,079.079 INFO:teuthology.suite.run:kernel sha1: distro
> 2016-11-22 06:20:23,717.717 INFO:teuthology.suite.run:ceph sha1:
> 013d4b2053c8be1bee62b01f03c88c861006c9f3
> 2016-11-22 06:20:23,717.717 INFO:teuthology.suite.run:skipping ceph
> package verification
> 2016-11-22 06:20:23,717.717 INFO:teuthology.suite.run:teuthology branch: master
> 2016-11-22 06:20:23,759.759 INFO:teuthology.suite.run:ceph-qa-suite
> branch: wip-fs-reorg-2 eef0d958ddd6b75f6a2bc07fb61f293e043f0d17
> 2016-11-22 06:20:23,763.763 INFO:teuthology.repo_utils:Fetching from
> upstream into /home/pdonnell/src/ceph-qa-suite_wip-fs-reorg-2
> 2016-11-22 06:20:23,805.805 INFO:teuthology.repo_utils:Resetting repo
> at /home/pdonnell/src/ceph-qa-suite_wip-fs-reorg-2 to branch
> wip-fs-reorg-2
> 2016-11-22 06:20:24,001.001 INFO:teuthology.suite.run:Suite fs in
> /home/pdonnell/src/ceph-qa-suite_wip-fs-reorg-2/suites/fs generated 91
> jobs (not yet filtered)
> 2016-11-22 06:20:24,010.010 INFO:teuthology.suite.run:Suite fs in
> /home/pdonnell/src/ceph-qa-suite_wip-fs-reorg-2/suites/fs scheduled 0
> jobs.
> 2016-11-22 06:20:24,010.010 INFO:teuthology.suite.run:91/91 jobs were
> filtered out.
> 
> 
> Anyone see the problem?
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
