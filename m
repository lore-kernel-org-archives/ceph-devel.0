From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 15/16] mds: allow open_remote_ino() to open xlocked dentry
Date: Mon, 19 Nov 2012 10:43:47 +0800
Message-ID: <1353293028-15238-16-git-send-email-zheng.z.yan@intel.com>
References: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65084 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989Ab2KSCoH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:44:07 -0500
In-Reply-To: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

discover_ino() has a parameter want_xlocked. The parameter indicates
if remote discover handler can proceed when xlocked dentry is
encountered. open_remote_ino() uses discover_ino() to find non-auth
inode, but always set 'want_xlocked' to false. This may cause
dead lock in some corner cases. For example:

we rename a inode's primary dentry to one of its remote dentry and
send slave request to one witness MDS. but before the slave request
reaches the witness MDS, the inode is trimmed from the witness MDS'
cache. Then when the slave request arrives, open_remote_ino() will
be called during traversing the destpath. open_remote_ino() calls
discover_ino() with 'want_xlocled=false' to find the inode.
discover_ino() sends MDiscover message to the inode's authority MDS.
The handler of MDiscover message finds the inode's primary dentry
is xlocked and it sleeps.

The fix is add a parameter 'want_xlocked' to open_remote_ino() and
make open_remote_ino() pass the parameter to discover_ino().

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 51 ++++++++++++++++++++++++++++-----------------------
 src/mds/MDCache.h  |  8 ++++----
 src/mds/Server.cc  |  7 +++++++
 3 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 5dcb3e3..9cddfeb 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -6731,7 +6731,8 @@ int MDCache::path_traverse(MDRequest *mdr, Message *req, Context *fin,     // wh
 	} else {
           dout(7) << "remote link to " << dnl->get_remote_ino() << ", which i don't have" << dendl;
 	  assert(mdr);  // we shouldn't hit non-primary dentries doing a non-mdr traversal!
-          open_remote_ino(dnl->get_remote_ino(), _get_waiter(mdr, req, fin));
+          open_remote_ino(dnl->get_remote_ino(), _get_waiter(mdr, req, fin),
+			  (null_okay && depth == path.depth() - 1));
 	  if (mds->logger) mds->logger->inc(l_mds_trino);
           return 1;
         }        
@@ -7017,12 +7018,13 @@ CInode *MDCache::get_dentry_inode(CDentry *dn, MDRequest *mdr, bool projected)
 class C_MDC_RetryOpenRemoteIno : public Context {
   MDCache *mdcache;
   inodeno_t ino;
+  bool want_xlocked;
   Context *onfinish;
 public:
-  C_MDC_RetryOpenRemoteIno(MDCache *mdc, inodeno_t i, Context *c) :
-    mdcache(mdc), ino(i), onfinish(c) {}
+  C_MDC_RetryOpenRemoteIno(MDCache *mdc, inodeno_t i, Context *c, bool wx) :
+    mdcache(mdc), ino(i), want_xlocked(wx), onfinish(c) {}
   void finish(int r) {
-    mdcache->open_remote_ino(ino, onfinish);
+    mdcache->open_remote_ino(ino, onfinish, want_xlocked);
   }
 };
 
@@ -7032,19 +7034,20 @@ class C_MDC_OpenRemoteIno : public Context {
   inodeno_t ino;
   inodeno_t hadino;
   version_t hadv;
+  bool want_xlocked;
   Context *onfinish;
 public:
   vector<Anchor> anchortrace;
 
-  C_MDC_OpenRemoteIno(MDCache *mdc, inodeno_t i, inodeno_t hi, version_t hv, Context *c) :
-    mdcache(mdc), ino(i), hadino(hi), hadv(hv), onfinish(c) {}
-  C_MDC_OpenRemoteIno(MDCache *mdc, inodeno_t i, vector<Anchor>& at, Context *c) :
-    mdcache(mdc), ino(i), hadino(0), hadv(0), onfinish(c), anchortrace(at) {}
+  C_MDC_OpenRemoteIno(MDCache *mdc, inodeno_t i, bool wx, inodeno_t hi, version_t hv, Context *c) :
+    mdcache(mdc), ino(i), hadino(hi), hadv(hv), want_xlocked(wx), onfinish(c) {}
+  C_MDC_OpenRemoteIno(MDCache *mdc, inodeno_t i, bool wx, vector<Anchor>& at, Context *c) :
+    mdcache(mdc), ino(i), hadino(0), hadv(0), want_xlocked(wx), onfinish(c), anchortrace(at) {}
 
   void finish(int r) {
     assert(r == 0);
     if (r == 0)
-      mdcache->open_remote_ino_2(ino, anchortrace, hadino, hadv, onfinish);
+      mdcache->open_remote_ino_2(ino, anchortrace, want_xlocked, hadino, hadv, onfinish);
     else {
       onfinish->finish(r);
       delete onfinish;
@@ -7052,18 +7055,18 @@ public:
   }
 };
 
-void MDCache::open_remote_ino(inodeno_t ino, Context *onfinish, inodeno_t hadino, version_t hadv)
+void MDCache::open_remote_ino(inodeno_t ino, Context *onfinish, bool want_xlocked,
+			      inodeno_t hadino, version_t hadv)
 {
-  dout(7) << "open_remote_ino on " << ino << dendl;
+  dout(7) << "open_remote_ino on " << ino << (want_xlocked ? " want_xlocked":"") << dendl;
   
-  C_MDC_OpenRemoteIno *c = new C_MDC_OpenRemoteIno(this, ino, hadino, hadv, onfinish);
+  C_MDC_OpenRemoteIno *c = new C_MDC_OpenRemoteIno(this, ino, want_xlocked,
+						   hadino, hadv, onfinish);
   mds->anchorclient->lookup(ino, c->anchortrace, c);
 }
 
-void MDCache::open_remote_ino_2(inodeno_t ino,
-                                vector<Anchor>& anchortrace,
-				inodeno_t hadino, version_t hadv,
-                                Context *onfinish)
+void MDCache::open_remote_ino_2(inodeno_t ino, vector<Anchor>& anchortrace, bool want_xlocked,
+				inodeno_t hadino, version_t hadv, Context *onfinish)
 {
   dout(7) << "open_remote_ino_2 on " << ino
 	  << ", trace depth is " << anchortrace.size() << dendl;
@@ -7106,7 +7109,7 @@ void MDCache::open_remote_ino_2(inodeno_t ino,
 
   if (!in->dirfragtree.contains(frag)) {
     dout(10) << "frag " << frag << " not valid, requerying anchortable" << dendl;
-    open_remote_ino(ino, onfinish);
+    open_remote_ino(ino, onfinish, want_xlocked);
     return;
   }
 
@@ -7116,7 +7119,7 @@ void MDCache::open_remote_ino_2(inodeno_t ino,
     dout(10) << "opening remote dirfrag " << frag << " under " << *in << dendl;
     /* we re-query the anchortable just to avoid a fragtree update race */
     open_remote_dirfrag(in, frag,
-			new C_MDC_RetryOpenRemoteIno(this, ino, onfinish));
+			new C_MDC_RetryOpenRemoteIno(this, ino, onfinish, want_xlocked));
     return;
   }
 
@@ -7124,7 +7127,7 @@ void MDCache::open_remote_ino_2(inodeno_t ino,
     if (in->is_frozen_dir()) {
       dout(7) << "traverse: " << *in << " is frozen_dir, waiting" << dendl;
       in->parent->dir->add_waiter(CDir::WAIT_UNFREEZE,
-				  new C_MDC_RetryOpenRemoteIno(this, ino, onfinish));
+				  new C_MDC_RetryOpenRemoteIno(this, ino, onfinish, want_xlocked));
       return;
     }
     dir = in->get_or_open_dirfrag(this, frag);
@@ -7146,20 +7149,22 @@ void MDCache::open_remote_ino_2(inodeno_t ino,
 		 << " in complete dir " << *dir
 		 << ", requerying anchortable"
 		 << dendl;
-	open_remote_ino(ino, onfinish, anchortrace[i].ino, anchortrace[i].updated);
+	open_remote_ino(ino, onfinish, want_xlocked,
+		        anchortrace[i].ino, anchortrace[i].updated);
       }
     } else {
       dout(10) << "need ino " << anchortrace[i].ino
 	       << ", fetching incomplete dir " << *dir
 	       << dendl;
-      dir->fetch(new C_MDC_OpenRemoteIno(this, ino, anchortrace, onfinish));
+      dir->fetch(new C_MDC_OpenRemoteIno(this, ino, want_xlocked, anchortrace, onfinish));
     }
   } else {
     // hmm, discover.
     dout(10) << "have remote dirfrag " << *dir << ", discovering " 
 	     << anchortrace[i].ino << dendl;
-    discover_ino(dir, anchortrace[i].ino, 
-		 new C_MDC_RetryOpenRemoteIno(this, ino, onfinish));
+    discover_ino(dir, anchortrace[i].ino,
+	         new C_MDC_RetryOpenRemoteIno(this, ino, onfinish, want_xlocked),
+		 (want_xlocked && i == anchortrace.size() - 1));
   }
 }
 
diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
index 64290aa..31c7467 100644
--- a/src/mds/MDCache.h
+++ b/src/mds/MDCache.h
@@ -701,11 +701,11 @@ public:
 
   void open_remote_dirfrag(CInode *diri, frag_t fg, Context *fin);
   CInode *get_dentry_inode(CDentry *dn, MDRequest *mdr, bool projected=false);
-  void open_remote_ino(inodeno_t ino, Context *fin, inodeno_t hadino=0, version_t hadv=0);
+  void open_remote_ino(inodeno_t ino, Context *fin, bool want_xlocked=false,
+		       inodeno_t hadino=0, version_t hadv=0);
   void open_remote_ino_2(inodeno_t ino,
-                         vector<Anchor>& anchortrace,
-			 inodeno_t hadino, version_t hadv,
-                         Context *onfinish);
+			 vector<Anchor>& anchortrace, bool want_xlocked,
+			 inodeno_t hadino, version_t hadv, Context *onfinish);
   void open_remote_dentry(CDentry *dn, bool projected, Context *fin);
   void _open_remote_dentry_finish(int r, CDentry *dn, bool projected, Context *fin);
 
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 5cee949..ec0d5d5 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5237,6 +5237,13 @@ void Server::handle_client_rename(MDRequest *mdr)
       if (desttrace[i]->is_auth() && desttrace[i]->is_projected())
 	  xlocks.insert(&desttrace[i]->versionlock);
     }
+    // xlock srci and oldin's primary dentries, so witnesses can call
+    // open_remote_ino() with 'want_locked=true' when the srcdn or destdn
+    // is traversed.
+    if (srcdnl->is_remote())
+      xlocks.insert(&srci->get_projected_parent_dn()->lock);
+    if (destdnl->is_remote())
+      xlocks.insert(&oldin->get_projected_parent_dn()->lock);
   }
 
   // we need to update srci's ctime.  xlock its least contended lock to do that...
-- 
1.7.11.7

