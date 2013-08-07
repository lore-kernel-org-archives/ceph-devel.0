From: Jean-Daniel BUSSY <silversurfer972@gmail.com>
Subject: Reduce cluster log verbosity
Date: Wed, 7 Aug 2013 12:29:01 +0900
Message-ID: <CANB=HGgN44+2V7eCe5yzcEwSgc7bS1ihVVuXnR1yi=csbi-aiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:65133 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756993Ab3HGD3W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Aug 2013 23:29:22 -0400
Received: by mail-ob0-f172.google.com with SMTP id er7so1664017obc.31
        for <ceph-devel@vger.kernel.org>; Tue, 06 Aug 2013 20:29:21 -0700 (PDT)
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
