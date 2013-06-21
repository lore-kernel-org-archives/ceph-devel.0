From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/2] mds: use "open-by-ino" helper to handle LOOKUPINO request
Date: Fri, 21 Jun 2013 14:39:26 +0800
Message-ID: <1371796767-16205-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50145 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161442Ab3FUGoX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 21 Jun 2013 02:44:23 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Fixes #3541
Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 38 ++++++++------------------------------
 src/mds/Server.h  |  1 -
 2 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 1d16d04..e84626b 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -2483,41 +2483,19 @@ void Server::handle_client_lookup_ino(MDRequest *mdr)
 void Server::_lookup_ino(MDRequest *mdr)
 {
   inodeno_t ino = mdr->client_request->get_filepath().get_ino();
-  dout(10) << "_lookup_ino " << mdr << " checking peers for ino " << ino << dendl;
-  mdcache->find_ino_peers(ino,
-			  new C_MDS_LookupIno2(this, mdr), -1);
+  dout(10) << "_lookup_ino " << mdr << " opening ino " << ino << dendl;
+  mdcache->open_ino(ino, (int64_t)-1, new C_MDS_LookupIno2(this, mdr), false);
 }
 
-struct C_MDS_LookupIno3 : public Context {
-  Server *server;
-  MDRequest *mdr;
-  C_MDS_LookupIno3(Server *s, MDRequest *r) : server(s), mdr(r) {}
-  void finish(int r) {
-    server->_lookup_ino_3(mdr, r);
-  }
-};
-
 void Server::_lookup_ino_2(MDRequest *mdr, int r)
 {
   inodeno_t ino = mdr->client_request->get_filepath().get_ino();
-  dout(10) << "_lookup_ino_2 " << mdr << " checked peers for ino " << ino
-	   << " and got r=" << r << dendl;
-  if (r == 0) {
-    dispatch_client_request(mdr);
-    return;
-  }
-
-  // okay fine, maybe it's a directory though...
-  mdcache->find_ino_dir(ino, new C_MDS_LookupIno3(this, mdr));
-}
-
-void Server::_lookup_ino_3(MDRequest *mdr, int r)
-{
-  inodeno_t ino = mdr->client_request->get_filepath().get_ino();
-  dout(10) << "_lookup_ino_3 " << mdr << " checked dir obj for ino " << ino
-	   << " and got r=" << r << dendl;
-  if (r == 0) {
-    dispatch_client_request(mdr);
+  dout(10) << "_lookup_ino_2 " << mdr << " ino " << ino << " r=" << r << dendl;
+  if (r >= 0) {
+    if (r == mds->get_nodeid())
+      dispatch_client_request(mdr);
+    else
+      mdcache->request_forward(mdr, r);
     return;
   }
 
diff --git a/src/mds/Server.h b/src/mds/Server.h
index 269b286..2da4055 100644
--- a/src/mds/Server.h
+++ b/src/mds/Server.h
@@ -146,7 +146,6 @@ public:
   void handle_client_lookup_ino(MDRequest *mdr);
   void _lookup_ino(MDRequest *mdr);
   void _lookup_ino_2(MDRequest *mdr, int r);
-  void _lookup_ino_3(MDRequest *mdr, int r);
   void handle_client_readdir(MDRequest *mdr);
   void handle_client_file_setlock(MDRequest *mdr);
   void handle_client_file_readlock(MDRequest *mdr);
-- 
1.8.1.4

