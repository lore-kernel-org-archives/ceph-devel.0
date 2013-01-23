From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 15/25] mds: send resolve messages after all MDS reach resolve stage
Date: Wed, 23 Jan 2013 11:08:51 +0800
Message-ID: <1358910541-15535-16-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1296 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069Ab3AWDJS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:18 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Current code sends resolve messages when resolving MDS set changes.
There is no need to send resolve messages when some MDS leave the
resolve stage. Sending message while some MDS are replaying is also
not very useful.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc |  4 ++++
 src/mds/MDS.cc     | 13 ++++++-------
 src/mds/MDS.h      |  5 ++++-
 src/mds/MDSMap.h   |  6 ++++++
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 4374656..73da4c1 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -2739,6 +2739,10 @@ void MDCache::handle_resolve(MMDSResolve *m)
   int from = m->get_source().num();
 
   if (mds->get_state() < MDSMap::STATE_RESOLVE) {
+    if (mds->get_want_state() == CEPH_MDS_STATE_RESOLVE) {
+      mds->wait_for_resolve(new C_MDS_RetryMessage(mds, m));
+      return;
+    }
     // wait until we reach the resolve stage!
     m->put();
     return;
diff --git a/src/mds/MDS.cc b/src/mds/MDS.cc
index bd4bed9..4153417 100644
--- a/src/mds/MDS.cc
+++ b/src/mds/MDS.cc
@@ -974,14 +974,12 @@ void MDS::handle_mds_map(MMDSMap *m)
   // RESOLVE
   // is someone else newly resolving?
   if (is_resolve() || is_rejoin() || is_clientreplay() || is_active() || is_stopping()) {
-    set<int> oldresolve, resolve;
-    oldmap->get_mds_set(oldresolve, MDSMap::STATE_RESOLVE);
-    mdsmap->get_mds_set(resolve, MDSMap::STATE_RESOLVE);
-    if (oldresolve != resolve) {
-      dout(10) << " resolve set is " << resolve << ", was " << oldresolve << dendl;
+    if (!oldmap->is_resolving() && mdsmap->is_resolving()) {
+      set<int> oldresolve, resolve;
+      mdsmap->get_mds_set(resolve, MDSMap::STATE_RESOLVE);
+      dout(10) << " resolve set is " << resolve << dendl;
       calc_recovery_set();
-      if (!mdsmap->is_any_failed())
-	mdcache->send_resolves();
+      mdcache->send_resolves();
     }
   }
   
@@ -1410,6 +1408,7 @@ void MDS::resolve_start()
   reopen_log();
 
   mdcache->resolve_start();
+  finish_contexts(g_ceph_context, waiting_for_resolve);
 }
 void MDS::resolve_done()
 {
diff --git a/src/mds/MDS.h b/src/mds/MDS.h
index a90587e..f61ad8d 100644
--- a/src/mds/MDS.h
+++ b/src/mds/MDS.h
@@ -196,7 +196,7 @@ class MDS : public Dispatcher {
   int state;         // my confirmed state
   int want_state;    // the state i want
 
-  list<Context*> waiting_for_active, waiting_for_replay, waiting_for_reconnect;
+  list<Context*> waiting_for_active, waiting_for_replay, waiting_for_reconnect, waiting_for_resolve;
   list<Context*> replay_queue;
   map<int, list<Context*> > waiting_for_active_peer;
   list<Message*> waiting_for_nolaggy;
@@ -219,6 +219,9 @@ class MDS : public Dispatcher {
   void wait_for_reconnect(Context *c) {
     waiting_for_reconnect.push_back(c);
   }
+  void wait_for_resolve(Context *c) {
+    waiting_for_resolve.push_back(c);
+  }
   void wait_for_mdsmap(epoch_t e, Context *c) {
     waiting_for_mdsmap[e].push_back(c);
   }
diff --git a/src/mds/MDSMap.h b/src/mds/MDSMap.h
index 3a83ed8..47c2c52 100644
--- a/src/mds/MDSMap.h
+++ b/src/mds/MDSMap.h
@@ -449,6 +449,12 @@ public:
   bool is_any_failed() {
     return failed.size();
   }
+  bool is_resolving() {
+    return
+      get_num_mds(STATE_RESOLVE) > 0 &&
+      get_num_mds(STATE_REPLAY) == 0 &&
+      failed.empty();
+  }
   bool is_rejoining() {  
     // nodes are rejoining cache state
     return 
-- 
1.7.11.7

