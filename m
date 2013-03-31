From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 06/39] mds: make table client/server tolerate duplicated
 message
Date: Sun, 31 Mar 2013 21:21:19 +0800
Message-ID: <5158384F.5020200@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com> <1363531902-24909-7-git-send-email-zheng.z.yan@intel.com> <CAPYLRzi12A+yFFaY35YMsiMCgdh_fec5QCkc7QFExGGHxN_v-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19833 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753562Ab3CaNV0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 31 Mar 2013 09:21:26 -0400
In-Reply-To: <CAPYLRzi12A+yFFaY35YMsiMCgdh_fec5QCkc7QFExGGHxN_v-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On 03/30/2013 06:00 AM, Gregory Farnum wrote:
> I believe this patch has been outdated thanks to the tid exchange
> you're doing now, right?
> -Greg

tid exchange does not avoid duplicated prepare/commit messages, but it makes avoidance of
duplicated messages easier. How about the patch below?

Thanks
Yan, Zheng

----
From e3d7b3e1d757aee847384180e2d6ee59a900ca05 Mon Sep 17 00:00:00 2001
From: "Yan, Zheng" <zheng.z.yan@intel.com>
Date: Sun, 31 Mar 2013 17:54:50 +0800
Subject: [PATCH] mds: avoid sending duplicated table prepare/commit

This patch makes table client defer sending table prepare/commit messages
until receiving table server's 'ready' message. This avoid duplicated table
prepare/commit messages.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/AnchorClient.cc   |  9 +++++--
 src/mds/MDS.cc            | 14 +++++++++--
 src/mds/MDS.h             |  4 +++-
 src/mds/MDSTableClient.cc | 60 +++++++++++++++++++++++++----------------------
 src/mds/MDSTableClient.h  |  7 ++++--
 5 files changed, 59 insertions(+), 35 deletions(-)

diff --git a/src/mds/AnchorClient.cc b/src/mds/AnchorClient.cc
index 455e97f..bcc8710 100644
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
@@ -80,9 +82,12 @@ void AnchorClient::lookup(inodeno_t ino, vector<Anchor>& trace, Context *onfinis
 
 void AnchorClient::_lookup(inodeno_t ino)
 {
+  int ts = mds->mdsmap->get_tableserver();
+  if (mds->mdsmap->get_state(ts) < MDSMap::STATE_REJOIN)
+    return;
   MMDSTableRequest *req = new MMDSTableRequest(table, TABLESERVER_OP_QUERY, 0, 0);
   ::encode(ino, req->bl);
-  mds->send_message_mds(req, mds->mdsmap->get_tableserver());
+  mds->send_message_mds(req, ts);
 }
 
 
diff --git a/src/mds/MDS.cc b/src/mds/MDS.cc
index 32bb064..2d48815 100644
--- a/src/mds/MDS.cc
+++ b/src/mds/MDS.cc
@@ -1050,7 +1050,7 @@ void MDS::handle_mds_map(MMDSMap *m)
     for (set<int>::iterator p = failed.begin(); p != failed.end(); ++p)
       if (oldfailed.count(*p) == 0) {
 	messenger->mark_down(oldmap->get_inst(*p).addr);
-	mdcache->handle_mds_failure(*p);
+	handle_mds_failure(*p);
       }
     
     // or down then up?
@@ -1061,7 +1061,7 @@ void MDS::handle_mds_map(MMDSMap *m)
       if (oldmap->have_inst(*p) &&
 	  oldmap->get_inst(*p) != mdsmap->get_inst(*p)) {
 	messenger->mark_down(oldmap->get_inst(*p).addr);
-	mdcache->handle_mds_failure(*p);
+	handle_mds_failure(*p);
       }
   }
   if (is_clientreplay() || is_active() || is_stopping()) {
@@ -1548,6 +1548,16 @@ void MDS::handle_mds_recovery(int who)
   waiting_for_active_peer.erase(who);
 }
 
+void MDS::handle_mds_failure(int who)
+{
+  dout(5) << "handle_mds_failure mds." << who << dendl;
+
+  mdcache->handle_mds_failure(who);
+
+  anchorclient->handle_mds_failure(who);
+  snapclient->handle_mds_failure(who);
+}
+
 void MDS::stopping_start()
 {
   dout(2) << "stopping_start" << dendl;
diff --git a/src/mds/MDS.h b/src/mds/MDS.h
index 42e8516..6658cf0 100644
--- a/src/mds/MDS.h
+++ b/src/mds/MDS.h
@@ -378,13 +378,15 @@ class MDS : public Dispatcher {
   void rejoin_joint_start();
   void rejoin_done();
   void recovery_done();
-  void handle_mds_recovery(int who);
   void clientreplay_start();
   void clientreplay_done();
   void active_start();
   void stopping_start();
   void stopping_done();
 
+  void handle_mds_recovery(int who);
+  void handle_mds_failure(int who);
+
   void suicide();
   void respawn();
 
diff --git a/src/mds/MDSTableClient.cc b/src/mds/MDSTableClient.cc
index 12331f9..2ce3286 100644
--- a/src/mds/MDSTableClient.cc
+++ b/src/mds/MDSTableClient.cc
@@ -65,18 +65,15 @@ void MDSTableClient::handle_request(class MMDSTableRequest *m)
       }
     } 
     else if (pending_commit.count(tid)) {
-      dout(10) << "stray agree on " << reqid
-	       << " tid " << tid
-	       << ", already committing, resending COMMIT"
-	       << dendl;      
-      MMDSTableRequest *req = new MMDSTableRequest(table, TABLESERVER_OP_COMMIT, 0, tid);
-      mds->send_message_mds(req, mds->mdsmap->get_tableserver());
+      dout(10) << "stray agree on " << reqid << " tid " << tid
+	       << ", already committing, will resend COMMIT" << dendl;
+      assert(!server_ready);
+      // will re-send commit when receiving the server ready message
     }
     else {
-      dout(10) << "stray agree on " << reqid
-	       << " tid " << tid
-	       << ", sending ROLLBACK"
-	       << dendl;      
+      dout(10) << "stray agree on " << reqid << " tid " << tid
+	       << ", sending ROLLBACK" << dendl;
+      assert(!server_ready);
       MMDSTableRequest *req = new MMDSTableRequest(table, TABLESERVER_OP_ROLLBACK, 0, tid);
       mds->send_message_mds(req, mds->mdsmap->get_tableserver());
     }
@@ -102,6 +99,9 @@ void MDSTableClient::handle_request(class MMDSTableRequest *m)
     break;
 
   case TABLESERVER_OP_SERVER_READY:
+    assert(!server_ready);
+    server_ready = true;
+
     if (last_reqid == ~0ULL)
       last_reqid = reqid;
 
@@ -144,26 +144,18 @@ void MDSTableClient::_prepare(bufferlist& mutation, version_t *ptid, bufferlist
   uint64_t reqid = ++last_reqid;
   dout(10) << "_prepare " << reqid << dendl;
 
-  // send message
-  MMDSTableRequest *req = new MMDSTableRequest(table, TABLESERVER_OP_PREPARE, reqid);
-  req->bl = mutation;
-
   pending_prepare[reqid].mutation = mutation;
   pending_prepare[reqid].ptid = ptid;
   pending_prepare[reqid].pbl = pbl;
   pending_prepare[reqid].onfinish = onfinish;
 
-  send_to_tableserver(req);
-}
-
-void MDSTableClient::send_to_tableserver(MMDSTableRequest *req)
-{
-  int ts = mds->mdsmap->get_tableserver();
-  if (mds->mdsmap->get_state(ts) >= MDSMap::STATE_CLIENTREPLAY)
-    mds->send_message_mds(req, ts);
-  else {
-    dout(10) << " deferring request to not-yet-active tableserver mds." << ts << dendl;
-  }
+  if (server_ready) {
+    // send message
+    MMDSTableRequest *req = new MMDSTableRequest(table, TABLESERVER_OP_PREPARE, reqid);
+    req->bl = mutation;
+    mds->send_message_mds(req, mds->mdsmap->get_tableserver());
+  } else
+    dout(10) << "tableserver is not ready yet, deferring request" << dendl;
 }
 
 void MDSTableClient::commit(version_t tid, LogSegment *ls)
@@ -176,9 +168,12 @@ void MDSTableClient::commit(version_t tid, LogSegment *ls)
 
   assert(g_conf->mds_kill_mdstable_at != 4);
 
-  // send message
-  MMDSTableRequest *req = new MMDSTableRequest(table, TABLESERVER_OP_COMMIT, 0, tid);
-  send_to_tableserver(req);
+  if (server_ready) {
+    // send message
+    MMDSTableRequest *req = new MMDSTableRequest(table, TABLESERVER_OP_COMMIT, 0, tid);
+    mds->send_message_mds(req, mds->mdsmap->get_tableserver());
+  } else
+    dout(10) << "tableserver is not ready yet, deferring request" << dendl;
 }
 
 
@@ -228,3 +223,12 @@ void MDSTableClient::resend_prepares()
     mds->send_message_mds(req, mds->mdsmap->get_tableserver());
   }
 }
+
+void MDSTableClient::handle_mds_failure(int who)
+{
+  if (who != mds->mdsmap->get_tableserver())
+    return; // do nothing.
+
+  dout(7) << "tableserver mds." << who << " fails" << dendl;
+  server_ready = false;
+}
diff --git a/src/mds/MDSTableClient.h b/src/mds/MDSTableClient.h
index 934f5fe..f8a84eb 100644
--- a/src/mds/MDSTableClient.h
+++ b/src/mds/MDSTableClient.h
@@ -30,6 +30,8 @@ protected:
 
   uint64_t last_reqid;
 
+  bool server_ready;
+
   // prepares
   struct _pending_prepare {
     Context *onfinish;
@@ -63,7 +65,8 @@ protected:
   void _logged_ack(version_t tid);
 
 public:
-  MDSTableClient(MDS *m, int tab) : mds(m), table(tab), last_reqid(~0ULL) {}
+  MDSTableClient(MDS *m, int tab) :
+    mds(m), table(tab), last_reqid(~0ULL), server_ready(false) {}
   virtual ~MDSTableClient() {}
 
   void handle_request(MMDSTableRequest *m);
@@ -85,7 +88,7 @@ public:
     ack_waiters[tid].push_back(c);
   }
 
-  void send_to_tableserver(MMDSTableRequest *req);
+  void handle_mds_failure(int mds);
 
   // child must implement
   virtual void resend_queries() = 0;
-- 
1.7.11.7

