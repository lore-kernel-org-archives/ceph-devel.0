From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 06/30] mds: fix slave commit tracking
Date: Thu, 23 May 2013 16:06:34 +0800
Message-ID: <1369296418-14871-7-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39281 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755390Ab3EWINH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:07 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

MDS may crash after journalling a slave commit, but before sending
commit ack to the master. Later when the MDS restarts, it will not
send commit ack to the master. So the master waits for the commit
ack forever. The fix is remove failed MDS from requests' uncommitted
slave list. When failed MDS recovers, its resolve message will tell
the master which slave requests are not committed. The master will
re-add the recovering MDS to requests' uncommitted slave list if
necessary.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 55 ++++++++++++++++++++++++++++++++----------------------
 src/mds/MDCache.h  |  3 +++
 src/mds/MDS.cc     |  1 -
 3 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 24ef1cd..9db51b1 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -2174,7 +2174,7 @@ void MDCache::committed_master_slave(metareqid_t r, int from)
   dout(10) << "committed_master_slave mds." << from << " on " << r << dendl;
   assert(uncommitted_masters.count(r));
   uncommitted_masters[r].slaves.erase(from);
-  if (uncommitted_masters[r].slaves.empty())
+  if (!uncommitted_masters[r].recovering && uncommitted_masters[r].slaves.empty())
     log_master_commit(r);
 }
 
@@ -2191,20 +2191,20 @@ void MDCache::logged_master_update(metareqid_t reqid)
 }
 
 /*
- * The mds could crash after receiving all slaves' commit acknowledgement,
- * but before journalling the ECommitted.
+ * Master may crash after receiving all slaves' commit acks, but before journalling
+ * the final commit. Slaves may crash after journalling the slave commit, but before
+ * sending commit ack to the master. Commit masters with no uncommitted slave when
+ * resolve finishes.
  */
 void MDCache::finish_committed_masters()
 {
-  map<metareqid_t, umaster>::iterator p = uncommitted_masters.begin();
-  while (p != uncommitted_masters.end()) {
-    if (p->second.slaves.empty()) {
-      metareqid_t reqid = p->first;
-      dout(10) << "finish_committed_masters " << reqid << dendl;
-      ++p;
-      log_master_commit(reqid);
-    } else {
-      ++p;
+  for (map<metareqid_t, umaster>::iterator p = uncommitted_masters.begin();
+       p != uncommitted_masters.end();
+       ++p) {
+    p->second.recovering = false;
+    if (!p->second.committing && p->second.slaves.empty()) {
+      dout(10) << "finish_committed_masters " << p->first << dendl;
+      log_master_commit(p->first);
     }
   }
 }
@@ -2700,6 +2700,16 @@ void MDCache::handle_mds_failure(int who)
     }
   }
 
+  for (map<metareqid_t, umaster>::iterator p = uncommitted_masters.begin();
+       p != uncommitted_masters.end();
+       ++p) {
+    // The failed MDS may have already committed the slave update
+    if (p->second.slaves.count(who)) {
+      p->second.recovering = true;
+      p->second.slaves.erase(who);
+    }
+  }
+
   while (!finish.empty()) {
     dout(10) << "cleaning up slave request " << *finish.front() << dendl;
     request_finish(finish.front());
@@ -2959,17 +2969,18 @@ void MDCache::maybe_resolve_finish()
     dout(10) << "maybe_resolve_finish still waiting for resolves ("
 	     << resolve_gather << ")" << dendl;
     return;
+  }
+
+  dout(10) << "maybe_resolve_finish got all resolves+resolve_acks, done." << dendl;
+  disambiguate_imports();
+  finish_committed_masters();
+  if (mds->is_resolve()) {
+    trim_unlinked_inodes();
+    recalc_auth_bits();
+    trim_non_auth();
+    mds->resolve_done();
   } else {
-    dout(10) << "maybe_resolve_finish got all resolves+resolve_acks, done." << dendl;
-    disambiguate_imports();
-    if (mds->is_resolve()) {
-      trim_unlinked_inodes();
-      recalc_auth_bits();
-      trim_non_auth(); 
-      mds->resolve_done();
-    } else {
-      maybe_send_pending_rejoins();
-    }
+    maybe_send_pending_rejoins();
   }
 }
 
diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
index c41692b..3c73bef 100644
--- a/src/mds/MDCache.h
+++ b/src/mds/MDCache.h
@@ -323,6 +323,9 @@ protected:
     LogSegment *ls;
     list<Context*> waiters;
     bool safe;
+    bool committing;
+    bool recovering;
+    umaster() : committing(false), recovering(false) {}
   };
   map<metareqid_t, umaster>                 uncommitted_masters;         // master: req -> slave set
 
diff --git a/src/mds/MDS.cc b/src/mds/MDS.cc
index 935fb0c..16b857e 100644
--- a/src/mds/MDS.cc
+++ b/src/mds/MDS.cc
@@ -1460,7 +1460,6 @@ void MDS::reconnect_done()
 void MDS::rejoin_joint_start()
 {
   dout(1) << "rejoin_joint_start" << dendl;
-  mdcache->finish_committed_masters();
   mdcache->rejoin_send_rejoins();
 }
 void MDS::rejoin_done()
-- 
1.8.1.4

