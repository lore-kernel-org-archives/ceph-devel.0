From: Jean-Daniel BUSSY <silversurfer972@gmail.com>
Subject: Reduce log verbosity
Date: Wed, 7 Aug 2013 12:10:24 +0900
Message-ID: <CANB=HGgxw3fzcDhn7JKQA00eO4SfZHBptPi7Y=UxVQwUWny8yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:37214 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756870Ab3HGDKo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Aug 2013 23:10:44 -0400
Received: by mail-ob0-f169.google.com with SMTP id wc20so2754879obb.0
        for <ceph-devel@vger.kernel.org>; Tue, 06 Aug 2013 20:10:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

We have log aggregation on our ceph cluster and verbosity is a problem
on the cluster log file at /etc/ceph/ceph.conf
I got advice from some nice folk on IRC and I tried to use syslog and
setup the log level to WARN but the INF logs are still pouring.
I confirmed settings are changed in the admin socked and got these:

  "clog_to_syslog_level": "warn",
  "clog_to_syslog_facility": "daemon",
  "mon_cluster_log_to_syslog": "true",
  "mon_cluster_log_to_syslog_level": "warn",
  "mon_cluster_log_to_syslog_facility": "daemon",
  "mon_cluster_log_file": "\/var\/log\/ceph\/ceph.log",

I guess I am missing some option flag or something. Any hint?

Thanks

BUSSY Jean-Daniel
Cloud Engineer
Email: silversurfer972@gmail.com
