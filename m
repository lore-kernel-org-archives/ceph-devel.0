From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: teuthology-suite --rerun puzzle (take 2)
Date: Tue, 22 Nov 2016 09:38:49 -0800
Message-ID: <CAMMFjmGkK8+Q33ExYRbUNnHSQfJsCtpB73Kf=TAwGhJqAV0nAw@mail.gmail.com>
References: <CA+2bHPZwXDfWrjJ=i-QsAOWaZWVX+JFwmuvbkjh2mVgYQcWShA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37423 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933463AbcKVRra (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Nov 2016 12:47:30 -0500
Received: by mail-wm0-f46.google.com with SMTP id t79so37680018wmt.0
        for <ceph-devel@vger.kernel.org>; Tue, 22 Nov 2016 09:47:30 -0800 (PST)
In-Reply-To: <CA+2bHPZwXDfWrjJ=i-QsAOWaZWVX+JFwmuvbkjh2mVgYQcWShA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Zack Cerza <zack@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Patric,

Rerun option in teuthology has a bug.
Zack is off this week, but he is aware of it and fixing this problem.

Thx
YuriW

On Tue, Nov 22, 2016 at 7:44 AM, Patrick Donnelly <pdonnell@redhat.com> wrote:
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
> --
> Patrick Donnelly
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
