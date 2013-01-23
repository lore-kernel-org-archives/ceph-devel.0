From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 17/25] mds: don't replace existing slave request
Date: Wed, 23 Jan 2013 11:08:53 +0800
Message-ID: <1358910541-15535-18-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51770 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753093Ab3AWDJT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:19 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The MDS may receive a client request, but find there is an existing
slave request. It means other MDS is handling the same request, so
we should not replace the slave request with a new client request,
just forward the request.

The client request may include embeded cap releases, we need process
them even the request is forwarded.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc |  6 +++---
 src/mds/Server.cc  | 22 +++++++++++++---------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 73da4c1..542f4a6 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -7569,13 +7569,13 @@ MDRequest *MDCache::request_start(MClientRequest *req)
   if (active_requests.count(req->get_reqid())) {
     MDRequest *mdr = active_requests[req->get_reqid()];
     if (mdr->is_slave()) {
-      dout(10) << "request_start already had " << *mdr << ", cleaning up" << dendl;
-      request_cleanup(mdr);
+      dout(10) << "request_start already had " << *mdr << ", forward new msg" << dendl;
+      mds->forward_message_mds(req, mdr->slave_to_mds);
     } else {
       dout(10) << "request_start already processing " << *mdr << ", dropping new msg" << dendl;
       req->put();
-      return 0;
     }
+    return 0;
   }
 
   // register new client request
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 90b0120..de73a8c 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -1096,28 +1096,32 @@ void Server::handle_client_request(MClientRequest *req)
     session->trim_completed_requests(req->get_oldest_client_tid());
   }
 
+  // request_start may drop the request, get a reference for cap release
+  if (!req->releases.empty() && req->get_source().is_client() && !req->is_replay())
+    req->get();
+
   // register + dispatch
   MDRequest *mdr = mdcache->request_start(req);
-  if (!mdr) 
-    return;
-  if (session) {
-    mdr->session = session;
-    session->requests.push_back(&mdr->item_session_request);
+  if (mdr) {
+    if (session) {
+      mdr->session = session;
+      session->requests.push_back(&mdr->item_session_request);
+    }
   }
 
   // process embedded cap releases?
   //  (only if NOT replay!)
-  if (req->get_source().is_client() &&
-      !req->is_replay()) {
+  if (!req->releases.empty() && req->get_source().is_client() && !req->is_replay()) {
     client_t client = req->get_source().num();
     for (vector<MClientRequest::Release>::iterator p = req->releases.begin();
 	 p != req->releases.end();
 	 p++)
       mds->locker->process_request_cap_release(mdr, client, p->item, p->dname);
+    req->put();
   }
 
-
-  dispatch_client_request(mdr);
+  if (mdr)
+    dispatch_client_request(mdr);
   return;
 }
 
-- 
1.7.11.7

