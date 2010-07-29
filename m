From: Thomas Mueller <thomas@chaschperli.ch>
Subject: [PATCH] debian/ceph.logrotate: enhance postrotate for "service"
 util
Date: Thu, 29 Jul 2010 15:58:17 +0000 (UTC)
Message-ID: <i2s8ep$33r$4@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:58818 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626Ab0G2P62 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Jul 2010 11:58:28 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OeVV3-0005C1-6m
	for ceph-devel@vger.kernel.org; Thu, 29 Jul 2010 17:58:25 +0200
Received: from cust.dyn.95-152-98-129.swisscomdata.ch ([95.152.98.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jul 2010 17:58:25 +0200
Received: from thomas by cust.dyn.95-152-98-129.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jul 2010 17:58:25 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

invoke-rc.d is debian specific. 

run "service ceph reload" if invoke-rc.d fails.


diff --git a/debian/ceph.logrotate b/debian/ceph.logrotate
index 851d57f..baea2e9 100644
--- a/debian/ceph.logrotate
+++ b/debian/ceph.logrotate
@@ -4,6 +4,6 @@
     compress
     sharedscripts
     postrotate
-        invoke-rc.d ceph reload
+        invoke-rc.d ceph reload || service ceph reload
     endscript
 }

