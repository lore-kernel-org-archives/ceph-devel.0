From: Dan Mick <dmick@redhat.com>
Subject: RFC: tool for applying 'ceph daemon <osd>' command to all OSDs
Date: Mon, 21 Dec 2015 21:59:30 -0800
Message-ID: <5678E6C2.40007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56362 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916AbbLVF7b (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Dec 2015 00:59:31 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 1CAFE219F
	for <ceph-devel@vger.kernel.org>; Tue, 22 Dec 2015 05:59:31 +0000 (UTC)
Received: from [10.17.96.100] (angus.lax.redhat.com [10.17.96.100])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tBM5xUMZ011536
	for <ceph-devel@vger.kernel.org>; Tue, 22 Dec 2015 00:59:31 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I needed something to fetch current config values from all OSDs (sorta
the opposite of 'injectargs --key value), so I hacked it, and then
spiffed it up a bit.  Does this seem like something that would be useful
in this form in the upstream Ceph, or does anyone have any thoughts on
its design or structure?

It requires a locally-installed ceph CLI and a ceph.conf that points to
the cluster and any required keyrings.  You can also provide it with
a YAML file mapping host to osds if you want to save time collecting
that info for a statically-defined cluster, or if you want just a subset
of OSDs.

https://github.com/dmick/tools/blob/master/osd_daemon_cmd.py

Excerpt from usage:

Execute a Ceph osd daemon command on every OSD in a cluster with
one connection to each OSD host.

Usage:
    osd_daemon_cmd [-c CONF] [-u USER] [-f FILE] (COMMAND | -k KEY)

Options:
   -c CONF   ceph.conf file to use [default: ./ceph.conf]
   -u USER   user to connect with ssh
   -f FILE   get names and osds from yaml
   COMMAND   command other than "config get" to execute
   -k KEY    config key to retrieve with config get <key>

-- 
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs
