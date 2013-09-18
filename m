From: Alfredo Deza <alfredo.deza@inktank.com>
Subject: [ANN] ceph-deploy 1.2.5 released!
Date: Wed, 18 Sep 2013 09:48:02 -0400
Message-ID: <CANtztVw9SSJ1E3N=q_aZULEMkc4_YFbi01hKr11K1+1D5guuAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:50156 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab3IRNsD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Sep 2013 09:48:03 -0400
Received: by mail-ob0-f178.google.com with SMTP id uy5so7368894obc.37
        for <ceph-devel@vger.kernel.org>; Wed, 18 Sep 2013 06:48:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

There is a new release of ceph-deploy, the easy ceph deployment tool.

There were a good amount of bug fixes into this release and a wealth
of improvements. Thanks
to all of you who contributed patches and issues, and thanks to Dmitry
Borodaenko and
Andrew Woodward for extensively testing and reporting problems before
this release went out.

Installation instructions: https://github.com/ceph/ceph-deploy#installation

This is the list of all fixes that went into this release which can
also be found in the CHANGELOG.rst file in ceph-deploy's git repo:

* Improve ``osd help`` menu with path information
* Really discourage the use of ``ceph-deploy new [IP]``
* Fix hanging remote requests
* Add ``mon status`` output when creating monitors
* Fix Debian install issue (wrong parameter order) (Thanks Sayid Munawar)
* ``osd`` commands will be more verbose when deploying them
* Issue a warning when provided hosts do not match ``hostname -s`` remotely
* Create two flags for altering/not-altering source repos at install time:
  ``--adjust-repos`` and ``--no-adjust-repos``
* Do not do any ``sudo`` commands if user is root
* Use ``mon status`` for every ``mon`` deployment and detect problems with
  monitors.
* Allow to specify ``host:fqdn/ip`` for all mon commands (Thanks Dmitry
  Borodaenko)
* Be consistent for hostname detection (Thanks Dmitry Borodaenko)
* Fix hanging problem on remote hosts

Highlights
--------------
* Dumpling users will benefit from better status information from each
monitor when deploying.
* 2 new flags to enable/disable adding source repositories when
installing (``--adjust-repos`` and ``--no-adjust-repos``) that
  should help environments that have custom repos (or that are
prevented to going to the internet).
* Much better OSD output! This will improve debugging as there is now
capturing of every step on remote hosts.


Make sure you update!

Thanks,


Alfredo

p.s. What happened to 1.2.4? As we released this we found there was a
problem with mon commands that could hang
so even though 1.2.4 was released we decided to cut another release
with the fix.
