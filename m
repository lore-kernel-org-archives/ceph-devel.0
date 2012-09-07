From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] osd/OSD.cc: Fix typo in OSD::heartbeat_check()
Date: Fri,  7 Sep 2012 13:49:27 +0800
Message-ID: <1346996967-6380-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27715 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463Ab2IGFtb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Sep 2012 01:49:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The check 'p->second.last_tx > cutoff' should always be false
since last_tx is periodically updated by OSD::heartbeat()

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/osd/OSD.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
index 5add675..562fd25 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -1946,13 +1946,13 @@ void OSD::heartbeat_check()
        p != heartbeat_peers.end();
        p++) {
     dout(25) << "heartbeat_check osd." << p->first
-	     << " first_rx " << p->second.first_tx
+	     << " first_tx " << p->second.first_tx
 	     << " last_tx " << p->second.last_tx
 	     << " last_rx " << p->second.last_rx
 	     << dendl;
     if (p->second.last_rx == utime_t()) {
       if (p->second.last_tx == utime_t() ||
-	  p->second.last_tx > cutoff)
+	  p->second.first_tx > cutoff)
 	continue;  // just started sending recently
       derr << "heartbeat_check: no reply from osd." << p->first
 	   << " ever, first ping sent " << p->second.first_tx
-- 
1.7.11.4

