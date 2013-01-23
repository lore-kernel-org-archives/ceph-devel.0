From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 24/25] mds: rejoin remote wrlocks and frozen auth pin
Date: Wed, 23 Jan 2013 11:09:00 +0800
Message-ID: <1358910541-15535-25-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8242 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150Ab3AWDJ1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:27 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Includes remote wrlocks and frozen authpin in cache rejoin strong message

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc              |  4 +--
 src/mds/MDCache.cc             | 56 +++++++++++++++++++++++++++++++++++++++---
 src/mds/Mutation.cc            | 11 ++++++++-
 src/mds/Mutation.h             | 11 ++++++---
 src/mds/Server.cc              |  9 ++++++-
 src/messages/MMDSCacheRejoin.h | 12 +++++++++
 6 files changed, 93 insertions(+), 10 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index aca7052..3f81013 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -1322,7 +1322,7 @@ void Locker::remote_wrlock_start(SimpleLock *lock, int target, MDRequest *mut)
 
   // send lock request
   if (!lock->is_waiter_for(SimpleLock::WAIT_REMOTEXLOCK)) {
-    mut->start_locking(lock);
+    mut->start_locking(lock, target);
     mut->more()->slaves.insert(target);
     MMDSSlaveRequest *r = new MMDSSlaveRequest(mut->reqid, mut->attempt,
 					       MMDSSlaveRequest::OP_WRLOCK);
@@ -1407,9 +1407,9 @@ bool Locker::xlock_start(SimpleLock *lock, MDRequest *mut)
     
     // send lock request
     if (!lock->is_waiter_for(SimpleLock::WAIT_REMOTEXLOCK)) {
-      mut->start_locking(lock);
       int auth = lock->get_parent()->authority().first;
       mut->more()->slaves.insert(auth);
+      mut->start_locking(lock, auth);
       MMDSSlaveRequest *r = new MMDSSlaveRequest(mut->reqid, mut->attempt,
 						 MMDSSlaveRequest::OP_XLOCK);
       r->set_lock_type(lock->get_type());
diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 499b4e0..200aebe 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -2648,6 +2648,9 @@ void MDCache::handle_mds_failure(int who)
 		 << " to recover" << dendl;
 	p->second->clear_ambiguous_auth();
       }
+
+      if (p->second->locking && p->second->locking_target_mds == who)
+	p->second->finish_locking(p->second->locking);
     }
   }
 
@@ -3499,6 +3502,11 @@ void MDCache::rejoin_send_rejoins()
 	    rejoin->add_inode_authpin(vinodeno_t(i.ino, i.snapid), p->second->reqid, p->second->attempt);
 	  else
 	    rejoin->add_dentry_authpin(i.dirfrag, i.dname, i.snapid, p->second->reqid, p->second->attempt);
+
+	  if (p->second->has_more() && p->second->more()->is_remote_frozen_authpin &&
+	      p->second->more()->rename_inode == (*q))
+	    rejoin->add_inode_frozen_authpin(vinodeno_t(i.ino, i.snapid),
+					     p->second->reqid, p->second->attempt);
 	}
       }
       // xlocks
@@ -3521,6 +3529,22 @@ void MDCache::rejoin_send_rejoins()
 				     p->second->reqid, p->second->attempt);
 	}
       }
+      // remote wrlocks
+      for (map<SimpleLock*, int>::iterator q = p->second->remote_wrlocks.begin();
+	   q != p->second->remote_wrlocks.end();
+	   ++q) {
+	int who = q->second;
+	if (rejoins.count(who) == 0) continue;
+	MMDSCacheRejoin *rejoin = rejoins[who];
+
+	dout(15) << " " << *p->second << " wrlock on " << q->second
+		 << " " << q->first->get_parent() << dendl;
+	MDSCacheObjectInfo i;
+	q->first->get_parent()->set_object_info(i);
+	assert(i.ino);
+	rejoin->add_inode_wrlock(vinodeno_t(i.ino, i.snapid), q->first->get_type(),
+				 p->second->reqid, p->second->attempt);
+      }
     }
   }
 
@@ -4214,7 +4238,9 @@ void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
 	dout(10) << " dn xlock by " << r << " on " << *dn << dendl;
 	MDRequest *mdr = request_get(r.reqid);  // should have this from auth_pin above.
 	assert(mdr->is_auth_pinned(dn));
-	dn->lock.set_state(LOCK_LOCK);
+	if (dn->lock.is_stable())
+	  dn->auth_pin(&dn->lock);
+	dn->lock.set_state(LOCK_XLOCK);
 	dn->lock.get_xlock(mdr, mdr->get_client());
 	mdr->xlocks.insert(&dn->lock);
 	mdr->locks.insert(&dn->lock);
@@ -4257,9 +4283,14 @@ void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
 	      mdr = request_get(r.reqid);
 	    else
 	      mdr = request_start_slave(r.reqid, r.attempt, from);
+	    if (strong->frozen_authpin_inodes.count(in->vino())) {
+	      assert(!in->get_num_auth_pins());
+	      mdr->freeze_auth_pin(in);
+	    } else {
+	      assert(!in->is_frozen_auth_pin());
+	    }
 	    mdr->auth_pin(in);
 	  }
-	  
 	  // xlock(s)?
 	  if (strong->xlocked_inodes.count(in->vino())) {
 	    for (map<int,MMDSCacheRejoin::slave_reqid>::iterator r = strong->xlocked_inodes[in->vino()].begin();
@@ -4269,7 +4300,9 @@ void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
 	      dout(10) << " inode xlock by " << r->second << " on " << *lock << " on " << *in << dendl;
 	      MDRequest *mdr = request_get(r->second.reqid);  // should have this from auth_pin above.
 	      assert(mdr->is_auth_pinned(in));
-	      lock->set_state(LOCK_LOCK);
+	      if (lock->is_stable())
+		in->auth_pin(lock);
+	      lock->set_state(LOCK_XLOCK);
 	      if (lock == &in->filelock)
 		in->loner_cap = -1;
 	      lock->get_xlock(mdr, mdr->get_client());
@@ -4277,6 +4310,23 @@ void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
 	      mdr->locks.insert(lock);
 	    }
 	  }
+	  // wrlock(s)?
+	  if (strong->wrlocked_inodes.count(in->vino())) {
+	    for (map<int,MMDSCacheRejoin::slave_reqid>::iterator r = strong->wrlocked_inodes[in->vino()].begin();
+		 r != strong->wrlocked_inodes[in->vino()].end();
+		 ++r) {
+	      SimpleLock *lock = in->get_lock(r->first);
+	      dout(10) << " inode wrlock by " << r->second << " on " << *lock << " on " << *in << dendl;
+	      MDRequest *mdr = request_get(r->second.reqid);  // should have this from auth_pin above.
+	      assert(mdr->is_auth_pinned(in));
+	      lock->set_state(LOCK_LOCK);
+	      if (lock == &in->filelock)
+		in->loner_cap = -1;
+	      lock->get_wrlock(true);
+	      mdr->wrlocks.insert(lock);
+	      mdr->locks.insert(lock);
+	    }
+	  }
 	} else {
 	  dout(10) << " sender has dentry but not inode, adding them as a replica" << dendl;
 	}
diff --git a/src/mds/Mutation.cc b/src/mds/Mutation.cc
index 367181c..62968f7 100644
--- a/src/mds/Mutation.cc
+++ b/src/mds/Mutation.cc
@@ -47,17 +47,19 @@ void Mutation::drop_pins()
   pins.clear();
 }
 
-void Mutation::start_locking(SimpleLock *lock)
+void Mutation::start_locking(SimpleLock *lock, int target)
 {
   assert(locking == NULL);
   pin(lock->get_parent());
   locking = lock;
+  locking_target_mds = target;
 }
 
 void Mutation::finish_locking(SimpleLock *lock)
 {
   assert(locking == lock);
   locking = NULL;
+  locking_target_mds = -1;
 }
 
 
@@ -228,6 +230,13 @@ void MDRequest::unfreeze_auth_pin()
   more()->is_freeze_authpin = false;
 }
 
+void MDRequest::set_remote_frozen_auth_pin(CInode *inode)
+{
+  assert(!more()->rename_inode || more()->rename_inode == inode);
+  more()->rename_inode = inode;
+  more()->is_remote_frozen_authpin = true;
+}
+
 void MDRequest::set_ambiguous_auth(CInode *inode)
 {
   assert(!more()->rename_inode || more()->rename_inode == inode);
diff --git a/src/mds/Mutation.h b/src/mds/Mutation.h
index c64657f..bb5f1f6 100644
--- a/src/mds/Mutation.h
+++ b/src/mds/Mutation.h
@@ -61,6 +61,7 @@ struct Mutation {
   // lock we are currently trying to acquire.  if we give up for some reason,
   // be sure to eval() this.
   SimpleLock *locking;
+  int locking_target_mds;
 
   // if this flag is set, do not attempt to acquire further locks.
   //  (useful for wrlock, which may be a moving auth target)
@@ -82,12 +83,14 @@ struct Mutation {
       ls(0),
       slave_to_mds(-1),
       locking(NULL),
+      locking_target_mds(-1),
       done_locking(false), committing(false), aborted(false), killed(false) { }
   Mutation(metareqid_t ri, __u32 att=0, int slave_to=-1)
     : reqid(ri), attempt(att),
       ls(0),
       slave_to_mds(slave_to), 
       locking(NULL),
+      locking_target_mds(-1),
       done_locking(false), committing(false), aborted(false), killed(false) { }
   virtual ~Mutation() {
     assert(locking == NULL);
@@ -113,7 +116,7 @@ struct Mutation {
   void set_stickydirs(CInode *in);
   void drop_pins();
 
-  void start_locking(SimpleLock *lock);
+  void start_locking(SimpleLock *lock, int target=-1);
   void finish_locking(SimpleLock *lock);
 
   // auth pins
@@ -204,6 +207,7 @@ struct MDRequest : public Mutation {
     CInode* rename_inode;
     bool is_freeze_authpin;
     bool is_ambiguous_auth;
+    bool is_remote_frozen_authpin;
     bool is_inode_exporter;
 
     map<client_t,entity_inst_t> imported_client_map;
@@ -224,8 +228,8 @@ struct MDRequest : public Mutation {
     More() : 
       src_reanchor_atid(0), dst_reanchor_atid(0), inode_import_v(0),
       rename_inode(0), is_freeze_authpin(false), is_ambiguous_auth(false),
-      is_inode_exporter(false), flock_was_waiting(false),
-      stid(0), slave_commit(0) { }
+      is_remote_frozen_authpin(false), is_inode_exporter(false),
+      flock_was_waiting(false), stid(0), slave_commit(0) { }
   } *_more;
 
 
@@ -280,6 +284,7 @@ struct MDRequest : public Mutation {
   bool did_ino_allocation();
   bool freeze_auth_pin(CInode *inode);
   void unfreeze_auth_pin();
+  void set_remote_frozen_auth_pin(CInode *inode);
   bool can_auth_pin(MDSCacheObject *object);
   void drop_local_auth_pins();
   void set_ambiguous_auth(CInode *inode);
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index ad28750..083c287 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -1524,7 +1524,7 @@ void Server::handle_slave_auth_pin(MDRequest *mdr)
 
     objects.push_back(object);
     if (*p == mdr->slave_request->get_authpin_freeze())
-      auth_pin_freeze = dynamic_cast<CInode*>(object);
+      auth_pin_freeze = (CInode*)object;
   }
   
   // can we auth pin them?
@@ -1587,6 +1587,9 @@ void Server::handle_slave_auth_pin(MDRequest *mdr)
     reply->get_authpins().push_back(info);
   }
 
+  if (auth_pin_freeze)
+    auth_pin_freeze->set_object_info(reply->get_authpin_freeze());
+
   mds->send_message_mds(reply, mdr->slave_to_mds);
   
   // clean up this request
@@ -1611,6 +1614,8 @@ void Server::handle_slave_auth_pin_ack(MDRequest *mdr, MMDSSlaveRequest *ack)
     dout(10) << " remote has pinned " << *object << dendl;
     if (!mdr->is_auth_pinned(object))
       mdr->remote_auth_pins.insert(object);
+    if (*p == ack->get_authpin_freeze())
+      mdr->set_remote_frozen_auth_pin((CInode *)object);
     pinned.insert(object);
   }
 
@@ -5542,6 +5547,8 @@ void Server::handle_client_rename(MDRequest *mdr)
     le->had_slaves = true;
     
     mds->mdcache->add_uncommitted_master(mdr->reqid, mdr->ls, mdr->more()->witnessed);
+    // no need to send frozen auth pin to recovring auth MDS of srci
+    mdr->more()->is_remote_frozen_authpin = false;
   }
   
   _rename_prepare(mdr, &le->metablob, &le->client_map, srcdn, destdn, straydn);
diff --git a/src/messages/MMDSCacheRejoin.h b/src/messages/MMDSCacheRejoin.h
index e5a86ee..825400d 100644
--- a/src/messages/MMDSCacheRejoin.h
+++ b/src/messages/MMDSCacheRejoin.h
@@ -184,7 +184,9 @@ class MMDSCacheRejoin : public Message {
     }
   };
   map<vinodeno_t, slave_reqid> authpinned_inodes;
+  map<vinodeno_t, slave_reqid> frozen_authpin_inodes;
   map<vinodeno_t, map<__s32, slave_reqid> > xlocked_inodes;
+  map<vinodeno_t, map<__s32, slave_reqid> > wrlocked_inodes;
   map<dirfrag_t, map<string_snap_t, slave_reqid> > authpinned_dentries;
   map<dirfrag_t, map<string_snap_t, slave_reqid> > xlocked_dentries;
   
@@ -227,9 +229,15 @@ public:
   void add_inode_authpin(vinodeno_t ino, const metareqid_t& ri, __u32 attempt) {
     authpinned_inodes[ino] = slave_reqid(ri, attempt);
   }
+  void add_inode_frozen_authpin(vinodeno_t ino, const metareqid_t& ri, __u32 attempt) {
+    frozen_authpin_inodes[ino] = slave_reqid(ri, attempt);
+  }
   void add_inode_xlock(vinodeno_t ino, int lt, const metareqid_t& ri, __u32 attempt) {
     xlocked_inodes[ino][lt] = slave_reqid(ri, attempt);
   }
+  void add_inode_wrlock(vinodeno_t ino, int lt, const metareqid_t& ri, __u32 attempt) {
+    wrlocked_inodes[ino][lt] = slave_reqid(ri, attempt);
+  }
 
   void add_scatterlock_state(CInode *in) {
     if (inode_scatterlocks.count(in->ino()))
@@ -278,7 +286,9 @@ public:
     ::encode(inode_locks, payload);
     ::encode(inode_scatterlocks, payload);
     ::encode(authpinned_inodes, payload);
+    ::encode(frozen_authpin_inodes, payload);
     ::encode(xlocked_inodes, payload);
+    ::encode(wrlocked_inodes, payload);
     ::encode(cap_export_bl, payload);
     ::encode(strong_dirfrags, payload);
     ::encode(weak, payload);
@@ -296,7 +306,9 @@ public:
     ::decode(inode_locks, p);
     ::decode(inode_scatterlocks, p);
     ::decode(authpinned_inodes, p);
+    ::decode(frozen_authpin_inodes, p);
     ::decode(xlocked_inodes, p);
+    ::decode(wrlocked_inodes, p);
     ::decode(cap_export_bl, p);
     if (cap_export_bl.length()) {
       bufferlist::iterator q = cap_export_bl.begin();
-- 
1.7.11.7

