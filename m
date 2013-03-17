From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 16/39] mds: send cache rejoin messages after gathering all resolves
Date: Sun, 17 Mar 2013 22:51:19 +0800
Message-ID: <1363531902-24909-17-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34328 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932610Ab3CQOwo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:52:44 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 10 ++++++++++
 src/mds/MDCache.h  |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index f102205..6853bf1 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -2914,6 +2914,8 @@ void MDCache::maybe_resolve_finish()
       recalc_auth_bits();
       trim_non_auth(); 
       mds->resolve_done();
+    } else {
+      maybe_send_pending_rejoins();
     }
   }
 }
@@ -3398,6 +3400,13 @@ void MDCache::rejoin_send_rejoins()
 {
   dout(10) << "rejoin_send_rejoins with recovery_set " << recovery_set << dendl;
 
+  if (!resolve_gather.empty()) {
+    dout(7) << "rejoin_send_rejoins still waiting for resolves ("
+	    << resolve_gather << ")" << dendl;
+    rejoins_pending = true;
+    return;
+  }
+
   map<int, MMDSCacheRejoin*> rejoins;
 
   // encode cap list once.
@@ -3571,6 +3580,7 @@ void MDCache::rejoin_send_rejoins()
     mds->send_message_mds(p->second, p->first);
   }
   rejoin_ack_gather.insert(mds->whoami);   // we need to complete rejoin_gather_finish, too
+  rejoins_pending = false;
 
   // nothing?
   if (mds->is_rejoin() && rejoins.empty()) {
diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
index 278debf..379f715 100644
--- a/src/mds/MDCache.h
+++ b/src/mds/MDCache.h
@@ -383,6 +383,7 @@ public:
 
 protected:
   // [rejoin]
+  bool rejoins_pending;
   set<int> rejoin_gather;      // nodes from whom i need a rejoin
   set<int> rejoin_sent;        // nodes i sent a rejoin to
   set<int> rejoin_ack_gather;  // nodes from whom i need a rejoin ack
@@ -417,6 +418,10 @@ protected:
   void handle_cache_rejoin_full(MMDSCacheRejoin *m);
   void rejoin_send_acks();
   void rejoin_trim_undef_inodes();
+  void maybe_send_pending_rejoins() {
+    if (rejoins_pending)
+      rejoin_send_rejoins();
+  }
 public:
   void rejoin_gather_finish();
   void rejoin_send_rejoins();
-- 
1.7.11.7

