From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 06/39] mds: make table client/server tolerate duplicated message
Date: Sun, 17 Mar 2013 22:51:09 +0800
Message-ID: <1363531902-24909-7-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34328 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932476Ab3CQOwI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:52:08 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Anchor client re-sends queries when the anchor server becomes active.
So it's possible to get duplicated query reply.

When the table server recovers, the clients re-send commits to the
server, the server re-sends 'agree' messages to the clients. When
the clients receive the 'agree' messages, they may send another
commit/rollback message to the server.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/AnchorClient.cc   |  4 +++-
 src/mds/AnchorServer.cc   |  6 ++++--
 src/mds/MDSTableServer.cc | 22 ++++++++++++++++------
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/src/mds/AnchorClient.cc b/src/mds/AnchorClient.cc
index d7da9d1..bcc8710 100644
--- a/src/mds/AnchorClient.cc
+++ b/src/mds/AnchorClient.cc
@@ -41,7 +41,9 @@ void AnchorClient::handle_query_result(class MMDSTableRequest *m)
   ::decode(ino, p);
   ::decode(trace, p);
 
-  assert(pending_lookup.count(ino));
+  if (!pending_lookup.count(ino))
+    return;
+
   list<_pending_lookup> ls;
   ls.swap(pending_lookup[ino]);
   pending_lookup.erase(ino);
diff --git a/src/mds/AnchorServer.cc b/src/mds/AnchorServer.cc
index 6f37e53..594bf7b 100644
--- a/src/mds/AnchorServer.cc
+++ b/src/mds/AnchorServer.cc
@@ -213,10 +213,12 @@ bool AnchorServer::check_pending(version_t tid, MMDSTableRequest *req, list<Cont
       ++p;
     }
     assert(p != pending.end());
-    assert(p->second == NULL);
     // not the earliest pending operation, wait if it's a commit
     if (req) {
-      p->second = new C_MDS_RetryMessage(mds, req);
+      if (p->second == NULL)
+	p->second = new C_MDS_RetryMessage(mds, req);
+      else
+	req->put(); // duplicated commit
       return false;
     }
   }
diff --git a/src/mds/MDSTableServer.cc b/src/mds/MDSTableServer.cc
index 07c7d26..730606f 100644
--- a/src/mds/MDSTableServer.cc
+++ b/src/mds/MDSTableServer.cc
@@ -120,15 +120,25 @@ void MDSTableServer::_commit_logged(MMDSTableRequest *req)
 void MDSTableServer::handle_rollback(MMDSTableRequest *req)
 {
   dout(7) << "handle_rollback " << *req << dendl;
-  _rollback(req->get_tid());
-  _note_rollback(req->get_tid());
-  mds->mdlog->start_submit_entry(new ETableServer(table, TABLESERVER_OP_ROLLBACK, 0, -1, 
-						  req->get_tid(), version));
+
+  version_t tid = req->get_tid();
+  if (pending_for_mds.count(tid)) {
+    _rollback(tid);
+    _note_rollback(tid);
+    mds->mdlog->start_submit_entry(new ETableServer(table, TABLESERVER_OP_ROLLBACK, 0, -1,
+	  tid, version));
+  } else if (tid <= version) {
+    dout(0) << "got rollback for tid " << tid << " <= " << version
+	    << ", already rollbacked or committed." << dendl;
+  }
+  else {
+    // wtf.
+    dout(0) << "got rollbacked for tid " << tid << " > " << version << dendl;
+    assert(tid <= version);
+  }
   req->put();
 }
 
-
-
 // SERVER UPDATE
 
 void MDSTableServer::do_server_update(bufferlist& bl)
-- 
1.7.11.7

