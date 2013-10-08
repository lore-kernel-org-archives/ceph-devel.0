From: Alfredo Deza <alfredo.deza@inktank.com>
Subject: [ANN] ceph-deploy 1.2.7 released!
Date: Tue, 8 Oct 2013 09:11:43 -0400
Message-ID: <CANtztVxX8k7xmOQgN6b3TtW=sLCug80wE51OgN6m0KzpWrpTyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:53291 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427Ab3JHNLo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Oct 2013 09:11:44 -0400
Received: by mail-qa0-f48.google.com with SMTP id hu16so3744484qab.7
        for <ceph-devel@vger.kernel.org>; Tue, 08 Oct 2013 06:11:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

Version 1.2.7 of ceph-deploy has been released, the easy ceph deployment tool.

As always, there were a good amount of bug fixes into this release and a wealth
of improvements. 1.2.6 was not announced as it was a small bug fix
from the previous
release.

Installation instructions: https://github.com/ceph/ceph-deploy#installation

This is the list of all fixes that went into this release which can
also be found in the CHANGELOG.rst file in ceph-deploy's git repo:

* Ensure local calls to ceph-deploy do not attempt to ssh.
* ``mon create-initial`` command to deploy all defined mons, wait for them to
  form quorum and finally to ``gatherkeys``.
* Improve help menu for mon commands.
* Add ``--fs-type`` option to ``disk`` and ``osd`` commands (Thanks Benoit
  Knecht)
* Make sure we are using ``--cluster`` for remote configs when starting ceph
* Fix broken ``mon destroy`` calls using the new hostname resolution helper
* Add a helper to catch common monitor errors (reporting the status of a mon)
* Normalize all configuration options in ceph-deploy (Thanks Andrew Woodward)
* Use a ``cuttlefish`` compatible ``mon_status`` command
* Make ``osd activate`` use the new remote connection libraries for improved
  readability.
* Make ``disk zap`` also use the new remote connection libraries.
* Handle any connection errors that may came up when attempting to get into
  remote hosts.

Highlights
-----------
* Cuttlefish users will benefit from all the monitor work in ceph-deploy: catch
  common pitfalls and errors when deploying monitors.
* A new sub-command to create monitors was added: ``ceph-deploy mon
  create-initial`` which will deploy all initially defined monitors, will wait
  for them to form quorum and finally will gather the keys when they do
  *greatly simplifying the steps needed for this*.
* Disk zapping will have **much** better output and should help debugging.


Make sure you update!

Thanks,


Alfredo
