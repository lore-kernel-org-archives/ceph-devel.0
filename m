From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 08/25] mds: fix "had dentry linked to wrong inode" warning
Date: Wed, 23 Jan 2013 11:08:44 +0800
Message-ID: <1358910541-15535-9-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12218 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752980Ab3AWDJM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:12 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The reason of "had dentry linked to wrong inode" warning is that
Server::_rename_prepare() adds the destdir to the EMetaBlob before
adding the straydir. So during MDS recovers, the destdir is first
replayed. The old inode is directly replaced by the source inode.
We can void the warning by adding the straydir first.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc  |  7 +++++++
 src/mds/journal.cc | 30 +++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 4492341..157f6ac 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5804,6 +5804,13 @@ void Server::_rename_prepare(MDRequest *mdr,
   // prepare nesting, mtime updates
   int predirty_dir = silent ? 0:PREDIRTY_DIR;
   
+  // guarantee stray dir is processed first during journal replay. unlink the old inode,
+  // then link the source inode to destdn
+  if (destdnl->is_primary() && straydn->is_auth()) {
+    metablob->add_dir_context(straydn->get_dir());
+    metablob->add_dir(straydn->get_dir(), true);
+  }
+
   // sub off target
   if (destdn->is_auth() && !destdnl->is_null()) {
     mdcache->predirty_journal_parents(mdr, metablob, oldin, destdn->get_dir(),
diff --git a/src/mds/journal.cc b/src/mds/journal.cc
index 4bd6f89..ae380f3 100644
--- a/src/mds/journal.cc
+++ b/src/mds/journal.cc
@@ -545,18 +545,14 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
 	mds->mdcache->add_inode(in);
 	if (!dn->get_linkage()->is_null()) {
 	  if (dn->get_linkage()->is_primary()) {
-	    CInode *old_in = dn->get_linkage()->get_inode();
+	    unlinked.insert(dn->get_linkage()->get_inode());
 	    stringstream ss;
 	    ss << "EMetaBlob.replay FIXME had dentry linked to wrong inode " << *dn
-	        << " " << *old_in
-	        << " should be " << p->inode.ino;
+	       << " " << *dn->get_linkage()->get_inode() << " should be " << p->inode.ino;
 	    dout(0) << ss.str() << dendl;
 	    mds->clog.warn(ss);
-	    dir->unlink_inode(dn);
-	    mds->mdcache->remove_inode_recursive(old_in);
-
-	    //assert(0); // hrm!  fallout from sloppy unlink?  or?  hmmm FIXME investigate further
 	  }
+	  dir->unlink_inode(dn);
 	}
 	unlinked.erase(in);
 	dir->link_primary_inode(dn, in);
@@ -574,8 +570,17 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
 	p->update_inode(mds, in);
 	if (p->dirty) in->_mark_dirty(logseg);
 	if (dn->get_linkage()->get_inode() != in) {
-	  if (!dn->get_linkage()->is_null())  // note: might be remote.  as with stray reintegration.
+	  if (!dn->get_linkage()->is_null()) { // note: might be remote.  as with stray reintegration.
+	    if (dn->get_linkage()->is_primary()) {
+	      unlinked.insert(dn->get_linkage()->get_inode());
+	      stringstream ss;
+	      ss << "EMetaBlob.replay FIXME had dentry linked to wrong inode " << *dn
+		 << " " << *dn->get_linkage()->get_inode() << " should be " << p->inode.ino;
+	      dout(0) << ss.str() << dendl;
+	      mds->clog.warn(ss);
+	    }
 	    dir->unlink_inode(dn);
+	  }
 	  unlinked.erase(in);
 	  dir->link_primary_inode(dn, in);
 	  dout(10) << "EMetaBlob.replay linked " << *in << dendl;
@@ -600,10 +605,13 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
       } else {
 	if (!dn->get_linkage()->is_null()) {
 	  dout(10) << "EMetaBlob.replay unlinking " << *dn << dendl;
-	  if (dn->get_linkage()->is_primary())
+	  if (dn->get_linkage()->is_primary()) {
 	    unlinked.insert(dn->get_linkage()->get_inode());
-	  if (dn->get_linkage()->get_inode() == renamed_diri)
-	    olddir = dir;
+	    stringstream ss;
+	    ss << "EMetaBlob.replay FIXME had dentry linked to wrong inode " << *dn
+	       << " " << *dn->get_linkage()->get_inode() << " should be remote " << p->ino;
+	    dout(0) << ss.str() << dendl;
+	  }
 	  dir->unlink_inode(dn);
 	}
 	dir->link_remote_inode(dn, p->ino, p->d_type);
-- 
1.7.11.7

