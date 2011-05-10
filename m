From: Brian Chrisman <brchrisman@gmail.com>
Subject: [PATCH 1/2] support for xattrs in libceph
Date: Tue, 10 May 2011 12:38:48 -0700
Message-ID: <1305056329-482-2-git-send-email-brchrisman@gmail.com>
References: <1305056329-482-1-git-send-email-brchrisman@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52767 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab1EJTlg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 15:41:36 -0400
Received: by pvg12 with SMTP id 12so2967952pvg.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 12:41:35 -0700 (PDT)
In-Reply-To: <1305056329-482-1-git-send-email-brchrisman@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Brian Chrisman <bchrisman@gmail.com>, Brian Chrisman <brchrisman@gmail.com>

From: Brian Chrisman <bchrisman@gmail.com>


Signed-off-by: Brian Chrisman <brchrisman@gmail.com>
---
 src/client/Client.cc       |   67 +++++++++++++++++++++++++++++++++++++++++++-
 src/client/Client.h        |   10 ++++++
 src/include/ceph/libceph.h |   15 ++++++++++
 src/libceph.cc             |   42 +++++++++++++++++++++++++++
 4 files changed, 133 insertions(+), 1 deletions(-)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 6a27273..5083e99 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -5563,6 +5563,71 @@ int Client::ll_setattr(vinodeno_t vino, struct stat *attr, int mask, int uid, in
 // ----------
 // xattrs
 
+int Client::getxattr(const char *path, const char *name, void *value, size_t size)
+{
+  Mutex::Locker lock(client_lock);
+  Inode *ceph_inode;
+  Client::path_walk(path, &ceph_inode, true);
+  return Client::_getxattr(ceph_inode, name, value, size, getuid(), getgid());
+}
+
+int Client::lgetxattr(const char *path, const char *name, void *value, size_t size)
+{
+  Mutex::Locker lock(client_lock);
+  Inode *ceph_inode;
+  Client::path_walk(path, &ceph_inode, false);
+  return Client::_getxattr(ceph_inode, name, value, size, getuid(), getgid());
+}
+
+int Client::listxattr(const char *path, char *list, size_t size)
+{
+  Mutex::Locker lock(client_lock);
+  Inode *ceph_inode;
+  Client::path_walk(path, &ceph_inode, true);
+  return Client::_listxattr(ceph_inode, list, size, getuid(), getgid());
+}
+
+int Client::llistxattr(const char *path, char *list, size_t size)
+{
+  Mutex::Locker lock(client_lock);
+  Inode *ceph_inode;
+  Client::path_walk(path, &ceph_inode, false);
+  return Client::_listxattr(ceph_inode, list, size, getuid(), getgid());
+}
+
+int Client::removexattr(const char *path, const char *name)
+{
+  Mutex::Locker lock(client_lock);
+  Inode *ceph_inode;
+  Client::path_walk(path, &ceph_inode, true);
+  return Client::_removexattr(ceph_inode, name, getuid(), getgid());
+}
+
+int Client::lremovexattr(const char *path, const char *name)
+{
+  Mutex::Locker lock(client_lock);
+  Inode *ceph_inode;
+  Client::path_walk(path, &ceph_inode, false);
+  return Client::_removexattr(ceph_inode, name, getuid(), getgid());
+}
+
+int Client::setxattr(const char *path, const char *name, const void *value, size_t size, int flags)
+{
+  Mutex::Locker lock(client_lock);
+  Inode *ceph_inode;
+  Client::path_walk(path, &ceph_inode, true);
+  return Client::_setxattr(ceph_inode, name, value, size, flags, getuid(), getgid());
+}
+
+int Client::lsetxattr(const char *path, const char *name, const void *value, size_t size, int flags)
+{
+  Mutex::Locker lock(client_lock);
+  Inode *ceph_inode;
+  Client::path_walk(path, &ceph_inode, false);
+  return Client::_setxattr(ceph_inode, name, value, size, flags, getuid(), getgid());
+}
+
+
 int Client::_getxattr(Inode *in, const char *name, void *value, size_t size,
 		      int uid, int gid)
 {
@@ -5708,7 +5773,7 @@ int Client::ll_removexattr(vinodeno_t vino, const char *name, int uid, int gid)
   tout << name << std::endl;
 
   // only user xattrs, for now
-  if (strncmp(name, "user.", 5))
+  if (strncmp(name, "user.", 5) && strncmp(name, "security.", 9) && strncmp(name, "trusted.", 8))
     return -EOPNOTSUPP;
 
   Inode *in = _ll_get_inode(vino);
diff --git a/src/client/Client.h b/src/client/Client.h
index ab21dc8..b36621d 100644
--- a/src/client/Client.h
+++ b/src/client/Client.h
@@ -1258,6 +1258,16 @@ public:
   int fsync(int fd, bool syncdataonly);
   int fstat(int fd, struct stat *stbuf);
 
+  // full path xattr ops
+  int getxattr(const char *path, const char *name, void *value, size_t size);
+  int lgetxattr(const char *path, const char *name, void *value, size_t size);
+  int listxattr(const char *path, char *list, size_t size);
+  int llistxattr(const char *path, char *list, size_t size);
+  int removexattr(const char *path, const char *name);
+  int lremovexattr(const char *path, const char *name);
+  int setxattr(const char *path, const char *name, const void *value, size_t size, int flags);
+  int lsetxattr(const char *path, const char *name, const void *value, size_t size, int flags);
+
   int sync_fs();
   int64_t drop_caches();
 
diff --git a/src/include/ceph/libceph.h b/src/include/ceph/libceph.h
index 3ed3369..f9fc29e 100644
--- a/src/include/ceph/libceph.h
+++ b/src/include/ceph/libceph.h
@@ -121,6 +121,21 @@ int ceph_fstat(struct ceph_mount_info *cmount, int fd, struct stat *stbuf);
 
 int ceph_sync_fs(struct ceph_mount_info *cmount);
 
+/* xattr support */
+int ceph_getxattr(struct ceph_mount_info *cmount, const char *path, const char *name, 
+	void *value, size_t size);
+int ceph_lgetxattr(struct ceph_mount_info *cmount, const char *path, const char *name, 
+	void *value, size_t size);
+int ceph_listxattr(struct ceph_mount_info *cmount, const char *path, char *list, size_t size);
+int ceph_llistxattr(struct ceph_mount_info *cmount, const char *path, char *list, size_t size);
+int ceph_removexattr(struct ceph_mount_info *cmount, const char *path, const char *name);
+int ceph_lremovexattr(struct ceph_mount_info *cmount, const char *path, const char *name);
+int ceph_setxattr(struct ceph_mount_info *cmount, const char *path, const char *name, 
+	const void *value, size_t size, int flags);
+int ceph_lsetxattr(struct ceph_mount_info *cmount, const char *path, const char *name, 
+	const void *value, size_t size, int flags);
+
+
 
 /* expose file layout */
 int ceph_get_file_stripe_unit(struct ceph_mount_info *cmount, int fh);
diff --git a/src/libceph.cc b/src/libceph.cc
index d1143d6..6388bde 100644
--- a/src/libceph.cc
+++ b/src/libceph.cc
@@ -416,6 +416,48 @@ extern "C" int ceph_setattr(struct ceph_mount_info *cmount, const char *relpath,
   return cmount->get_client()->setattr(relpath, attr, mask);
 }
 
+// *xattr() calls supporting samba/vfs
+extern "C" int ceph_getxattr(struct ceph_mount_info *cmount, const char *path, const char *name, void *value, size_t size)
+{
+  return cmount->get_client()->getxattr(path, name, value, size);
+}
+
+extern "C" int ceph_lgetxattr(struct ceph_mount_info *cmount, const char *path, const char *name, void *value, size_t size)
+{
+  return cmount->get_client()->lgetxattr(path, name, value, size);
+}
+
+extern "C" int ceph_listxattr(struct ceph_mount_info *cmount, const char *path, char *list, size_t size)
+{
+  return cmount->get_client()->listxattr(path, list, size);
+}
+
+extern "C" int ceph_llistxattr(struct ceph_mount_info *cmount, const char *path, char *list, size_t size)
+{
+  return cmount->get_client()->llistxattr(path, list, size);
+}
+
+extern "C" int ceph_removexattr(struct ceph_mount_info *cmount, const char *path, const char *name)
+{
+  return cmount->get_client()->removexattr(path, name);
+}
+
+extern "C" int ceph_lremovexattr(struct ceph_mount_info *cmount, const char *path, const char *name)
+{
+  return cmount->get_client()->lremovexattr(path, name);
+}
+
+extern "C" int ceph_setxattr(struct ceph_mount_info *cmount, const char *path, const char *name, const void *value, size_t size, int flags)
+{
+  return cmount->get_client()->setxattr(path, name, value, size, flags);
+}
+
+extern "C" int ceph_lsetxattr(struct ceph_mount_info *cmount, const char *path, const char *name, const void *value, size_t size, int flags)
+{
+  return cmount->get_client()->lsetxattr(path, name, value, size, flags);
+}
+/* end xattr support */
+
 extern "C" int ceph_chmod(struct ceph_mount_info *cmount, const char *path, mode_t mode)
 {
   return cmount->get_client()->chmod(path, mode);
-- 
1.7.1

