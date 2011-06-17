From: Wilfrid Allembrand <wilfrid.allembrand@gmail.com>
Subject: Cluster expansion : adding monitor
Date: Fri, 17 Jun 2011 23:13:25 +0200
Message-ID: <BANLkTi=fZuWfzHQe+TptCaotOrXPWkf-QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43646 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757842Ab1FQVN1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jun 2011 17:13:27 -0400
Received: by gyh3 with SMTP id 3so781936gyh.19
        for <ceph-devel@vger.kernel.org>; Fri, 17 Jun 2011 14:13:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm still doing some tests and wanted to test reinstallation of a
monitor on a previously crashed machine.
After OS and ceph reinstallation, I then follow the wiki
(http://ceph.newdream.net/wiki/Monitor_cluster_expansion) but I have a
problem for step 2) :


2) Copy the mon data from an existing, online monitor.
alpha$ rsync -av /srv/ceph/mon.alpha/ beta:/srv/ceph/mon.beta

On all my existing and online monitors, I don't have a /srv/ceph/
directory. Ceph version is 0.29.1 on Ubuntu 11.04 server 64.
Is the wiki page obsolete for newer ceph versions ?

Extract from my ceph.conf :

[global]
    user = root
    log file = /var/log/ceph/$name.log
    pid file = /var/run/ceph/$name.pid

[mon]
        mon data = /data/mon$id
        ; some minimal logging (just message traffic) to aid debugging
        debug ms = 1

[mon.1]
        host = test2
        mon addr = 10.1.56.232:6789
