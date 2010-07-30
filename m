From: Thomas Mueller <thomas@chaschperli.ch>
Subject: [PATCH] redirect stdout to /dev/null when reloading
Date: Fri, 30 Jul 2010 08:14:16 +0200
Message-ID: <1280470456-6210-1-git-send-email-thomas@chaschperli.ch>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.muellerit.ch ([92.51.129.153]:54293 "EHLO
	mail.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755284Ab0G3GYQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jul 2010 02:24:16 -0400
Received: from mail.muellerit.ch ([127.0.0.1])
	by localhost (mail.muellerit.ch [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XxosyshPWjCN for <ceph-devel@vger.kernel.org>;
	Fri, 30 Jul 2010 08:14:20 +0200 (CEST)
Received: from gargelblaster.mit.local (zux221-125-110.adsl.green.ch [81.221.125.110])
	by mail.muellerit.ch (Postfix) with ESMTPSA id 6E0B8792402E
	for <ceph-devel@vger.kernel.org>; Fri, 30 Jul 2010 08:14:20 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Thomas Mueller <thomas@chaschperli.ch>

the reload command prints to stdout. example:

# service ceph reload
=== mon.0 ===
Reloading Ceph mon0 on hoe001...kill -1 22197...done
=== osd.0 ===
Reloading Ceph osd0 on hoe001...kill -1 22263...done


"properly" configured systems will send the output by mail to 
the administrator - this is not desired in case of successfull
reloading.


Signed-off-by: Thomas Mueller <thomas@chaschperli.ch>
---
 debian/ceph.logrotate |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/debian/ceph.logrotate b/debian/ceph.logrotate
index baea2e9..308de50 100644
--- a/debian/ceph.logrotate
+++ b/debian/ceph.logrotate
@@ -4,6 +4,6 @@
     compress
     sharedscripts
     postrotate
-        invoke-rc.d ceph reload || service ceph reload
+        invoke-rc.d ceph reload >/dev/null || service ceph reload >/dev/null
     endscript
 }
-- 
1.7.1

