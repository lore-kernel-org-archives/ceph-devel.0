From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 23/39] mds: reqid for rejoinning authpin/wrlock need to be list
Date: Sun, 17 Mar 2013 22:51:26 +0800
Message-ID: <1363531902-24909-24-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23734 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932610Ab3CQOxg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:53:36 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc             | 78 ++++++++++++++++++++++++------------------
 src/messages/MMDSCacheRejoin.h | 12 +++----
 2 files changed, 50 insertions(+), 40 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 38b1fdf..f4622de 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -4305,16 +4305,19 @@ void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
       // dn auth_pin?
       if (strong->authpinned_dentries.count(p->first) &&
 	  strong->authpinned_dentries[p->first].count(q->first)) {
-	MMDSCacheRejoin::slave_reqid r = strong->authpinned_dentries[p->first][q->first];
-	dout(10) << " dn authpin by " << r << " on " << *dn << dendl;
-	
-	// get/create slave mdrequest
-	MDRequest *mdr;
-	if (have_request(r.reqid))
-	  mdr = request_get(r.reqid);
-	else
-	  mdr = request_start_slave(r.reqid, r.attempt, from);
-	mdr->auth_pin(dn);
+	for (list<MMDSCacheRejoin::slave_reqid>::iterator r = strong->authpinned_dentries[p->first][q->first].begin();
+	     r != strong->authpinned_dentries[p->first][q->first].end();
+	     ++r) {
+	  dout(10) << " dn authpin by " << *r << " on " << *dn << dendl;
+
+	  // get/create slave mdrequest
+	  MDRequest *mdr;
+	  if (have_request(r->reqid))
+	    mdr = request_get(r->reqid);
+	  else
+	    mdr = request_start_slave(r->reqid, r->attempt, from);
+	  mdr->auth_pin(dn);
+	}
       }
 
       // dn xlock?
@@ -4389,22 +4392,25 @@ void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
 
     // auth pin?
     if (strong->authpinned_inodes.count(in->vino())) {
-      MMDSCacheRejoin::slave_reqid r = strong->authpinned_inodes[in->vino()];
-      dout(10) << " inode authpin by " << r << " on " << *in << dendl;
+      for (list<MMDSCacheRejoin::slave_reqid>::iterator r = strong->authpinned_inodes[in->vino()].begin();
+	   r != strong->authpinned_inodes[in->vino()].end();
+	   ++r) {
+	dout(10) << " inode authpin by " << *r << " on " << *in << dendl;
 
-      // get/create slave mdrequest
-      MDRequest *mdr;
-      if (have_request(r.reqid))
-	mdr = request_get(r.reqid);
-      else
-	mdr = request_start_slave(r.reqid, r.attempt, from);
-      if (strong->frozen_authpin_inodes.count(in->vino())) {
-	assert(!in->get_num_auth_pins());
-	mdr->freeze_auth_pin(in);
-      } else {
-	assert(!in->is_frozen_auth_pin());
+	// get/create slave mdrequest
+	MDRequest *mdr;
+	if (have_request(r->reqid))
+	  mdr = request_get(r->reqid);
+	else
+	  mdr = request_start_slave(r->reqid, r->attempt, from);
+	if (strong->frozen_authpin_inodes.count(in->vino())) {
+	  assert(!in->get_num_auth_pins());
+	  mdr->freeze_auth_pin(in);
+	} else {
+	  assert(!in->is_frozen_auth_pin());
+	}
+	mdr->auth_pin(in);
       }
-      mdr->auth_pin(in);
     }
     // xlock(s)?
     if (strong->xlocked_inodes.count(in->vino())) {
@@ -4427,19 +4433,23 @@ void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
     }
     // wrlock(s)?
     if (strong->wrlocked_inodes.count(in->vino())) {
-      for (map<int,MMDSCacheRejoin::slave_reqid>::iterator q = strong->wrlocked_inodes[in->vino()].begin();
+      for (map<int, list<MMDSCacheRejoin::slave_reqid> >::iterator q = strong->wrlocked_inodes[in->vino()].begin();
 	   q != strong->wrlocked_inodes[in->vino()].end();
 	   ++q) {
 	SimpleLock *lock = in->get_lock(q->first);
-	dout(10) << " inode wrlock by " << q->second << " on " << *lock << " on " << *in << dendl;
-	MDRequest *mdr = request_get(q->second.reqid);  // should have this from auth_pin above.
-	assert(mdr->is_auth_pinned(in));
-	lock->set_state(LOCK_LOCK);
-	if (lock == &in->filelock)
-	  in->loner_cap = -1;
-	lock->get_wrlock(true);
-	mdr->wrlocks.insert(lock);
-	mdr->locks.insert(lock);
+	for (list<MMDSCacheRejoin::slave_reqid>::iterator r = q->second.begin();
+	     r != q->second.end();
+	     ++r) {
+	  dout(10) << " inode wrlock by " << *r << " on " << *lock << " on " << *in << dendl;
+	  MDRequest *mdr = request_get(r->reqid);  // should have this from auth_pin above.
+	  assert(mdr->is_auth_pinned(in));
+	  lock->set_state(LOCK_MIX);
+	  if (lock == &in->filelock)
+	    in->loner_cap = -1;
+	  lock->get_wrlock(true);
+	  mdr->wrlocks.insert(lock);
+	  mdr->locks.insert(lock);
+	}
       }
     }
   }
diff --git a/src/messages/MMDSCacheRejoin.h b/src/messages/MMDSCacheRejoin.h
index 7c37ab4..f29e8f5 100644
--- a/src/messages/MMDSCacheRejoin.h
+++ b/src/messages/MMDSCacheRejoin.h
@@ -188,11 +188,11 @@ class MMDSCacheRejoin : public Message {
       ::decode(attempt, bl);
     }
   };
-  map<vinodeno_t, slave_reqid> authpinned_inodes;
+  map<vinodeno_t, list<slave_reqid> > authpinned_inodes;
   map<vinodeno_t, slave_reqid> frozen_authpin_inodes;
   map<vinodeno_t, map<__s32, slave_reqid> > xlocked_inodes;
-  map<vinodeno_t, map<__s32, slave_reqid> > wrlocked_inodes;
-  map<dirfrag_t, map<string_snap_t, slave_reqid> > authpinned_dentries;
+  map<vinodeno_t, map<__s32, list<slave_reqid> > > wrlocked_inodes;
+  map<dirfrag_t, map<string_snap_t, list<slave_reqid> > > authpinned_dentries;
   map<dirfrag_t, map<string_snap_t, slave_reqid> > xlocked_dentries;
   
   MMDSCacheRejoin() : Message(MSG_MDS_CACHEREJOIN) {}
@@ -232,7 +232,7 @@ public:
     ::encode(bl, inode_base);
   }
   void add_inode_authpin(vinodeno_t ino, const metareqid_t& ri, __u32 attempt) {
-    authpinned_inodes[ino] = slave_reqid(ri, attempt);
+    authpinned_inodes[ino].push_back(slave_reqid(ri, attempt));
   }
   void add_inode_frozen_authpin(vinodeno_t ino, const metareqid_t& ri, __u32 attempt) {
     frozen_authpin_inodes[ino] = slave_reqid(ri, attempt);
@@ -241,7 +241,7 @@ public:
     xlocked_inodes[ino][lt] = slave_reqid(ri, attempt);
   }
   void add_inode_wrlock(vinodeno_t ino, int lt, const metareqid_t& ri, __u32 attempt) {
-    wrlocked_inodes[ino][lt] = slave_reqid(ri, attempt);
+    wrlocked_inodes[ino][lt].push_back(slave_reqid(ri, attempt));
   }
 
   void add_scatterlock_state(CInode *in) {
@@ -282,7 +282,7 @@ public:
   }
   void add_dentry_authpin(dirfrag_t df, const string& dname, snapid_t last,
 			  const metareqid_t& ri, __u32 attempt) {
-    authpinned_dentries[df][string_snap_t(dname, last)] = slave_reqid(ri, attempt);
+    authpinned_dentries[df][string_snap_t(dname, last)].push_back(slave_reqid(ri, attempt));
   }
   void add_dentry_xlock(dirfrag_t df, const string& dname, snapid_t last,
 			const metareqid_t& ri, __u32 attempt) {
-- 
1.7.11.7

