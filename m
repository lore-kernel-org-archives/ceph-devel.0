From: Sage Weil <sweil@redhat.com>
Subject: Re: re-running teuthology jobs
Date: Sat, 28 Feb 2015 09:21:43 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502280921051.25838@cobra.newdream.net>
References: <54F1985A.1090907@dachary.org> <54F1D849.4020803@dachary.org> <1556427609.29934314.1425138429026.JavaMail.zimbra@redhat.com> <54F1EA1B.5030207@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-972499182-1425144105=:25838"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60303 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbbB1RWt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 28 Feb 2015 12:22:49 -0500
In-Reply-To: <54F1EA1B.5030207@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-972499182-1425144105=:25838
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Sat, 28 Feb 2015, Loic Dachary wrote:
> 
> 
> On 28/02/2015 16:47, Yuri Weinstein wrote:
> > Loic
> > 
> > In case you want to add some comments - http://tracker.ceph.com/issues/10945
> 
> Done thanks !

It would also be nice to just point it at the archive directory of the run 
that failed and have it figure the rest out from the orig.config.yaml (or 
whatever else) in that directory.  At least, that's how I would probably 
use it!

sage

> 
> > 
> > Thx
> > YuriW
> > 
> > ----- Original Message -----
> > From: "Loic Dachary" <loic@dachary.org>
> > To: "Ceph Development" <ceph-devel@vger.kernel.org>
> > Sent: Saturday, February 28, 2015 7:01:29 AM
> > Subject: Re: re-running teuthology jobs
> > 
> > The simpler way is to use the --filter argument of teuthology-suite with the value of the description: field found in the config.yaml file. For instance, running the rados failed jobs http://tracker.ceph.com/issues/10641#rados failed jobs:
> > 
> > $ ./virtualenv/bin/teuthology-suite --priority 101 --suite rados --filter 'rados/multimon/{clusters/21.yaml msgr-failures/many.yaml tasks/mon_clock_with_skews.yaml},rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml workloads/small-objects.yaml},rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml msgr-failures/osd-delay.yaml thrashers/pggrow.yaml workloads/ec-small-objects.yaml},rados/verify/{1thrash/none.yaml clusters/fixed-2.yaml fs/btrfs.yaml msgr-failures/few.yaml tasks/mon_recovery.yaml validater/valgrind.yaml},rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml msgr-failures/osd-delay.yaml thrashers/default.yaml workloads/cache-agent-small.yaml}' --suite-branch firefly --machine-type plana,burnupi,mira --distro ubuntu --email loic@dacha
 ry.org --owner loic@dachary.org  --ceph firefly-backports
> > 2015-02-28 15:58:08,474.474 INFO:teuthology.suite:ceph sha1: e54834bfac3c38562987730b317cb1944a96005b
> > 2015-02-28 15:58:08,969.969 INFO:teuthology.suite:ceph version: 0.80.8-75-ge54834b-1precise
> > 2015-02-28 15:58:09,606.606 INFO:teuthology.suite:teuthology branch: master
> > 2015-02-28 15:58:10,407.407 INFO:teuthology.suite:ceph-qa-suite branch: firefly
> > 2015-02-28 15:58:10,409.409 INFO:teuthology.repo_utils:Fetching from upstream into /home/loic/src/ceph-qa-suite_firefly
> > 2015-02-28 15:58:11,522.522 INFO:teuthology.repo_utils:Resetting repo at /home/loic/src/ceph-qa-suite_firefly to branch firefly
> > 2015-02-28 15:58:12,393.393 INFO:teuthology.suite:Suite rados in /home/loic/src/ceph-qa-suite_firefly/suites/rados generated 693 jobs (not yet filtered)
> > 2015-02-28 15:58:12,419.419 INFO:teuthology.suite:Scheduling rados/multimon/{clusters/21.yaml msgr-failures/many.yaml tasks/mon_clock_with_skews.yaml}
> > Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backports---basic-multi and ID 783145
> > 2015-02-28 15:58:14,199.199 INFO:teuthology.suite:Scheduling rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml msgr-failures/osd-delay.yaml thrashers/default.yaml workloads/cache-agent-small.yaml}
> > Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backports---basic-multi and ID 783146
> > 2015-02-28 15:58:15,650.650 INFO:teuthology.suite:Scheduling rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml workloads/small-objects.yaml}
> > Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backports---basic-multi and ID 783147
> > 2015-02-28 15:58:16,837.837 INFO:teuthology.suite:Scheduling rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml msgr-failures/osd-delay.yaml thrashers/pggrow.yaml workloads/ec-small-objects.yaml}
> > Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backports---basic-multi and ID 783148
> > 2015-02-28 15:58:18,421.421 INFO:teuthology.suite:Scheduling rados/verify/{1thrash/none.yaml clusters/fixed-2.yaml fs/btrfs.yaml msgr-failures/few.yaml tasks/mon_recovery.yaml validater/valgrind.yaml}
> > Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backports---basic-multi and ID 783149
> > 2015-02-28 15:58:19,729.729 INFO:teuthology.suite:Suite rados in /home/loic/src/ceph-qa-suite_firefly/suites/rados scheduled 5 jobs.
> > 2015-02-28 15:58:19,729.729 INFO:teuthology.suite:Suite rados in /home/loic/src/ceph-qa-suite_firefly/suites/rados -- 688 jobs were filtered out.
> > Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backports---basic-multi and ID 783150
> > 
> > Creates the http://pulpito.ceph.com/loic-2015-02-28_15:58:07-rados-firefly-backports---basic-multi/ run with just 5 jobs.
> > 
> > On 28/02/2015 11:28, Loic Dachary wrote:
> >> Hi,
> >>
> >> A teuthology rados run ( https://github.com/ceph/ceph-qa-suite/tree/master/suites/rados ) completed with five dead jobs out of 693. They failed because of DNS errors and I'd like to re-run them. Ideally I could do something like:
> >>
> >> teuthology-schedule --run loic-2015-02-27_20:22:09-rados-firefly-backports---basic-multi --job-id 781444 --job-id  781457 ...
> >>
> >> and it would re-schedule a run of the designated jobs from the designated run. But I don't think such a command exist. 
> >>
> >> I will therefore manually do what such a command would do, for each failed job:
> >>
> >> * download http://qa-proxy.ceph.com/teuthology/loic-2015-02-27_20:22:09-rados-firefly-backports---basic-multi/781444/orig.config.yaml
> >> * git clone https://github.com/ceph/ceph-qa-suite /srv/ceph-qa-suite
> >> * cd /srv/ceph-qa-suite ; git checkout firefly (assuming that's the ceph-qa-suite branch I'm interested in)
> >> * remove the fields:
> >>    job_id: '781444'
> >>    last_in_suite: false
> >>    worker_log: /var/lib/teuthworker/archive/worker_logs/worker.multi.14588
> >> * replace the suite_path: field with suite_path: /srv/ceph-qa-suite
> >> * teuthology-lock --lock enough machines (i.e. one for each element in the roles: section of the orig.config.yaml)
> >> * turn the machine list into a consumable file for teuthology : teuthology-lock --list-targets > targets.yaml 
> >> * run teuthology orig.config.yaml targets.yaml
> >> * wait for the result
> >>
> >> Is there a better way to do that ? 
> >>
> >> Cheers
> >>
> > 
> 
> -- 
> Loïc Dachary, Artisan Logiciel Libre
> 
> 
--557981400-972499182-1425144105=:25838--
