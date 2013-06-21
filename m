From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/2] mds: kill Server::handle_client_lookup_hash()
Date: Fri, 21 Jun 2013 14:39:27 +0800
Message-ID: <1371796767-16205-2-git-send-email-zheng.z.yan@intel.com>
References: <1371796767-16205-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50145 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422795Ab3FUGoY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 21 Jun 2013 02:44:24 -0400
In-Reply-To: <1371796767-16205-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Server::handle_client_lookup_ino() is more simple and robust. Use it
to handle both LOOKUPHASH and LOOKUINO requests.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 141 +-----------------------------------------------------
 src/mds/Server.h  |   4 --
 2 files changed, 1 insertion(+), 144 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index e84626b..627ecd0 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -1161,9 +1161,6 @@ void Server::dispatch_client_request(MDRequest *mdr)
   
   switch (req->get_op()) {
   case CEPH_MDS_OP_LOOKUPHASH:
-    handle_client_lookup_hash(mdr);
-    break;
-
   case CEPH_MDS_OP_LOOKUPINO:
     handle_client_lookup_ino(mdr);
     break;
@@ -2318,135 +2315,6 @@ void Server::handle_client_lookup_parent(MDRequest *mdr)
   reply_request(mdr, 0, in, dn);  // reply
 }
 
-struct C_MDS_LookupHash2 : public Context {
-  Server *server;
-  MDRequest *mdr;
-  C_MDS_LookupHash2(Server *s, MDRequest *r) : server(s), mdr(r) {}
-  void finish(int r) {
-    server->_lookup_hash_2(mdr, r);
-  }
-};
-
-/* This function DOES clean up the mdr before returning*/
-/*
- * filepath:  ino
- * filepath2: dirino/<hash as base-10 %d>
- *
- * This dirino+hash is optional.
- */
-void Server::handle_client_lookup_hash(MDRequest *mdr)
-{
-  MClientRequest *req = mdr->client_request;
-
-  inodeno_t ino = req->get_filepath().get_ino();
-  inodeno_t dirino = req->get_filepath2().get_ino();
-
-  CInode *in = 0;
-
-  if (ino) {
-    in = mdcache->get_inode(ino);
-    if (in && in->state_test(CInode::STATE_PURGING)) {
-      reply_request(mdr, -ESTALE);
-      return;
-    }
-    if (!in && !dirino) {
-      dout(10) << " no dirino, looking up ino " << ino << " directly" << dendl;
-      _lookup_ino(mdr);
-      return;
-    }
-  }
-  if (!in) {
-    // try the directory
-    CInode *diri = mdcache->get_inode(dirino);
-    if (!diri) {
-      mdcache->find_ino_peers(dirino,
-			      new C_MDS_LookupHash2(this, mdr), -1);
-      return;
-    }
-    if (diri->state_test(CInode::STATE_PURGING)) {
-      reply_request(mdr, -ESTALE);
-      return;
-    }
-    dout(10) << " have diri " << *diri << dendl;
-    unsigned hash = atoi(req->get_filepath2()[0].c_str());
-    frag_t fg = diri->dirfragtree[hash];
-    dout(10) << " fg is " << fg << dendl;
-    CDir *dir = diri->get_dirfrag(fg);
-    if (!dir) {
-      if (!diri->is_auth()) {
-	if (diri->is_ambiguous_auth()) {
-	  // wait
-	  dout(7) << " waiting for single auth in " << *diri << dendl;
-	  diri->add_waiter(CInode::WAIT_SINGLEAUTH, new C_MDS_RetryRequest(mdcache, mdr));
-	  return;
-	} 
-	mdcache->request_forward(mdr, diri->authority().first);
-	return;
-      }
-      dir = diri->get_or_open_dirfrag(mdcache, fg);
-    }
-    assert(dir);
-    dout(10) << " have dir " << *dir << dendl;
-    if (!dir->is_auth()) {
-      if (dir->is_ambiguous_auth()) {
-	// wait
-	dout(7) << " waiting for single auth in " << *dir << dendl;
-	dir->add_waiter(CDir::WAIT_SINGLEAUTH, new C_MDS_RetryRequest(mdcache, mdr));
-	return;
-      } 
-      mdcache->request_forward(mdr, dir->authority().first);
-      return;
-    }
-    if (!dir->is_complete()) {
-      dir->fetch(new C_MDS_RetryRequest(mdcache, mdr));
-      return;
-    }
-    reply_request(mdr, -ESTALE);
-    return;
-  }
-
-  dout(10) << "reply to lookup_hash on " << *in << dendl;
-  MClientReply *reply = new MClientReply(req, 0);
-  reply_request(mdr, reply, in, in->get_parent_dn());
-}
-
-struct C_MDS_LookupHash3 : public Context {
-  Server *server;
-  MDRequest *mdr;
-  C_MDS_LookupHash3(Server *s, MDRequest *r) : server(s), mdr(r) {}
-  void finish(int r) {
-    server->_lookup_hash_3(mdr, r);
-  }
-};
-
-void Server::_lookup_hash_2(MDRequest *mdr, int r)
-{
-  inodeno_t dirino = mdr->client_request->get_filepath2().get_ino();
-  dout(10) << "_lookup_hash_2 " << mdr << " checked peers for dirino " << dirino << " and got r=" << r << dendl;
-  if (r == 0) {
-    dispatch_client_request(mdr);
-    return;
-  }
-
-  // okay fine, try the dir object then!
-  mdcache->find_ino_dir(dirino, new C_MDS_LookupHash3(this, mdr));
-}
-
-void Server::_lookup_hash_3(MDRequest *mdr, int r)
-{
-  inodeno_t dirino = mdr->client_request->get_filepath2().get_ino();
-  dout(10) << "_lookup_hash_3 " << mdr << " checked dir object for dirino " << dirino
-	   << " and got r=" << r << dendl;
-  if (r == 0) {
-    dispatch_client_request(mdr);
-    return;
-  }
-  dout(10) << "_lookup_hash_3 " << mdr << " trying the ino itself" << dendl;
-  _lookup_ino(mdr);
-}
-
-/***************/
-
 struct C_MDS_LookupIno2 : public Context {
   Server *server;
   MDRequest *mdr;
@@ -2471,7 +2339,7 @@ void Server::handle_client_lookup_ino(MDRequest *mdr)
     return;
   }
   if (!in) {
-    _lookup_ino(mdr);
+    mdcache->open_ino(ino, (int64_t)-1, new C_MDS_LookupIno2(this, mdr), false);
     return;
   }
 
@@ -2480,13 +2348,6 @@ void Server::handle_client_lookup_ino(MDRequest *mdr)
   reply_request(mdr, reply, in, in->get_parent_dn());
 }
 
-void Server::_lookup_ino(MDRequest *mdr)
-{
-  inodeno_t ino = mdr->client_request->get_filepath().get_ino();
-  dout(10) << "_lookup_ino " << mdr << " opening ino " << ino << dendl;
-  mdcache->open_ino(ino, (int64_t)-1, new C_MDS_LookupIno2(this, mdr), false);
-}
-
 void Server::_lookup_ino_2(MDRequest *mdr, int r)
 {
   inodeno_t ino = mdr->client_request->get_filepath().get_ino();
diff --git a/src/mds/Server.h b/src/mds/Server.h
index 2da4055..6e8f275 100644
--- a/src/mds/Server.h
+++ b/src/mds/Server.h
@@ -140,11 +140,7 @@ public:
   // requests on existing inodes.
   void handle_client_getattr(MDRequest *mdr, bool is_lookup);
   void handle_client_lookup_parent(MDRequest *mdr);
-  void handle_client_lookup_hash(MDRequest *mdr);
-  void _lookup_hash_2(MDRequest *mdr, int r);
-  void _lookup_hash_3(MDRequest *mdr, int r);
   void handle_client_lookup_ino(MDRequest *mdr);
-  void _lookup_ino(MDRequest *mdr);
   void _lookup_ino_2(MDRequest *mdr, int r);
   void handle_client_readdir(MDRequest *mdr);
   void handle_client_file_setlock(MDRequest *mdr);
-- 
1.8.1.4

