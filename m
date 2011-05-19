From: Brian Chrisman <brchrisman@gmail.com>
Subject: [PATCH 2/2] expanding testceph to test open/readdir/telldir
Date: Thu, 19 May 2011 13:22:33 -0700
Message-ID: <1305836553-393-3-git-send-email-brchrisman@gmail.com>
References: <1305836553-393-1-git-send-email-brchrisman@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59798 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934662Ab1ESUW6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2011 16:22:58 -0400
Received: by pvg12 with SMTP id 12so1349957pvg.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2011 13:22:58 -0700 (PDT)
In-Reply-To: <1305836553-393-1-git-send-email-brchrisman@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Brian Chrisman <brchrisman@gmail.com>


Signed-off-by: Brian Chrisman <brchrisman@gmail.com>
---
 src/client/testceph.cc |   88 +++++++++++++++++++++++++++++++++++++----------
 1 files changed, 69 insertions(+), 19 deletions(-)

diff --git a/src/client/testceph.cc b/src/client/testceph.cc
index c24cc03..413da10 100644
--- a/src/client/testceph.cc
+++ b/src/client/testceph.cc
@@ -30,6 +30,7 @@ int main(int argc, const char **argv)
 {
   struct ceph_mount_info *cmount;
     cout << "calling ceph_create..." << std::endl;
+  int my_fd;
   int ret = ceph_create(&cmount, NULL);
   if (ret) {
     cerr << "ceph_create failed with error: " << ret << std::endl;
@@ -67,7 +68,12 @@ int main(int argc, const char **argv)
   } else {
     cout << "ceph_opendir: success" << std::endl;
   }
-
+  //ret = ceph_closedir(cmount, foo_dir);
+  //if (ret == 0) {
+  //  cerr << "ceph_closedir success" << std::endl;
+  //} else {
+  //  cerr << "ceph_closedir error: " << cpp_strerror(ret) << std::endl;
+  //}
   ret = ceph_mkdir(cmount, "foo",  0777);
   if (ret) {
     cerr << "ceph_mkdir error: " << cpp_strerror(ret) << std::endl;
@@ -129,7 +135,7 @@ int main(int argc, const char **argv)
   } else {
     cout << "ceph_rmdir: success" << std::endl;
   }
-  ret = ceph_open(cmount, "barfile", O_CREAT, 0666);
+  my_fd = ret = ceph_open(cmount, "barfile", O_CREAT, 0666);
   if (ret < 0) {
     cerr << "ceph_open O_CREAT error: " << cpp_strerror(ret) << std::endl;
     return 1;
@@ -175,6 +181,15 @@ int main(int argc, const char **argv)
   if (strncmp((char *) aybabtu, aybabtu_reference,7)) {
     cerr << "ceph_getxattr error: no match (" << aybabtu << ") should be (" << aybabtu_reference << cpp_strerror(ret) << std::endl;
   }
+  ret = ceph_close(cmount,my_fd);
+  if (ret < 0) {
+    cerr << "ceph_close error: " << cpp_strerror(ret) << std::endl;
+    return 1;
+  } else {
+    cout << "ceph_close: success" << std::endl;
+  }
+
+
   cout << "Attempting lstat on '/.'" << std::endl;
   ret = ceph_lstat(cmount, "/.", &stbuf);
   if (ret) {
@@ -191,40 +206,75 @@ int main(int argc, const char **argv)
   } else {
     cout << "ceph_lstat: success" << std::endl;
   }
-  cout << "Attempting readdir_r" << std::endl;
-  ret = ceph_mkdir(cmount, "readdir_r_test",  0777);
+  cout << "Setting up readdir test" << std::endl;
+  ret = ceph_mkdir(cmount, "readdir_test",  0777);
   if (ret) {
     cerr << "ceph_mkdir error: " << cpp_strerror(ret) << std::endl;
     return 1;
   } else {
     cout << "ceph_mkdir: success" << std::endl;
   }
-  struct ceph_dir_result *readdir_r_test_dir;
-  ret = ceph_opendir(cmount, "readdir_r_test", &readdir_r_test_dir);
-  if (ret != 0) {
-    cerr << "ceph_opendir error: unexpected result from trying to open readdir_r_test: "
-	 << cpp_strerror(ret) << std::endl;
+  my_fd = ret = ceph_open(cmount, "readdir_test/opened_file_1", O_CREAT, 0666);
+  if (ret < 0) {
+    cerr << "ceph_open O_CREAT error: " << cpp_strerror(ret) << std::endl;
     return 1;
   } else {
-    cout << "ceph_opendir: success" << std::endl;
+    cout << "ceph_open: success" << std::endl;
   }
-  ret = ceph_open(cmount, "readdir_r_test/opened_file", O_CREAT, 0666);
+  ret = ceph_close(cmount, my_fd);
   if (ret < 0) {
-    cerr << "ceph_open O_CREAT error: " << cpp_strerror(ret) << std::endl;
+    cerr << "ceph_close error: " << cpp_strerror(ret) << std::endl;
     return 1;
   } else {
-    cout << "ceph_open: success" << std::endl;
+    cout << "ceph_close: success" << std::endl;
   }
 
-  struct dirent * result;
-  result = (struct dirent *) malloc(sizeof(struct dirent));
-  ret = ceph_readdir_r(cmount, readdir_r_test_dir, result);
+  struct ceph_dir_result *readdir_test_dir;
+  ret = ceph_opendir(cmount, "readdir_test", &readdir_test_dir);
   if (ret != 0) {
-    cerr << "ceph_readdir_r: fail, returned: " << ret << std::endl;
-  } else {
-    cerr << "ceph_readdir_r: success: " << *result->d_name << std::endl;
+    cerr << "ceph_opendir error: unexpected result from trying to open readdir_test: "
+	 << cpp_strerror(ret) << std::endl;
     return 1;
+  } else {
+    cout << "ceph_opendir: success" << std::endl;
   }
+  cout << "Attempting readdir on opened directory..." << std::endl;
+  struct dirent * result;
+  //result = (struct dirent *) malloc(sizeof(struct dirent));
+  result = ceph_readdir(cmount, readdir_test_dir);
+  if (result == (dirent *) NULL) {
+    cout << "ceph_readdir: failed to read any entries" << std::endl;
+  }
+  loff_t telldir_result;
+  while ( result != (dirent *) NULL) {
+    cout << "ceph_readdir: dirent->d_name: (" << result->d_name << ")" << std::endl;
+    cout << "ceph_telldir: starting" << std::endl;
+    telldir_result = ceph_telldir(cmount, readdir_test_dir);
+    if (telldir_result > -1) {
+      cout << "ceph_telldir: offset: from return code:" << telldir_result << std::endl;
+    } else {
+      cout << "ceph_telldir: failed" << std::endl;
+    }
+    cout << "ceph_readdir: lookup success: trying for another..." << std::endl;
+    result = ceph_readdir(cmount, readdir_test_dir);
+  }
+  cout << "ceph_readdir: finished" << std::endl;
+
+  // tell us that we're at the end of the directory:
+  cout << "ceph_telldir: starting" << std::endl;
+  telldir_result = ceph_telldir(cmount, readdir_test_dir);
+  if (telldir_result > -1) {
+    cout << "ceph_telldir: offset: from return code:" << telldir_result << std::endl;
+  } else {
+    cout << "ceph_telldir: failed" << std::endl;
+  }
+
+  //ret = ceph_closedir(cmount,readdir_test_dir);
+  //if (ret == 0) {
+  //  cerr << "ceph_closedir success" << std::endl;
+  //} else {
+  //  cerr << "ceph_closedir error: " << cpp_strerror(ret) << std::endl;
+  //}
   
   ceph_shutdown(cmount);
 
-- 
1.7.1

