From: Sage Weil <sage@newdream.net>
Subject: Re: [sepia] CentOS builds failing in Shaman since Friday evening
Date: Sat, 3 Jun 2017 20:45:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706032044430.3646@piezo.novalocal>
References: <4a0aa923-028a-a9bf-d988-ead0f51fe831@suse.cz> <CAJ4mKGYGn4vL3k5TKs3v=Ho8L7DuU97eDWLD_HBqCKf+J+pfZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-695415966-1496522735=:3646"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40789 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbdFCUpg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Jun 2017 16:45:36 -0400
In-Reply-To: <CAJ4mKGYGn4vL3k5TKs3v=Ho8L7DuU97eDWLD_HBqCKf+J+pfZg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Nathan Cutler <ncutler@suse.cz>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "sepia@ceph.com" <sepia@ceph.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-695415966-1496522735=:3646
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

I'm seeing the builds all complete:

https://shaman.ceph.com/repos/ceph/wip-sage-testing/468be5dab6a2d8421a4fc35744463d47a80f47c2/

but it won't schedule:

$ teuthology-suite -s rados -c wip-sage-testing2 --subset 111/444 -p 100 
-k distro
2017-06-03 20:44:27,112.112 INFO:teuthology.suite.run:kernel sha1: distro
2017-06-03 20:44:27,389.389 INFO:teuthology.suite.run:ceph sha1: 
b03f3062d40c35e4898d77604d62e7e7c4e88afd
Traceback (most recent call last):
  File "/home/sage/src/teuthology/virtualenv/bin/teuthology-suite", line 11, in <module>
    load_entry_point('teuthology', 'console_scripts', 'teuthology-suite')()
  File "/home/sage/src/teuthology/scripts/suite.py", line 137, in main
    return teuthology.suite.main(args)
  File "/home/sage/src/teuthology/teuthology/suite/__init__.py", line 86, in main
    run = Run(conf)
  File "/home/sage/src/teuthology/teuthology/suite/run.py", line 46, in __init__
    self.base_config = self.create_initial_config()
  File "/home/sage/src/teuthology/teuthology/suite/run.py", line 92, in create_initial_config
    self.choose_ceph_version(ceph_hash)
  File "/home/sage/src/teuthology/teuthology/suite/run.py", line 185, in choose_ceph_version
    util.schedule_fail(str(exc), self.name)
  File "/home/sage/src/teuthology/teuthology/suite/util.py", line 72, in schedule_fail
    raise ScheduleFailError(message, name)
teuthology.exceptions.ScheduleFailError: Scheduling sage-2017-06-03_20:44:27-rados-wip-sage-testing2-distro-basic-smithi 
failed: 'package_manager_version'

:/

On Sat, 3 Jun 2017, Gregory Farnum wrote:

> Adding sepia list for more infrastructure dev attention. (No idea where that
> problem is coming from.)
> 
> On Sat, Jun 3, 2017 at 5:52 AM Nathan Cutler <ncutler@suse.cz> wrote:
>       CentOS builds in Shaman started failing with this error:
> 
>       {standard input}: Assembler messages:
>       {standard input}:186778: Warning: end of file not at end of a
>       line;
>       newline inserted
>       {standard input}: Error: open CFI at the end of file; missing
>       .cfi_endproc directive
>       c++: internal compiler error: Killed (program cc1plus)
>       Please submit a full bug report,
>       with preprocessed source if appropriate.
>       See <http://bugzilla.redhat.com/bugzilla> for instructions.
> 
>       AFAICT the first occurrence was in [1] and the error has been
>       haunting
>       the build queue since then.
> 
>       [1]
> https://shaman.ceph.com/builds/ceph/wip-sage-testing2/f93ad23a8fec219667a03
>       695136842edb0cceace/default/45729/
> 
>       Nathan
>       --
>       To unsubscribe from this list: send the line "unsubscribe
>       ceph-devel" in
>       the body of a message to majordomo@vger.kernel.org
>       More majordomo info at 
>       http://vger.kernel.org/majordomo-info.html
> 
> 
> 
--8323329-695415966-1496522735=:3646--
