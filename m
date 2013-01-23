From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 12/25] mds: preserve non-auth/unlinked objects until slave commit
Date: Wed, 23 Jan 2013 11:08:48 +0800
Message-ID: <1358910541-15535-13-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51770 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818Ab3AWDJQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:16 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The MDS should not trim objects in non-auth subtree immediately after
replaying a slave rename. Because the slave rename may require rollback
later and these objects are needed for rollback.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc         | 93 +++++++++++++++++++++++++++++++++++++---------
 src/mds/MDCache.h          |  5 +++
 src/mds/Mutation.h         |  5 ++-
 src/mds/events/EMetaBlob.h |  3 +-
 src/mds/journal.cc         | 53 +++++++++++++-------------
 5 files changed, 113 insertions(+), 46 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index adcf8c1..5a6d3f2 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -2867,16 +2867,14 @@ void MDCache::handle_resolve_ack(MMDSResolveAck *ack)
     
     if (mds->is_resolve()) {
       // replay
-      assert(uncommitted_slave_updates[from].count(*p));
+      MDSlaveUpdate *su = get_uncommitted_slave_update(from, *p);
+      assert(su);
+
       // log commit
       mds->mdlog->start_submit_entry(new ESlaveUpdate(mds->mdlog, "unknown", *p, from,
-						      ESlaveUpdate::OP_COMMIT,
-						      uncommitted_slave_updates[from][*p]->origop));
+						      ESlaveUpdate::OP_COMMIT, su->origop));
 
-      delete uncommitted_slave_updates[from][*p];
-      uncommitted_slave_updates[from].erase(*p);
-      if (uncommitted_slave_updates[from].empty())
-	uncommitted_slave_updates.erase(from);
+      finish_uncommitted_slave_update(from, *p);
 
       mds->mdlog->wait_for_safe(new C_MDC_SlaveCommit(this, from, *p));
       mds->mdlog->flush();
@@ -2893,28 +2891,26 @@ void MDCache::handle_resolve_ack(MMDSResolveAck *ack)
     dout(10) << " abort on slave " << *p << dendl;
 
     if (mds->is_resolve()) {
-      assert(uncommitted_slave_updates[from].count(*p));
+      MDSlaveUpdate *su = get_uncommitted_slave_update(from, *p);
+      assert(su);
 
       // perform rollback (and journal a rollback entry)
       // note: this will hold up the resolve a bit, until the rollback entries journal.
-      switch (uncommitted_slave_updates[from][*p]->origop) {
+      switch (su->origop) {
       case ESlaveUpdate::LINK:
-	mds->server->do_link_rollback(uncommitted_slave_updates[from][*p]->rollback, from, 0);
+	mds->server->do_link_rollback(su->rollback, from, 0);
 	break;
       case ESlaveUpdate::RENAME:
-	mds->server->do_rename_rollback(uncommitted_slave_updates[from][*p]->rollback, from, 0);
+	mds->server->do_rename_rollback(su->rollback, from, 0);
 	break;
       case ESlaveUpdate::RMDIR:
-	mds->server->do_rmdir_rollback(uncommitted_slave_updates[from][*p]->rollback, from, 0);
+	mds->server->do_rmdir_rollback(su->rollback, from, 0);
 	break;
       default:
 	assert(0);
       }
 
-      delete uncommitted_slave_updates[from][*p];
-      uncommitted_slave_updates[from].erase(*p);
-      if (uncommitted_slave_updates[from].empty())
-	uncommitted_slave_updates.erase(from);
+      finish_uncommitted_slave_update(from, *p);
     } else {
       MDRequest *mdr = request_get(*p);
       if (mdr->more()->slave_commit) {
@@ -2939,7 +2935,63 @@ void MDCache::handle_resolve_ack(MMDSResolveAck *ack)
   ack->put();
 }
 
+void MDCache::add_uncommitted_slave_update(int master, metareqid_t reqid, MDSlaveUpdate *su)
+{
+  assert(uncommitted_slave_updates[master].count(reqid) == 0);
+  uncommitted_slave_updates[master][reqid] = su;
+  if (su->rename_olddir)
+    uncommitted_slave_rename_olddir[su->rename_olddir]++;
+  for(set<CInode*>::iterator p = su->unlinked.begin(); p != su->unlinked.end(); p++)
+     uncommitted_slave_unlink[*p]++;
+}
+
+void MDCache::finish_uncommitted_slave_update(int master, metareqid_t reqid)
+{
+  assert(uncommitted_slave_updates[master].count(reqid));
+  MDSlaveUpdate* su = uncommitted_slave_updates[master][reqid];
+
+  uncommitted_slave_updates[master].erase(reqid);
+  if (uncommitted_slave_updates[master].empty())
+    uncommitted_slave_updates.erase(master);
+  // discard the non-auth subtree we renamed out of
+  if (su->rename_olddir) {
+    uncommitted_slave_rename_olddir[su->rename_olddir]--;
+    if (uncommitted_slave_rename_olddir[su->rename_olddir] == 0) {
+      uncommitted_slave_rename_olddir.erase(su->rename_olddir);
+      // in the resolve stage, there probably are unfinished rename rollback,
+      // trim_non_auth_subtree() does not recognize projected linkage change.
+      // non-auth subtrees will be trimmed when the resolve stage finishes.
+      if (!mds->is_resolve()) {
+	CDir *root = get_subtree_root(su->rename_olddir);
+	if (root->get_dir_auth() == CDIR_AUTH_UNDEF)
+	  try_trim_non_auth_subtree(root);
+      }
+    }
+  }
+  // removed the inodes that were unlinked by slave update
+  for(set<CInode*>::iterator p = su->unlinked.begin(); p != su->unlinked.end(); p++) {
+    CInode *in = *p;
+    uncommitted_slave_unlink[in]--;
+    if (uncommitted_slave_unlink[in] == 0) {
+      uncommitted_slave_unlink.erase(in);
+      if (!in->get_projected_parent_dn())
+	mds->mdcache->remove_inode_recursive(in);
+    }
+  }
+  delete su;
+}
 
+MDSlaveUpdate* MDCache::get_uncommitted_slave_update(int master, metareqid_t reqid)
+{
+
+  MDSlaveUpdate* su = NULL;
+  if (uncommitted_slave_updates.count(master) &&
+      uncommitted_slave_updates[master].count(reqid)) {
+    su = uncommitted_slave_updates[master][reqid];
+    assert(su);
+  }
+  return su;
+}
 
 void MDCache::disambiguate_imports()
 {
@@ -5788,6 +5840,10 @@ bool MDCache::trim_non_auth_subtree(CDir *dir)
 {
   dout(10) << "trim_non_auth_subtree(" << dir << ") " << *dir << dendl;
 
+  // preserve the dir for rollback
+  if (uncommitted_slave_rename_olddir.count(dir))
+    return true;
+
   bool keep_dir = false;
   CDir::map_t::iterator j = dir->begin();
   CDir::map_t::iterator i = j;
@@ -5805,7 +5861,9 @@ bool MDCache::trim_non_auth_subtree(CDir *dir)
         for (list<CDir*>::iterator subdir = subdirs.begin();
             subdir != subdirs.end();
             ++subdir) {
-          if ((*subdir)->is_subtree_root() || my_ambiguous_imports.count((*subdir)->dirfrag())) {
+          if (uncommitted_slave_rename_olddir.count(*subdir) || // preserve the dir for rollback
+	      my_ambiguous_imports.count((*subdir)->dirfrag()) ||
+	      (*subdir)->is_subtree_root()) {
             keep_inode = true;
             dout(10) << "trim_non_auth_subtree(" << dir << ") subdir " << *subdir << "is kept!" << dendl;
           }
@@ -5837,6 +5895,7 @@ bool MDCache::trim_non_auth_subtree(CDir *dir)
       dir->remove_dentry(dn);
     }
   }
+
   /**
    * We've now checked all our children and deleted those that need it.
    * Now return to caller, and tell them if *we're* a keeper.
diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
index 31c7467..ecf5b29 100644
--- a/src/mds/MDCache.h
+++ b/src/mds/MDCache.h
@@ -312,6 +312,8 @@ protected:
   map<int, map<dirfrag_t, vector<dirfrag_t> > > other_ambiguous_imports;  
 
   map<int, map<metareqid_t, MDSlaveUpdate*> > uncommitted_slave_updates;  // slave: for replay.
+  map<CDir*, int> uncommitted_slave_rename_olddir;  // slave: preserve the non-auth dir until seeing commit.
+  map<CInode*, int> uncommitted_slave_unlink;  // slave: preserve the unlinked inode until seeing commit.
 
   // track master requests whose slaves haven't acknowledged commit
   struct umaster {
@@ -337,6 +339,9 @@ protected:
   void disambiguate_imports();
   void recalc_auth_bits();
   void trim_unlinked_inodes();
+  void add_uncommitted_slave_update(int master, metareqid_t reqid, MDSlaveUpdate*);
+  void finish_uncommitted_slave_update(int master, metareqid_t reqid);
+  MDSlaveUpdate* get_uncommitted_slave_update(int master, metareqid_t reqid);
 public:
   void remove_inode_recursive(CInode *in);
 
diff --git a/src/mds/Mutation.h b/src/mds/Mutation.h
index d0d3eca..36d62a7 100644
--- a/src/mds/Mutation.h
+++ b/src/mds/Mutation.h
@@ -298,10 +298,13 @@ struct MDSlaveUpdate {
   bufferlist rollback;
   elist<MDSlaveUpdate*>::item item;
   Context *waiter;
+  CDir* rename_olddir;
+  set<CInode*> unlinked;
   MDSlaveUpdate(int oo, bufferlist &rbl, elist<MDSlaveUpdate*> &list) :
     origop(oo),
     item(this),
-    waiter(0) {
+    waiter(0),
+    rename_olddir(0) {
     rollback.claim(rbl);
     list.push_back(&item);
   }
diff --git a/src/mds/events/EMetaBlob.h b/src/mds/events/EMetaBlob.h
index 9bbd615..77ceb94 100644
--- a/src/mds/events/EMetaBlob.h
+++ b/src/mds/events/EMetaBlob.h
@@ -27,6 +27,7 @@
 class MDS;
 class MDLog;
 class LogSegment;
+class MDSlaveUpdate;
 
 /*
  * a bunch of metadata in the journal
@@ -674,7 +675,7 @@ private:
   }
 
   void update_segment(LogSegment *ls);
-  void replay(MDS *mds, LogSegment *ls=0);
+  void replay(MDS *mds, LogSegment *ls, MDSlaveUpdate *su=NULL);
 };
 WRITE_CLASS_ENCODER(EMetaBlob)
 WRITE_CLASS_ENCODER(EMetaBlob::fullbit)
diff --git a/src/mds/journal.cc b/src/mds/journal.cc
index 72a5e5e..3e7e0fa 100644
--- a/src/mds/journal.cc
+++ b/src/mds/journal.cc
@@ -415,7 +415,7 @@ void EMetaBlob::fullbit::update_inode(MDS *mds, CInode *in)
   in->old_inodes = old_inodes;
 }
 
-void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
+void EMetaBlob::replay(MDS *mds, LogSegment *logseg, MDSlaveUpdate *slaveup)
 {
   dout(10) << "EMetaBlob.replay " << lump_map.size() << " dirlumps by " << client_name << dendl;
 
@@ -676,8 +676,12 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
       
       // see if we can discard the subtree we renamed out of
       CDir *root = mds->mdcache->get_subtree_root(olddir);
-      if (root->get_dir_auth() == CDIR_AUTH_UNDEF)
-	mds->mdcache->try_trim_non_auth_subtree(root);
+      if (root->get_dir_auth() == CDIR_AUTH_UNDEF) {
+	if (slaveup) // preserve the old dir until slave commit
+	  slaveup->rename_olddir = olddir;
+	else
+	  mds->mdcache->try_trim_non_auth_subtree(root);
+      }
     }
 
     // if we are the srci importer, we'll also have some dirfrags we have to open up...
@@ -710,8 +714,12 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
     for (set<CInode*>::iterator p = linked.begin(); p != linked.end(); p++)
       unlinked.erase(*p);
     dout(10) << " unlinked set contains " << unlinked << dendl;
-    for (map<CInode*, CDir*>::iterator p = unlinked.begin(); p != unlinked.end(); ++p)
-      mds->mdcache->remove_inode_recursive(p->first);
+    for (map<CInode*, CDir*>::iterator p = unlinked.begin(); p != unlinked.end(); ++p) {
+      if (slaveup) // preserve unlinked inodes until slave commit
+	slaveup->unlinked.insert(p->first);
+      else
+	mds->mdcache->remove_inode_recursive(p->first);
+    }
   }
 
   // table client transactions
@@ -1107,23 +1115,21 @@ void ECommitted::replay(MDS *mds)
 
 void ESlaveUpdate::replay(MDS *mds)
 {
+  MDSlaveUpdate *su;
   switch (op) {
   case ESlaveUpdate::OP_PREPARE:
     dout(10) << "ESlaveUpdate.replay prepare " << reqid << " for mds." << master 
 	     << ": applying commit, saving rollback info" << dendl;
-    assert(mds->mdcache->uncommitted_slave_updates[master].count(reqid) == 0);
-    commit.replay(mds, _segment);
-    mds->mdcache->uncommitted_slave_updates[master][reqid] = 
-      new MDSlaveUpdate(origop, rollback, _segment->slave_updates);
+    su = new MDSlaveUpdate(origop, rollback, _segment->slave_updates);
+    commit.replay(mds, _segment, su);
+    mds->mdcache->add_uncommitted_slave_update(master, reqid, su);
     break;
 
   case ESlaveUpdate::OP_COMMIT:
-    if (mds->mdcache->uncommitted_slave_updates[master].count(reqid)) {
+    su = mds->mdcache->get_uncommitted_slave_update(master, reqid);
+    if (su) {
       dout(10) << "ESlaveUpdate.replay commit " << reqid << " for mds." << master << dendl;
-      delete mds->mdcache->uncommitted_slave_updates[master][reqid];
-      mds->mdcache->uncommitted_slave_updates[master].erase(reqid);
-      if (mds->mdcache->uncommitted_slave_updates[master].empty())
-	mds->mdcache->uncommitted_slave_updates.erase(master);
+      mds->mdcache->finish_uncommitted_slave_update(master, reqid);
     } else {
       dout(10) << "ESlaveUpdate.replay commit " << reqid << " for mds." << master 
 	       << ": ignoring, no previously saved prepare" << dendl;
@@ -1131,19 +1137,12 @@ void ESlaveUpdate::replay(MDS *mds)
     break;
 
   case ESlaveUpdate::OP_ROLLBACK:
-    if (mds->mdcache->uncommitted_slave_updates[master].count(reqid)) {
-      dout(10) << "ESlaveUpdate.replay abort " << reqid << " for mds." << master
-	       << ": applying rollback commit blob" << dendl;
-      assert(mds->mdcache->uncommitted_slave_updates[master].count(reqid));
-      commit.replay(mds, _segment);
-      delete mds->mdcache->uncommitted_slave_updates[master][reqid];
-      mds->mdcache->uncommitted_slave_updates[master].erase(reqid);
-      if (mds->mdcache->uncommitted_slave_updates[master].empty())
-	mds->mdcache->uncommitted_slave_updates.erase(master);
-    } else {
-      dout(10) << "ESlaveUpdate.replay abort " << reqid << " for mds." << master 
-	       << ": ignoring, no previously saved prepare" << dendl;
-    }
+    dout(10) << "ESlaveUpdate.replay abort " << reqid << " for mds." << master
+	     << ": applying rollback commit blob" << dendl;
+    su = mds->mdcache->get_uncommitted_slave_update(master, reqid);
+    if (su)
+      mds->mdcache->finish_uncommitted_slave_update(master, reqid);
+    commit.replay(mds, _segment);
     break;
 
   default:
-- 
1.7.11.7

