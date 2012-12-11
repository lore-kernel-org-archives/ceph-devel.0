From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 13/14] mds: fix race between send_dentry_link() and cache expire
Date: Tue, 11 Dec 2012 16:30:59 +0800
Message-ID: <1355214660-26354-14-git-send-email-zheng.z.yan@intel.com>
References: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16602 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752519Ab2LKIbR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 03:31:17 -0500
In-Reply-To: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

MDentryLink message can race with cache expire, When it arrives at
the target MDS, it's possible there is no corresponding dentry in
the cache. If this race happens, we should expire the replica inode
encoded in the MDentryLink message. But to expire an inode, the MDS
need to know which subtree does the inode belong to, so modify the
MDentryLink message to include this information.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc         | 85 ++++++++++++++++++++++++++++++----------------
 src/messages/MDentryLink.h |  7 +++-
 2 files changed, 61 insertions(+), 31 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 43a3954..3579261 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -9269,14 +9269,15 @@ void MDCache::send_dentry_link(CDentry *dn)
 {
   dout(7) << "send_dentry_link " << *dn << dendl;
 
+  CDir *subtree = get_subtree_root(dn->get_dir());
   for (map<int,int>::iterator p = dn->replicas_begin(); 
        p != dn->replicas_end(); 
        p++) {
     if (mds->mdsmap->get_state(p->first) < MDSMap::STATE_REJOIN) 
       continue;
     CDentry::linkage_t *dnl = dn->get_linkage();
-    MDentryLink *m = new MDentryLink(dn->get_dir()->dirfrag(), dn->name,
-				     dnl->is_primary());
+    MDentryLink *m = new MDentryLink(subtree->dirfrag(), dn->get_dir()->dirfrag(),
+				     dn->name, dnl->is_primary());
     if (dnl->is_primary()) {
       dout(10) << "  primary " << *dnl->get_inode() << dendl;
       replicate_inode(dnl->get_inode(), p->first, m->bl);
@@ -9295,32 +9296,48 @@ void MDCache::send_dentry_link(CDentry *dn)
 /* This function DOES put the passed message before returning */
 void MDCache::handle_dentry_link(MDentryLink *m)
 {
-  CDir *dir = get_dirfrag(m->get_dirfrag());
-  assert(dir);
-  CDentry *dn = dir->lookup(m->get_dn());
-  assert(dn);
 
-  dout(7) << "handle_dentry_link on " << *dn << dendl;
-  CDentry::linkage_t *dnl = dn->get_linkage();
+  CDentry *dn = NULL;
+  CDir *dir = get_dirfrag(m->get_dirfrag());
+  if (!dir) {
+    dout(7) << "handle_dentry_link don't have dirfrag " << m->get_dirfrag() << dendl;
+  } else {
+    dn = dir->lookup(m->get_dn());
+    if (!dn) {
+      dout(7) << "handle_dentry_link don't have dentry " << *dir << " dn " << m->get_dn() << dendl;
+    } else {
+      dout(7) << "handle_dentry_link on " << *dn << dendl;
+      CDentry::linkage_t *dnl = dn->get_linkage();
 
-  assert(!dn->is_auth());
-  assert(dnl->is_null());
+      assert(!dn->is_auth());
+      assert(dnl->is_null());
+    }
+  }
 
   bufferlist::iterator p = m->bl.begin();
   list<Context*> finished;
-  
-  if (m->get_is_primary()) {
-    // primary link.
-    add_replica_inode(p, dn, finished);
-  } else {
-    // remote link, easy enough.
-    inodeno_t ino;
-    __u8 d_type;
-    ::decode(ino, p);
-    ::decode(d_type, p);
-    dir->link_remote_inode(dn, ino, d_type);
+  if (dn) {
+    if (m->get_is_primary()) {
+      // primary link.
+      add_replica_inode(p, dn, finished);
+    } else {
+      // remote link, easy enough.
+      inodeno_t ino;
+      __u8 d_type;
+      ::decode(ino, p);
+      ::decode(d_type, p);
+      dir->link_remote_inode(dn, ino, d_type);
+    }
+  } else if (m->get_is_primary()) {
+    CInode *in = add_replica_inode(p, NULL, finished);
+    assert(in->get_num_ref() == 0);
+    assert(in->get_parent_dn() == NULL);
+    MCacheExpire* expire = new MCacheExpire(mds->get_nodeid());
+    expire->add_inode(m->get_subtree(), in->vino(), in->get_replica_nonce());
+    mds->send_message_mds(expire, m->get_source().num());
+    remove_inode(in);
   }
-  
+
   if (!finished.empty())
     mds->queue_waiters(finished);
 
@@ -9352,6 +9369,11 @@ void MDCache::send_dentry_unlink(CDentry *dn, CDentry *straydn, MDRequest *mdr)
 /* This function DOES put the passed message before returning */
 void MDCache::handle_dentry_unlink(MDentryUnlink *m)
 {
+  // straydn
+  CDentry *straydn = NULL;
+  if (m->straybl.length())
+    straydn = add_replica_stray(m->straybl, m->get_source().num());
+
   CDir *dir = get_dirfrag(m->get_dirfrag());
   if (!dir) {
     dout(7) << "handle_dentry_unlink don't have dirfrag " << m->get_dirfrag() << dendl;
@@ -9363,13 +9385,6 @@ void MDCache::handle_dentry_unlink(MDentryUnlink *m)
       dout(7) << "handle_dentry_unlink on " << *dn << dendl;
       CDentry::linkage_t *dnl = dn->get_linkage();
 
-      // straydn
-      CDentry *straydn = NULL;
-      if (m->straybl.length()) {
-	int from = m->get_source().num();
-	straydn = add_replica_stray(m->straybl, from);
-      }
-
       // open inode?
       if (dnl->is_primary()) {
 	CInode *in = dnl->get_inode();
@@ -9392,8 +9407,9 @@ void MDCache::handle_dentry_unlink(MDentryUnlink *m)
 	  migrator->export_caps(in);
 	
 	lru.lru_bottouch(straydn);  // move stray to end of lru
-
+	straydn = NULL;
       } else {
+	assert(!straydn);
 	assert(dnl->is_remote());
 	dn->dir->unlink_inode(dn);
       }
@@ -9404,6 +9420,15 @@ void MDCache::handle_dentry_unlink(MDentryUnlink *m)
     }
   }
 
+  // race with trim_dentry()
+  if (straydn) {
+    assert(straydn->get_num_ref() == 0);
+    assert(straydn->get_linkage()->is_null());
+    map<int, MCacheExpire*> expiremap;
+    trim_dentry(straydn, expiremap);
+    send_expire_messages(expiremap);
+  }
+
   m->put();
   return;
 }
diff --git a/src/messages/MDentryLink.h b/src/messages/MDentryLink.h
index ed02bc2..b351532 100644
--- a/src/messages/MDentryLink.h
+++ b/src/messages/MDentryLink.h
@@ -17,11 +17,13 @@
 #define CEPH_MDENTRYLINK_H
 
 class MDentryLink : public Message {
+  dirfrag_t subtree;
   dirfrag_t dirfrag;
   string dn;
   bool is_primary;
 
  public:
+  dirfrag_t get_subtree() { return subtree; }
   dirfrag_t get_dirfrag() { return dirfrag; }
   string& get_dn() { return dn; }
   bool get_is_primary() { return is_primary; }
@@ -30,8 +32,9 @@ class MDentryLink : public Message {
 
   MDentryLink() :
     Message(MSG_MDS_DENTRYLINK) { }
-  MDentryLink(dirfrag_t df, string& n, bool p) :
+  MDentryLink(dirfrag_t r, dirfrag_t df, string& n, bool p) :
     Message(MSG_MDS_DENTRYLINK),
+    subtree(r),
     dirfrag(df),
     dn(n),
     is_primary(p) {}
@@ -46,12 +49,14 @@ public:
   
   void decode_payload() {
     bufferlist::iterator p = payload.begin();
+    ::decode(subtree, p);
     ::decode(dirfrag, p);
     ::decode(dn, p);
     ::decode(is_primary, p);
     ::decode(bl, p);
   }
   void encode_payload(uint64_t features) {
+    ::encode(subtree, payload);
     ::encode(dirfrag, payload);
     ::encode(dn, payload);
     ::encode(is_primary, payload);
-- 
1.7.11.7

