From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/2] client: trim deleted inode
Date: Sun, 21 Jul 2013 10:21:14 +0800
Message-ID: <1374373274-3457-3-git-send-email-zheng.z.yan@intel.com>
References: <1374373274-3457-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36648 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755218Ab3GUCVa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 20 Jul 2013 22:21:30 -0400
In-Reply-To: <1374373274-3457-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

previous patch makes MDS send notification to clients when an inode
is deleted. When receiving a such notification, we invalidate any
dentry link to the deleted inode. If there is no other reference to
the inode, the inode gets trimmed.

For cephfs fuse client, we use fuse_lowlevel_notify_inval_entry() or
fuse_lowlevel_notify_delete() to notify the kernel to trim the deleted
inode. (this is not completely reliable because we play unlink/link
tricks when  handle MDS replies. it's difficult to keep the user space
cache and kernel dcache in sync)

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/client/Client.cc  | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/client/Client.h   | 14 +++++++++++
 src/client/fuse_ll.cc | 19 ++++++++++++--
 3 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index ae7ddf6..f9c4f2b 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -141,9 +141,12 @@ Client::Client(Messenger *m, MonClient *mc)
     timer(m->cct, client_lock),
     ino_invalidate_cb(NULL),
     ino_invalidate_cb_handle(NULL),
+    dentry_invalidate_cb(NULL),
+    dentry_invalidate_cb_handle(NULL),
     getgroups_cb(NULL),
     getgroups_cb_handle(NULL),
     async_ino_invalidator(m->cct),
+    async_dentry_invalidator(m->cct),
     tick_event(NULL),
     monclient(mc), messenger(m), whoami(m->get_myname().num()),
     initialized(false), mounted(false), unmounting(false),
@@ -403,11 +406,17 @@ void Client::shutdown()
   admin_socket->unregister_command("dump_cache");
 
   if (ino_invalidate_cb) {
-    ldout(cct, 10) << "shutdown stopping invalidator finisher" << dendl;
+    ldout(cct, 10) << "shutdown stopping cache invalidator finisher" << dendl;
     async_ino_invalidator.wait_for_empty();
     async_ino_invalidator.stop();
   }
 
+  if (dentry_invalidate_cb) {
+    ldout(cct, 10) << "shutdown stopping dentry invalidator finisher" << dendl;
+    async_dentry_invalidator.wait_for_empty();
+    async_dentry_invalidator.stop();
+  }
+
   objectcacher->stop();  // outside of client_lock! this does a join.
 
   client_lock.Lock();
@@ -3526,6 +3535,45 @@ void Client::handle_cap_flushsnap_ack(MetaSession *session, Inode *in, MClientCa
   m->put();
 }
 
+class C_Client_DentryInvalidate : public Context  {
+private:
+  Client *client;
+  vinodeno_t dirino;
+  vinodeno_t ino;
+  string name;
+public:
+  C_Client_DentryInvalidate(Client *c, Dentry *dn) :
+			    client(c), dirino(dn->dir->parent_inode->vino()),
+			    ino(dn->inode->vino()), name(dn->name) { }
+  void finish(int r) {
+    client->_async_dentry_invalidate(dirino, ino, name);
+  }
+};
+
+void Client::_async_dentry_invalidate(vinodeno_t dirino, vinodeno_t ino, string& name)
+{
+  ldout(cct, 10) << "_async_dentry_invalidate '" << name << "' ino " << ino
+		 << " in dir " << dirino << dendl;
+  dentry_invalidate_cb(dentry_invalidate_cb_handle, dirino, ino, name);
+}
+
+void Client::_schedule_invalidate_dentry_callback(Dentry *dn)
+{
+  if (dentry_invalidate_cb && dn->inode->ll_ref > 0)
+    async_dentry_invalidator.queue(new C_Client_DentryInvalidate(this, dn));
+}
+
+void Client::_invalidate_inode_parents(Inode *in)
+{
+  set<Dentry*>::iterator q = in->dn_set.begin();
+  while (q != in->dn_set.end()) {
+    Dentry *dn = *q++;
+    // FIXME: we play lots of unlink/link tricks when handling MDS replies,
+    //        so in->dn_set doesn't always reflect the state of kernel's dcache.
+    _schedule_invalidate_dentry_callback(dn);
+    unlink(dn, false);
+  }
+}
 
 void Client::handle_cap_grant(MetaSession *session, Inode *in, Cap *cap, MClientCaps *m)
 {
@@ -3553,8 +3601,12 @@ void Client::handle_cap_grant(MetaSession *session, Inode *in, Cap *cap, MClient
     in->uid = m->head.uid;
     in->gid = m->head.gid;
   }
+  bool deleted_inode = false;
   if ((issued & CEPH_CAP_LINK_EXCL) == 0) {
     in->nlink = m->head.nlink;
+    if (in->nlink == 0 &&
+	(new_caps & (CEPH_CAP_LINK_SHARED | CEPH_CAP_LINK_EXCL)))
+      deleted_inode = true;
   }
   if ((issued & CEPH_CAP_XATTR_EXCL) == 0 &&
       m->xattrbl.length() &&
@@ -3608,6 +3660,10 @@ void Client::handle_cap_grant(MetaSession *session, Inode *in, Cap *cap, MClient
   if (new_caps)
     signal_cond_list(in->waitfor_caps);
 
+  // may drop inode's last ref
+  if (deleted_inode)
+    _invalidate_inode_parents(in);
+
   m->put();
 }
 
@@ -6294,6 +6350,17 @@ void Client::ll_register_ino_invalidate_cb(client_ino_callback_t cb, void *handl
   async_ino_invalidator.start();
 }
 
+void Client::ll_register_dentry_invalidate_cb(client_dentry_callback_t cb, void *handle)
+{
+  Mutex::Locker l(client_lock);
+  ldout(cct, 10) << "ll_register_dentry_invalidate_cb cb " << (void*)cb << " p " << (void*)handle << dendl;
+  if (cb == NULL)
+    return;
+  dentry_invalidate_cb = cb;
+  dentry_invalidate_cb_handle = handle;
+  async_dentry_invalidator.start();
+}
+
 void Client::ll_register_getgroups_cb(client_getgroups_callback_t cb, void *handle)
 {
   Mutex::Locker l(client_lock);
diff --git a/src/client/Client.h b/src/client/Client.h
index 96e8937..9579711 100644
--- a/src/client/Client.h
+++ b/src/client/Client.h
@@ -119,6 +119,9 @@ class MetaRequest;
 
 typedef void (*client_ino_callback_t)(void *handle, vinodeno_t ino, int64_t off, int64_t len);
 
+typedef void (*client_dentry_callback_t)(void *handle, vinodeno_t dirino,
+					 vinodeno_t ino, string& name);
+
 typedef int (*client_getgroups_callback_t)(void *handle, uid_t uid, gid_t **sgids);
 
 // ========================================================
@@ -209,10 +212,14 @@ class Client : public Dispatcher {
   client_ino_callback_t ino_invalidate_cb;
   void *ino_invalidate_cb_handle;
 
+  client_dentry_callback_t dentry_invalidate_cb;
+  void *dentry_invalidate_cb_handle;
+
   client_getgroups_callback_t getgroups_cb;
   void *getgroups_cb_handle;
 
   Finisher async_ino_invalidator;
+  Finisher async_dentry_invalidator;
 
   Context *tick_event;
   utime_t last_cap_renew;
@@ -352,6 +359,7 @@ protected:
 
   friend class C_Client_PutInode; // calls put_inode()
   friend class C_Client_CacheInvalidate;  // calls ino_invalidate_cb
+  friend class C_Client_DentryInvalidate;  // calls dentry_invalidate_cb
 
   //int get_cache_size() { return lru.lru_get_size(); }
   //void set_cache_size(int m) { lru.lru_set_max(m); }
@@ -454,6 +462,10 @@ protected:
   void finish_cap_snap(Inode *in, CapSnap *capsnap, int used);
   void _flushed_cap_snap(Inode *in, snapid_t seq);
 
+  void _schedule_invalidate_dentry_callback(Dentry *dn);
+  void _async_dentry_invalidate(vinodeno_t dirino, vinodeno_t ino, string& name);
+  void _invalidate_inode_parents(Inode *in);
+
   void _schedule_invalidate_callback(Inode *in, int64_t off, int64_t len, bool keep_caps);
   void _invalidate_inode_cache(Inode *in, bool keep_caps);
   void _invalidate_inode_cache(Inode *in, int64_t off, int64_t len, bool keep_caps);
@@ -727,6 +739,8 @@ public:
 
   void ll_register_ino_invalidate_cb(client_ino_callback_t cb, void *handle);
 
+  void ll_register_dentry_invalidate_cb(client_dentry_callback_t cb, void *handle);
+
   void ll_register_getgroups_cb(client_getgroups_callback_t cb, void *handle);
 };
 
diff --git a/src/client/fuse_ll.cc b/src/client/fuse_ll.cc
index 8339553..82761b9 100644
--- a/src/client/fuse_ll.cc
+++ b/src/client/fuse_ll.cc
@@ -534,7 +534,7 @@ static int getgroups_cb(void *handle, uid_t uid, gid_t **sgids)
   return 0;
 }
 
-static void invalidate_cb(void *handle, vinodeno_t vino, int64_t off, int64_t len)
+static void ino_invalidate_cb(void *handle, vinodeno_t vino, int64_t off, int64_t len)
 {
   CephFuse::Handle *cfuse = (CephFuse::Handle *)handle;
   fuse_ino_t fino = cfuse->make_fake_ino(vino.ino, vino.snapid);
@@ -543,6 +543,19 @@ static void invalidate_cb(void *handle, vinodeno_t vino, int64_t off, int64_t le
 #endif
 }
 
+static void dentry_invalidate_cb(void *handle, vinodeno_t dirino,
+				 vinodeno_t ino, string& name)
+{
+  CephFuse::Handle *cfuse = (CephFuse::Handle *)handle;
+  fuse_ino_t fdirino = cfuse->make_fake_ino(dirino.ino, dirino.snapid);
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 9)
+  fuse_ino_t fino = cfuse->make_fake_ino(ino.ino, ino.snapid);
+  fuse_lowlevel_notify_delete(cfuse->ch, fdirino, fino, name.c_str(), name.length());
+#elif FUSE_VERSION >= FUSE_MAKE_VERSION(2, 8)
+  fuse_lowlevel_notify_inval_entry(cfuse->ch, fdirino, name.c_str(), name.length());
+#endif
+}
+
 static void do_init(void *data, fuse_conn_info *bar)
 {
   CephFuse::Handle *cfuse = (CephFuse::Handle *)data;
@@ -703,8 +716,10 @@ int CephFuse::Handle::init(int argc, const char *argv[])
 
   client->ll_register_getgroups_cb(getgroups_cb, this);
 
+  client->ll_register_dentry_invalidate_cb(dentry_invalidate_cb, this);
+
   if (g_conf->fuse_use_invalidate_cb)
-    client->ll_register_ino_invalidate_cb(invalidate_cb, this);
+    client->ll_register_ino_invalidate_cb(ino_invalidate_cb, this);
 
 done:
   fuse_opt_free_args(&args);
-- 
1.8.1.4

