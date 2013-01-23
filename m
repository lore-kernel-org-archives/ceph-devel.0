From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 22/25] mds: properly clear CDir::STATE_COMPLETE when replaying EImportStart
Date: Wed, 23 Jan 2013 11:08:58 +0800
Message-ID: <1358910541-15535-23-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1721 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069Ab3AWDJY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:24 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

when replaying EImportStart, we should set/clear directory's COMPLETE
flag according with the flag in the journal entry.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc         |  5 +++--
 src/mds/Migrator.cc        |  4 +---
 src/mds/Server.cc          |  2 +-
 src/mds/events/EMetaBlob.h | 20 +++++++++++++++++---
 src/mds/journal.cc         |  2 ++
 5 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index f258451..14d1fcb 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -466,7 +466,7 @@ void MDCache::_create_system_file(CDir *dir, const char *name, CInode *in, Conte
     le->metablob.add_root(true, in);
   }
   if (mdir)
-    le->metablob.add_dir(mdir, true, true, true); // dirty AND complete AND new
+    le->metablob.add_new_dir(mdir); // dirty AND complete AND new
 
   mds->mdlog->submit_entry(le);
   mds->mdlog->wait_for_safe(new C_MDC_CreateSystemFile(this, mut, dn, dpv, fin));
@@ -3280,6 +3280,7 @@ void MDCache::recalc_auth_bits()
       else {
 	dir->state_set(CDir::STATE_REJOINING);
 	dir->state_clear(CDir::STATE_AUTH);
+	dir->state_clear(CDir::STATE_COMPLETE);
 	if (dir->is_dirty()) 
 	  dir->mark_clean();
       }
@@ -8385,7 +8386,7 @@ void MDCache::_purge_stray_purged(CDentry *dn, int r)
     pf->rstat.sub(in->inode.accounted_rstat);
 
     le->metablob.add_dir_context(dn->dir);
-    EMetaBlob::dirlump& dl = le->metablob.add_dir(dn->dir, true, false, false);
+    EMetaBlob::dirlump& dl = le->metablob.add_dir(dn->dir, true);
     le->metablob.add_null_dentry(dl, dn, true);
     le->metablob.add_destroyed_inode(in->ino());
 
diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index 453cfaf..3449306 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -2391,9 +2391,7 @@ int Migrator::decode_import_dir(bufferlist::iterator& blp,
 
   // add to journal entry
   if (le) 
-    le->metablob.add_dir(dir, 
-			 true,                 // Hmm: dirty=false would be okay in some cases
-			 dir->is_complete());  
+    le->metablob.add_import_dir(dir);
 
   int num_imported = 0;
 
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 1b3d49e..5f3119d 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -3827,7 +3827,7 @@ void Server::handle_client_mkdir(MDRequest *mdr)
   journal_allocated_inos(mdr, &le->metablob);
   mdcache->predirty_journal_parents(mdr, &le->metablob, newi, dn->get_dir(), PREDIRTY_PRIMARY|PREDIRTY_DIR, 1);
   le->metablob.add_primary_dentry(dn, true, newi);
-  le->metablob.add_dir(newdir, true, true, true); // dirty AND complete AND new
+  le->metablob.add_new_dir(newdir); // dirty AND complete AND new
   
   // issue a cap on the directory
   int cmode = CEPH_FILE_MODE_RDWR;
diff --git a/src/mds/events/EMetaBlob.h b/src/mds/events/EMetaBlob.h
index 77ceb94..bd0a8f7 100644
--- a/src/mds/events/EMetaBlob.h
+++ b/src/mds/events/EMetaBlob.h
@@ -283,6 +283,7 @@ public:
     static const int STATE_COMPLETE =    (1<<1);
     static const int STATE_DIRTY =       (1<<2);  // dirty due to THIS journal item, that is!
     static const int STATE_NEW =         (1<<3);  // new directory
+    static const int STATE_IMPORTING =	 (1<<4);  // importing directory
 
     //version_t  dirv;
     fnode_t fnode;
@@ -305,6 +306,8 @@ public:
     void mark_dirty() { state |= STATE_DIRTY; }
     bool is_new() { return state & STATE_NEW; }
     void mark_new() { state |= STATE_NEW; }
+    bool is_importing() { return state & STATE_IMPORTING; }
+    void mark_importing() { state |= STATE_IMPORTING; }
 
     list<std::tr1::shared_ptr<fullbit> >   &get_dfull()   { return dfull; }
     list<remotebit> &get_dremote() { return dremote; }
@@ -634,11 +637,21 @@ private:
 							      &in->old_inodes)));
   }
   
-  dirlump& add_dir(CDir *dir, bool dirty, bool complete=false, bool isnew=false) {
+  dirlump& add_dir(CDir *dir, bool dirty, bool complete=false) {
     return add_dir(dir->dirfrag(), dir->get_projected_fnode(), dir->get_projected_version(),
-		   dirty, complete, isnew);
+		   dirty, complete);
   }
-  dirlump& add_dir(dirfrag_t df, fnode_t *pf, version_t pv, bool dirty, bool complete=false, bool isnew=false) {
+  dirlump& add_new_dir(CDir *dir) {
+    return add_dir(dir->dirfrag(), dir->get_projected_fnode(), dir->get_projected_version(),
+		   true, true, true); // dirty AND complete AND new
+  }
+  dirlump& add_import_dir(CDir *dir) {
+    // dirty=false would be okay in some cases
+    return add_dir(dir->dirfrag(), dir->get_projected_fnode(), dir->get_projected_version(),
+		   true, dir->is_complete(), false, true);
+  }
+  dirlump& add_dir(dirfrag_t df, fnode_t *pf, version_t pv, bool dirty,
+		   bool complete=false, bool isnew=false, bool importing=false) {
     if (lump_map.count(df) == 0)
       lump_order.push_back(df);
 
@@ -648,6 +661,7 @@ private:
     if (complete) l.mark_complete();
     if (dirty) l.mark_dirty();
     if (isnew) l.mark_new();
+    if (importing) l.mark_importing();
     return l;
   }
   
diff --git a/src/mds/journal.cc b/src/mds/journal.cc
index e8b8c2f..bba3507 100644
--- a/src/mds/journal.cc
+++ b/src/mds/journal.cc
@@ -516,6 +516,8 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg, MDSlaveUpdate *slaveup)
       dir->mark_new(logseg);
     if (lump.is_complete())
       dir->mark_complete();
+    else if (lump.is_importing())
+      dir->state_clear(CDir::STATE_COMPLETE);
     
     dout(10) << "EMetaBlob.replay updated dir " << *dir << dendl;  
 
-- 
1.7.11.7

