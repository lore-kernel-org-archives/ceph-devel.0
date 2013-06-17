From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 8/8] mds: fix remote wrlock rejoin
Date: Mon, 17 Jun 2013 20:10:29 +0800
Message-ID: <1371471029-10589-9-git-send-email-zheng.z.yan@intel.com>
References: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1943 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932860Ab3FQMLp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Jun 2013 08:11:45 -0400
In-Reply-To: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

remote wrlock's target is not always inode's auth MDS.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index f1ebedf..2b127b5 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -4523,25 +4523,29 @@ void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
 	mdr->locks.insert(lock);
       }
     }
-    // wrlock(s)?
-    if (strong->wrlocked_inodes.count(in->vino())) {
-      for (map<int, list<MMDSCacheRejoin::slave_reqid> >::iterator q = strong->wrlocked_inodes[in->vino()].begin();
-	   q != strong->wrlocked_inodes[in->vino()].end();
-	   ++q) {
-	SimpleLock *lock = in->get_lock(q->first);
-	for (list<MMDSCacheRejoin::slave_reqid>::iterator r = q->second.begin();
-	     r != q->second.end();
-	     ++r) {
-	  dout(10) << " inode wrlock by " << *r << " on " << *lock << " on " << *in << dendl;
-	  MDRequest *mdr = request_get(r->reqid);  // should have this from auth_pin above.
+  }
+  // wrlock(s)?
+  for (map<vinodeno_t, map<int, list<MMDSCacheRejoin::slave_reqid> > >::iterator p = strong->wrlocked_inodes.begin();
+       p != strong->wrlocked_inodes.end();
+       ++p) {
+    CInode *in = get_inode(p->first);
+    for (map<int, list<MMDSCacheRejoin::slave_reqid> >::iterator q = p->second.begin();
+	 q != p->second.end();
+	++q) {
+      SimpleLock *lock = in->get_lock(q->first);
+      for (list<MMDSCacheRejoin::slave_reqid>::iterator r = q->second.begin();
+	  r != q->second.end();
+	  ++r) {
+	dout(10) << " inode wrlock by " << *r << " on " << *lock << " on " << *in << dendl;
+	MDRequest *mdr = request_get(r->reqid);  // should have this from auth_pin above.
+	if (in->is_auth())
 	  assert(mdr->is_auth_pinned(in));
-	  lock->set_state(LOCK_MIX);
-	  if (lock == &in->filelock)
-	    in->loner_cap = -1;
-	  lock->get_wrlock(true);
-	  mdr->wrlocks.insert(lock);
-	  mdr->locks.insert(lock);
-	}
+	lock->set_state(LOCK_MIX);
+	if (lock == &in->filelock)
+	  in->loner_cap = -1;
+	lock->get_wrlock(true);
+	mdr->wrlocks.insert(lock);
+	mdr->locks.insert(lock);
       }
     }
   }
-- 
1.8.1.4

