From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 05/30] mds: fix uncommitted master wait
Date: Thu, 23 May 2013 16:06:33 +0800
Message-ID: <1369296418-14871-6-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51287 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438Ab3EWINH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:07 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

We may add new waiter while the master is committing. so we should
take the waiters and wake up them when the master is committed.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 23 +++++++++--------------
 src/mds/MDCache.h  |  2 +-
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index cc661f2..24ef1cd 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -2144,32 +2144,27 @@ void MDCache::predirty_journal_parents(Mutation *mut, EMetaBlob *blob,
 struct C_MDC_CommittedMaster : public Context {
   MDCache *cache;
   metareqid_t reqid;
-  LogSegment *ls;
-  list<Context*> waiters;
-  C_MDC_CommittedMaster(MDCache *s, metareqid_t r, LogSegment *l, list<Context*> &w) :
-    cache(s), reqid(r), ls(l) {
-    waiters.swap(w);
-  }
+  C_MDC_CommittedMaster(MDCache *s, metareqid_t r) : cache(s), reqid(r) {}
   void finish(int r) {
-    cache->_logged_master_commit(reqid, ls, waiters);
+    cache->_logged_master_commit(reqid);
   }
 };
 
 void MDCache::log_master_commit(metareqid_t reqid)
 {
   dout(10) << "log_master_commit " << reqid << dendl;
+  uncommitted_masters[reqid].committing = true;
   mds->mdlog->start_submit_entry(new ECommitted(reqid), 
-				 new C_MDC_CommittedMaster(this, reqid, 
-							   uncommitted_masters[reqid].ls,
-							   uncommitted_masters[reqid].waiters));
-  mds->mdcache->uncommitted_masters.erase(reqid);
+				 new C_MDC_CommittedMaster(this, reqid));
 }
 
-void MDCache::_logged_master_commit(metareqid_t reqid, LogSegment *ls, list<Context*> &waiters)
+void MDCache::_logged_master_commit(metareqid_t reqid)
 {
   dout(10) << "_logged_master_commit " << reqid << dendl;
-  ls->uncommitted_masters.erase(reqid);
-  mds->queue_waiters(waiters);
+  assert(uncommitted_masters.count(reqid));
+  uncommitted_masters[reqid].ls->uncommitted_masters.erase(reqid);
+  mds->queue_waiters(uncommitted_masters[reqid].waiters);
+  uncommitted_masters.erase(reqid);
 }
 
 // while active...
diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
index d837586..c41692b 100644
--- a/src/mds/MDCache.h
+++ b/src/mds/MDCache.h
@@ -291,7 +291,7 @@ public:
   }
   void log_master_commit(metareqid_t reqid);
   void logged_master_update(metareqid_t reqid);
-  void _logged_master_commit(metareqid_t reqid, LogSegment *ls, list<Context*> &waiters);
+  void _logged_master_commit(metareqid_t reqid);
   void committed_master_slave(metareqid_t r, int from);
   void finish_committed_masters();
 
-- 
1.8.1.4

