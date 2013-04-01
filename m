From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] mds: don't roll back prepared table updates
Date: Mon,  1 Apr 2013 16:51:22 +0800
Message-ID: <1364806282-15071-2-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
 <1364806282-15071-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19353 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755591Ab3DAIvi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 1 Apr 2013 04:51:38 -0400
In-Reply-To: <1364806282-15071-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com, greg@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

When table server is recovering, it re-sends 'agree' messages for
prepared table updates. It is possible table client receives an
'agree' messages before it commits the corresponding update. Don't
send 'rollback' message back to the server in this case.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDSTableClient.cc | 11 ++++++++++-
 src/mds/MDSTableClient.h  |  1 +
 src/mds/MDSTableServer.cc |  9 ++++++---
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/src/mds/MDSTableClient.cc b/src/mds/MDSTableClient.cc
index 2ce3286..b478149 100644
--- a/src/mds/MDSTableClient.cc
+++ b/src/mds/MDSTableClient.cc
@@ -59,11 +59,17 @@ void MDSTableClient::handle_request(class MMDSTableRequest *m)
       if (pending_prepare[reqid].pbl)
 	*pending_prepare[reqid].pbl = m->bl;
       pending_prepare.erase(reqid);
+      prepared_update[tid] = reqid;
       if (onfinish) {
         onfinish->finish(0);
         delete onfinish;
       }
-    } 
+    }
+    else if (prepared_update.count(tid)) {
+      dout(10) << "got duplicated agree on " << reqid << " atid " << tid << dendl;
+      assert(prepared_update[tid] == reqid);
+      assert(!server_ready);
+    }
     else if (pending_commit.count(tid)) {
       dout(10) << "stray agree on " << reqid << " tid " << tid
 	       << ", already committing, will resend COMMIT" << dendl;
@@ -162,6 +168,9 @@ void MDSTableClient::commit(version_t tid, LogSegment *ls)
 {
   dout(10) << "commit " << tid << dendl;
 
+  assert(prepared_update.count(tid));
+  prepared_update.erase(tid);
+
   assert(pending_commit.count(tid) == 0);
   pending_commit[tid] = ls;
   ls->pending_commit_tids[table].insert(tid);
diff --git a/src/mds/MDSTableClient.h b/src/mds/MDSTableClient.h
index f8a84eb..16b14c4 100644
--- a/src/mds/MDSTableClient.h
+++ b/src/mds/MDSTableClient.h
@@ -45,6 +45,7 @@ protected:
   };
 
   map<uint64_t, _pending_prepare> pending_prepare;
+  map<version_t, uint64_t> prepared_update;
   list<_pending_prepare> waiting_for_reqid;
 
   // pending commits
diff --git a/src/mds/MDSTableServer.cc b/src/mds/MDSTableServer.cc
index 00bea5e..b775246 100644
--- a/src/mds/MDSTableServer.cc
+++ b/src/mds/MDSTableServer.cc
@@ -120,10 +120,13 @@ void MDSTableServer::_commit_logged(MMDSTableRequest *req)
 void MDSTableServer::handle_rollback(MMDSTableRequest *req)
 {
   dout(7) << "handle_rollback " << *req << dendl;
-  _rollback(req->get_tid());
-  _note_rollback(req->get_tid());
+
+  version_t tid = req->get_tid();
+  assert(pending_for_mds.count(tid));
+  _rollback(tid);
+  _note_rollback(tid);
   mds->mdlog->start_submit_entry(new ETableServer(table, TABLESERVER_OP_ROLLBACK, 0, -1, 
-						  req->get_tid(), version));
+						  tid, version));
   req->put();
 }
 
-- 
1.7.11.7

