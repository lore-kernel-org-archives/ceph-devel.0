From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 11/29] mds: fix anchor table commit race
Date: Fri,  4 Jan 2013 17:02:02 +0800
Message-ID: <1357290140-17044-12-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17477 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091Ab3ADJCk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:40 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Anchor table updates for a given inode is fully serialized on client side.
But due to network latency, two commit requests from different clients can
arrive to anchor server out of order. The anchor table gets corrupted if
updates are committed in wrong order.

The fix is track on-going anchor updates for individual inode and delay
processing commit requests that arrive out of order.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/AnchorServer.cc   | 61 +++++++++++++++++++++++++++++++++++++++++++++--
 src/mds/AnchorServer.h    | 13 +++++++++-
 src/mds/MDSTableServer.cc |  4 +++-
 src/mds/MDSTableServer.h  |  2 +-
 src/mds/SnapServer.cc     |  3 ++-
 src/mds/SnapServer.h      |  2 +-
 6 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/src/mds/AnchorServer.cc b/src/mds/AnchorServer.cc
index cd2e625..4b1bf64 100644
--- a/src/mds/AnchorServer.cc
+++ b/src/mds/AnchorServer.cc
@@ -142,12 +142,13 @@ void AnchorServer::_prepare(bufferlist &bl, uint64_t reqid, int bymds)
     }
     inc(ino);
     pending_create[version] = ino;  // so we can undo
+    pending_ops[ino].push_back(pair<version_t, Context*>(version, NULL));
     break;
 
-
   case TABLE_OP_DESTROY:
     version++;
     pending_destroy[version] = ino;
+    pending_ops[ino].push_back(pair<version_t, Context*>(version, NULL));
     break;
     
   case TABLE_OP_UPDATE:
@@ -155,6 +156,7 @@ void AnchorServer::_prepare(bufferlist &bl, uint64_t reqid, int bymds)
     version++;
     pending_update[version].first = ino;
     pending_update[version].second = trace;
+    pending_ops[ino].push_back(pair<version_t, Context*>(version, NULL));
     break;
 
   default:
@@ -163,8 +165,56 @@ void AnchorServer::_prepare(bufferlist &bl, uint64_t reqid, int bymds)
   //dump();
 }
 
-void AnchorServer::_commit(version_t tid)
+bool AnchorServer::check_pending(version_t tid, MMDSTableRequest *req, list<Context *>& finished)
+{
+  inodeno_t ino;
+  if (pending_create.count(tid))
+    ino = pending_create[tid];
+  else if (pending_destroy.count(tid))
+    ino = pending_destroy[tid];
+  else if (pending_update.count(tid))
+    ino = pending_update[tid].first;
+  else
+    assert(0);
+
+  assert(pending_ops.count(ino));
+  list< pair<version_t, Context*> >& pending = pending_ops[ino];
+  list< pair<version_t, Context*> >::iterator p = pending.begin();
+  if (p->first == tid) {
+    assert(p->second == NULL);
+  } else {
+    while (p != pending.end()) {
+      if (p->first == tid)
+	break;
+      p++;
+    }
+    assert(p != pending.end());
+    assert(p->second == NULL);
+    // not the earliest pending operation, wait if it's a commit
+    if (req) {
+      p->second = new C_MDS_RetryMessage(mds, req);
+      return false;
+    }
+  }
+
+  pending.erase(p);
+  if (pending.empty()) {
+    pending_ops.erase(ino);
+  } else {
+    for (p = pending.begin(); p != pending.end() && p->second; p++) {
+      finished.push_back(p->second);
+      p->second = NULL;
+    }
+  }
+  return true;
+}
+
+bool AnchorServer::_commit(version_t tid, MMDSTableRequest *req)
 {
+  list<Context *> finished;
+  if (!check_pending(tid, req, finished))
+    return false;
+
   if (pending_create.count(tid)) {
     dout(7) << "commit " << tid << " create " << pending_create[tid] << dendl;
     pending_create.erase(tid);
@@ -206,10 +256,16 @@ void AnchorServer::_commit(version_t tid)
   // bump version.
   version++;
   //dump();
+
+  mds->queue_waiters(finished);
+  return true;
 }
 
 void AnchorServer::_rollback(version_t tid) 
 {
+  list<Context *> finished;
+  check_pending(tid, NULL, finished);
+
   if (pending_create.count(tid)) {
     inodeno_t ino = pending_create[tid];
     dout(7) << "rollback " << tid << " create " << ino << dendl;
@@ -234,6 +290,7 @@ void AnchorServer::_rollback(version_t tid)
   // bump version.
   version++;
   //dump();
+  mds->queue_waiters(finished);
 }
 
 /* This function DOES put the passed message before returning */
diff --git a/src/mds/AnchorServer.h b/src/mds/AnchorServer.h
index aa5588a..50a848e 100644
--- a/src/mds/AnchorServer.h
+++ b/src/mds/AnchorServer.h
@@ -30,6 +30,7 @@ class AnchorServer : public MDSTableServer {
   map<version_t, inodeno_t> pending_create;
   map<version_t, inodeno_t> pending_destroy;
   map<version_t, pair<inodeno_t, vector<Anchor> > > pending_update;
+  map<inodeno_t, list<pair<version_t, Context*> > > pending_ops;
 
   void reset_state();
   void encode_server_state(bufferlist& bl) {
@@ -47,17 +48,27 @@ class AnchorServer : public MDSTableServer {
     ::decode(pending_create, p);
     ::decode(pending_destroy, p);
     ::decode(pending_update, p);
+
+    map<version_t, inodeno_t> sort;
+    sort.insert(pending_create.begin(), pending_create.end());
+    sort.insert(pending_destroy.begin(), pending_destroy.end());
+    for (map<version_t, pair<inodeno_t, vector<Anchor> > >::iterator p = pending_update.begin();
+	 p != pending_update.end(); p++)
+      sort[p->first] = p->second.first;
+    for (map<version_t, inodeno_t>::iterator p = sort.begin(); p != sort.end(); p++)
+      pending_ops[p->second].push_back(pair<version_t, Context*>(p->first, NULL));
   }
 
   bool add(inodeno_t ino, inodeno_t dirino, __u32 dn_hash, bool replace);
   void inc(inodeno_t ino, int ref=1);
   void dec(inodeno_t ino, int ref=1);
+  bool check_pending(version_t tid, MMDSTableRequest *req, list<Context *>& finished);
 
   void dump();
 
   // server bits
   void _prepare(bufferlist &bl, uint64_t reqid, int bymds);
-  void _commit(version_t tid);
+  bool _commit(version_t tid, MMDSTableRequest *req=NULL);
   void _rollback(version_t tid);
   void handle_query(MMDSTableRequest *m);
 };
diff --git a/src/mds/MDSTableServer.cc b/src/mds/MDSTableServer.cc
index cfa3087..7175bbb 100644
--- a/src/mds/MDSTableServer.cc
+++ b/src/mds/MDSTableServer.cc
@@ -82,7 +82,9 @@ void MDSTableServer::handle_commit(MMDSTableRequest *req)
 
     assert(g_conf->mds_kill_mdstable_at != 5);
 
-    _commit(tid);
+    if (!_commit(tid, req))
+      return;
+
     _note_commit(tid);
     mds->mdlog->start_submit_entry(new ETableServer(table, TABLESERVER_OP_COMMIT, 0, -1, 
 						    tid, version));
diff --git a/src/mds/MDSTableServer.h b/src/mds/MDSTableServer.h
index 6e3601a..1467263 100644
--- a/src/mds/MDSTableServer.h
+++ b/src/mds/MDSTableServer.h
@@ -78,7 +78,7 @@ private:
  public:
   virtual void handle_query(MMDSTableRequest *m) = 0;
   virtual void _prepare(bufferlist &bl, uint64_t reqid, int bymds) = 0;
-  virtual void _commit(version_t tid) = 0;
+  virtual bool _commit(version_t tid, MMDSTableRequest *req=NULL) = 0;
   virtual void _rollback(version_t tid) = 0;
   virtual void _server_update(bufferlist& bl) { assert(0); }
 
diff --git a/src/mds/SnapServer.cc b/src/mds/SnapServer.cc
index 29da28c..a39395c 100644
--- a/src/mds/SnapServer.cc
+++ b/src/mds/SnapServer.cc
@@ -101,7 +101,7 @@ bool SnapServer::_is_prepared(version_t tid)
     pending_destroy.count(tid);
 }
 
-void SnapServer::_commit(version_t tid)
+bool SnapServer::_commit(version_t tid, MMDSTableRequest *req)
 {
   if (pending_create.count(tid)) {
     dout(7) << "commit " << tid << " create " << pending_create[tid] << dendl;
@@ -134,6 +134,7 @@ void SnapServer::_commit(version_t tid)
   // bump version.
   version++;
   //dump();
+  return true;
 }
 
 void SnapServer::_rollback(version_t tid) 
diff --git a/src/mds/SnapServer.h b/src/mds/SnapServer.h
index e75cc65..cf8ea6a 100644
--- a/src/mds/SnapServer.h
+++ b/src/mds/SnapServer.h
@@ -70,7 +70,7 @@ public:
   // server bits
   void _prepare(bufferlist &bl, uint64_t reqid, int bymds);
   bool _is_prepared(version_t tid);
-  void _commit(version_t tid);
+  bool _commit(version_t tid, MMDSTableRequest *req=NULL);
   void _rollback(version_t tid);
   void _server_update(bufferlist& bl);
   void handle_query(MMDSTableRequest *m);
-- 
1.7.11.7

