From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] mds: Clean up finished two phase commits
Date: Wed, 19 Sep 2012 15:52:36 +0800
Message-ID: <1348041156-2990-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48196 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217Ab2ISHwj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 Sep 2012 03:52:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

When handling master request with slaves, the mds could crash
after receiving all slaves' commit acknowledgement, but before
journalling the ECommitted. Current MDS recovery code does not
handle this case correctly, the request will be left in
LogSegment's uncommitted_masters after recovery is finished.
It prevents LogSegment from being trimmed. The fix is find and
clean up request of this kind when recovery enters rejoin stage.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 18 ++++++++++++++++++
 src/mds/MDCache.h  |  1 +
 src/mds/MDS.cc     |  1 +
 3 files changed, 20 insertions(+)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 9ac7a62..da3affb 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -2163,6 +2163,24 @@ void MDCache::committed_master_slave(metareqid_t r, int from)
 }
 
 
+/*
+ * The mds could crash after receiving all slaves' commit acknowledgement,
+ * but before journalling the ECommitted.
+ */
+void MDCache::finish_committed_masters()
+{
+  map<metareqid_t, umaster>::iterator p = uncommitted_masters.begin();
+  while (p != uncommitted_masters.end()) {
+    if (p->second.slaves.empty()) {
+      metareqid_t reqid = p->first;
+      dout(10) << "finish_committed_masters " << reqid << dendl;
+      ++p;
+      log_master_commit(reqid);
+    } else {
+      ++p;
+    }
+  }
+}
 
 /*
  * at end of resolve... we must journal a commit|abort for all slave
diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
index 9c7b096..12bdb03 100644
--- a/src/mds/MDCache.h
+++ b/src/mds/MDCache.h
@@ -291,6 +291,7 @@ public:
   void log_master_commit(metareqid_t reqid);
   void _logged_master_commit(metareqid_t reqid, LogSegment *ls, list<Context*> &waiters);
   void committed_master_slave(metareqid_t r, int from);
+  void finish_committed_masters();
 
   void _logged_slave_commit(int from, metareqid_t reqid);
 
diff --git a/src/mds/MDS.cc b/src/mds/MDS.cc
index ce306c4..d0aac30 100644
--- a/src/mds/MDS.cc
+++ b/src/mds/MDS.cc
@@ -1413,6 +1413,7 @@ void MDS::reconnect_done()
 void MDS::rejoin_joint_start()
 {
   dout(1) << "rejoin_joint_start" << dendl;
+  mdcache->finish_committed_masters();
   mdcache->rejoin_send_rejoins();
 }
 void MDS::rejoin_done()
-- 
1.7.11.4

