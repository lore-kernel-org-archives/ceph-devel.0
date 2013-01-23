From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 13/25] mds: fix slave rename rollback
Date: Wed, 23 Jan 2013 11:08:49 +0800
Message-ID: <1358910541-15535-14-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11370 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936Ab3AWDJR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:17 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The main issue of old slave rename rollback code is that it assumes
all affected objects are in the cache. The assumption is not true
when MDS does rollback in the resolve stage. This patch removes the
assumption and makes Server::do_rename_rollback() check individual
object and roll back change.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 314 ++++++++++++++++++++++++++++++++++--------------------
 src/mds/Server.h  |   3 +-
 2 files changed, 198 insertions(+), 119 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index fedd4c2..4f2222f 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5010,7 +5010,7 @@ void Server::do_rmdir_rollback(bufferlist &rbl, int master, MDRequest *mdr)
 
 void Server::_rmdir_rollback_finish(MDRequest *mdr, metareqid_t reqid, CDentry *dn, CDentry *straydn)
 {
-  dout(10) << "_rmdir_rollback_finish " << *mdr << dendl;
+  dout(10) << "_rmdir_rollback_finish " << reqid << dendl;
 
   CInode *in = straydn->get_linkage()->get_inode();
   straydn->get_dir()->unlink_inode(dn);
@@ -6429,15 +6429,12 @@ void Server::_commit_slave_rename(MDRequest *mdr, int r,
 }
 
 void _rollback_repair_dir(Mutation *mut, CDir *dir, rename_rollback::drec &r, utime_t ctime, 
-			  bool isdir, int linkunlink, bool primary, frag_info_t &dirstat, nest_info_t &rstat)
+			  bool isdir, int linkunlink, nest_info_t &rstat)
 {
   fnode_t *pf;
-  if (dir->is_auth()) {
-    pf = dir->project_fnode();
-    mut->add_projected_fnode(dir);
-    pf->version = dir->pre_dirty();
-  } else
-    pf = dir->get_projected_fnode();
+  pf = dir->project_fnode();
+  mut->add_projected_fnode(dir);
+  pf->version = dir->pre_dirty();
 
   if (isdir) {
     pf->fragstat.nsubdirs += linkunlink;
@@ -6446,7 +6443,7 @@ void _rollback_repair_dir(Mutation *mut, CDir *dir, rename_rollback::drec &r, ut
     pf->fragstat.nfiles += linkunlink;
     pf->rstat.rfiles += linkunlink;
   }    
-  if (primary) {
+  if (r.ino) {
     pf->rstat.rbytes += linkunlink * rstat.rbytes;
     pf->rstat.rfiles += linkunlink * rstat.rfiles;
     pf->rstat.rsubdirs += linkunlink * rstat.rsubdirs;
@@ -6457,21 +6454,24 @@ void _rollback_repair_dir(Mutation *mut, CDir *dir, rename_rollback::drec &r, ut
     pf->fragstat.mtime = r.dirfrag_old_mtime;
     if (pf->rstat.rctime == ctime)
       pf->rstat.rctime = r.dirfrag_old_rctime;
-    mut->add_updated_lock(&dir->get_inode()->filelock);
-    mut->add_updated_lock(&dir->get_inode()->nestlock);
   }
+  mut->add_updated_lock(&dir->get_inode()->filelock);
+  mut->add_updated_lock(&dir->get_inode()->nestlock);
 }
 
 struct C_MDS_LoggedRenameRollback : public Context {
   Server *server;
   Mutation *mut;
   MDRequest *mdr;
-  CInode *in;
-  CDir *olddir;
+  CDentry *srcdn;
+  version_t srcdnpv;
+  CDentry *destdn;
+  CDentry *straydn;
   C_MDS_LoggedRenameRollback(Server *s, Mutation *m, MDRequest *r,
-			     CInode *i, CDir *d) : server(s), mut(m), mdr(r), in(i), olddir(d) {}
+			     CDentry *sd, version_t pv, CDentry *dd, CDentry *st) :
+    server(s), mut(m), mdr(r), srcdn(sd), srcdnpv(pv), destdn(dd), straydn(st) {}
   void finish(int r) {
-    server->_rename_rollback_finish(mut, mdr, in, olddir);
+    server->_rename_rollback_finish(mut, mdr, srcdn, srcdnpv, destdn, straydn);
   }
 };
 
@@ -6489,87 +6489,128 @@ void Server::do_rename_rollback(bufferlist &rbl, int master, MDRequest *mdr)
   Mutation *mut = new Mutation(rollback.reqid);
   mut->ls = mds->mdlog->get_current_segment();
 
+  CDentry *srcdn = NULL;
   CDir *srcdir = mds->mdcache->get_dirfrag(rollback.orig_src.dirfrag);
-  assert(srcdir);
-  dout(10) << "  srcdir " << *srcdir << dendl;
-  CDentry *srcdn = srcdir->lookup(rollback.orig_src.dname);
-  assert(srcdn);
-  dout(10) << "   srcdn " << *srcdn << dendl;
-  CDentry::linkage_t *srcdnl = srcdn->get_linkage();
-  assert(srcdnl->is_null());
+  if (srcdir) {
+    dout(10) << "  srcdir " << *srcdir << dendl;
+    srcdn = srcdir->lookup(rollback.orig_src.dname);
+    if (srcdn) {
+      dout(10) << "   srcdn " << *srcdn << dendl;
+      assert(srcdn->get_linkage()->is_null());
+    } else
+      dout(10) << "   srcdn not found" << dendl;
+  } else
+    dout(10) << "  srcdir not found" << dendl;
 
-  CInode *in;
-  if (rollback.orig_src.ino)
-    in = mds->mdcache->get_inode(rollback.orig_src.ino);
-  else
-    in = mds->mdcache->get_inode(rollback.orig_src.remote_ino);    
-  assert(in);
-  
+  CDentry *destdn = NULL;
   CDir *destdir = mds->mdcache->get_dirfrag(rollback.orig_dest.dirfrag);
-  assert(destdir);
-  dout(10) << " destdir " << *destdir << dendl;
-  CDentry *destdn = destdir->lookup(rollback.orig_dest.dname);
-  assert(destdn);
-  CDentry::linkage_t *destdnl = destdn->get_linkage();
-  dout(10) << "  destdn " << *destdn << dendl;
+  if (destdir) {
+    dout(10) << " destdir " << *destdir << dendl;
+    destdn = destdir->lookup(rollback.orig_dest.dname);
+    if (destdn)
+      dout(10) << "  destdn " << *destdn << dendl;
+    else
+      dout(10) << "  destdn not found" << dendl;
+  } else
+    dout(10) << " destdir not found" << dendl;
 
-  CDir *straydir = 0;
-  CDentry *straydn = 0;
-  CDentry::linkage_t *straydnl = 0;
+  CInode *in = NULL;
+  if (rollback.orig_src.ino) {
+    in = mds->mdcache->get_inode(rollback.orig_src.ino);
+    if (in && in->is_dir())
+      assert(srcdn && destdn);
+  } else
+    in = mds->mdcache->get_inode(rollback.orig_src.remote_ino);
+
+  CDir *straydir = NULL;
+  CDentry *straydn = NULL;
   if (rollback.stray.dirfrag.ino) {
     straydir = mds->mdcache->get_dirfrag(rollback.stray.dirfrag);
-    assert(straydir);
-    dout(10) << "straydir " << *straydir << dendl;
-    straydn = straydir->lookup(rollback.stray.dname);
-    assert(straydn);
-    straydnl = straydn->get_linkage();
-    assert(straydnl->is_primary());
-    dout(10) << " straydn " << *straydn << dendl;
+    if (straydir) {
+      dout(10) << "straydir " << *straydir << dendl;
+      straydn = straydir->lookup(rollback.stray.dname);
+      if (straydn) {
+	dout(10) << " straydn " << *straydn << dendl;
+	assert(straydn->get_linkage()->is_primary());
+      } else
+	dout(10) << " straydn not found" << dendl;
+    } else
+      dout(10) << "straydir not found" << dendl;
   }
-  
-  // unlink
-  destdir->unlink_inode(destdn);
-  if (straydn)
-    straydir->unlink_inode(straydn);
 
-  bool linkmerge = ((rollback.orig_src.ino && 
-		     rollback.orig_src.ino == rollback.orig_dest.remote_ino) ||
-		    (rollback.orig_dest.ino && 
-		     rollback.orig_dest.ino == rollback.orig_src.remote_ino));
+  CInode *target = NULL;
+  if (rollback.orig_dest.ino) {
+    target = mds->mdcache->get_inode(rollback.orig_dest.ino);
+    if (target)
+      assert(destdn && straydn);
+  } else if (rollback.orig_dest.remote_ino)
+    target = mds->mdcache->get_inode(rollback.orig_dest.remote_ino);
+
+  // can't use is_auth() in the resolve stage
+  int whoami = mds->get_nodeid();
+  // slave
+  assert(!destdn || destdn->authority().first != whoami);
+  assert(!straydn || straydn->authority().first != whoami);
+
+  bool force_journal_src = false;
+  bool force_journal_dest = false;
+  if (in && in->is_dir() && srcdn->authority().first != whoami)
+    force_journal_src = _need_force_journal(in, false);
+  if (target && target->is_dir())
+    force_journal_dest = _need_force_journal(in, true);
   
+  version_t srcdnpv = 0;
   // repair src
-  if (rollback.orig_src.ino)
-    srcdir->link_primary_inode(srcdn, in);
-  else
-    srcdir->link_remote_inode(srcdn, rollback.orig_src.remote_ino, 
-			      rollback.orig_src.remote_d_type);
-  inode_t *pi;
-  if (in->is_auth()) {
-    pi = in->project_inode();
-    mut->add_projected_inode(in);
-    pi->version = in->pre_dirty();
-  } else
-    pi = in->get_projected_inode();
-  if (pi->ctime == rollback.ctime)
-    pi->ctime = rollback.orig_src.old_ctime;
+  if (srcdn) {
+    if (srcdn->authority().first == whoami)
+      srcdnpv = srcdn->pre_dirty();
+    if (rollback.orig_src.ino) {
+      assert(in);
+      srcdn->push_projected_linkage(in);
+    } else
+      srcdn->push_projected_linkage(rollback.orig_src.remote_ino,
+				    rollback.orig_src.remote_d_type);
+  }
 
-  _rollback_repair_dir(mut, srcdir, rollback.orig_src, rollback.ctime,
-		       in->is_dir(), 1, srcdnl->is_primary(), pi->dirstat, pi->rstat);
+  inode_t *pi = 0;
+  if (in) {
+    if (in->authority().first == whoami) {
+      pi = in->project_inode();
+      mut->add_projected_inode(in);
+      pi->version = in->pre_dirty();
+    } else
+      pi = in->get_projected_inode();
+    if (pi->ctime == rollback.ctime)
+      pi->ctime = rollback.orig_src.old_ctime;
+  }
+
+  if (srcdn && srcdn->authority().first == whoami) {
+    nest_info_t blah;
+    _rollback_repair_dir(mut, srcdir, rollback.orig_src, rollback.ctime,
+			 in ? in->is_dir() : false, 1, pi ? pi->rstat : blah);
+  }
 
   // repair dest
-  CInode *target = 0;
-  if (rollback.orig_dest.ino) {
-    target = mds->mdcache->get_inode(rollback.orig_dest.ino);
-    destdir->link_primary_inode(destdn, target);
-    assert(linkmerge || straydn);
-  } else if (rollback.orig_dest.remote_ino) {
-    target = mds->mdcache->get_inode(rollback.orig_dest.remote_ino);
-    destdir->link_remote_inode(destdn, rollback.orig_dest.remote_ino, 
-			       rollback.orig_dest.remote_d_type);
+  if (destdn) {
+    if (rollback.orig_dest.ino && target) {
+      destdn->push_projected_linkage(target);
+    } else if (rollback.orig_dest.remote_ino) {
+      destdn->push_projected_linkage(rollback.orig_dest.remote_ino,
+				     rollback.orig_dest.remote_d_type);
+    } else {
+      // the dentry will be trimmed soon, it's ok to have wrong linkage
+      if (rollback.orig_dest.ino)
+	assert(mds->is_resolve());
+      destdn->push_projected_linkage();
+    }
   }
-  inode_t *ti = 0;
+
+  if (straydn)
+    destdn->push_projected_linkage();
+
+  inode_t *ti = NULL;
   if (target) {
-    if (target->is_auth()) {
+    if (target->authority().first == whoami) {
       ti = target->project_inode();
       mut->add_projected_inode(target);
       ti->version = target->pre_dirty();
@@ -6579,63 +6620,100 @@ void Server::do_rename_rollback(bufferlist &rbl, int master, MDRequest *mdr)
       ti->ctime = rollback.orig_dest.old_ctime;
     ti->nlink++;
   }
-  if (target)
-    _rollback_repair_dir(mut, destdir, rollback.orig_dest, rollback.ctime,
-			 target->is_dir(), 0, destdnl->is_primary(), ti->dirstat, ti->rstat);
-  else {
-    frag_info_t blah;
-    nest_info_t blah2;
-    _rollback_repair_dir(mut, destdir, rollback.orig_dest, rollback.ctime, 0, -1, 0, blah, blah2);
-  }
-
-  // repair stray
-  if (straydir)
-    _rollback_repair_dir(mut, straydir, rollback.stray, rollback.ctime,
-			 target->is_dir(), -1, true, ti->dirstat, ti->rstat);
 
-  dout(0) << "  srcdn back to " << *srcdn << dendl;
-  dout(0) << "   srci back to " << *srcdnl->get_inode() << dendl;
-  dout(0) << " destdn back to " << *destdn << dendl;
-  if (destdnl->get_inode()) dout(0) << "  desti back to " << *destdnl->get_inode() << dendl;
+  if (srcdn)
+    dout(0) << " srcdn back to " << *srcdn << dendl;
+  if (in)
+    dout(0) << "  srci back to " << *in << dendl;
+  if (destdn)
+    dout(0) << " destdn back to " << *destdn << dendl;
+  if (target)
+    dout(0) << "  desti back to " << *target << dendl;
   
   // journal it
   ESlaveUpdate *le = new ESlaveUpdate(mdlog, "slave_rename_rollback", rollback.reqid, master,
 				      ESlaveUpdate::OP_ROLLBACK, ESlaveUpdate::RENAME);
   mdlog->start_entry(le);
 
-  le->commit.add_dir_context(srcdir);
-  le->commit.add_primary_dentry(srcdn, true, 0);
-  le->commit.add_dir_context(destdir);
-  if (destdnl->is_null())
-    le->commit.add_null_dentry(destdn, true);
-  else if (destdnl->is_primary())
-    le->commit.add_primary_dentry(destdn, true, 0);
-  else if (destdnl->is_remote())
-    le->commit.add_remote_dentry(destdn, true);
-  if (straydn) {
-    le->commit.add_dir_context(straydir);
-    le->commit.add_null_dentry(straydn, true);
+  if (srcdn && (srcdn->authority().first == whoami || force_journal_src)) {
+    le->commit.add_dir_context(srcdir);
+    if (rollback.orig_src.ino)
+      le->commit.add_primary_dentry(srcdn, true);
+    else
+      le->commit.add_remote_dentry(srcdn, true);
   }
 
-  if (in->is_dir()) {
+  if (force_journal_dest) {
+    assert(rollback.orig_dest.ino);
+    le->commit.add_dir_context(destdir);
+    le->commit.add_primary_dentry(destdn, true);
+  }
+
+  // slave: no need to journal straydn
+
+  if (target && target->authority().first == whoami) {
+    assert(rollback.orig_dest.remote_ino);
+    le->commit.add_dir_context(target->get_projected_parent_dir());
+    le->commit.add_primary_dentry(target->get_projected_parent_dn(), true, target);
+  }
+
+  if (force_journal_dest) {
+    dout(10) << " noting rename target ino " << target->ino() << " in metablob" << dendl;
+    le->commit.renamed_dirino = target->ino();
+  } else if (force_journal_src || (in && in->is_dir() && srcdn->authority().first == whoami)) {
     dout(10) << " noting renamed dir ino " << in->ino() << " in metablob" << dendl;
     le->commit.renamed_dirino = in->ino();
-    mdcache->project_subtree_rename(in, destdir, srcdir);
   }
   
+  if (target && target->is_dir()) {
+    assert(destdn);
+    mdcache->project_subtree_rename(in, straydir, destdir);
+  }
+
+  if (in && in->is_dir()) {
+    assert(srcdn);
+    mdcache->project_subtree_rename(in, destdir, srcdir);
+  }
+
   mdlog->submit_entry(le, new C_MDS_LoggedRenameRollback(this, mut, mdr,
-							 srcdnl->get_inode(), destdir));
+							 srcdn, srcdnpv, destdn, straydn));
   mdlog->flush();
 }
 
-void Server::_rename_rollback_finish(Mutation *mut, MDRequest *mdr, CInode *in, CDir *olddir)
+void Server::_rename_rollback_finish(Mutation *mut, MDRequest *mdr, CDentry *srcdn,
+				     version_t srcdnpv, CDentry *destdn, CDentry *straydn)
 {
-  dout(10) << "_rename_rollback_finish" << dendl;
+  dout(10) << "_rename_rollback_finish" << mut->reqid << dendl;
+
+  if (straydn) {
+    straydn->get_dir()->unlink_inode(straydn);
+    straydn->pop_projected_linkage();
+  }
+  if (destdn) {
+    destdn->get_dir()->unlink_inode(destdn);
+    destdn->pop_projected_linkage();
+  }
+  if (srcdn) {
+    srcdn->pop_projected_linkage();
+    if (srcdn->authority().first == mds->get_nodeid())
+      srcdn->mark_dirty(srcdnpv, mut->ls);
+  }
+
   mut->apply();
 
-  // update subtree map?
-  if (in->is_dir())
-    mdcache->adjust_subtree_after_rename(in, olddir, true);
+  if (srcdn) {
+    CInode *in = srcdn->get_linkage()->get_inode();
+    // update subtree map?
+    if (in && in->is_dir())
+      mdcache->adjust_subtree_after_rename(in, destdn->get_dir(), true);
+  }
+
+  if (destdn) {
+    CInode *oldin = destdn->get_linkage()->get_inode();
+    // update subtree map?
+    if (oldin && oldin->is_dir())
+      mdcache->adjust_subtree_after_rename(oldin, straydn->get_dir(), true);
+  }
 
   if (mdr)
     mds->mdcache->request_finish(mdr);
diff --git a/src/mds/Server.h b/src/mds/Server.h
index e028912..85ab340 100644
--- a/src/mds/Server.h
+++ b/src/mds/Server.h
@@ -232,7 +232,8 @@ public:
   void _logged_slave_rename(MDRequest *mdr, CDentry *srcdn, CDentry *destdn, CDentry *straydn);
   void _commit_slave_rename(MDRequest *mdr, int r, CDentry *srcdn, CDentry *destdn, CDentry *straydn);
   void do_rename_rollback(bufferlist &rbl, int master, MDRequest *mdr);
-  void _rename_rollback_finish(Mutation *mut, MDRequest *mdr, CInode *in, CDir *olddir);
+  void _rename_rollback_finish(Mutation *mut, MDRequest *mdr, CDentry *srcdn,
+			       version_t srcdnpv, CDentry *destdn, CDentry *staydn);
 
 };
 
-- 
1.7.11.7

