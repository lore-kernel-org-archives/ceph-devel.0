From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 25/30] mds: bring back old style backtrace handling
Date: Tue, 28 May 2013 14:04:37 +0800
Message-ID: <51A448F5.2090408@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com> <1369296418-14871-26-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1305231549010.29396@cobra.newdream.net> <51A2C233.1080808@intel.com> <alpine.DEB.2.00.1305271307310.1350@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:54387 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932969Ab3E1GEk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 May 2013 02:04:40 -0400
In-Reply-To: <alpine.DEB.2.00.1305271307310.1350@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com, sam.lang@inktank.com

On 05/28/2013 04:08 AM, Sage Weil wrote:
> On Mon, 27 May 2013, Yan, Zheng wrote:
> 
[ snip ]
>> @@ -1028,6 +1034,104 @@ void CInode::build_backtrace(int64_t location, inode_backtrace_t* bt)
>>    }
>>  }
>>  
>> +struct C_Inode_StoredBacktrace : public Context {
>> +  CInode *in;
>> +  version_t version;
>> +  Context *fin;
>> +  C_Inode_StoredBacktrace(CInode *i, version_t v, Context *f) : in(i), version(v), fin(f) {}
>> +  void finish(int r) {
>> +    in->_stored_backtrace(version, fin);
>> +  }
>> +};
>> +
>> +void CInode::store_backtrace(Context *fin)
>> +{
>> +  dout(10) << "store_backtrace on " << *this << dendl;
>> +  assert(is_dirty_parent());
>> +
>> +  auth_pin(this);
>> +
>> +  int64_t pool;
>> +  if (is_dir())
>> +    pool = mdcache->mds->mdsmap->get_metadata_pool();
>> +  else
>> +    pool = inode.layout.fl_pg_pool;
>> +
>> +  inode_backtrace_t bt;
>> +  build_backtrace(pool, &bt);
>> +  bufferlist bl;
>> +  ::encode(bt, bl);
>> +
>> +  ObjectOperation op;
>> +  op.create(false);
>> +  op.setxattr("parent", bl);
>> +
>> +  // write it.
>> +  SnapContext snapc;
>> +  object_t oid = get_object_name(ino(), frag_t(), "");
>> +  object_locator_t oloc(pool);
>> +  Context *fin2 = new C_Inode_StoredBacktrace(this, inode.backtrace_version, fin);
>> +
>> +  if (!state_test(STATE_DIRTYPOOL)) {
>> +    mdcache->mds->objecter->mutate(oid, oloc, op, snapc, ceph_clock_now(g_ceph_context),
>> +				   0, NULL, fin2);
>> +    return;
>> +  }
>> +
>> +  C_GatherBuilder gather(g_ceph_context, fin2);
>> +  mdcache->mds->objecter->mutate(oid, oloc, op, snapc, ceph_clock_now(g_ceph_context),
>> +				 0, NULL, gather.new_sub());
> 
> This mutate() call clobbers op in the Objecter::Op ctor (to avoid a bit of 
> extra work).  It needs to get rebuilt in the loop below..
> 
> Otherwise, looks good!
> 
Updated patch. "git://github.com/ukernel/ceph.git wip-mds" is also updated

---
From 38b909b5d1f5092d6b04b3c7669e21afd12151fb Mon Sep 17 00:00:00 2001
From: "Yan, Zheng" <zheng.z.yan@intel.com>
Date: Fri, 17 May 2013 16:43:01 +0800
Subject: [PATCH 25/32] mds: bring back old style backtrace handling

To queue a backtrace update, current code allocates a BacktraceInfo
structure and adds it to log segment's update_backtraces list. The
main issue of this approach is that BacktraceInfo is independent
from inode. It's very inconvenient to find pending backtrace updates
for given inodes. When exporting inodes from one MDS to another
MDS, we need find and cancel all pending backtrace updates on the
source MDS.

This patch brings back old backtrace handling code and adapts it
for the current backtrace format. The basic idea behind of the old
code is: when an inode's backtrace becomes dirty, add the inode to
log segment's dirty_parent_inodes list.

Compare to the current backtrace handling, another difference is
that backtrace update is journalled in EMetaBlob::full_bit

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CInode.cc          | 112 +++++++++++++++++++++++++++++++++++++++++++++
 src/mds/CInode.h           |  13 +++++-
 src/mds/LogSegment.h       |   2 +
 src/mds/MDCache.cc         |  12 ++++-
 src/mds/MDLog.cc           |   1 +
 src/mds/Migrator.cc        |   6 ++-
 src/mds/Server.cc          |  16 +++++--
 src/mds/events/EMetaBlob.h |  16 +++++--
 src/mds/journal.cc         |  13 ++++++
 9 files changed, 180 insertions(+), 11 deletions(-)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 655088b..835c4b9 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -127,6 +127,7 @@ ostream& operator<<(ostream& out, CInode& in)
   if (in.state_test(CInode::STATE_AMBIGUOUSAUTH)) out << " AMBIGAUTH";
   if (in.state_test(CInode::STATE_NEEDSRECOVER)) out << " needsrecover";
   if (in.state_test(CInode::STATE_RECOVERING)) out << " recovering";
+  if (in.state_test(CInode::STATE_DIRTYPARENT)) out << " dirtyparent";
   if (in.is_freezing_inode()) out << " FREEZING=" << in.auth_pin_freeze_allowance;
   if (in.is_frozen_inode()) out << " FROZEN";
   if (in.is_frozen_auth_pin()) out << " FROZEN_AUTHPIN";
@@ -328,9 +329,14 @@ void CInode::pop_and_dirty_projected_inode(LogSegment *ls)
   assert(!projected_nodes.empty());
   dout(15) << "pop_and_dirty_projected_inode " << projected_nodes.front()->inode
 	   << " v" << projected_nodes.front()->inode->version << dendl;
+  int64_t old_pool = inode.layout.fl_pg_pool;
+
   mark_dirty(projected_nodes.front()->inode->version, ls);
   inode = *projected_nodes.front()->inode;
 
+  if (inode.is_backtrace_updated())
+    _mark_dirty_parent(ls, old_pool != inode.layout.fl_pg_pool);
+
   map<string,bufferptr> *px = projected_nodes.front()->xattrs;
   if (px) {
     xattrs = *px;
@@ -1028,6 +1034,108 @@ void CInode::build_backtrace(int64_t location, inode_backtrace_t* bt)
   }
 }
 
+struct C_Inode_StoredBacktrace : public Context {
+  CInode *in;
+  version_t version;
+  Context *fin;
+  C_Inode_StoredBacktrace(CInode *i, version_t v, Context *f) : in(i), version(v), fin(f) {}
+  void finish(int r) {
+    in->_stored_backtrace(version, fin);
+  }
+};
+
+void CInode::store_backtrace(Context *fin)
+{
+  dout(10) << "store_backtrace on " << *this << dendl;
+  assert(is_dirty_parent());
+
+  auth_pin(this);
+
+  int64_t pool;
+  if (is_dir())
+    pool = mdcache->mds->mdsmap->get_metadata_pool();
+  else
+    pool = inode.layout.fl_pg_pool;
+
+  inode_backtrace_t bt;
+  build_backtrace(pool, &bt);
+  bufferlist bl;
+  ::encode(bt, bl);
+
+  ObjectOperation op;
+  op.create(false);
+  op.setxattr("parent", bl);
+
+  SnapContext snapc;
+  object_t oid = get_object_name(ino(), frag_t(), "");
+  object_locator_t oloc(pool);
+  Context *fin2 = new C_Inode_StoredBacktrace(this, inode.backtrace_version, fin);
+
+  if (!state_test(STATE_DIRTYPOOL)) {
+    mdcache->mds->objecter->mutate(oid, oloc, op, snapc, ceph_clock_now(g_ceph_context),
+				   0, NULL, fin2);
+    return;
+  }
+
+  C_GatherBuilder gather(g_ceph_context, fin2);
+  mdcache->mds->objecter->mutate(oid, oloc, op, snapc, ceph_clock_now(g_ceph_context),
+				 0, NULL, gather.new_sub());
+
+  set<int64_t> old_pools;
+  for (vector<int64_t>::iterator p = inode.old_pools.begin();
+      p != inode.old_pools.end();
+      ++p) {
+    if (*p == pool || old_pools.count(*p))
+      continue;
+
+    ObjectOperation op;
+    op.create(false);
+    op.setxattr("parent", bl);
+
+    object_locator_t oloc(*p);
+    mdcache->mds->objecter->mutate(oid, oloc, op, snapc, ceph_clock_now(g_ceph_context),
+				   0, NULL, gather.new_sub());
+    old_pools.insert(*p);
+  }
+  gather.activate();
+}
+
+void CInode::_stored_backtrace(version_t v, Context *fin)
+{
+  dout(10) << "_stored_backtrace" << dendl;
+
+  if (v == inode.backtrace_version)
+    clear_dirty_parent();
+  auth_unpin(this);
+  if (fin)
+    fin->complete(0);
+}
+
+void CInode::_mark_dirty_parent(LogSegment *ls, bool dirty_pool)
+{
+  if (!state_test(STATE_DIRTYPARENT)) {
+    dout(10) << "mark_dirty_parent" << dendl;
+    state_set(STATE_DIRTYPARENT);
+    get(PIN_DIRTYPARENT);
+    assert(ls);
+  }
+  if (dirty_pool)
+    state_set(STATE_DIRTYPOOL);
+  if (ls)
+    ls->dirty_parent_inodes.push_back(&item_dirty_parent);
+}
+
+void CInode::clear_dirty_parent()
+{
+  if (state_test(STATE_DIRTYPARENT)) {
+    dout(10) << "clear_dirty_parent" << dendl;
+    state_clear(STATE_DIRTYPARENT);
+    state_clear(STATE_DIRTYPOOL);
+    put(PIN_DIRTYPARENT);
+    item_dirty_parent.remove_myself();
+  }
+}
+
 // ------------------
 // parent dir
 
@@ -3049,6 +3157,10 @@ void CInode::decode_import(bufferlist::iterator& p,
     get(PIN_DIRTY);
     _mark_dirty(ls);
   }
+  if (is_dirty_parent()) {
+    get(PIN_DIRTYPARENT);
+    _mark_dirty_parent(ls);
+  }
 
   ::decode(pop, ceph_clock_now(g_ceph_context), p);
 
diff --git a/src/mds/CInode.h b/src/mds/CInode.h
index 727e18c..b7c3860 100644
--- a/src/mds/CInode.h
+++ b/src/mds/CInode.h
@@ -151,12 +151,14 @@ public:
   static const int STATE_NEEDSRECOVER = (1<<11);
   static const int STATE_RECOVERING =   (1<<12);
   static const int STATE_PURGING =     (1<<13);
+  static const int STATE_DIRTYPARENT =  (1<<14);
   static const int STATE_DIRTYRSTAT =  (1<<15);
   static const int STATE_STRAYPINNED = (1<<16);
   static const int STATE_FROZENAUTHPIN = (1<<17);
+  static const int STATE_DIRTYPOOL =   (1<<18);
 
   static const int MASK_STATE_EXPORTED =
-    (STATE_DIRTY|STATE_NEEDSRECOVER);
+    (STATE_DIRTY|STATE_NEEDSRECOVER|STATE_DIRTYPARENT|STATE_DIRTYPOOL);
   static const int MASK_STATE_EXPORT_KEPT =
     (STATE_FROZEN|STATE_AMBIGUOUSAUTH|STATE_EXPORTINGCAPS);
 
@@ -389,6 +391,7 @@ public:
   elist<CInode*>::item item_dirty;
   elist<CInode*>::item item_caps;
   elist<CInode*>::item item_open_file;
+  elist<CInode*>::item item_dirty_parent;
   elist<CInode*>::item item_dirty_dirfrag_dir;
   elist<CInode*>::item item_dirty_dirfrag_nest;
   elist<CInode*>::item item_dirty_dirfrag_dirfragtree;
@@ -429,7 +432,7 @@ private:
     parent(0),
     inode_auth(CDIR_AUTH_DEFAULT),
     replica_caps_wanted(0),
-    item_dirty(this), item_caps(this), item_open_file(this),
+    item_dirty(this), item_caps(this), item_open_file(this), item_dirty_parent(this),
     item_dirty_dirfrag_dir(this), 
     item_dirty_dirfrag_nest(this), 
     item_dirty_dirfrag_dirfragtree(this), 
@@ -536,6 +539,12 @@ private:
   void _fetched_backtrace(bufferlist *bl, inode_backtrace_t *bt, Context *fin);
 
   void build_backtrace(int64_t location, inode_backtrace_t* bt);
+  void store_backtrace(Context *fin);
+  void _stored_backtrace(version_t v, Context *fin);
+  void _mark_dirty_parent(LogSegment *ls, bool dirty_pool=false);
+  void clear_dirty_parent();
+  bool is_dirty_parent() { return state_test(STATE_DIRTYPARENT); }
+  bool is_dirty_pool() { return state_test(STATE_DIRTYPOOL); }
 
   void encode_store(bufferlist& bl);
   void decode_store(bufferlist::iterator& bl);
diff --git a/src/mds/LogSegment.h b/src/mds/LogSegment.h
index 8cf58a1..d42e352 100644
--- a/src/mds/LogSegment.h
+++ b/src/mds/LogSegment.h
@@ -58,6 +58,7 @@ class LogSegment {
   elist<CDentry*> dirty_dentries;
 
   elist<CInode*>  open_files;
+  elist<CInode*>  dirty_parent_inodes;
   elist<CInode*>  dirty_dirfrag_dir;
   elist<CInode*>  dirty_dirfrag_nest;
   elist<CInode*>  dirty_dirfrag_dirfragtree;
@@ -90,6 +91,7 @@ class LogSegment {
     dirty_inodes(member_offset(CInode, item_dirty)),
     dirty_dentries(member_offset(CDentry, item_dirty)),
     open_files(member_offset(CInode, item_open_file)),
+    dirty_parent_inodes(member_offset(CInode, item_dirty_parent)),
     dirty_dirfrag_dir(member_offset(CInode, item_dirty_dirfrag_dir)),
     dirty_dirfrag_nest(member_offset(CInode, item_dirty_dirfrag_nest)),
     dirty_dirfrag_dirfragtree(member_offset(CInode, item_dirty_dirfrag_dirfragtree)),
diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 601ddc2..00ba4eb 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -235,6 +235,8 @@ void MDCache::remove_inode(CInode *o)
 
   if (o->is_dirty())
     o->mark_clean();
+  if (o->is_dirty_parent())
+    o->clear_dirty_parent();
 
   o->filelock.remove_dirty();
   o->nestlock.remove_dirty();
@@ -1585,7 +1587,13 @@ void MDCache::journal_dirty_inode(Mutation *mut, EMetaBlob *metablob, CInode *in
     CDentry *dn = in->get_projected_parent_dn();
     if (!dn->get_projected_linkage()->is_null())  // no need to cow a null dentry
       journal_cow_dentry(mut, metablob, dn, follows);
-    metablob->add_primary_dentry(dn, in, true);
+    if (in->get_projected_inode()->is_backtrace_updated()) {
+      bool dirty_pool = in->get_projected_inode()->layout.fl_pg_pool !=
+			in->get_previous_projected_inode()->layout.fl_pg_pool;
+      metablob->add_primary_dentry(dn, in, true, true, dirty_pool);
+    } else {
+      metablob->add_primary_dentry(dn, in, true);
+    }
   }
 }
 
@@ -3403,6 +3411,8 @@ void MDCache::recalc_auth_bits()
 	    dnl->get_inode()->state_clear(CInode::STATE_AUTH);
 	    if (dnl->get_inode()->is_dirty())
 	      dnl->get_inode()->mark_clean();
+	    if (dnl->get_inode()->is_dirty_parent())
+	      dnl->get_inode()->clear_dirty_parent();
 	    // avoid touching scatterlocks for our subtree roots!
 	    if (subtree_inodes.count(dnl->get_inode()) == 0)
 	      dnl->get_inode()->clear_scatter_dirty();
diff --git a/src/mds/MDLog.cc b/src/mds/MDLog.cc
index 5389743..84d2612 100644
--- a/src/mds/MDLog.cc
+++ b/src/mds/MDLog.cc
@@ -619,6 +619,7 @@ void MDLog::standby_trim_segments()
     seg->dirty_inodes.clear_list();
     seg->dirty_dentries.clear_list();
     seg->open_files.clear_list();
+    seg->dirty_parent_inodes.clear_list();
     seg->dirty_dirfrag_dir.clear_list();
     seg->dirty_dirfrag_nest.clear_list();
     seg->dirty_dirfrag_dirfragtree.clear_list();
diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index 766ecf9..faa8a8d 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -1098,6 +1098,8 @@ void Migrator::finish_export_inode(CInode *in, utime_t now, list<Context*>& fini
 
   in->item_open_file.remove_myself();
 
+  in->clear_dirty_parent();
+
   // waiters
   in->take_waiting(CInode::WAIT_ANY_MASK, finished);
 
@@ -2074,6 +2076,8 @@ void Migrator::import_reverse(CDir *dir)
 	if (!in->has_subtree_root_dirfrag(mds->get_nodeid()))
 	  in->clear_scatter_dirty();
 
+	in->clear_dirty_parent();
+
 	in->authlock.clear_gather();
 	in->linklock.clear_gather();
 	in->dirfragtreelock.clear_gather();
@@ -2515,7 +2519,7 @@ int Migrator::decode_import_dir(bufferlist::iterator& blp,
     
     // add dentry to journal entry
     if (le)
-      le->metablob.add_dentry(dn, dn->is_dirty());
+      le->metablob.add_import_dentry(dn);
   }
   
 #ifdef MDS_VERIFY_FRAGSTAT
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 3750f3c..e0dbf4e 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -2688,6 +2688,7 @@ public:
     // dirty inode, dn, dir
     newi->inode.version--;   // a bit hacky, see C_MDS_mknod_finish
     newi->mark_dirty(newi->inode.version+1, mdr->ls);
+    newi->_mark_dirty_parent(mdr->ls);
 
     mdr->apply();
 
@@ -2821,6 +2822,7 @@ void Server::handle_client_openc(MDRequest *mdr)
   dn->push_projected_linkage(in);
 
   in->inode.version = dn->pre_dirty();
+  in->inode.update_backtrace();
   if (cmode & CEPH_FILE_MODE_WR) {
     in->inode.client_ranges[client].range.first = 0;
     in->inode.client_ranges[client].range.last = in->inode.get_layout_size_increment();
@@ -2839,7 +2841,7 @@ void Server::handle_client_openc(MDRequest *mdr)
   le->metablob.add_client_req(req->get_reqid(), req->get_oldest_client_tid());
   journal_allocated_inos(mdr, &le->metablob);
   mdcache->predirty_journal_parents(mdr, &le->metablob, in, dn->get_dir(), PREDIRTY_PRIMARY|PREDIRTY_DIR, 1);
-  le->metablob.add_primary_dentry(dn, in, true);
+  le->metablob.add_primary_dentry(dn, in, true, true);
 
   // do the open
   mds->locker->issue_new_caps(in, cmode, mdr->session, realm, req->is_replay());
@@ -3771,6 +3773,8 @@ void Server::handle_set_vxattr(MDRequest *mdr, CInode *cur,
     }
 
     pi->version = cur->pre_dirty();
+    if (cur->is_file())
+      pi->update_backtrace();
 
     // log + wait
     mdr->ls = mdlog->get_current_segment();
@@ -4013,6 +4017,7 @@ public:
     // a new version of hte inode since it's just been created)
     newi->inode.version--; 
     newi->mark_dirty(newi->inode.version + 1, mdr->ls);
+    newi->_mark_dirty_parent(mdr->ls);
 
     // mkdir?
     if (newi->inode.is_dir()) { 
@@ -4095,6 +4100,7 @@ void Server::handle_client_mknod(MDRequest *mdr)
     newi->inode.mode |= S_IFREG;
   newi->inode.version = dn->pre_dirty();
   newi->inode.rstat.rfiles = 1;
+  newi->inode.update_backtrace();
 
   // if the client created a _regular_ file via MKNOD, it's highly likely they'll
   // want to write to it (e.g., if they are reexporting NFS)
@@ -4135,7 +4141,7 @@ void Server::handle_client_mknod(MDRequest *mdr)
   
   mdcache->predirty_journal_parents(mdr, &le->metablob, newi, dn->get_dir(),
 				    PREDIRTY_PRIMARY|PREDIRTY_DIR, 1);
-  le->metablob.add_primary_dentry(dn, newi, true);
+  le->metablob.add_primary_dentry(dn, newi, true, true);
 
   journal_and_reply(mdr, newi, dn, le, new C_MDS_mknod_finish(mds, mdr, dn, newi, follows));
 }
@@ -4175,6 +4181,7 @@ void Server::handle_client_mkdir(MDRequest *mdr)
 
   newi->inode.version = dn->pre_dirty();
   newi->inode.rstat.rsubdirs = 1;
+  newi->inode.update_backtrace();
 
   dout(12) << " follows " << follows << dendl;
   if (follows >= dn->first)
@@ -4193,7 +4200,7 @@ void Server::handle_client_mkdir(MDRequest *mdr)
   le->metablob.add_client_req(req->get_reqid(), req->get_oldest_client_tid());
   journal_allocated_inos(mdr, &le->metablob);
   mdcache->predirty_journal_parents(mdr, &le->metablob, newi, dn->get_dir(), PREDIRTY_PRIMARY|PREDIRTY_DIR, 1);
-  le->metablob.add_primary_dentry(dn, newi, true);
+  le->metablob.add_primary_dentry(dn, newi, true, true);
   le->metablob.add_new_dir(newdir); // dirty AND complete AND new
   
   // issue a cap on the directory
@@ -4251,6 +4258,7 @@ void Server::handle_client_symlink(MDRequest *mdr)
   newi->inode.rstat.rbytes = newi->inode.size;
   newi->inode.rstat.rfiles = 1;
   newi->inode.version = dn->pre_dirty();
+  newi->inode.update_backtrace();
 
   if (follows >= dn->first)
     dn->first = follows + 1;
@@ -4263,7 +4271,7 @@ void Server::handle_client_symlink(MDRequest *mdr)
   le->metablob.add_client_req(req->get_reqid(), req->get_oldest_client_tid());
   journal_allocated_inos(mdr, &le->metablob);
   mdcache->predirty_journal_parents(mdr, &le->metablob, newi, dn->get_dir(), PREDIRTY_PRIMARY|PREDIRTY_DIR, 1);
-  le->metablob.add_primary_dentry(dn, newi, true);
+  le->metablob.add_primary_dentry(dn, newi, true, true);
 
   journal_and_reply(mdr, newi, dn, le, new C_MDS_mknod_finish(mds, mdr, dn, newi, follows));
 }
diff --git a/src/mds/events/EMetaBlob.h b/src/mds/events/EMetaBlob.h
index a5e9c33..58056cc 100644
--- a/src/mds/events/EMetaBlob.h
+++ b/src/mds/events/EMetaBlob.h
@@ -470,9 +470,19 @@ private:
   // convenience: primary or remote?  figure it out.
   void add_dentry(CDentry *dn, bool dirty) {
     dirlump& lump = add_dir(dn->get_dir(), false);
-    add_dentry(lump, dn, dirty);
+    add_dentry(lump, dn, dirty, false, false);
   }
-  void add_dentry(dirlump& lump, CDentry *dn, bool dirty) {
+  void add_import_dentry(CDentry *dn) {
+    bool dirty_parent = false;
+    bool dirty_pool = false;
+    if (dn->get_linkage()->is_primary()) {
+      dirty_parent = dn->get_linkage()->get_inode()->is_dirty_parent();
+      dirty_pool = dn->get_linkage()->get_inode()->is_dirty_pool();
+    }
+    dirlump& lump = add_dir(dn->get_dir(), false);
+    add_dentry(lump, dn, dn->is_dirty(), dirty_parent, dirty_pool);
+  }
+  void add_dentry(dirlump& lump, CDentry *dn, bool dirty, bool dirty_parent, bool dirty_pool) {
     // primary or remote
     if (dn->get_projected_linkage()->is_remote()) {
       add_remote_dentry(dn, dirty);
@@ -482,7 +492,7 @@ private:
       return;
     }
     assert(dn->get_projected_linkage()->is_primary());
-    add_primary_dentry(dn, 0, dirty);
+    add_primary_dentry(dn, 0, dirty, dirty_parent, dirty_pool);
   }
 
   void add_root(bool dirty, CInode *in, inode_t *pi=0, fragtree_t *pdft=0, bufferlist *psnapbl=0,
diff --git a/src/mds/journal.cc b/src/mds/journal.cc
index f29695b..dc7a9ae 100644
--- a/src/mds/journal.cc
+++ b/src/mds/journal.cc
@@ -185,6 +185,17 @@ void LogSegment::try_to_expire(MDS *mds, C_GatherBuilder &gather_bld)
   assert(g_conf->mds_kill_journal_expire_at != 3);
 
   // backtraces to be stored/updated
+  for (elist<CInode*>::iterator p = dirty_parent_inodes.begin(); !p.end(); ++p) {
+    CInode *in = *p;
+    assert(in->is_auth());
+    if (in->can_auth_pin()) {
+      dout(15) << "try_to_expire waiting for storing backtrace on " << *in << dendl;
+      in->store_backtrace(gather_bld.new_sub());
+    } else {
+      dout(15) << "try_to_expire waiting for unfreeze on " << *in << dendl;
+      in->add_waiter(CInode::WAIT_UNFREEZE, gather_bld.new_sub());
+    }
+  }
   for (elist<BacktraceInfo*>::iterator p = update_backtraces.begin(); !p.end(); ++p) {
     BacktraceInfo *btinfo = *p;
     store_backtrace_update(mds, btinfo, gather_bld.new_sub());
@@ -1178,6 +1189,8 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg, MDSlaveUpdate *slaveup)
       }
 
       assert(g_conf->mds_kill_journal_replay_at != 2);
+      if (p->is_dirty_parent())
+	in->_mark_dirty_parent(logseg, p->is_dirty_pool());
 
       // store backtrace for allocated inos (create, mkdir, symlink, mknod)
       if (allocated_ino || used_preallocated_ino) {
-- 
1.8.1.4


