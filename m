From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 7/8] mds: fix race between scatter gather and dirfrag
 export
Date: Thu, 20 Jun 2013 02:01:31 +0800
Message-ID: <51C1F1FB.6090408@intel.com>
References: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com> <1371471029-10589-8-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1306190822400.26222@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:19548 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934815Ab3FSSBj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 Jun 2013 14:01:39 -0400
In-Reply-To: <alpine.DEB.2.00.1306190822400.26222@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

previous patch is buggy. please review this one.

"git://github.com/ukernel/ceph.git wip-mds" is also updated.

Regards
Yan, Zheng

---
From 15a5d37a90daca11d9dc0a581417d2a07b9d14ad Mon Sep 17 00:00:00 2001
From: "Yan, Zheng" <zheng.z.yan@intel.com>
Date: Sun, 16 Jun 2013 07:01:52 +0800
Subject: [PATCH 1/2] mds: fix race between scatter gather and dirfrag export

If we gather dirty scatter lock state while corresponding dirfrag
is been exporting, we may receive different dirfrag states from
two MDS and we need to find which one is the newest. The solution
is adding a new variable "migrate seq" to dirfrag, increase it by
one when dirfrag's auth MDS changes. When gathering dirty scatter
lock state, use "migrate seq" to find the newest dirfrag state.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CDir.cc    |  4 ++++
 src/mds/CDir.h     |  4 +++-
 src/mds/CInode.cc  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/mds/CInode.h   |  1 +
 src/mds/Locker.cc  | 19 +++++++++++++------
 src/mds/MDCache.cc |  9 +++++++--
 src/mds/MDS.h      |  2 +-
 7 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
index 8c83eba..2b991d7 100644
--- a/src/mds/CDir.cc
+++ b/src/mds/CDir.cc
@@ -154,6 +154,7 @@ ostream& CDir::print_db_line_prefix(ostream& out)
 // CDir
 
 CDir::CDir(CInode *in, frag_t fg, MDCache *mdcache, bool auth) :
+  mseq(0),
   dirty_rstat_inodes(member_offset(CInode, dirty_rstat_item)),
   item_dirty(this), item_new(this),
   pop_me(ceph_clock_now(g_ceph_context)),
@@ -2121,6 +2122,8 @@ void CDir::_committed(version_t v)
 void CDir::encode_export(bufferlist& bl)
 {
   assert(!is_projected());
+  ceph_seq_t seq = mseq + 1;
+  ::encode(seq, bl);
   ::encode(first, bl);
   ::encode(fnode, bl);
   ::encode(dirty_old_rstat, bl);
@@ -2150,6 +2153,7 @@ void CDir::finish_export(utime_t now)
 
 void CDir::decode_import(bufferlist::iterator& blp, utime_t now, LogSegment *ls)
 {
+  ::decode(mseq, blp);
   ::decode(first, blp);
   ::decode(fnode, blp);
   ::decode(dirty_old_rstat, blp);
diff --git a/src/mds/CDir.h b/src/mds/CDir.h
index 87c79c2..11f4a76 100644
--- a/src/mds/CDir.h
+++ b/src/mds/CDir.h
@@ -170,6 +170,7 @@ public:
 
   fnode_t fnode;
   snapid_t first;
+  ceph_seq_t mseq; // migrate sequence
   map<snapid_t,old_rstat_t> dirty_old_rstat;  // [value.first,key]
 
   // my inodes with dirty rstat data
@@ -547,7 +548,8 @@ public:
   // -- import/export --
   void encode_export(bufferlist& bl);
   void finish_export(utime_t now);
-  void abort_export() { 
+  void abort_export() {
+    mseq += 2;
     put(PIN_TEMPEXPORTING);
   }
   void decode_import(bufferlist::iterator& blp, utime_t now, LogSegment *ls);
diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 8936acd..4852994 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -1222,6 +1222,7 @@ void CInode::encode_lock_state(int type, bufferlist& bl)
 	  dout(20) << fg << "           fragstat " << pf->fragstat << dendl;
 	  dout(20) << fg << " accounted_fragstat " << pf->accounted_fragstat << dendl;
 	  ::encode(fg, tmp);
+	  ::encode(dir->mseq, tmp);
 	  ::encode(dir->first, tmp);
 	  ::encode(pf->fragstat, tmp);
 	  ::encode(pf->accounted_fragstat, tmp);
@@ -1255,6 +1256,7 @@ void CInode::encode_lock_state(int type, bufferlist& bl)
 	  dout(10) << fg << " " << pf->rstat << dendl;
 	  dout(10) << fg << " " << dir->dirty_old_rstat << dendl;
 	  ::encode(fg, tmp);
+	  ::encode(dir->mseq, tmp);
 	  ::encode(dir->first, tmp);
 	  ::encode(pf->rstat, tmp);
 	  ::encode(pf->accounted_rstat, tmp);
@@ -1404,10 +1406,12 @@ void CInode::decode_lock_state(int type, bufferlist& bl)
       dout(10) << " ...got " << n << " fragstats on " << *this << dendl;
       while (n--) {
 	frag_t fg;
+	ceph_seq_t mseq;
 	snapid_t fgfirst;
 	frag_info_t fragstat;
 	frag_info_t accounted_fragstat;
 	::decode(fg, p);
+	::decode(mseq, p);
 	::decode(fgfirst, p);
 	::decode(fragstat, p);
 	::decode(accounted_fragstat, p);
@@ -1420,6 +1424,12 @@ void CInode::decode_lock_state(int type, bufferlist& bl)
 	  assert(dir);                // i am auth; i had better have this dir open
 	  dout(10) << fg << " first " << dir->first << " -> " << fgfirst
 		   << " on " << *dir << dendl;
+	  if (dir->fnode.fragstat.version == get_projected_inode()->dirstat.version &&
+	      ceph_seq_cmp(mseq, dir->mseq) < 0) {
+	    dout(10) << " mseq " << mseq << " < " << dir->mseq << ", ignoring" << dendl;
+	    continue;
+	  }
+	  dir->mseq = mseq;
 	  dir->first = fgfirst;
 	  dir->fnode.fragstat = fragstat;
 	  dir->fnode.accounted_fragstat = accounted_fragstat;
@@ -1462,11 +1472,13 @@ void CInode::decode_lock_state(int type, bufferlist& bl)
       ::decode(n, p);
       while (n--) {
 	frag_t fg;
+	ceph_seq_t mseq;
 	snapid_t fgfirst;
 	nest_info_t rstat;
 	nest_info_t accounted_rstat;
 	map<snapid_t,old_rstat_t> dirty_old_rstat;
 	::decode(fg, p);
+	::decode(mseq, p);
 	::decode(fgfirst, p);
 	::decode(rstat, p);
 	::decode(accounted_rstat, p);
@@ -1481,6 +1493,12 @@ void CInode::decode_lock_state(int type, bufferlist& bl)
 	  assert(dir);                // i am auth; i had better have this dir open
 	  dout(10) << fg << " first " << dir->first << " -> " << fgfirst
 		   << " on " << *dir << dendl;
+	  if (dir->fnode.rstat.version == get_projected_inode()->rstat.version &&
+	      ceph_seq_cmp(mseq, dir->mseq) < 0) {
+	    dout(10) << " mseq " << mseq << " < " << dir->mseq << ", ignoring" << dendl;
+	    continue;
+	  }
+	  dir->mseq = mseq;
 	  dir->first = fgfirst;
 	  dir->fnode.rstat = rstat;
 	  dir->fnode.accounted_rstat = accounted_rstat;
@@ -1606,6 +1624,36 @@ void CInode::start_scatter(ScatterLock *lock)
   }
 }
 
+/*
+ * set dirfrag_version to inode_version - 1. so that we can use dirfrag version
+ * to check if we have gathered scatter state for a given dirfrag.
+ */
+void CInode::start_scatter_gather(ScatterLock *lock, int auth)
+{
+  assert(is_auth());
+  inode_t *pi = get_projected_inode();
+
+  for (map<frag_t,CDir*>::iterator p = dirfrags.begin();
+       p != dirfrags.end();
+       ++p) {
+    CDir *dir = p->second;
+
+    if (dir->is_auth())
+      continue;
+    if (auth >= 0 && dir->authority().first != auth)
+      continue;
+
+    switch (lock->get_type()) {
+      case CEPH_LOCK_IFILE:
+	dir->fnode.fragstat.version = pi->dirstat.version - 1;
+	break;
+      case CEPH_LOCK_INEST:
+	dir->fnode.rstat.version = pi->rstat.version - 1;
+	break;
+    }
+  }
+}
+
 struct C_Inode_FragUpdate : public Context {
   CInode *in;
   CDir *dir;
diff --git a/src/mds/CInode.h b/src/mds/CInode.h
index 779bb63..82c2347 100644
--- a/src/mds/CInode.h
+++ b/src/mds/CInode.h
@@ -651,6 +651,7 @@ public:
   void clear_scatter_dirty();  // on rejoin ack
 
   void start_scatter(ScatterLock *lock);
+  void start_scatter_gather(ScatterLock *lock, int auth=-1);
   void finish_scatter_update(ScatterLock *lock, CDir *dir,
 			     version_t inode_version, version_t dir_accounted_version);
   void finish_scatter_gather_update(int type);
diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 8065207..30e014a 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -731,8 +731,9 @@ void Locker::eval_gather(SimpleLock *lock, bool first, bool *pneed_issue, list<C
 	  lock->get_parent()->is_replicated()) {
 	dout(10) << " finished (local) gather for mix->lock, now gathering from replicas" << dendl;
 	send_lock_message(lock, LOCK_AC_LOCK);
-	lock->init_gather();
 	lock->set_state(LOCK_MIX_LOCK2);
+	lock->init_gather();
+	in->start_scatter_gather(static_cast<ScatterLock *>(lock));
 	return;
       }
 
@@ -3430,7 +3431,7 @@ bool Locker::simple_sync(SimpleLock *lock, bool *need_issue)
   assert(lock->is_stable());
 
   CInode *in = 0;
-  if (lock->get_cap_shift())
+  if (lock->get_type() != CEPH_LOCK_DN)
     in = static_cast<CInode *>(lock->get_parent());
 
   int old_state = lock->get_state();
@@ -3453,10 +3454,11 @@ bool Locker::simple_sync(SimpleLock *lock, bool *need_issue)
     if (lock->get_parent()->is_replicated() && old_state == LOCK_MIX) {
       send_lock_message(lock, LOCK_AC_SYNC);
       lock->init_gather();
+      in->start_scatter_gather(static_cast<ScatterLock *>(lock));
       gather++;
     }
     
-    if (in && in->is_head()) {
+    if (lock->get_cap_shift() && in->is_head()) {
       if (in->issued_caps_need_gather(lock)) {
 	if (need_issue)
 	  *need_issue = true;
@@ -3568,7 +3570,7 @@ void Locker::simple_lock(SimpleLock *lock, bool *need_issue)
   assert(lock->get_state() != LOCK_LOCK);
   
   CInode *in = 0;
-  if (lock->get_cap_shift())
+  if (lock->get_type() != CEPH_LOCK_DN)
     in = static_cast<CInode *>(lock->get_parent());
 
   int old_state = lock->get_state();
@@ -3596,7 +3598,7 @@ void Locker::simple_lock(SimpleLock *lock, bool *need_issue)
   }
   if (lock->is_rdlocked())
     gather++;
-  if (in && in->is_head()) {
+  if (lock->get_cap_shift() && in->is_head()) {
     if (in->issued_caps_need_gather(lock)) {
       if (need_issue)
 	*need_issue = true;
@@ -3629,6 +3631,8 @@ void Locker::simple_lock(SimpleLock *lock, bool *need_issue)
       gather++;
       send_lock_message(lock, LOCK_AC_LOCK);
       lock->init_gather();
+      if (lock->get_state() == LOCK_MIX_LOCK2)
+	in->start_scatter_gather(static_cast<ScatterLock *>(lock));
     }
   }
 
@@ -4034,8 +4038,9 @@ void Locker::scatter_tempsync(ScatterLock *lock, bool *need_issue)
 
   if (lock->get_state() == LOCK_MIX_TSYN &&
       in->is_replicated()) {
-    lock->init_gather();
     send_lock_message(lock, LOCK_AC_LOCK);
+    lock->init_gather();
+    in->start_scatter_gather(static_cast<ScatterLock *>(lock));
     gather++;
   }
 
@@ -4364,6 +4369,8 @@ void Locker::file_excl(ScatterLock *lock, bool *need_issue)
       lock->get_state() != LOCK_XSYN_EXCL) {  // if we were lock, replicas are already lock.
     send_lock_message(lock, LOCK_AC_LOCK);
     lock->init_gather();
+    if (lock->get_state() == LOCK_MIX_EXCL)
+      in->start_scatter_gather(static_cast<ScatterLock *>(lock));
     gather++;
   }
   if (lock->is_leased()) {
diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 2b0029f..f2068e5 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -3764,6 +3764,7 @@ void MDCache::rejoin_walk(CDir *dir, MMDSCacheRejoin *rejoin)
     dout(15) << " add_strong_dirfrag " << *dir << dendl;
     rejoin->add_strong_dirfrag(dir->dirfrag(), dir->get_replica_nonce(), dir->get_dir_rep());
     dir->state_set(CDir::STATE_REJOINING);
+    dir->mseq = 0;
 
     for (CDir::map_t::iterator p = dir->items.begin();
 	 p != dir->items.end();
@@ -3913,11 +3914,15 @@ void MDCache::handle_cache_rejoin_weak(MMDSCacheRejoin *weak)
        ++p) {
     CInode *in = get_inode(p->first);
     assert(in);
+    if (survivor) {
+      in->start_scatter_gather(&in->filelock, from);
+      in->start_scatter_gather(&in->nestlock, from);
+    } else {
+      rejoin_potential_updated_scatterlocks.insert(in);
+    }
     in->decode_lock_state(CEPH_LOCK_IFILE, p->second.file);
     in->decode_lock_state(CEPH_LOCK_INEST, p->second.nest);
     in->decode_lock_state(CEPH_LOCK_IDFT, p->second.dft);
-    if (!survivor)
-      rejoin_potential_updated_scatterlocks.insert(in);
   }
 
   // recovering peer may send incorrect dirfrags here.  we need to
diff --git a/src/mds/MDS.h b/src/mds/MDS.h
index 9e3e2da..b99815d 100644
--- a/src/mds/MDS.h
+++ b/src/mds/MDS.h
@@ -35,7 +35,7 @@
 #include "SessionMap.h"
 
 
-#define CEPH_MDS_PROTOCOL    17 /* cluster internal */
+#define CEPH_MDS_PROTOCOL    18 /* cluster internal */
 
 
 enum {
-- 
1.8.1.4

