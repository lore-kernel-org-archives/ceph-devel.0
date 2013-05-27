From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 07/30] mds: fix straydn race
Date: Mon, 27 May 2013 10:09:47 +0800
Message-ID: <51A2C06B.7000802@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com> <1369296418-14871-8-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1305230943310.32642@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6331 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755779Ab3E0CJu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 26 May 2013 22:09:50 -0400
In-Reply-To: <alpine.DEB.2.00.1305230943310.32642@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com

updated version
---
From 6cd1c8c076d7afa1c4e2bd247e34cee45b3ef562 Mon Sep 17 00:00:00 2001
From: "Yan, Zheng" <zheng.z.yan@intel.com>
Date: Fri, 5 Apr 2013 19:50:35 +0800
Subject: [PATCH 07/33] mds: fix straydn race

For unlink/rename request, the target dentry's linkage may change
before all locks are acquired. So we need check if the existing stray
dentry is valid.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Mutation.cc |  7 +++++++
 src/mds/Mutation.h  |  1 +
 src/mds/Server.cc   | 49 ++++++++++++++++++++++++++++++-------------------
 src/mds/Server.h    |  1 +
 4 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/src/mds/Mutation.cc b/src/mds/Mutation.cc
index 4e4f69c..3916b2a 100644
--- a/src/mds/Mutation.cc
+++ b/src/mds/Mutation.cc
@@ -30,6 +30,13 @@ void Mutation::pin(MDSCacheObject *o)
   }      
 }
 
+void Mutation::unpin(MDSCacheObject *o)
+{
+  assert(pins.count(o));
+  o->put(MDSCacheObject::PIN_REQUEST);
+  pins.erase(o);
+}
+
 void Mutation::set_stickydirs(CInode *in)
 {
   if (stickydirs.count(in) == 0) {
diff --git a/src/mds/Mutation.h b/src/mds/Mutation.h
index de122a5..c0bea19 100644
--- a/src/mds/Mutation.h
+++ b/src/mds/Mutation.h
@@ -113,6 +113,7 @@ struct Mutation {
 
   // pin items in cache
   void pin(MDSCacheObject *o);
+  void unpin(MDSCacheObject *o);
   void set_stickydirs(CInode *in);
   void drop_pins();
 
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 63401e8..42db7ad 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -1797,6 +1797,24 @@ CDentry* Server::prepare_null_dentry(MDRequest *mdr, CDir *dir, const string& dn
   return dn;
 }
 
+CDentry* Server::prepare_stray_dentry(MDRequest *mdr, CInode *in)
+{
+  CDentry *straydn = mdr->straydn;
+  if (straydn) {
+    string name;
+    in->name_stray_dentry(name);
+    if (straydn->get_name() == name)
+      return straydn;
+
+    assert(!mdr->done_locking);
+    mdr->unpin(straydn);
+  }
+
+  straydn = mdcache->get_or_create_stray_dentry(in);
+  mdr->straydn = straydn;
+  mdr->pin(straydn);
+  return straydn;
+}
 
 /** prepare_new_inode
  *
@@ -4899,18 +4917,14 @@ void Server::handle_client_unlink(MDRequest *mdr)
   }
 
   // -- create stray dentry? --
-  CDentry *straydn = mdr->straydn;
+  CDentry *straydn = NULL;
   if (dnl->is_primary()) {
-    if (!straydn) {
-      straydn = mdcache->get_or_create_stray_dentry(dnl->get_inode());
-      mdr->pin(straydn);
-      mdr->straydn = straydn;
-    }
-  } else if (straydn)
-    straydn = NULL;
-  if (straydn)
+    straydn = prepare_stray_dentry(mdr, dnl->get_inode());
     dout(10) << " straydn is " << *straydn << dendl;
-
+  } else if (mdr->straydn) {
+    mdr->unpin(mdr->straydn);
+    mdr->straydn = NULL;
+  }
 
   // lock
   set<SimpleLock*> rdlocks, wrlocks, xlocks;
@@ -5650,17 +5664,14 @@ void Server::handle_client_rename(MDRequest *mdr)
     dout(10) << " this is a link merge" << dendl;
 
   // -- create stray dentry? --
-  CDentry *straydn = mdr->straydn;
+  CDentry *straydn = NULL;
   if (destdnl->is_primary() && !linkmerge) {
-    if (!straydn) {
-      straydn = mdcache->get_or_create_stray_dentry(destdnl->get_inode());
-      mdr->pin(straydn);
-      mdr->straydn = straydn;
-    }
-  } else if (straydn)
-    straydn = NULL;
-  if (straydn)
+    straydn = prepare_stray_dentry(mdr, destdnl->get_inode());
     dout(10) << " straydn is " << *straydn << dendl;
+  } else if (mdr->straydn) {
+    mdr->unpin(mdr->straydn);
+    mdr->straydn = NULL;
+  }
 
   // -- prepare witness list --
   /*
diff --git a/src/mds/Server.h b/src/mds/Server.h
index 15c8077..ffe9256 100644
--- a/src/mds/Server.h
+++ b/src/mds/Server.h
@@ -120,6 +120,7 @@ public:
   CDir *validate_dentry_dir(MDRequest *mdr, CInode *diri, const string& dname);
   CDir *traverse_to_auth_dir(MDRequest *mdr, vector<CDentry*> &trace, filepath refpath);
   CDentry *prepare_null_dentry(MDRequest *mdr, CDir *dir, const string& dname, bool okexist=false);
+  CDentry *prepare_stray_dentry(MDRequest *mdr, CInode *in);
   CInode* prepare_new_inode(MDRequest *mdr, CDir *dir, inodeno_t useino, unsigned mode,
 			    ceph_file_layout *layout=NULL);
   void journal_allocated_inos(MDRequest *mdr, EMetaBlob *blob);
-- 
1.8.1.4

