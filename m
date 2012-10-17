From: Tommi Virtanen <tv@inktank.com>
Subject: Braindump: multiple clusters on the same hardware
Date: Wed, 17 Oct 2012 12:35:09 -0700
Message-ID: <CADvuQREhkrqxm1dMo3XXFpwhtCzC7SM7cK_7+r5HnACGbCnJLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52092 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757777Ab2JQTfb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Oct 2012 15:35:31 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so7827065oag.19
        for <ceph-devel@vger.kernel.org>; Wed, 17 Oct 2012 12:35:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: John Wilkins <john.wilkins@inktank.com>

You can run multiple Ceph clusters on the same hardware. They will
have completely separate monitors, OSDs (including separate data disks
and journals that will not be shared between clusters), MDSs etc.

This provides a higher level of isolation than e.g. just using
multiple RADOS pools and CRUSH rulesets.

This multiple cluster support is activated in all the Ceph commands,
such as ``ceph``, with the ``--cluster=`` option. For example, to see
the status of the cluster ``uswest1a``, run ``ceph --cluster=uswest1a
-s``. This will read ``/etc/ceph/uswest1a.conf`` instead of the
default ``ceph.conf``, and use the monitor addresses and keyrings
specified in that file. In the configuration file, the name of the
cluster can be referred to as ``$cluster``. Cluster names must consist
of letters a-z and digits 0-9 only.

This also means that when preparing disks for OSD hotplugging, you may
want to specify a non-default cluster with ``ceph-disk-prepare
--cluster=NAME /dev/sdb``.

To guard against typos in IP addresses and port numbers, make sure
each ``CLUSTER.conf`` file specifies an ``fsid``. You should also have
a distinct ``mon.`` key for each cluster. Following documented
installation procedures makes sure they are both randomly generated
for each cluster.

Current status: multi-cluster support has not been fully QA'ed, and
there are known issues (e.g. http://tracker.newdream.net/issues/3253
http://tracker.newdream.net/issues/3277 ).
