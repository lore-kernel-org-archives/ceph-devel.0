From: Brian Chrisman <brchrisman@gmail.com>
Subject: [PATCH 1/2] add ceph_readdir() to libceph
Date: Thu, 19 May 2011 13:22:32 -0700
Message-ID: <1305836553-393-2-git-send-email-brchrisman@gmail.com>
References: <1305836553-393-1-git-send-email-brchrisman@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36203 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933926Ab1ESUW4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2011 16:22:56 -0400
Received: by pvg12 with SMTP id 12so1349946pvg.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2011 13:22:55 -0700 (PDT)
In-Reply-To: <1305836553-393-1-git-send-email-brchrisman@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Brian Chrisman <brchrisman@gmail.com>


Signed-off-by: Brian Chrisman <brchrisman@gmail.com>
---
 src/client/Client.cc       |   35 +++++++++++++++++++++++++++++++++--
 src/client/Client.h        |    1 +
 src/include/ceph/libceph.h |    1 +
 src/libceph.cc             |    5 +++++
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index e4b400c..0284c03 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -4298,8 +4298,6 @@ int Client::readdir_r_cb(dir_result_t *d, add_dirent_cb_t cb, void *p)
 }
 
 
-
-
 int Client::readdir_r(dir_result_t *d, struct dirent *de)
 {  
   return readdirplus_r(d, de, 0, 0);
@@ -4337,6 +4335,39 @@ static int _readdir_single_dirent_cb(void *p, struct dirent *de, struct stat *st
   return 0;  
 }
 
+struct dirent * Client::readdir(dir_result_t *d)
+{
+  int ret;
+  static int stmask;
+  static struct dirent de;
+  static struct stat st;
+  single_readdir sr;
+  sr.de = &de;
+  sr.st = &st;
+  sr.stmask = &stmask;
+  sr.full = false;
+
+  /*
+   * Return mechanisms are non-obvious (callback appears intended for multi-read mechanism like cfuse)
+   * readdir_r_cb=0 end of directory reached on prior call
+   * readdir_r_cb=0 entry filled and offset now at end of the directory
+   * readdir_r_cb=-1 entry is filled successfully, not end of dir
+   * readdir_r_cb=-(other) on error
+   * callback leaves sr.full=false when 'offset is at end of directory'
+   * callback may leave sr.full=false on error
+   * callback sets sr.full=true on 'successfully read dirent'
+   */
+  ret = readdir_r_cb(d, _readdir_single_dirent_cb, (void *)&sr);
+  if (ret < -1) {
+    errno = -ret;
+    return (dirent *) NULL;
+  }
+  if (sr.full) {
+    return &de;
+  }
+  return (dirent *) NULL;
+}
+
 int Client::readdirplus_r(dir_result_t *d, struct dirent *de, struct stat *st, int *stmask)
 {  
   single_readdir sr;
diff --git a/src/client/Client.h b/src/client/Client.h
index b36621d..e10979d 100644
--- a/src/client/Client.h
+++ b/src/client/Client.h
@@ -1204,6 +1204,7 @@ public:
 
   int readdir_r_cb(dir_result_t *dirp, add_dirent_cb_t cb, void *p);
 
+  struct dirent * readdir(dir_result_t *d);
   int readdir_r(dir_result_t *dirp, struct dirent *de);
   int readdirplus_r(dir_result_t *dirp, struct dirent *de, struct stat *st, int *stmask);
 
diff --git a/src/include/ceph/libceph.h b/src/include/ceph/libceph.h
index f9fc29e..bf28402 100644
--- a/src/include/ceph/libceph.h
+++ b/src/include/ceph/libceph.h
@@ -76,6 +76,7 @@ int ceph_chdir(struct ceph_mount_info *cmount, const char *s);
 
 int ceph_opendir(struct ceph_mount_info *cmount, const char *name, struct ceph_dir_result **dirpp);
 int ceph_closedir(struct ceph_mount_info *cmount, struct ceph_dir_result *dirp);
+struct dirent * ceph_readdir(struct ceph_mount_info *cmount, struct ceph_dir_result *dirp);
 int ceph_readdir_r(struct ceph_mount_info *cmount, struct ceph_dir_result *dirp, struct dirent *de);
 int ceph_readdirplus_r(struct ceph_mount_info *cmount, struct ceph_dir_result *dirp, struct dirent *de,
 		       struct stat *st, int *stmask);
diff --git a/src/libceph.cc b/src/libceph.cc
index 6388bde..54993ac 100644
--- a/src/libceph.cc
+++ b/src/libceph.cc
@@ -319,6 +319,11 @@ extern "C" int ceph_closedir(struct ceph_mount_info *cmount, struct ceph_dir_res
   return cmount->get_client()->closedir((dir_result_t*)dirp);
 }
 
+extern "C" struct dirent * ceph_readdir(struct ceph_mount_info *cmount, struct ceph_dir_result *dirp)
+{
+  return cmount->get_client()->readdir((dir_result_t*)dirp);
+}
+
 extern "C" int ceph_readdir_r(struct ceph_mount_info *cmount, struct ceph_dir_result *dirp, struct dirent *de)
 {
   return cmount->get_client()->readdir_r((dir_result_t*)dirp, de);
-- 
1.7.1

