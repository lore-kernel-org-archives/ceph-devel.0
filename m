From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 22/30] mds: reorder EMetaBlob::add_primary_dentry's parameters
Date: Thu, 23 May 2013 16:06:50 +0800
Message-ID: <1369296418-14871-23-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51279 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757007Ab3EWINR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:17 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

prepare for adding new state parameter such as 'dirty_parent'

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CDir.cc            |  2 +-
 src/mds/Locker.cc          |  2 +-
 src/mds/MDCache.cc         | 14 +++++++-------
 src/mds/Server.cc          | 38 +++++++++++++++++++-------------------
 src/mds/events/EMetaBlob.h |  8 ++++----
 src/mds/events/EOpen.h     |  2 +-
 6 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
index 10b4bf4..6342dcb 100644
--- a/src/mds/CDir.cc
+++ b/src/mds/CDir.cc
@@ -1055,7 +1055,7 @@ void CDir::assimilate_dirty_rstat_inodes_finish(Mutation *mut, EMetaBlob *blob)
     mut->add_projected_inode(in);
 
     in->clear_dirty_rstat();
-    blob->add_primary_dentry(dn, true, in);
+    blob->add_primary_dentry(dn, in, true);
   }
 
   if (!dirty_rstat_inodes.empty())
diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 7823aed..4358a79 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -2128,7 +2128,7 @@ bool Locker::check_inode_max_size(CInode *in, bool force_wrlock,
     mdcache->predirty_journal_parents(mut, metablob, in, 0, PREDIRTY_PRIMARY);
     // no cow, here!
     CDentry *parent = in->get_projected_parent_dn();
-    metablob->add_primary_dentry(parent, true, in);
+    metablob->add_primary_dentry(parent, in, true);
   } else {
     metablob->add_dir_context(in->get_projected_parent_dn()->get_dir());
     mdcache->journal_dirty_inode(mut, metablob, in);
diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 8fc1ab8..601ddc2 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -461,7 +461,7 @@ void MDCache::_create_system_file(CDir *dir, const char *name, CInode *in, Conte
 
   if (!in->is_mdsdir()) {
     predirty_journal_parents(mut, &le->metablob, in, dir, PREDIRTY_PRIMARY|PREDIRTY_DIR, 1);
-    le->metablob.add_primary_dentry(dn, true, in);
+    le->metablob.add_primary_dentry(dn, in, true);
   } else {
     predirty_journal_parents(mut, &le->metablob, in, dir, PREDIRTY_DIR, 1);
     journal_dirty_inode(mut, &le->metablob, in);
@@ -1552,7 +1552,7 @@ void MDCache::journal_cow_dentry(Mutation *mut, EMetaBlob *metablob, CDentry *dn
       CDentry *olddn = dn->dir->add_primary_dentry(dn->name, oldin, oldfirst, follows);
       oldin->inode.version = olddn->pre_dirty();
       dout(10) << " olddn " << *olddn << dendl;
-      metablob->add_primary_dentry(olddn, true, 0);
+      metablob->add_primary_dentry(olddn, 0, true);
       mut->add_cow_dentry(olddn);
     } else {
       assert(dnl->is_remote());
@@ -1585,7 +1585,7 @@ void MDCache::journal_dirty_inode(Mutation *mut, EMetaBlob *metablob, CInode *in
     CDentry *dn = in->get_projected_parent_dn();
     if (!dn->get_projected_linkage()->is_null())  // no need to cow a null dentry
       journal_cow_dentry(mut, metablob, dn, follows);
-    metablob->add_primary_dentry(dn, true, in);
+    metablob->add_primary_dentry(dn, in, true);
   }
 }
 
@@ -5514,7 +5514,7 @@ void MDCache::queue_file_recover(CInode *in)
     }
     
     in->parent->first = in->first;
-    le->metablob.add_primary_dentry(in->parent, true, in);
+    le->metablob.add_primary_dentry(in->parent, in, true);
     mds->mdlog->submit_entry(le, new C_MDC_QueuedCow(this, in, mut));
     mds->mdlog->flush();
   }
@@ -5794,7 +5794,7 @@ void MDCache::truncate_inode_finish(CInode *in, LogSegment *ls)
   EUpdate *le = new EUpdate(mds->mdlog, "truncate finish");
   mds->mdlog->start_entry(le);
   le->metablob.add_dir_context(in->get_parent_dir());
-  le->metablob.add_primary_dentry(in->get_projected_parent_dn(), true, in);
+  le->metablob.add_primary_dentry(in->get_projected_parent_dn(), in, true);
   le->metablob.add_truncate_finish(in->ino(), ls->offset);
 
   journal_dirty_inode(mut, &le->metablob, in);
@@ -8384,7 +8384,7 @@ void MDCache::snaprealm_create(MDRequest *mdr, CInode *in)
   
   predirty_journal_parents(mut, &le->metablob, in, 0, PREDIRTY_PRIMARY);
   journal_cow_inode(mut, &le->metablob, in);
-  le->metablob.add_primary_dentry(in->get_projected_parent_dn(), true, in);
+  le->metablob.add_primary_dentry(in->get_projected_parent_dn(), in, true);
 
   mds->mdlog->submit_entry(le, new C_MDC_snaprealm_create_finish(this, mdr, mut, in));
   mds->mdlog->flush();
@@ -8833,7 +8833,7 @@ void MDCache::_purge_stray_purged(CDentry *dn, int r)
     pi->version = in->pre_dirty();
 
     le->metablob.add_dir_context(dn->dir);
-    le->metablob.add_primary_dentry(dn, true, in);
+    le->metablob.add_primary_dentry(dn, in, true);
 
     mds->mdlog->submit_entry(le, new C_MDC_PurgeStrayLoggedTruncate(this, dn, mds->mdlog->get_current_segment()));
   }
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 69f1869..8a0719c 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -2839,7 +2839,7 @@ void Server::handle_client_openc(MDRequest *mdr)
   le->metablob.add_client_req(req->get_reqid(), req->get_oldest_client_tid());
   journal_allocated_inos(mdr, &le->metablob);
   mdcache->predirty_journal_parents(mdr, &le->metablob, in, dn->get_dir(), PREDIRTY_PRIMARY|PREDIRTY_DIR, 1);
-  le->metablob.add_primary_dentry(dn, true, in);
+  le->metablob.add_primary_dentry(dn, in, true);
 
   // do the open
   mds->locker->issue_new_caps(in, cmode, mdr->session, realm, req->is_replay());
@@ -4135,7 +4135,7 @@ void Server::handle_client_mknod(MDRequest *mdr)
   
   mdcache->predirty_journal_parents(mdr, &le->metablob, newi, dn->get_dir(),
 				    PREDIRTY_PRIMARY|PREDIRTY_DIR, 1);
-  le->metablob.add_primary_dentry(dn, true, newi);
+  le->metablob.add_primary_dentry(dn, newi, true);
 
   journal_and_reply(mdr, newi, dn, le, new C_MDS_mknod_finish(mds, mdr, dn, newi, follows));
 }
@@ -4193,7 +4193,7 @@ void Server::handle_client_mkdir(MDRequest *mdr)
   le->metablob.add_client_req(req->get_reqid(), req->get_oldest_client_tid());
   journal_allocated_inos(mdr, &le->metablob);
   mdcache->predirty_journal_parents(mdr, &le->metablob, newi, dn->get_dir(), PREDIRTY_PRIMARY|PREDIRTY_DIR, 1);
-  le->metablob.add_primary_dentry(dn, true, newi);
+  le->metablob.add_primary_dentry(dn, newi, true);
   le->metablob.add_new_dir(newdir); // dirty AND complete AND new
   
   // issue a cap on the directory
@@ -4263,7 +4263,7 @@ void Server::handle_client_symlink(MDRequest *mdr)
   le->metablob.add_client_req(req->get_reqid(), req->get_oldest_client_tid());
   journal_allocated_inos(mdr, &le->metablob);
   mdcache->predirty_journal_parents(mdr, &le->metablob, newi, dn->get_dir(), PREDIRTY_PRIMARY|PREDIRTY_DIR, 1);
-  le->metablob.add_primary_dentry(dn, true, newi);
+  le->metablob.add_primary_dentry(dn, newi, true);
 
   journal_and_reply(mdr, newi, dn, le, new C_MDS_mknod_finish(mds, mdr, dn, newi, follows));
 }
@@ -4801,7 +4801,7 @@ void Server::do_link_rollback(bufferlist &rbl, int master, MDRequest *mdr)
   mdlog->start_entry(le);
   le->commit.add_dir_context(parent);
   le->commit.add_dir(parent, true);
-  le->commit.add_primary_dentry(in->get_projected_parent_dn(), true, 0);
+  le->commit.add_primary_dentry(in->get_projected_parent_dn(), 0, true);
   
   mdlog->submit_entry(le, new C_MDS_LoggedLinkRollback(this, mut, mdr));
   mdlog->flush();
@@ -5096,7 +5096,7 @@ void Server::_unlink_local(MDRequest *mdr, CDentry *dn, CDentry *straydn)
     if (in->snaprealm || follows + 1 > dn->first)
       in->project_past_snaprealm_parent(straydn->get_dir()->inode->find_snaprealm());
 
-    le->metablob.add_primary_dentry(straydn, true, in);
+    le->metablob.add_primary_dentry(straydn, in, true);
   } else {
     // remote link.  update remote inode.
     mdcache->predirty_journal_parents(mdr, &le->metablob, in, dn->get_dir(), PREDIRTY_DIR, -1);
@@ -5256,7 +5256,7 @@ void Server::handle_slave_rmdir_prep(MDRequest *mdr)
   le->rollback = mdr->more()->rollback_bl;
 
   le->commit.add_dir_context(straydn->get_dir());
-  le->commit.add_primary_dentry(straydn, true, in);
+  le->commit.add_primary_dentry(straydn, in, true);
   // slave: no need to journal original dentry
 
   dout(10) << " noting renamed (unlinked) dir ino " << in->ino() << " in metablob" << dendl;
@@ -5386,7 +5386,7 @@ void Server::do_rmdir_rollback(bufferlist &rbl, int master, MDRequest *mdr)
   mdlog->start_entry(le);
   
   le->commit.add_dir_context(dn->get_dir());
-  le->commit.add_primary_dentry(dn, true, in);
+  le->commit.add_primary_dentry(dn, in, true);
   // slave: no need to journal straydn
   
   dout(10) << " noting renamed (unlinked) dir ino " << in->ino() << " in metablob" << dendl;
@@ -6282,11 +6282,11 @@ void Server::_rename_prepare(MDRequest *mdr,
 	if (oldin->snaprealm || src_realm->get_newest_seq() + 1 > srcdn->first)
 	  oldin->project_past_snaprealm_parent(straydn->get_dir()->inode->find_snaprealm());
 	straydn->first = MAX(oldin->first, next_dest_snap);
-	metablob->add_primary_dentry(straydn, true, oldin);
+	metablob->add_primary_dentry(straydn, oldin, true);
       } else if (force_journal_stray) {
 	dout(10) << " forced journaling straydn " << *straydn << dendl;
 	metablob->add_dir_context(straydn->get_dir());
-	metablob->add_primary_dentry(straydn, true, oldin);
+	metablob->add_primary_dentry(straydn, oldin, true);
       }
     } else if (destdnl->is_remote()) {
       if (oldin->is_auth()) {
@@ -6294,7 +6294,7 @@ void Server::_rename_prepare(MDRequest *mdr,
 	metablob->add_dir_context(oldin->get_projected_parent_dir());
 	mdcache->journal_cow_dentry(mdr, metablob, oldin->get_projected_parent_dn(),
 				    CEPH_NOSNAP, 0, destdnl);
-	metablob->add_primary_dentry(oldin->get_projected_parent_dn(), true, oldin);
+	metablob->add_primary_dentry(oldin->get_projected_parent_dn(), oldin, true);
       }
     }
   }
@@ -6312,7 +6312,7 @@ void Server::_rename_prepare(MDRequest *mdr,
       if (srci->get_projected_parent_dn()->is_auth()) { // it's remote
 	metablob->add_dir_context(srci->get_projected_parent_dir());
         mdcache->journal_cow_dentry(mdr, metablob, srci->get_projected_parent_dn(), CEPH_NOSNAP, 0, srcdnl);
-	metablob->add_primary_dentry(srci->get_projected_parent_dn(), true, srci);
+	metablob->add_primary_dentry(srci->get_projected_parent_dn(), srci, true);
       }
     } else {
       if (destdn->is_auth() && !destdnl->is_null())
@@ -6321,7 +6321,7 @@ void Server::_rename_prepare(MDRequest *mdr,
 	destdn->first = MAX(destdn->first, next_dest_snap);
 
       if (destdn->is_auth())
-        metablob->add_primary_dentry(destdn, true, destdnl->get_inode());
+        metablob->add_primary_dentry(destdn, destdnl->get_inode(), true);
     }
   } else if (srcdnl->is_primary()) {
     // project snap parent update?
@@ -6335,11 +6335,11 @@ void Server::_rename_prepare(MDRequest *mdr,
       destdn->first = MAX(destdn->first, next_dest_snap);
 
     if (destdn->is_auth())
-      metablob->add_primary_dentry(destdn, true, srci);
+      metablob->add_primary_dentry(destdn, srci, true);
     else if (force_journal_dest) {
       dout(10) << " forced journaling destdn " << *destdn << dendl;
       metablob->add_dir_context(destdn->get_dir());
-      metablob->add_primary_dentry(destdn, true, srci);
+      metablob->add_primary_dentry(destdn, srci, true);
       if (srcdn->is_auth() && srci->is_dir()) {
 	// journal new subtrees root dirfrags
 	list<CDir*> ls;
@@ -6361,7 +6361,7 @@ void Server::_rename_prepare(MDRequest *mdr,
     // both primary and NULL dentries. Because during journal replay, null dentry is
     // processed after primary dentry.
     if (srcdnl->is_primary() && !srci->is_dir() && !destdn->is_auth())
-      metablob->add_primary_dentry(srcdn, true, srci);
+      metablob->add_primary_dentry(srcdn, srci, true);
     metablob->add_null_dentry(srcdn, true);
   } else
     dout(10) << " NOT journaling srcdn " << *srcdn << dendl;
@@ -7073,7 +7073,7 @@ void Server::do_rename_rollback(bufferlist &rbl, int master, MDRequest *mdr,
   if (srcdn && (srcdn->authority().first == whoami || force_journal_src)) {
     le->commit.add_dir_context(srcdir);
     if (rollback.orig_src.ino)
-      le->commit.add_primary_dentry(srcdn, true);
+      le->commit.add_primary_dentry(srcdn, 0, true);
     else
       le->commit.add_remote_dentry(srcdn, true);
   }
@@ -7081,7 +7081,7 @@ void Server::do_rename_rollback(bufferlist &rbl, int master, MDRequest *mdr,
   if (force_journal_dest) {
     assert(rollback.orig_dest.ino);
     le->commit.add_dir_context(destdir);
-    le->commit.add_primary_dentry(destdn, true);
+    le->commit.add_primary_dentry(destdn, 0, true);
   }
 
   // slave: no need to journal straydn
@@ -7089,7 +7089,7 @@ void Server::do_rename_rollback(bufferlist &rbl, int master, MDRequest *mdr,
   if (target && target->authority().first == whoami) {
     assert(rollback.orig_dest.remote_ino);
     le->commit.add_dir_context(target->get_projected_parent_dir());
-    le->commit.add_primary_dentry(target->get_projected_parent_dn(), true, target);
+    le->commit.add_primary_dentry(target->get_projected_parent_dn(), target, true);
   }
 
   if (force_journal_dest) {
diff --git a/src/mds/events/EMetaBlob.h b/src/mds/events/EMetaBlob.h
index 439bd78..3d87f79 100644
--- a/src/mds/events/EMetaBlob.h
+++ b/src/mds/events/EMetaBlob.h
@@ -414,11 +414,11 @@ private:
   }
 
   // return remote pointer to to-be-journaled inode
-  void add_primary_dentry(CDentry *dn, bool dirty, CInode *in=0) {
+  void add_primary_dentry(CDentry *dn, CInode *in, bool dirty) {
     add_primary_dentry(add_dir(dn->get_dir(), false),
-		       dn, dirty, in);
+		       dn, in, dirty);
   }
-  void add_primary_dentry(dirlump& lump, CDentry *dn, bool dirty, CInode *in=0) {
+  void add_primary_dentry(dirlump& lump, CDentry *dn, CInode *in, bool dirty) {
     if (!in) 
       in = dn->get_projected_linkage()->get_inode();
 
@@ -458,7 +458,7 @@ private:
       return;
     }
     assert(dn->get_projected_linkage()->is_primary());
-    add_primary_dentry(dn, dirty);
+    add_primary_dentry(dn, 0, dirty);
   }
 
   void add_root(bool dirty, CInode *in, inode_t *pi=0, fragtree_t *pdft=0, bufferlist *psnapbl=0,
diff --git a/src/mds/events/EOpen.h b/src/mds/events/EOpen.h
index 792540e..1267cf0 100644
--- a/src/mds/events/EOpen.h
+++ b/src/mds/events/EOpen.h
@@ -34,7 +34,7 @@ public:
   void add_clean_inode(CInode *in) {
     if (!in->is_base()) {
       metablob.add_dir_context(in->get_projected_parent_dn()->get_dir());
-      metablob.add_primary_dentry(in->get_projected_parent_dn(), false, 0);
+      metablob.add_primary_dentry(in->get_projected_parent_dn(), 0, false);
       inos.push_back(in->ino());
     }
   }
-- 
1.8.1.4

