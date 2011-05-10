From: Brian Chrisman <brchrisman@gmail.com>
Subject: [PATCH 2/2] expand testceph to check xattrs
Date: Tue, 10 May 2011 12:38:49 -0700
Message-ID: <1305056329-482-3-git-send-email-brchrisman@gmail.com>
References: <1305056329-482-1-git-send-email-brchrisman@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47790 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab1EJTlj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 15:41:39 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so2966074pzk.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 12:41:39 -0700 (PDT)
In-Reply-To: <1305056329-482-1-git-send-email-brchrisman@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Brian Chrisman <brchrisman@gmail.com>


Signed-off-by: Brian Chrisman <brchrisman@gmail.com>
---
 src/client/testceph.cc |   74 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 73 insertions(+), 1 deletions(-)

diff --git a/src/client/testceph.cc b/src/client/testceph.cc
index 1bbd81d..da4b7a2 100644
--- a/src/client/testceph.cc
+++ b/src/client/testceph.cc
@@ -14,9 +14,13 @@
 
 #include "common/errno.h"
 #include "include/ceph/libceph.h"
+#include <stdlib.h>
 
 #include <errno.h>
 #include <iostream>
+#include <fcntl.h>
+#include <sys/xattr.h>
+#include <string.h>
 
 using std::cout;
 using std::cerr;
@@ -24,16 +28,19 @@ using std::cerr;
 int main(int argc, const char **argv)
 {
   struct ceph_mount_info *cmount;
+    cout << "calling ceph_create..." << std::endl;
   int ret = ceph_create(&cmount, NULL);
   if (ret) {
     cerr << "ceph_create failed with error: " << ret << std::endl;
     return 1;
   }
-
+    cout << "calling ceph_conf_read_file..." << ret << std::endl;
   ceph_conf_read_file(cmount, NULL);
+    cout << "calling ceph_conf_parse_argv..." << ret << std::endl;
   ceph_conf_parse_argv(cmount, argc, argv);
 
   char buf[128];
+    cout << "calling ceph_conf_get..." << ret << std::endl;
   ret = ceph_conf_get(cmount, "log file", buf, sizeof(buf));
   if (ret) {
     cerr << "ceph_conf_get(\"log file\") failed with error " << ret << std::endl;
@@ -49,18 +56,23 @@ int main(int argc, const char **argv)
   }
   cout << "Successfully mounted Ceph!" << std::endl;
 
+  // what if foo is already there???
   struct ceph_dir_result *foo_dir;
   ret = ceph_opendir(cmount, "foo", &foo_dir);
   if (ret != -ENOENT) {
     cerr << "ceph_opendir error: unexpected result from trying to open foo: "
 	 << cpp_strerror(ret) << std::endl;
     return 1;
+  } else {
+    cout << "ceph_opendir: success" << std::endl;
   }
 
   ret = ceph_mkdir(cmount, "foo",  0777);
   if (ret) {
     cerr << "ceph_mkdir error: " << cpp_strerror(ret) << std::endl;
     return 1;
+  } else {
+    cout << "ceph_mkdir: success" << std::endl;
   }
 
   struct stat stbuf;
@@ -68,39 +80,99 @@ int main(int argc, const char **argv)
   if (ret) {
     cerr << "ceph_lstat error: " << cpp_strerror(ret) << std::endl;
     return 1;
+  } else {
+    cout << "ceph_lstat: success" << std::endl;
   }
 
   if (!S_ISDIR(stbuf.st_mode)) {
     cerr << "ceph_lstat(foo): foo is not a directory? st_mode = "
 	 << stbuf.st_mode << std::endl;
     return 1;
+  } else {
+    cout << "ceph_lstat: mode success" << std::endl;
   }
 
   ret = ceph_rmdir(cmount, "foo");
   if (ret) {
     cerr << "ceph_rmdir error: " << cpp_strerror(ret) << std::endl;
     return 1;
+  } else {
+    cout << "ceph_rmdir: success" << std::endl;
   }
 
   ret = ceph_mkdirs(cmount, "foo/bar/baz",  0777);
   if (ret) {
     cerr << "ceph_mkdirs error: " << cpp_strerror(ret) << std::endl;
     return 1;
+  } else {
+    cout << "ceph_mkdirs: success" << std::endl;
   }
   ret = ceph_rmdir(cmount, "foo/bar/baz");
   if (ret) {
     cerr << "ceph_rmdir error: " << cpp_strerror(ret) << std::endl;
     return 1;
+  } else {
+    cout << "ceph_rmdir: success" << std::endl;
   }
   ret = ceph_rmdir(cmount, "foo/bar");
   if (ret) {
     cerr << "ceph_rmdir error: " << cpp_strerror(ret) << std::endl;
     return 1;
+  } else {
+    cout << "ceph_rmdir: success" << std::endl;
   }
   ret = ceph_rmdir(cmount, "foo");
   if (ret) {
     cerr << "ceph_rmdir error: " << cpp_strerror(ret) << std::endl;
     return 1;
+  } else {
+    cout << "ceph_rmdir: success" << std::endl;
+  }
+  ret = ceph_open(cmount, "barfile", O_CREAT, 0666);
+  if (ret < 0) {
+    cerr << "ceph_open O_CREAT error: " << cpp_strerror(ret) << std::endl;
+    return 1;
+  } else {
+    cout << "ceph_open: success" << std::endl;
+  }
+  ret = ceph_setxattr(cmount, "barfile", "user.testxattr", (void *) "AYBABTU", 7, XATTR_CREATE);
+  if (ret < 0) {
+    cerr << "ceph_setxattr error: " << cpp_strerror(ret) << std::endl;
+    return 1;
+  } else {
+    cout << "ceph_setxattr: success" << std::endl;
+  }
+  char *outlist;
+  outlist = (char *) malloc(256);
+  ret = ceph_listxattr(cmount, "barfile", outlist, 0);
+  free(outlist);
+  if (ret < 1) {
+    cerr << "ceph_listxattr error (a): should have returned > 0" << cpp_strerror(ret) << std::endl;
+    return 1;
+  } else {
+    cout << "ceph_listxattr: success" << std::endl;
+  }
+  
+  outlist = (char *) malloc(ret);
+  ret = ceph_listxattr(cmount, "barfile", outlist, ret);
+  if (ret < 1) {
+    cerr << "ceph_listxattr error (b): should have returned > 0" << cpp_strerror(ret) << std::endl;
+    return 1;
+  } else {
+    cout << "ceph_listxattr: success" << std::endl;
+  }
+  void *aybabtu;
+  aybabtu = malloc(8);
+  ret = ceph_getxattr(cmount, "barfile", "user.testxattr", aybabtu, 7);
+  if (ret < 1) {
+    cerr << "ceph_getxattr error: " << cpp_strerror(ret) << std::endl;
+    return 1;
+  } else {
+    cout << "ceph_getxattr: success" << std::endl;
+  }
+  char aybabtu_reference[]="AYBABTU";
+  if (strncmp((char *) aybabtu, aybabtu_reference,7)) {
+    cerr << "ceph_getxattr error: no match (" << aybabtu << ") should be (" << aybabtu_reference << cpp_strerror(ret) << std::endl;
   }
 
   ceph_shutdown(cmount);
-- 
1.7.1

