From: jie sun <0maidou0@gmail.com>
Subject: (unknown)
Date: Tue, 23 Oct 2012 12:12:56 +0800
Message-ID: <CAB6Jr7RbMaxQpxV0_pUTwSwf51wuavmJ_Dnzdk4OVMZiHcMZKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:38657 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab2JWEM5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Oct 2012 00:12:57 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so3189804oag.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 21:12:57 -0700 (PDT)
Subject: 
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I created and mounted a rbd for a virtual machine. And it can be used
as a block device normally, but often prompt some log like below:
"Oct 23 10:30:22 ubuntu12 kernel: [321506.941606] libceph: osd3
10.100.211.146:6810 socket closed
Oct 23 10:30:59 ubuntu12 kernel: [321544.337856] libceph: osd9
10.100.211.68:6809 socket closed
Oct 23 10:45:22 ubuntu12 kernel: [322407.233090] libceph: osd3
10.100.211.146:6810 socket closed
Oct 23 10:45:59 ubuntu12 kernel: [322444.766796] libceph: osd9
10.100.211.68:6809 socket closed
Oct 23 11:00:22 ubuntu12 kernel: [323307.529098] libceph: osd3
10.100.211.146:6810 socket closed
Oct 23 11:01:00 ubuntu12 kernel: [323345.241679] libceph: osd9
10.100.211.68:6809 socket closed
Oct 23 11:15:22 ubuntu12 kernel: [324207.821113] libceph: osd3
10.100.211.146:6810 socket closed
Oct 23 11:16:00 ubuntu12 kernel: [324245.717747] libceph: osd9
10.100.211.68:6809 socket closed
Oct 23 11:17:01 ubuntu12 CRON[10529]: (root) CMD (   cd / && run-parts
--report /etc/cron.hourly)
Oct 23 11:30:23 ubuntu12 kernel: [325108.117134] libceph: osd3
10.100.211.146:6810 socket closed"

These log also can be found in "/var/log/syslog".
I google something about this problem,but didn't understand what
you've wrote in "http://tracker.newdream.net/issues/2260" exactly.
How can I resolve this problem? My ceph version is 0.48.
Should I change some files, or modify some content of some file?

Thank you !
