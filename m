From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 17/30] mds: defer releasing cap if necessary
Date: Thu, 23 May 2013 16:06:45 +0800
Message-ID: <1369296418-14871-18-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51287 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400Ab3EWINN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:13 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

When inode is freezing or frozen, we defer processing MClientCaps
messages and cap release embedded in requests. The same deferral
logical should also cover MClientCapRelease messages.
---
 src/mds/Locker.cc | 88 +++++++++++++++++++++++++++++++++++--------------------
 src/mds/Locker.h  |  2 ++
 2 files changed, 58 insertions(+), 32 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 7e3e9fd..7823aed 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -2921,41 +2921,65 @@ void Locker::handle_client_cap_release(MClientCapRelease *m)
     return;
   }
 
-  for (vector<ceph_mds_cap_item>::iterator p = m->caps.begin(); p != m->caps.end(); ++p) {
-    inodeno_t ino((uint64_t)p->ino);
-    CInode *in = mdcache->get_inode(ino);
-    if (!in) {
-      dout(10) << " missing ino " << ino << dendl;
-      continue;
-    }
-    Capability *cap = in->get_client_cap(client);
-    if (!cap) {
-      dout(10) << " no cap on " << *in << dendl;
-      continue;
-    }
-    if (cap->get_cap_id() != p->cap_id) {
-      dout(7) << " ignoring client capid " << p->cap_id << " != my " << cap->get_cap_id() << " on " << *in << dendl;
-      continue;
-    }
-    if (ceph_seq_cmp(p->migrate_seq, cap->get_mseq()) < 0) {
-      dout(7) << " mseq " << p->migrate_seq << " < " << cap->get_mseq()
-	      << " on " << *in << dendl;
-      continue;
-    }
-    if (p->seq != cap->get_last_issue()) {
-      dout(10) << " issue_seq " << p->seq << " != " << cap->get_last_issue() << " on " << *in << dendl;
-      
-      // clean out any old revoke history
-      cap->clean_revoke_from(p->seq);
-      eval_cap_gather(in);
-      continue;
-    }
+  for (vector<ceph_mds_cap_item>::iterator p = m->caps.begin(); p != m->caps.end(); ++p)
+    _do_cap_release(client, inodeno_t((uint64_t)p->ino) , p->cap_id, p->migrate_seq, p->seq);
 
-    dout(7) << "removing cap on " << *in << dendl;
-    remove_client_cap(in, client);
+  m->put();
+}
+
+class C_Locker_RetryCapRelease : public Context {
+  Locker *locker;
+  client_t client;
+  inodeno_t ino;
+  uint64_t cap_id;
+  ceph_seq_t migrate_seq;
+  ceph_seq_t issue_seq;
+public:
+  C_Locker_RetryCapRelease(Locker *l, client_t c, inodeno_t i, uint64_t id,
+			   ceph_seq_t mseq, ceph_seq_t seq) :
+    locker(l), client(c), ino(i), cap_id(id), migrate_seq(mseq), issue_seq(seq) {}
+  void finish(int r) {
+    locker->_do_cap_release(client, ino, cap_id, migrate_seq, issue_seq);
   }
+};
 
-  m->put();
+void Locker::_do_cap_release(client_t client, inodeno_t ino, uint64_t cap_id,
+			     ceph_seq_t mseq, ceph_seq_t seq)
+{
+  CInode *in = mdcache->get_inode(ino);
+  if (!in) {
+    dout(7) << "_do_cap_release missing ino " << ino << dendl;
+    return;
+  }
+  Capability *cap = in->get_client_cap(client);
+  if (!cap) {
+    dout(7) << "_do_cap_release no cap for client" << client << " on "<< *in << dendl;
+    return;
+  }
+
+  dout(7) << "_do_cap_release for client." << client << " on "<< *in << dendl;
+  if (cap->get_cap_id() != cap_id) {
+    dout(7) << " capid " << cap_id << " != " << cap->get_cap_id() << ", ignore" << dendl;
+    return;
+  }
+  if (ceph_seq_cmp(mseq, cap->get_mseq()) < 0) {
+    dout(7) << " mseq " << mseq << " < " << cap->get_mseq() << ", ignore" << dendl;
+    return;
+  }
+  if (should_defer_client_cap_frozen(in)) {
+    dout(7) << " freezing|frozen, deferring" << dendl;
+    in->add_waiter(CInode::WAIT_UNFREEZE,
+                  new C_Locker_RetryCapRelease(this, client, ino, cap_id, mseq, seq));
+    return;
+  }
+  if (seq != cap->get_last_issue()) {
+    dout(7) << " issue_seq " << seq << " != " << cap->get_last_issue() << dendl;
+    // clean out any old revoke history
+    cap->clean_revoke_from(seq);
+    eval_cap_gather(in);
+    return;
+  }
+  remove_client_cap(in, client);
 }
 
 /* This function DOES put the passed message before returning */
diff --git a/src/mds/Locker.h b/src/mds/Locker.h
index f4d9861..b97307d 100644
--- a/src/mds/Locker.h
+++ b/src/mds/Locker.h
@@ -225,6 +225,7 @@ public:
   bool _do_cap_update(CInode *in, Capability *cap, int dirty, snapid_t follows, MClientCaps *m,
 		      MClientCaps *ack=0);
   void handle_client_cap_release(class MClientCapRelease *m);
+  void _do_cap_release(client_t client, inodeno_t ino, uint64_t cap_id, ceph_seq_t mseq, ceph_seq_t seq);
 
 
   // local
@@ -284,6 +285,7 @@ private:
   friend class C_MDL_CheckMaxSize;
   friend class C_MDL_RequestInodeFileCaps;
   friend class C_Locker_FileUpdate_finish;
+  friend class C_Locker_RetryCapRelease;
 
   
   // -- client leases --
-- 
1.8.1.4

