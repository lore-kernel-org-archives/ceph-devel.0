From: Thomas Mueller <thomas@chaschperli.ch>
Subject: [PATCH] add helptext for option "snapdirname" to manpage of
 mount.ceph
Date: Mon, 21 Jun 2010 10:32:26 +0000 (UTC)
Message-ID: <hvnf3q$iq7$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:54990 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757809Ab0FUKcf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 21 Jun 2010 06:32:35 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OQeIr-0003ig-M3
	for ceph-devel@vger.kernel.org; Mon, 21 Jun 2010 12:32:33 +0200
Received: from cust.dyn.95-152-66-220.swisscomdata.ch ([95.152.66.220])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 21 Jun 2010 12:32:33 +0200
Received: from thomas by cust.dyn.95-152-66-220.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 21 Jun 2010 12:32:33 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

inspired by the addition to 
http://ceph.newdream.net/wiki/Snapshots about the snapdirname
 option i've created a patch for the mount.ceph manpage

- Thomas

diff --git a/man/mount.ceph.8 b/man/mount.ceph.8
index d2cf027..996d68e 100644
--- a/man/mount.ceph.8
+++ b/man/mount.ceph.8
@@ -29,6 +29,10 @@ the time of mount.
 .PP
 A subdirectory \fIsubdir\fP may be specified if a subset of the file system is to be
 mounted.
+.SH OPTIONS
+snapdirname
+.IP
+set the name of the hidden snapdir. Default: .snap
 .SH EXAMPLES
 Mount the full file system:
 .IP

