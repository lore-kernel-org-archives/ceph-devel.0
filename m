From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 01/12] mds: Don't drop client request from MDS
Date: Tue,  2 Oct 2012 16:55:41 +0800
Message-ID: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:65146 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674Ab2JBIz4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Oct 2012 04:55:56 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

MDS may send client request for stray migration/reintegration.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 3 ++-
 src/mds/MDS.cc     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 06933f9..efa6671 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -7473,7 +7473,8 @@ void MDCache::request_forward(MDRequest *mdr, int who, int port)
 void MDCache::dispatch_request(MDRequest *mdr)
 {
   if (mdr->client_request) {
-    if (!mdr->item_session_request.is_on_list()) {
+    if (!mdr->reqid.name.is_mds() &&
+	!mdr->item_session_request.is_on_list()) {
       dout(10) << "request " << *mdr << " is canceled" << dendl;
       return;
     }
diff --git a/src/mds/MDS.cc b/src/mds/MDS.cc
index 8a5355b..3e7c97c 100644
--- a/src/mds/MDS.cc
+++ b/src/mds/MDS.cc
@@ -1716,9 +1716,9 @@ bool MDS::handle_deferrable_message(Message *m)
     switch (m->get_type()) {
       // SERVER
     case CEPH_MSG_CLIENT_SESSION:
-    case CEPH_MSG_CLIENT_REQUEST:
     case CEPH_MSG_CLIENT_RECONNECT:
       ALLOW_MESSAGES_FROM(CEPH_ENTITY_TYPE_CLIENT);
+    case CEPH_MSG_CLIENT_REQUEST:
       server->dispatch(m);
       break;
     case MSG_MDS_SLAVE_REQUEST:
-- 
1.7.11.4

