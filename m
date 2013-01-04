From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 13/29] mds: indroduce DROPLOCKS slave request
Date: Fri,  4 Jan 2013 17:02:04 +0800
Message-ID: <1357290140-17044-14-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17477 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753697Ab3ADJCl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:41 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

In some rare case, Locker::acquire_locks() drops all acquired locks
in order to auth pin new objects. But Locker::drop_locks only drops
explicitly acquired remote locks, does not drop objects' version
locks that were implicitly acquired on remote MDS. These leftover
locks break locking order when re-acquiring _locks and may cause
dead lock.

The fix is indroduce DROPLOCKS slave request which drops all acquired
lock on remote MDS.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc               | 30 +++++++++++++++++++++++++++---
 src/mds/Server.cc               |  6 ++++++
 src/messages/MMDSSlaveRequest.h |  4 ++++
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 98eaba8..dec0a94 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -483,16 +483,31 @@ void Locker::_drop_rdlocks(Mutation *mut, set<CInode*> *pneed_issue)
 
 void Locker::_drop_non_rdlocks(Mutation *mut, set<CInode*> *pneed_issue)
 {
+  set<int> slaves;
+
   while (!mut->xlocks.empty()) {
+    SimpleLock *lock = *mut->xlocks.begin();
+    MDSCacheObject *p = lock->get_parent();
+    if (!p->is_auth()) {
+      assert(lock->get_sm()->can_remote_xlock);
+      slaves.insert(p->authority().first);
+      lock->put_xlock();
+      mut->locks.erase(lock);
+      mut->xlocks.erase(lock);
+      continue;
+    }
     bool ni = false;
-    MDSCacheObject *p = (*mut->xlocks.begin())->get_parent();
-    xlock_finish(*mut->xlocks.begin(), mut, &ni);
+    xlock_finish(lock, mut, &ni);
     if (ni)
       pneed_issue->insert((CInode*)p);
   }
+
   while (!mut->remote_wrlocks.empty()) {
-    remote_wrlock_finish(mut->remote_wrlocks.begin()->first, mut->remote_wrlocks.begin()->second, mut);
+    slaves.insert(mut->remote_wrlocks.begin()->second);
+    mut->locks.erase(mut->remote_wrlocks.begin()->first);
+    mut->remote_wrlocks.erase(mut->remote_wrlocks.begin());
   }
+
   while (!mut->wrlocks.empty()) {
     bool ni = false;
     MDSCacheObject *p = (*mut->wrlocks.begin())->get_parent();
@@ -500,6 +515,15 @@ void Locker::_drop_non_rdlocks(Mutation *mut, set<CInode*> *pneed_issue)
     if (ni)
       pneed_issue->insert((CInode*)p);
   }
+
+  for (set<int>::iterator p = slaves.begin(); p != slaves.end(); p++) {
+    if (mds->mdsmap->get_state(*p) >= MDSMap::STATE_REJOIN) {
+      dout(10) << "_drop_non_rdlocks dropping remote locks on mds." << *p << dendl;
+      MMDSSlaveRequest *slavereq = new MMDSSlaveRequest(mut->reqid, mut->attempt,
+							MMDSSlaveRequest::OP_DROPLOCKS);
+      mds->send_message_mds(slavereq, *p);
+    }
+  }
 }
 
 void Locker::cancel_locking(Mutation *mut, set<CInode*> *pneed_issue)
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 6700eda..6097552 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -1455,6 +1455,12 @@ void Server::dispatch_slave_request(MDRequest *mdr)
     }
     break;
 
+  case MMDSSlaveRequest::OP_DROPLOCKS:
+    mds->locker->drop_locks(mdr);
+    mdr->slave_request->put();
+    mdr->slave_request = 0;
+    break;
+
   case MMDSSlaveRequest::OP_AUTHPIN:
     handle_slave_auth_pin(mdr);
     break;
diff --git a/src/messages/MMDSSlaveRequest.h b/src/messages/MMDSSlaveRequest.h
index 03ec582..35af81d 100644
--- a/src/messages/MMDSSlaveRequest.h
+++ b/src/messages/MMDSSlaveRequest.h
@@ -41,6 +41,8 @@ class MMDSSlaveRequest : public Message {
   static const int OP_RMDIRPREP = 10;
   static const int OP_RMDIRPREPACK = -10;
 
+  static const int OP_DROPLOCKS	= 11;
+
   static const int OP_FINISH = 17;  
   static const int OP_COMMITTED = -18;  
 
@@ -73,6 +75,8 @@ class MMDSSlaveRequest : public Message {
     case OP_RMDIRPREP: return "rmdir_prep";
     case OP_RMDIRPREPACK: return "rmdir_prep_ack";
 
+    case OP_DROPLOCKS: return "drop_locks";
+
     case OP_ABORT: return "abort";
       //case OP_COMMIT: return "commit";
 
-- 
1.7.11.7

