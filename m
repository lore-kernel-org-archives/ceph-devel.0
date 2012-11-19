From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 08/16] mds: don't forward client request from MDS
Date: Mon, 19 Nov 2012 10:43:40 +0800
Message-ID: <1353293028-15238-9-git-send-email-zheng.z.yan@intel.com>
References: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17039 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752921Ab2KSCoA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:44:00 -0500
In-Reply-To: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Forwarding client request that was from MDS will trigger assertion
in MDS::forward_message_mds(). MDS only send client requests for
stray migration/reintegration, so it's safe to drop them.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 5027469..88a248b 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -7475,13 +7475,17 @@ void MDCache::request_finish(MDRequest *mdr)
 
 void MDCache::request_forward(MDRequest *mdr, int who, int port)
 {
-  dout(7) << "request_forward " << *mdr << " to mds." << who << " req " << *mdr << dendl;
-  
-  mds->forward_message_mds(mdr->client_request, who);  
-  mdr->client_request = 0;
+  if (mdr->client_request->get_source().is_client()) {
+    dout(7) << "request_forward " << *mdr << " to mds." << who << " req "
+            << *mdr->client_request << dendl;
+    mds->forward_message_mds(mdr->client_request, who);
+    mdr->client_request = 0;
+    if (mds->logger) mds->logger->inc(l_mds_fw);
+  } else {
+    dout(7) << "request_forward drop " << *mdr << " req " << *mdr->client_request
+            << " was from mds" << dendl;
+  }
   request_cleanup(mdr);
-
-  if (mds->logger) mds->logger->inc(l_mds_fw);
 }
 
 
-- 
1.7.11.7

