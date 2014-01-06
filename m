From: "no-reply@mindtouch.us" <no-reply@mindtouch.us>
Subject: ctrlenter wants to share a link | Ceph Wiki
Date: Mon, 6 Jan 2014 06:35:24 +0000
Message-ID: <0000014366435178-e465c948-4981-43bd-a43b-d1871c450813-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from a9-24.smtp-out.amazonses.com ([54.240.9.24]:39185 "EHLO
	a9-24.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750909AbaAFGmm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jan 2014 01:42:42 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

ctrlenter wants to a share a link on Ceph Wiki: https://wiki.ceph.com/Planning/CDS/Dumpling/Etherpad_Snapshots/2H%3A_Ceph_stats_and_monitoring_tools

ctrlenter says:
Hi,
I use collectd(https://github.com/ceph/collectd-4.10.1) to monitor ceph. But get stuck, the collectd log looks like this:
[2014-01-02 17:18:37] [debug] did cconn_prepare(name=osd.0,i=0,st=2)
[2014-01-02 17:18:47] [debug] did cconn_prepare(name=osd.0,i=0,st=2)
[2014-01-02 17:18:47] [warning] ERROR: cconn_main_loop: timed out.

[2014-01-02 17:18:47] [debug] cconn_main_loop: reached all Ceph daemons :)
[2014-01-02 17:18:47] [error] Initialization of plugin `ceph' failed with status -110. Plugin will be unloaded.

I checked the  source code and found that ceph did not response the collectd when collectd tried to get version  from ceph side via *.asok, system call--poll seemed to timed out.

anyone can help me ?
Thank you!

Best Regards,
-Dennis
-------------------
This email was sent at the request of a user - please do not respond to this email.
