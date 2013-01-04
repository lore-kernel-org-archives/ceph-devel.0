From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 19/29] mds: disable concurrent remote locking
Date: Fri,  4 Jan 2013 17:02:10 +0800
Message-ID: <1357290140-17044-20-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28255 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753971Ab3ADJCs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:48 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Current code allows multiple MDRequests to concurrently acquire a
remote lock. But a lock ACK message wakes all requests because they
were all put to the same waiting queue. One request gets the lock,
the rest requests will re-send the OP_WRLOCK/OPWRLOCK slave requests
and trigger assertion on remote MDS. The fix is disable concurrently
acquiring remote lock, send OP_WRLOCK/OPWRLOCK slave request only
if there is no on-going slave request.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 54 ++++++++++++++++++++++++++++++++----------------------
 src/mds/Server.cc |  2 ++
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index dbf4452..cba894b 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -532,14 +532,18 @@ void Locker::cancel_locking(Mutation *mut, set<CInode*> *pneed_issue)
   assert(lock);
   dout(10) << "cancel_locking " << *lock << " on " << *mut << dendl;
 
-  if (lock->get_type() != CEPH_LOCK_DN) {
-    bool need_issue = false;
-    if (lock->get_state() == LOCK_PREXLOCK)
-      _finish_xlock(lock, &need_issue);
-    if (lock->is_stable())
-      eval(lock, &need_issue);
-    if (need_issue)
-      pneed_issue->insert((CInode *)lock->get_parent());
+  if (lock->get_parent()->is_auth()) {
+    if (lock->get_type() != CEPH_LOCK_DN) {
+      bool need_issue = false;
+      if (lock->get_state() == LOCK_PREXLOCK)
+	_finish_xlock(lock, &need_issue);
+      if (lock->is_stable())
+	eval(lock, &need_issue);
+      if (need_issue)
+	pneed_issue->insert((CInode *)lock->get_parent());
+    }
+  } else {
+    lock->finish_waiters(SimpleLock::WAIT_REMOTEXLOCK);
   }
   mut->finish_locking(lock);
 }
@@ -1314,14 +1318,17 @@ void Locker::remote_wrlock_start(SimpleLock *lock, int target, MDRequest *mut)
 				   new C_MDS_RetryRequest(mdcache, mut));
     return;
   }
-    
+
   // send lock request
-  mut->more()->slaves.insert(target);
-  MMDSSlaveRequest *r = new MMDSSlaveRequest(mut->reqid, mut->attempt,
-					     MMDSSlaveRequest::OP_WRLOCK);
-  r->set_lock_type(lock->get_type());
-  lock->get_parent()->set_object_info(r->get_object_info());
-  mds->send_message_mds(r, target);
+  if (!lock->is_waiter_for(SimpleLock::WAIT_REMOTEXLOCK)) {
+    mut->start_locking(lock);
+    mut->more()->slaves.insert(target);
+    MMDSSlaveRequest *r = new MMDSSlaveRequest(mut->reqid, mut->attempt,
+					       MMDSSlaveRequest::OP_WRLOCK);
+    r->set_lock_type(lock->get_type());
+    lock->get_parent()->set_object_info(r->get_object_info());
+    mds->send_message_mds(r, target);
+  }
   
   // wait
   lock->add_waiter(SimpleLock::WAIT_REMOTEXLOCK, new C_MDS_RetryRequest(mdcache, mut));
@@ -1398,13 +1405,16 @@ bool Locker::xlock_start(SimpleLock *lock, MDRequest *mut)
     }
     
     // send lock request
-    int auth = lock->get_parent()->authority().first;
-    mut->more()->slaves.insert(auth);
-    MMDSSlaveRequest *r = new MMDSSlaveRequest(mut->reqid, mut->attempt,
-					       MMDSSlaveRequest::OP_XLOCK);
-    r->set_lock_type(lock->get_type());
-    lock->get_parent()->set_object_info(r->get_object_info());
-    mds->send_message_mds(r, auth);
+    if (!lock->is_waiter_for(SimpleLock::WAIT_REMOTEXLOCK)) {
+      mut->start_locking(lock);
+      int auth = lock->get_parent()->authority().first;
+      mut->more()->slaves.insert(auth);
+      MMDSSlaveRequest *r = new MMDSSlaveRequest(mut->reqid, mut->attempt,
+						 MMDSSlaveRequest::OP_XLOCK);
+      r->set_lock_type(lock->get_type());
+      lock->get_parent()->set_object_info(r->get_object_info());
+      mds->send_message_mds(r, auth);
+    }
     
     // wait
     lock->add_waiter(SimpleLock::WAIT_REMOTEXLOCK, new C_MDS_RetryRequest(mdcache, mut));
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index c5793e5..517339f 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -1324,6 +1324,7 @@ void Server::handle_slave_request_reply(MMDSSlaveRequest *m)
       dout(10) << "got remote xlock on " << *lock << " on " << *lock->get_parent() << dendl;
       mdr->xlocks.insert(lock);
       mdr->locks.insert(lock);
+      mdr->finish_locking(lock);
       lock->get_xlock(mdr, mdr->get_client());
       lock->finish_waiters(SimpleLock::WAIT_REMOTEXLOCK);
     }
@@ -1338,6 +1339,7 @@ void Server::handle_slave_request_reply(MMDSSlaveRequest *m)
       dout(10) << "got remote wrlock on " << *lock << " on " << *lock->get_parent() << dendl;
       mdr->remote_wrlocks[lock] = from;
       mdr->locks.insert(lock);
+      mdr->finish_locking(lock);
       lock->finish_waiters(SimpleLock::WAIT_REMOTEXLOCK);
     }
     break;
-- 
1.7.11.7

