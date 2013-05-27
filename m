From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] mds: use "open-by-ino" function to open remote link
Date: Mon, 27 May 2013 09:55:10 +0800
Message-ID: <1369619710-3448-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56671 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755718Ab3E0BzO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 26 May 2013 21:55:14 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Also add a new config option "mds_open_remote_link_mode". The anchor
approach is used by default. If mode is non-zero, use the open-by-ino
function. In case open-by-ino function fails, if mode is 1, retry
using the anchor approach, otherwise trigger assertion.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/common/config_opts.h |  1 +
 src/mds/MDCache.cc       | 51 +++++++++++++++++++++++++++++++-----------------
 src/mds/MDCache.h        |  7 +++++--
 3 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/src/common/config_opts.h b/src/common/config_opts.h
index 776ac1c..a4755ea 100644
--- a/src/common/config_opts.h
+++ b/src/common/config_opts.h
@@ -338,6 +338,7 @@ OPTION(mds_kill_openc_at, OPT_INT, 0)
 OPTION(mds_kill_journal_at, OPT_INT, 0)
 OPTION(mds_kill_journal_expire_at, OPT_INT, 0)
 OPTION(mds_kill_journal_replay_at, OPT_INT, 0)
+OPTION(mds_open_remote_link_mode, OPT_INT, 0)
 OPTION(mds_inject_traceless_reply_probability, OPT_DOUBLE, 0) /* percentage
 				of MDS modify replies to skip sending the
 				client a trace on [0-1]*/
diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index db322d2..8c96608 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -7342,8 +7342,8 @@ int MDCache::path_traverse(MDRequest *mdr, Message *req, Context *fin,     // wh
 	} else {
           dout(7) << "remote link to " << dnl->get_remote_ino() << ", which i don't have" << dendl;
 	  assert(mdr);  // we shouldn't hit non-primary dentries doing a non-mdr traversal!
-          open_remote_ino(dnl->get_remote_ino(), _get_waiter(mdr, req, fin),
-			  (null_okay && depth == path.depth() - 1));
+          open_remote_dentry(dn, true, _get_waiter(mdr, req, fin),
+			     (null_okay && depth == path.depth() - 1));
 	  if (mds->logger) mds->logger->inc(l_mds_trino);
           return 1;
         }        
@@ -7790,36 +7790,51 @@ void MDCache::open_remote_ino_2(inodeno_t ino, vector<Anchor>& anchortrace, bool
 struct C_MDC_OpenRemoteDentry : public Context {
   MDCache *mdc;
   CDentry *dn;
-  bool projected;
+  inodeno_t ino;
   Context *onfinish;
-  C_MDC_OpenRemoteDentry(MDCache *m, CDentry *d, bool p, Context *f) :
-    mdc(m), dn(d), projected(p), onfinish(f) {}
+  bool want_xlocked;
+  int mode;
+  C_MDC_OpenRemoteDentry(MDCache *m, CDentry *d, inodeno_t i, Context *f,
+			 bool wx, int md) :
+    mdc(m), dn(d), ino(i), onfinish(f), want_xlocked(wx), mode(md) {}
   void finish(int r) {
-    mdc->_open_remote_dentry_finish(r, dn, projected, onfinish);
+    mdc->_open_remote_dentry_finish(dn, ino, onfinish, want_xlocked, mode, r);
   }
 };
 
-void MDCache::open_remote_dentry(CDentry *dn, bool projected, Context *fin)
+void MDCache::open_remote_dentry(CDentry *dn, bool projected, Context *fin, bool want_xlocked)
 {
   dout(10) << "open_remote_dentry " << *dn << dendl;
   CDentry::linkage_t *dnl = projected ? dn->get_projected_linkage() : dn->get_linkage();
-  open_remote_ino(dnl->get_remote_ino(), 
-		  new C_MDC_OpenRemoteDentry(this, dn, projected, fin));
+  inodeno_t ino = dnl->get_remote_ino();
+  int mode = g_conf->mds_open_remote_link_mode;
+  Context *fin2 =  new C_MDC_OpenRemoteDentry(this, dn, ino, fin, want_xlocked, mode);
+  if (mode == 0)
+    open_remote_ino(ino, fin2, want_xlocked); // anchor
+  else
+    open_ino(ino, -1, fin2, true, want_xlocked); // backtrace
 }
 
-void MDCache::_open_remote_dentry_finish(int r, CDentry *dn, bool projected, Context *fin)
+void MDCache::_open_remote_dentry_finish(CDentry *dn, inodeno_t ino, Context *fin,
+					 bool want_xlocked, int mode, int r)
 {
-  if (r == -ENOENT) {
-    dout(0) << "open_remote_dentry_finish bad remote dentry " << *dn << dendl;
-    dn->state_set(CDentry::STATE_BADREMOTEINO);
-  } else if (r != 0)
-    assert(0);
-  fin->finish(r);
-  delete fin;
+  if (r < 0) {
+    if (mode == 0) {
+      dout(0) << "open_remote_dentry_finish bad remote dentry " << *dn << dendl;
+      dn->state_set(CDentry::STATE_BADREMOTEINO);
+    } else {
+      dout(7) << "open_remote_dentry_finish failed to open ino " << ino
+	      << " for " << *dn << ", retry using anchortable" << dendl;
+      assert(mode == 1);
+      Context *fin2 =  new C_MDC_OpenRemoteDentry(this, dn, ino, fin, want_xlocked, 0);
+      open_remote_ino(ino, fin2, want_xlocked);
+      return;
+    }
+  }
+  fin->complete(r < 0 ? r : 0);
 }
 
 
-
 void MDCache::make_trace(vector<CDentry*>& trace, CInode *in)
 {
   // empty trace if we're a base inode
diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
index 5870749..3da8a36 100644
--- a/src/mds/MDCache.h
+++ b/src/mds/MDCache.h
@@ -754,14 +754,17 @@ public:
   void open_remote_ino_2(inodeno_t ino,
 			 vector<Anchor>& anchortrace, bool want_xlocked,
 			 inodeno_t hadino, version_t hadv, Context *onfinish);
-  void open_remote_dentry(CDentry *dn, bool projected, Context *fin);
-  void _open_remote_dentry_finish(int r, CDentry *dn, bool projected, Context *fin);
 
   bool parallel_fetch(map<inodeno_t,filepath>& pathmap, set<inodeno_t>& missing);
   bool parallel_fetch_traverse_dir(inodeno_t ino, filepath& path, 
 				   set<CDir*>& fetch_queue, set<inodeno_t>& missing,
 				   C_GatherBuilder &gather_bld);
 
+  void open_remote_dentry(CDentry *dn, bool projected, Context *fin,
+			  bool want_xlocked=false);
+  void _open_remote_dentry_finish(CDentry *dn, inodeno_t ino, Context *fin,
+				  bool want_xlocked, int mode, int r);
+
   void make_trace(vector<CDentry*>& trace, CInode *in);
 
 protected:
-- 
1.8.1.4

