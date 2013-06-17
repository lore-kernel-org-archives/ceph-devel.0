From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 5/8] mds: fix cross-authorty rename race
Date: Mon, 17 Jun 2013 20:10:26 +0800
Message-ID: <1371471029-10589-6-git-send-email-zheng.z.yan@intel.com>
References: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1943 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932719Ab3FQMLo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Jun 2013 08:11:44 -0400
In-Reply-To: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

When doing cross-authorty rename, we need to make sure bystanders
have received all messages sent by inode's original auth MDS,
then change inode's authorty. Otherwise lock messages sent by the
original/new auth MDS can arrive bystanders out of order. The fix
is: inode's original auth MDS sends notify messages to bystanders,
performs slave rename after receiving all bystanders' notify acks.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc              | 31 ++++++++++++++++++++-----
 src/mds/Server.cc               | 51 +++++++++++++++++++++++++++++++++++++++--
 src/mds/Server.h                |  1 +
 src/messages/MMDSSlaveRequest.h |  6 +++++
 4 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index b9b154d..2b0029f 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -2651,6 +2651,15 @@ void MDCache::handle_mds_failure(int who)
     if (p->second->slave_to_mds == who) {
       if (p->second->slave_did_prepare()) {
 	dout(10) << " slave request " << *p->second << " uncommitted, will resolve shortly" << dendl;
+	if (!p->second->more()->waiting_on_slave.empty()) {
+	  assert(p->second->more()->srcdn_auth_mds == mds->get_nodeid());
+	  // will rollback, no need to wait
+	  if (p->second->slave_request) {
+	    p->second->slave_request->put();
+	    p->second->slave_request = 0;
+	  }
+	  p->second->more()->waiting_on_slave.clear();
+	}
       } else {
 	dout(10) << " slave request " << *p->second << " has no prepare, finishing up" << dendl;
 	if (p->second->slave_request)
@@ -2660,12 +2669,22 @@ void MDCache::handle_mds_failure(int who)
       }
     }
 
-    if (p->second->is_slave() &&
-	p->second->slave_did_prepare() && p->second->more()->srcdn_auth_mds == who &&
-	mds->mdsmap->is_clientreplay_or_active_or_stopping(p->second->slave_to_mds)) {
-      // rename srcdn's auth mds failed, resolve even I'm a survivor.
-      dout(10) << " slave request " << *p->second << " uncommitted, will resolve shortly" << dendl;
-      add_ambiguous_slave_update(p->first, p->second->slave_to_mds);
+    if (p->second->is_slave() && p->second->slave_did_prepare()) {
+      if (p->second->more()->waiting_on_slave.count(who)) {
+	assert(p->second->more()->srcdn_auth_mds == mds->get_nodeid());
+	dout(10) << " slave request " << *p->second << " no longer need rename notity ack from mds."
+		 << who << dendl;
+	p->second->more()->waiting_on_slave.erase(who);
+	if (p->second->more()->waiting_on_slave.empty())
+	  mds->queue_waiter(new C_MDS_RetryRequest(this, p->second));
+      }
+
+      if (p->second->more()->srcdn_auth_mds == who &&
+	  mds->mdsmap->is_clientreplay_or_active_or_stopping(p->second->slave_to_mds)) {
+	// rename srcdn's auth mds failed, resolve even I'm a survivor.
+	dout(10) << " slave request " << *p->second << " uncommitted, will resolve shortly" << dendl;
+	add_ambiguous_slave_update(p->first, p->second->slave_to_mds);
+      }
     }
     
     // failed node is slave?
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index c3162e7..00bf018 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -1280,6 +1280,16 @@ void Server::handle_slave_request(MMDSSlaveRequest *m)
   if (m->is_reply())
     return handle_slave_request_reply(m);
 
+  // the purpose of rename notify is enforcing causal message ordering. making sure
+  // bystanders have received all messages from rename srcdn's auth MDS.
+  if (m->get_op() == MMDSSlaveRequest::OP_RENAMENOTIFY) {
+    MMDSSlaveRequest *reply = new MMDSSlaveRequest(m->get_reqid(), m->get_attempt(),
+						   MMDSSlaveRequest::OP_RENAMENOTIFYACK);
+    mds->send_message(reply, m->get_connection());
+    m->put();
+    return;
+  }
+
   CDentry *straydn = NULL;
   if (m->stray.length() > 0) {
     straydn = mdcache->add_replica_stray(m->stray, from);
@@ -1432,6 +1442,10 @@ void Server::handle_slave_request_reply(MMDSSlaveRequest *m)
     handle_slave_rename_prep_ack(mdr, m);
     break;
 
+  case MMDSSlaveRequest::OP_RENAMENOTIFYACK:
+    handle_slave_rename_notify_ack(mdr, m);
+    break;
+
   default:
     assert(0);
   }
@@ -6560,6 +6574,9 @@ void Server::handle_slave_rename_prep(MDRequest *mdr)
 
   // am i srcdn auth?
   if (srcdn->is_auth()) {
+    set<int> srcdnrep;
+    srcdn->list_replicas(srcdnrep);
+
     bool reply_witness = false;
     if (srcdnl->is_primary() && !srcdnl->get_inode()->state_test(CInode::STATE_AMBIGUOUSAUTH)) {
       // freeze?
@@ -6594,12 +6611,19 @@ void Server::handle_slave_rename_prep(MDRequest *mdr)
       if (mdr->slave_request->witnesses.size() > 1) {
 	dout(10) << " set srci ambiguous auth; providing srcdn replica list" << dendl;
 	reply_witness = true;
+	for (set<int>::iterator p = srcdnrep.begin(); p != srcdnrep.end(); ++p) {
+	  if (*p == mdr->slave_to_mds ||
+	      !mds->mdsmap->is_clientreplay_or_active_or_stopping(*p))
+	    continue;
+	  MMDSSlaveRequest *notify = new MMDSSlaveRequest(mdr->reqid, mdr->attempt,
+							  MMDSSlaveRequest::OP_RENAMENOTIFY);
+	  mds->send_message_mds(notify, *p);
+	  mdr->more()->waiting_on_slave.insert(*p);
+	}
       }
     }
 
     // is witness list sufficient?
-    set<int> srcdnrep;
-    srcdn->list_replicas(srcdnrep);
     for (set<int>::iterator p = srcdnrep.begin(); p != srcdnrep.end(); ++p) {
       if (*p == mdr->slave_to_mds ||
 	  mdr->slave_request->witnesses.count(*p)) continue;
@@ -6619,6 +6643,11 @@ void Server::handle_slave_rename_prep(MDRequest *mdr)
       return;	
     }
     dout(10) << " witness list sufficient: includes all srcdn replicas" << dendl;
+    if (!mdr->more()->waiting_on_slave.empty()) {
+      dout(10) << " still waiting for rename notify acks from "
+	       << mdr->more()->waiting_on_slave << dendl;
+      return;
+    }
   } else if (srcdnl->is_primary() && srcdn->authority() != destdn->authority()) {
     // set ambiguous auth for srci on witnesses
     mdr->set_ambiguous_auth(srcdnl->get_inode());
@@ -7187,6 +7216,24 @@ void Server::handle_slave_rename_prep_ack(MDRequest *mdr, MMDSSlaveRequest *ack)
     dout(10) << "still waiting on slaves " << mdr->more()->waiting_on_slave << dendl;
 }
 
+void Server::handle_slave_rename_notify_ack(MDRequest *mdr, MMDSSlaveRequest *ack)
+{
+  dout(10) << "handle_slave_rename_notify_ack " << *mdr << " from mds."
+	   << ack->get_source() << dendl;
+  assert(mdr->is_slave());
+  int from = ack->get_source().num();
+
+  if (mdr->more()->waiting_on_slave.count(from)) {
+    mdr->more()->waiting_on_slave.erase(from);
+
+    if (mdr->more()->waiting_on_slave.empty()) {
+      if (mdr->slave_request)
+	dispatch_slave_request(mdr);
+    } else 
+      dout(10) << " still waiting for rename notify acks from "
+	       << mdr->more()->waiting_on_slave << dendl;
+  }
+}
 
 
 
diff --git a/src/mds/Server.h b/src/mds/Server.h
index 35a405b..269b286 100644
--- a/src/mds/Server.h
+++ b/src/mds/Server.h
@@ -242,6 +242,7 @@ public:
   // slaving
   void handle_slave_rename_prep(MDRequest *mdr);
   void handle_slave_rename_prep_ack(MDRequest *mdr, MMDSSlaveRequest *m);
+  void handle_slave_rename_notify_ack(MDRequest *mdr, MMDSSlaveRequest *m);
   void _logged_slave_rename(MDRequest *mdr, CDentry *srcdn, CDentry *destdn, CDentry *straydn);
   void _commit_slave_rename(MDRequest *mdr, int r, CDentry *srcdn, CDentry *destdn, CDentry *straydn);
   void do_rename_rollback(bufferlist &rbl, int master, MDRequest *mdr, bool finish_mdr=false);
diff --git a/src/messages/MMDSSlaveRequest.h b/src/messages/MMDSSlaveRequest.h
index 35af81d..f8f30b2 100644
--- a/src/messages/MMDSSlaveRequest.h
+++ b/src/messages/MMDSSlaveRequest.h
@@ -43,6 +43,9 @@ class MMDSSlaveRequest : public Message {
 
   static const int OP_DROPLOCKS	= 11;
 
+  static const int OP_RENAMENOTIFY = 12;
+  static const int OP_RENAMENOTIFYACK = -12;
+
   static const int OP_FINISH = 17;  
   static const int OP_COMMITTED = -18;  
 
@@ -77,6 +80,9 @@ class MMDSSlaveRequest : public Message {
 
     case OP_DROPLOCKS: return "drop_locks";
 
+    case OP_RENAMENOTIFY: return "reame_notify";
+    case OP_RENAMENOTIFYACK: return "rename_notify_ack";
+
     case OP_ABORT: return "abort";
       //case OP_COMMIT: return "commit";
 
-- 
1.8.1.4

