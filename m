From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 20/30] mds: slient MDCache::trim_non_auth()
Date: Thu, 23 May 2013 16:06:48 +0800
Message-ID: <1369296418-14871-21-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51287 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756966Ab3EWINO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:14 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

No need to output the function's debug message to console.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 5c2732b..a67f605 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -6130,7 +6130,6 @@ void MDCache::trim_inode(CDentry *dn, CInode *in, CDir *con, map<int, MCacheExpi
 void MDCache::trim_non_auth()
 {
   dout(7) << "trim_non_auth" << dendl;
-  stringstream warn_str_dirs;
   
   // temporarily pin all subtree roots
   for (map<CDir*, set<CDir*> >::iterator p = subtrees.begin();
@@ -6164,22 +6163,18 @@ void MDCache::trim_non_auth()
       assert(dir);
 
       // unlink the dentry
-      dout(15) << "trim_non_auth removing " << *dn << dendl;
+      dout(10) << " removing " << *dn << dendl;
       if (dnl->is_remote()) {
 	dir->unlink_inode(dn);
       } 
       else if (dnl->is_primary()) {
 	CInode *in = dnl->get_inode();
+	dout(10) << " removing " << *in << dendl;
 	list<CDir*> ls;
-        warn_str_dirs << in->get_parent_dn()->get_name() << "\n";
 	in->get_dirfrags(ls);
 	for (list<CDir*>::iterator p = ls.begin(); p != ls.end(); ++p) {
 	  CDir *subdir = *p;
-	  filepath fp;
-	  subdir->get_inode()->make_path(fp);
-	  warn_str_dirs << fp << "\n";
-	  if (subdir->is_subtree_root()) 
-	    remove_subtree(subdir);
+	  assert(!subdir->is_subtree_root());
 	  in->close_dirfrag(subdir->dirfrag().frag);
 	}
 	dir->unlink_inode(dn);
@@ -6218,18 +6213,13 @@ void MDCache::trim_non_auth()
 	for (list<CDir*>::iterator p = ls.begin();
 	     p != ls.end();
 	     ++p) {
-	  dout(0) << " ... " << **p << dendl;
-	  CInode *diri = (*p)->get_inode();
-	  filepath fp;
-	  diri->make_path(fp);
-	  warn_str_dirs << fp << "\n";
+	  dout(10) << " removing " << **p << dendl;
 	  assert((*p)->get_num_ref() == 1);  // SUBTREE
 	  remove_subtree((*p));
 	  in->close_dirfrag((*p)->dirfrag().frag);
 	}
-	dout(0) << " ... " << *in << dendl;
-	if (in->get_parent_dn())
-	  warn_str_dirs << in->get_parent_dn()->get_name() << "\n";
+	dout(10) << " removing " << *in << dendl;
+	assert(!in->get_parent_dn());
 	assert(in->get_num_ref() == 0);
 	remove_inode(in);
       }
@@ -6238,10 +6228,6 @@ void MDCache::trim_non_auth()
   }
 
   show_subtrees();
-  if (warn_str_dirs.peek() != EOF) {
-    mds->clog.info() << "trim_non_auth has deleted paths: " << "\n";
-    mds->clog.info(warn_str_dirs);
-  }
 }
 
 /**
-- 
1.8.1.4

