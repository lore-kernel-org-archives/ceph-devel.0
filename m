From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 27/30] mds: remove old backtrace handling
Date: Mon, 27 May 2013 10:15:04 +0800
Message-ID: <51A2C1A8.8090908@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com> <1369296418-14871-28-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1305231543040.29396@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33133 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755849Ab3E0CPH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 26 May 2013 22:15:07 -0400
In-Reply-To: <alpine.DEB.2.00.1305231543040.29396@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com, sam.lang@inktank.com

updated version
---
From 8cf931f0d41573aab296249eb0011a29443c904b Mon Sep 17 00:00:00 2001
From: "Yan, Zheng" <zheng.z.yan@intel.com>
Date: Fri, 17 May 2013 16:11:27 +0800
Subject: [PATCH 28/33] mds: remove old backtrace handling

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/LogSegment.h       |  23 -------
 src/mds/MDLog.cc           |   1 -
 src/mds/Server.cc          |  45 --------------
 src/mds/events/EMetaBlob.h |  10 ---
 src/mds/journal.cc         | 150 +++++----------------------------------------
 5 files changed, 14 insertions(+), 215 deletions(-)

diff --git a/src/mds/LogSegment.h b/src/mds/LogSegment.h
index d42e352..44c7942 100644
--- a/src/mds/LogSegment.h
+++ b/src/mds/LogSegment.h
@@ -33,19 +33,6 @@ class CDentry;
 class MDS;
 class MDSlaveUpdate;
 
-// The backtrace info struct here is used to maintain the backtrace in
-// a queue that we will eventually want to write out (on journal segment
-// expiry).
-class BacktraceInfo {
-public:
-  int64_t location;
-  int64_t pool;
-  struct inode_backtrace_t bt;
-  elist<BacktraceInfo*>::item item_logseg;
-  BacktraceInfo(int64_t l, CInode *i, LogSegment *ls, int64_t p = -1);
-  ~BacktraceInfo();
-};
-
 class LogSegment {
  public:
   uint64_t offset, end;
@@ -63,8 +50,6 @@ class LogSegment {
   elist<CInode*>  dirty_dirfrag_nest;
   elist<CInode*>  dirty_dirfrag_dirfragtree;
 
-  elist<BacktraceInfo*> update_backtraces;
-
   elist<MDSlaveUpdate*> slave_updates;
   
   set<CInode*> truncating_inodes;
@@ -95,17 +80,9 @@ class LogSegment {
     dirty_dirfrag_dir(member_offset(CInode, item_dirty_dirfrag_dir)),
     dirty_dirfrag_nest(member_offset(CInode, item_dirty_dirfrag_nest)),
     dirty_dirfrag_dirfragtree(member_offset(CInode, item_dirty_dirfrag_dirfragtree)),
-    update_backtraces(member_offset(BacktraceInfo, item_logseg)),
     slave_updates(0), // passed to begin() manually
     inotablev(0), sessionmapv(0)
   { }
-
-  // backtrace handling
-  void queue_backtrace_update(CInode *in, int64_t location, int64_t pool = -1);
-  void remove_pending_backtraces(inodeno_t ino, int64_t pool);
-  void store_backtrace_update(MDS *mds, BacktraceInfo *info, Context *fin);
-  void _stored_backtrace(BacktraceInfo *info, Context *fin);
-  unsigned encode_parent_mutation(ObjectOperation& m, BacktraceInfo *info);
 };
 
 #endif
diff --git a/src/mds/MDLog.cc b/src/mds/MDLog.cc
index 84d2612..c477313 100644
--- a/src/mds/MDLog.cc
+++ b/src/mds/MDLog.cc
@@ -623,7 +623,6 @@ void MDLog::standby_trim_segments()
     seg->dirty_dirfrag_dir.clear_list();
     seg->dirty_dirfrag_nest.clear_list();
     seg->dirty_dirfrag_dirfragtree.clear_list();
-    seg->update_backtraces.clear_list();
     remove_oldest_segment();
     removed_segment = true;
   }
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 6a0f1f9..897168f 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -2698,8 +2698,6 @@ public:
 
     mds->balancer->hit_inode(mdr->now, newi, META_POP_IWR);
 
-    mdr->ls->queue_backtrace_update(newi, newi->inode.layout.fl_pg_pool);
-
     MClientReply *reply = new MClientReply(mdr->client_request, 0);
     reply->set_extra_bl(mdr->reply_extra_bl);
     mds->server->reply_request(mdr, reply);
@@ -3106,8 +3104,6 @@ public:
   void finish(int r) {
     assert(r == 0);
 
-    int64_t old_pool = in->inode.layout.fl_pg_pool;
-
     // apply
     in->pop_and_dirty_projected_inode(mdr->ls);
     mdr->apply();
@@ -3124,16 +3120,6 @@ public:
 
     if (changed_ranges)
       mds->locker->share_inode_max_size(in);
-
-    // if pool changed, queue a new backtrace and set forward pointer on old
-    if (old_pool != in->inode.layout.fl_pg_pool) {
-      mdr->ls->remove_pending_backtraces(in->ino(), in->inode.layout.fl_pg_pool);
-      mdr->ls->queue_backtrace_update(in, in->inode.layout.fl_pg_pool);
-
-      // set forwarding pointer on old backtrace
-      mdr->ls->remove_pending_backtraces(in->ino(), old_pool);
-      mdr->ls->queue_backtrace_update(in, old_pool, in->inode.layout.fl_pg_pool);
-    }
   }
 };
 
@@ -3514,8 +3500,6 @@ void Server::handle_client_setlayout(MDRequest *mdr)
   EUpdate *le = new EUpdate(mdlog, "setlayout");
   mdlog->start_entry(le);
   le->metablob.add_client_req(req->get_reqid(), req->get_oldest_client_tid());
-  // add the old pool to the metablob to indicate the pool changed with this event
-  le->metablob.add_old_pool(old_pool);
   mdcache->predirty_journal_parents(mdr, &le->metablob, cur, 0, PREDIRTY_PRIMARY, false);
   mdcache->journal_dirty_inode(mdr, &le->metablob, cur);
   
@@ -3781,10 +3765,6 @@ void Server::handle_set_vxattr(MDRequest *mdr, CInode *cur,
     EUpdate *le = new EUpdate(mdlog, "set vxattr layout");
     mdlog->start_entry(le);
     le->metablob.add_client_req(req->get_reqid(), req->get_oldest_client_tid());
-    if (cur->is_file()) {
-      assert(old_pool != -1);
-      le->metablob.add_old_pool(old_pool);
-    }
     mdcache->predirty_journal_parents(mdr, &le->metablob, cur, 0, PREDIRTY_PRIMARY, false);
     mdcache->journal_dirty_inode(mdr, &le->metablob, cur);
 
@@ -4037,15 +4017,6 @@ public:
     // hit pop
     mds->balancer->hit_inode(mdr->now, newi, META_POP_IWR);
 
-    // store the backtrace on the 'parent' xattr
-    if (newi->inode.is_dir()) {
-      // if its a dir, put it in the metadata pool
-      mdr->ls->queue_backtrace_update(newi, mds->mdsmap->get_metadata_pool());
-    } else {
-      // if its a file, put it in the data pool for that file
-      mdr->ls->queue_backtrace_update(newi, newi->inode.layout.fl_pg_pool);
-    }
-
     // reply
     MClientReply *reply = new MClientReply(mdr->client_request, 0);
     reply->set_result(0);
@@ -5982,20 +5953,6 @@ void Server::_rename_finish(MDRequest *mdr, CDentry *srcdn, CDentry *destdn, CDe
   // did we import srci?  if so, explicitly ack that import that, before we unlock and reply.
 
   assert(g_conf->mds_kill_rename_at != 7);
-  // backtrace
-  if (destdnl->inode->is_dir()) {
-    // replace previous backtrace on this inode with myself
-    mdr->ls->remove_pending_backtraces(destdnl->inode->ino(), mds->mdsmap->get_metadata_pool());
-    // queue an updated backtrace
-    mdr->ls->queue_backtrace_update(destdnl->inode, mds->mdsmap->get_metadata_pool());
-
-  } else {
-    // remove all pending backtraces going to the same pool
-    mdr->ls->remove_pending_backtraces(destdnl->inode->ino(), destdnl->inode->inode.layout.fl_pg_pool);
-    // queue an updated backtrace
-    mdr->ls->queue_backtrace_update(destdnl->inode, destdnl->inode->inode.layout.fl_pg_pool);
-  }
-  assert(g_conf->mds_kill_rename_at != 8);
 
   // reply
   MClientReply *reply = new MClientReply(mdr->client_request, 0);
@@ -6391,8 +6348,6 @@ void Server::_rename_prepare(MDRequest *mdr,
   if (srci->is_dir())
     mdcache->project_subtree_rename(srci, srcdn->get_dir(), destdn->get_dir());
 
-  // always update the backtrace
-  metablob->update_backtrace();
 }
 
 
diff --git a/src/mds/events/EMetaBlob.h b/src/mds/events/EMetaBlob.h
index f393097..973d277 100644
--- a/src/mds/events/EMetaBlob.h
+++ b/src/mds/events/EMetaBlob.h
@@ -324,9 +324,6 @@ private:
   // idempotent op(s)
   list<pair<metareqid_t,uint64_t> > client_reqs;
 
-  int64_t old_pool;
-  bool update_bt;
-
  public:
   void encode(bufferlist& bl) const;
   void decode(bufferlist::iterator& bl);
@@ -542,13 +539,6 @@ private:
   static const int TO_ROOT = 1;
   
   void add_dir_context(CDir *dir, int mode = TO_AUTH_SUBTREE_ROOT);
- 
-  void add_old_pool(int64_t pool) {
-    old_pool = pool;
-  }
-  void update_backtrace() {
-    update_bt = true;
-  }
 
   void print(ostream& out) const {
     out << "[metablob";
diff --git a/src/mds/journal.cc b/src/mds/journal.cc
index da88a36..f9a9426 100644
--- a/src/mds/journal.cc
+++ b/src/mds/journal.cc
@@ -196,10 +196,6 @@ void LogSegment::try_to_expire(MDS *mds, C_GatherBuilder &gather_bld)
       in->add_waiter(CInode::WAIT_UNFREEZE, gather_bld.new_sub());
     }
   }
-  for (elist<BacktraceInfo*>::iterator p = update_backtraces.begin(); !p.end(); ++p) {
-    BacktraceInfo *btinfo = *p;
-    store_backtrace_update(mds, btinfo, gather_bld.new_sub());
-  }
 
   assert(g_conf->mds_kill_journal_expire_at != 4);
 
@@ -278,101 +274,6 @@ void LogSegment::try_to_expire(MDS *mds, C_GatherBuilder &gather_bld)
   }
 }
 
-// ----------------------------
-// backtrace handling
-
-// BacktraceInfo is used for keeping the
-// current state of the backtrace to be stored later on
-// logsegment expire.  Constructing a BacktraceInfo
-// automatically puts it on the LogSegment list that is passed in,
-// after building the backtrace based on the current state of the inode.  We
-// construct the backtrace here to avoid keeping a ref to the inode.
-BacktraceInfo::BacktraceInfo(
-    int64_t l, CInode *i, LogSegment *ls, int64_t p) :
-        location(l), pool(p) {
-
-  // on setlayout cases, forward pointers mean
-  // pool != location, but for all others it does
-  if (pool == -1) pool = location;
-
-  bt.pool = pool;
-  i->build_backtrace(l, &bt);
-  ls->update_backtraces.push_back(&item_logseg);
-}
-
-// When the info_t is destroyed, it just needs to remove itself
-// from the LogSegment list
-BacktraceInfo::~BacktraceInfo() {
-  item_logseg.remove_myself();
-}
-
-// Queue a backtrace for later
-void LogSegment::queue_backtrace_update(CInode *inode, int64_t location, int64_t pool) {
-    // allocating a pointer here and not setting it to anything
-    // might look strange, but the constructor adds itself to the backtraces
-    // list of this LogSegment, which is how we keep track of it
-    new BacktraceInfo(location, inode, this, pool);
-}
-
-void LogSegment::remove_pending_backtraces(inodeno_t ino, int64_t pool) {
-  elist<BacktraceInfo*>::iterator i = update_backtraces.begin();
-  while(!i.end()) {
-    ++i;
-    if((*i)->bt.ino == ino && (*i)->location == pool) {
-      delete (*i);
-    }
-  }
-}
-
-unsigned LogSegment::encode_parent_mutation(ObjectOperation& m, BacktraceInfo *info)
-{
-  bufferlist parent;
-  ::encode(info->bt, parent);
-  m.setxattr("parent", parent);
-  return parent.length();
-}
-
-struct C_LogSegment_StoredBacktrace : public Context {
-  LogSegment *ls;
-  BacktraceInfo *info;
-  Context *fin;
-  C_LogSegment_StoredBacktrace(LogSegment *l, BacktraceInfo *c,
-			       Context *f) : ls(l), info(c), fin(f) {}
-  void finish(int r) {
-    ls->_stored_backtrace(info, fin);
-  }
-};
-
-void LogSegment::store_backtrace_update(MDS *mds, BacktraceInfo *info, Context *fin)
-{
-  ObjectOperation m;
-  // prev_pool will be the target pool on create,mkdir,etc.
-  encode_parent_mutation(m, info);
-
-  // write it.
-  SnapContext snapc;
-
-  object_t oid = CInode::get_object_name(info->bt.ino, frag_t(), "");
-
-  dout(10) << "store_parent for oid " << oid << " location " << info->location << " pool " << info->pool << dendl;
-
-  // store the backtrace in the specified pool
-  object_locator_t oloc(info->location);
-
-  mds->objecter->mutate(oid, oloc, m, snapc, ceph_clock_now(g_ceph_context), 0,
-		        NULL, new C_LogSegment_StoredBacktrace(this, info, fin) );
-
-}
-
-void LogSegment::_stored_backtrace(BacktraceInfo *info, Context *fin)
-{
-  delete info;
-  if (fin) {
-    fin->finish(0);
-    delete fin;
-  }
-}
-
 #undef DOUT_COND
 #define DOUT_COND(cct, l) (l<=cct->_conf->debug_mds || l <= cct->_conf->debug_mds_log)
 
@@ -383,8 +284,6 @@ void LogSegment::_stored_backtrace(BacktraceInfo *info, Context *fin)
 EMetaBlob::EMetaBlob(MDLog *mdlog) : opened_ino(0), renamed_dirino(0),
 				     inotablev(0), sessionmapv(0),
 				     allocated_ino(0),
-				     old_pool(-1),
-				     update_bt(false),
 				     last_subtree_map(mdlog ? mdlog->get_last_segment_offset() : 0),
 				     my_offset(mdlog ? mdlog->get_write_pos() : 0) //, _segment(0)
 { }
@@ -842,7 +741,7 @@ void EMetaBlob::dirlump::generate_test_instances(list<dirlump*>& ls)
  */
 void EMetaBlob::encode(bufferlist& bl) const
 {
-  ENCODE_START(6, 5, bl);
+  ENCODE_START(7, 5, bl);
   ::encode(lump_order, bl);
   ::encode(lump_map, bl);
   ::encode(roots, bl);
@@ -860,13 +759,18 @@ void EMetaBlob::encode(bufferlist& bl) const
   ::encode(client_reqs, bl);
   ::encode(renamed_dirino, bl);
   ::encode(renamed_dir_frags, bl);
-  ::encode(old_pool, bl);
-  ::encode(update_bt, bl);
+  {
+    // make MDS use v6 format happy
+    int64_t i = -1;
+    bool b = false;
+    ::encode(i, bl);
+    ::encode(b, bl);
+  }
   ENCODE_FINISH(bl);
 }
 void EMetaBlob::decode(bufferlist::iterator &bl)
 {
-  DECODE_START_LEGACY_COMPAT_LEN(6, 5, 5, bl);
+  DECODE_START_LEGACY_COMPAT_LEN(7, 5, 5, bl);
   ::decode(lump_order, bl);
   ::decode(lump_map, bl);
   if (struct_v >= 4) {
@@ -905,8 +809,11 @@ void EMetaBlob::decode(bufferlist::iterator &bl)
     ::decode(renamed_dir_frags, bl);
   }
   if (struct_v >= 6) {
-    ::decode(old_pool, bl);
-    ::decode(update_bt, bl);
+    // ignore
+    int64_t i;
+    bool b;
+    ::decode(i, bl);
+    ::decode(b, bl);
   }
   DECODE_FINISH(bl);
 }
@@ -1191,35 +1098,6 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg, MDSlaveUpdate *slaveup)
       assert(g_conf->mds_kill_journal_replay_at != 2);
       if (p->is_dirty_parent())
 	in->_mark_dirty_parent(logseg, p->is_dirty_pool());
-
-      // store backtrace for allocated inos (create, mkdir, symlink, mknod)
-      if (allocated_ino || used_preallocated_ino) {
-	if (in->inode.is_dir()) {
-	  logseg->queue_backtrace_update(in, mds->mdsmap->get_metadata_pool());
-	} else {
-	  logseg->queue_backtrace_update(in, in->inode.layout.fl_pg_pool);
-	}
-      }
-      // handle change of pool with backtrace update
-      if (old_pool != -1 && old_pool != in->inode.layout.fl_pg_pool) {
-	// update backtrace on new data pool
-	logseg->queue_backtrace_update(in, in->inode.layout.fl_pg_pool);
-
-	// set forwarding pointer on old backtrace
-	logseg->queue_backtrace_update(in, old_pool, in->inode.layout.fl_pg_pool);
-      }
-      // handle backtrace update if specified (used by rename)
-      if (update_bt) {
-	if (in->is_dir()) {
-	  // replace previous backtrace on this inode with myself
-	  logseg->remove_pending_backtraces(in->ino(), mds->mdsmap->get_metadata_pool());
-	  logseg->queue_backtrace_update(in, mds->mdsmap->get_metadata_pool());
-	} else {
-	  // remove all pending backtraces going to the same pool
-	  logseg->remove_pending_backtraces(in->ino(), in->inode.layout.fl_pg_pool);
-	  logseg->queue_backtrace_update(in, in->inode.layout.fl_pg_pool);
-	}
-      }
     }
 
     // remote dentries
-- 
1.8.1.4

