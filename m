From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 28/39] mds: add dirty imported dirfrag to LogSegment
Date: Sun, 17 Mar 2013 22:51:31 +0800
Message-ID: <1363531902-24909-29-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:30053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932677Ab3CQOxj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:53:39 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CDir.cc     | 7 +++++--
 src/mds/CDir.h      | 2 +-
 src/mds/Migrator.cc | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
index af0ae9c..34bd8d3 100644
--- a/src/mds/CDir.cc
+++ b/src/mds/CDir.cc
@@ -2164,7 +2164,7 @@ void CDir::finish_export(utime_t now)
   dirty_old_rstat.clear();
 }
 
-void CDir::decode_import(bufferlist::iterator& blp, utime_t now)
+void CDir::decode_import(bufferlist::iterator& blp, utime_t now, LogSegment *ls)
 {
   ::decode(first, blp);
   ::decode(fnode, blp);
@@ -2177,7 +2177,10 @@ void CDir::decode_import(bufferlist::iterator& blp, utime_t now)
   ::decode(s, blp);
   state &= MASK_STATE_IMPORT_KEPT;
   state |= (s & MASK_STATE_EXPORTED);
-  if (is_dirty()) get(PIN_DIRTY);
+  if (is_dirty()) {
+    get(PIN_DIRTY);
+    _mark_dirty(ls);
+  }
 
   ::decode(dir_rep, blp);
 
diff --git a/src/mds/CDir.h b/src/mds/CDir.h
index f4a3a3d..7e1db73 100644
--- a/src/mds/CDir.h
+++ b/src/mds/CDir.h
@@ -550,7 +550,7 @@ public:
   void abort_export() { 
     put(PIN_TEMPEXPORTING);
   }
-  void decode_import(bufferlist::iterator& blp, utime_t now);
+  void decode_import(bufferlist::iterator& blp, utime_t now, LogSegment *ls);
 
 
   // -- auth pins --
diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index 833df12..d626cb1 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -2397,7 +2397,7 @@ int Migrator::decode_import_dir(bufferlist::iterator& blp,
   dout(7) << "decode_import_dir " << *dir << dendl;
 
   // assimilate state
-  dir->decode_import(blp, now);
+  dir->decode_import(blp, now, ls);
 
   // mark  (may already be marked from get_or_open_dir() above)
   if (!dir->is_auth())
-- 
1.7.11.7

