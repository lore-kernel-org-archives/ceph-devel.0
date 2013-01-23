From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 04/25] mds: allow journaling multiple root inodes in EMetaBlob
Date: Wed, 23 Jan 2013 11:08:40 +0800
Message-ID: <1358910541-15535-5-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7278 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818Ab3AWDJI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:08 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

In some cases (rename, rmdir, subtree map), we may need journal multiple
root inodes (/, mdsdir) in one EMetaBlob. This patch modifies EMetaBlob
format to support journaling multiple root inodes.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/events/EMetaBlob.h | 45 ++++++++++++++++++++++++---------------------
 src/mds/journal.cc         | 11 +++++------
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/src/mds/events/EMetaBlob.h b/src/mds/events/EMetaBlob.h
index 116b704..9bbd615 100644
--- a/src/mds/events/EMetaBlob.h
+++ b/src/mds/events/EMetaBlob.h
@@ -366,7 +366,7 @@ private:
   // my lumps.  preserve the order we added them in a list.
   list<dirfrag_t>         lump_order;
   map<dirfrag_t, dirlump> lump_map;
-  fullbit *root;
+  list<std::tr1::shared_ptr<fullbit> > roots;
 
   list<pair<__u8,version_t> > table_tids;  // tableclient transactions
 
@@ -394,14 +394,11 @@ private:
 
  public:
   void encode(bufferlist& bl) const {
-    __u8 struct_v = 3;
+    __u8 struct_v = 4;
     ::encode(struct_v, bl);
     ::encode(lump_order, bl);
     ::encode(lump_map, bl);
-    bufferlist rootbl;
-    if (root)
-      root->encode(rootbl);
-    ::encode(rootbl, bl);
+    ::encode(roots, bl);
     ::encode(table_tids, bl);
     ::encode(opened_ino, bl);
     ::encode(allocated_ino, bl);
@@ -422,11 +419,15 @@ private:
     ::decode(struct_v, bl);
     ::decode(lump_order, bl);
     ::decode(lump_map, bl);
-    bufferlist rootbl;
-    ::decode(rootbl, bl);
-    if (rootbl.length()) {
-      bufferlist::iterator p = rootbl.begin();
-      root = new fullbit(p);
+    if (struct_v >= 4) {
+      ::decode(roots, bl);
+    } else {
+      bufferlist rootbl;
+      ::decode(rootbl, bl);
+      if (rootbl.length()) {
+	bufferlist::iterator p = rootbl.begin();
+	roots.push_back(std::tr1::shared_ptr<fullbit>(new fullbit(p)));
+      }
     }
     ::decode(table_tids, bl);
     ::decode(opened_ino, bl);
@@ -464,9 +465,7 @@ private:
   //LogSegment *_segment;
 
   EMetaBlob(MDLog *mdl = 0);  // defined in journal.cc
-  ~EMetaBlob() {
-    delete root;
-  }
+  ~EMetaBlob() { }
 
   void print(ostream& out) {
     for (list<dirfrag_t>::iterator p = lump_order.begin();
@@ -620,14 +619,18 @@ private:
     else
       in->encode_snap_blob(snapbl);
 
+    for (list<std::tr1::shared_ptr<fullbit> >::iterator p = roots.begin(); p != roots.end(); p++) {
+      if ((*p)->inode.ino == in->ino()) {
+	roots.erase(p);
+	break;
+      }
+    }
+
     string empty;
-    delete root;
-    root = new fullbit(empty,
-		       in->first, in->last,
-		       0,
-		       *pi, *pdft, *px,
-		       in->symlink, snapbl,
-		       dirty, default_layout, &in->old_inodes);
+    roots.push_back(std::tr1::shared_ptr<fullbit>(new fullbit(empty, in->first, in->last,
+							      0, *pi, *pdft, *px, in->symlink,
+							      snapbl, dirty, default_layout,
+							      &in->old_inodes)));
   }
   
   dirlump& add_dir(CDir *dir, bool dirty, bool complete=false, bool isnew=false) {
diff --git a/src/mds/journal.cc b/src/mds/journal.cc
index e73b8e7..4bd6f89 100644
--- a/src/mds/journal.cc
+++ b/src/mds/journal.cc
@@ -279,8 +279,7 @@ void EString::replay(MDS *mds)
 // -----------------------
 // EMetaBlob
 
-EMetaBlob::EMetaBlob(MDLog *mdlog) : root(NULL),
-				     opened_ino(0), renamed_dirino(0),
+EMetaBlob::EMetaBlob(MDLog *mdlog) : opened_ino(0), renamed_dirino(0),
 				     inotablev(0), sessionmapv(0),
 				     allocated_ino(0),
 				     last_subtree_map(mdlog ? mdlog->get_last_segment_offset() : 0),
@@ -422,15 +421,15 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
 
   assert(logseg);
 
-  if (root) {
-    CInode *in = mds->mdcache->get_inode(root->inode.ino);
+  for (list<std::tr1::shared_ptr<fullbit> >::iterator p = roots.begin(); p != roots.end(); p++) {
+    CInode *in = mds->mdcache->get_inode((*p)->inode.ino);
     bool isnew = in ? false:true;
     if (!in)
       in = new CInode(mds->mdcache, true);
-    root->update_inode(mds, in);
+    (*p)->update_inode(mds, in);
     if (isnew)
       mds->mdcache->add_inode(in);
-    if (root->dirty) in->_mark_dirty(logseg);
+    if ((*p)->dirty) in->_mark_dirty(logseg);
     dout(10) << "EMetaBlob.replay " << (isnew ? " added root ":" updated root ") << *in << dendl;    
   }
 
-- 
1.7.11.7

