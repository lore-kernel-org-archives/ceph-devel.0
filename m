From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 12/14] mds: fix file existing check in Server::handle_client_openc()
Date: Tue, 11 Dec 2012 16:30:58 +0800
Message-ID: <1355214660-26354-13-git-send-email-zheng.z.yan@intel.com>
References: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16602 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173Ab2LKIbQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 03:31:16 -0500
In-Reply-To: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Creating new file needs to be handled by directory fragment's auth
MDS, opening existing file in write mode needs to be handled by
corresponding inode's auth MDS. If a file is remote link, its parent
directory fragment's auth MDS can be different from corresponding
inode's auth MDS. So which MDS to handle create file request can be
affected by if the corresponding file already exists.

handle_client_openc() calls rdlock_path_xlock_dentry() at the very
beginning. It always assumes the request needs to be handled by
directory fragment's auth MDS. When handling a create file request,
if the file already exists and remotely linked to a non-auth inode,
handle_client_openc() falls back to handle_client_open(),
handle_client_open() forwards the request because the MDS is not
inode's auth MDS. Then when the request arrives at inode's auth MDS,
rdlock_path_xlock_dentry() is called, it will forward the request
back.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc |  9 +++++++--
 src/mds/Server.cc  | 33 ++++++++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index fe100f9..43a3954 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -6717,13 +6717,18 @@ int MDCache::path_traverse(MDRequest *mdr, Message *req, Context *fin,     // wh
     
     // can we conclude ENOENT?
     if (dnl && dnl->is_null()) {
-      if (mds->locker->rdlock_try(&dn->lock, client, NULL)) {
+      if (dn->lock.can_read(client) ||
+	  (dn->lock.is_xlocked() && dn->lock.get_xlock_by() == mdr)) {
         dout(10) << "traverse: miss on null+readable dentry " << path[depth] << " " << *dn << dendl;
         return -ENOENT;
-      } else {
+      } else if (curdir->is_auth()) {
         dout(10) << "miss on dentry " << *dn << ", can't read due to lock" << dendl;
         dn->lock.add_waiter(SimpleLock::WAIT_RD, _get_waiter(mdr, req, fin));
         return 1;
+      } else {
+	// non-auth and can not read, treat this as no dentry
+	dn = NULL;
+	dnl = NULL;
       }
     }
 
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index c95344e..60d3793 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -2589,6 +2589,29 @@ void Server::handle_client_openc(MDRequest *mdr)
     return;
   }
 
+  if (!(req->head.args.open.flags & O_EXCL)) {
+    int r = mdcache->path_traverse(mdr, NULL, NULL, req->get_filepath(),
+				   &mdr->dn[0], NULL, MDS_TRAVERSE_FORWARD);
+    if (r > 0) return;
+    if (r == 0) {
+      // it existed.
+      handle_client_open(mdr);
+      return;
+    }
+    if (r < 0 && r != -ENOENT) {
+      if (r == -ESTALE) {
+	dout(10) << "FAIL on ESTALE but attempting recovery" << dendl;
+	Context *c = new C_MDS_TryFindInode(this, mdr);
+	mdcache->find_ino_peers(req->get_filepath().get_ino(), c);
+      } else {
+	dout(10) << "FAIL on error " << r << dendl;
+	reply_request(mdr, r);
+      }
+      return;
+    }
+    // r == -ENOENT
+  }
+
   bool excl = (req->head.args.open.flags & O_EXCL);
   set<SimpleLock*> rdlocks, wrlocks, xlocks;
   ceph_file_layout *dir_layout = NULL;
@@ -2630,13 +2653,9 @@ void Server::handle_client_openc(MDRequest *mdr)
 
   if (!dnl->is_null()) {
     // it existed.  
-    if (req->head.args.open.flags & O_EXCL) {
-      dout(10) << "O_EXCL, target exists, failing with -EEXIST" << dendl;
-      reply_request(mdr, -EEXIST, dnl->get_inode(), dn);
-      return;
-    } 
-    
-    handle_client_open(mdr);
+    assert(req->head.args.open.flags & O_EXCL);
+    dout(10) << "O_EXCL, target exists, failing with -EEXIST" << dendl;
+    reply_request(mdr, -EEXIST, dnl->get_inode(), dn);
     return;
   }
 
-- 
1.7.11.7

