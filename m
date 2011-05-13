From: Brian Chrisman <brchrisman@gmail.com>
Subject: [PATCH 2/2] add basic test case for readdir_r
Date: Thu, 12 May 2011 23:39:38 -0700
Message-ID: <1305268778-18691-3-git-send-email-brchrisman@gmail.com>
References: <1305268778-18691-1-git-send-email-brchrisman@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54628 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159Ab1EMGj5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 May 2011 02:39:57 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so1043834pzk.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 May 2011 23:39:57 -0700 (PDT)
In-Reply-To: <1305268778-18691-1-git-send-email-brchrisman@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Brian Chrisman <brchrisman@gmail.com>


Signed-off-by: Brian Chrisman <brchrisman@gmail.com>
---
 src/client/testceph.cc |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/src/client/testceph.cc b/src/client/testceph.cc
index 520fa75..c24cc03 100644
--- a/src/client/testceph.cc
+++ b/src/client/testceph.cc
@@ -17,6 +17,7 @@
 #include <stdlib.h>
 
 #include <errno.h>
+#include <dirent.h>
 #include <iostream>
 #include <fcntl.h>
 #include <sys/xattr.h>
@@ -190,8 +191,41 @@ int main(int argc, const char **argv)
   } else {
     cout << "ceph_lstat: success" << std::endl;
   }
+  cout << "Attempting readdir_r" << std::endl;
+  ret = ceph_mkdir(cmount, "readdir_r_test",  0777);
+  if (ret) {
+    cerr << "ceph_mkdir error: " << cpp_strerror(ret) << std::endl;
+    return 1;
+  } else {
+    cout << "ceph_mkdir: success" << std::endl;
+  }
+  struct ceph_dir_result *readdir_r_test_dir;
+  ret = ceph_opendir(cmount, "readdir_r_test", &readdir_r_test_dir);
+  if (ret != 0) {
+    cerr << "ceph_opendir error: unexpected result from trying to open readdir_r_test: "
+	 << cpp_strerror(ret) << std::endl;
+    return 1;
+  } else {
+    cout << "ceph_opendir: success" << std::endl;
+  }
+  ret = ceph_open(cmount, "readdir_r_test/opened_file", O_CREAT, 0666);
+  if (ret < 0) {
+    cerr << "ceph_open O_CREAT error: " << cpp_strerror(ret) << std::endl;
+    return 1;
+  } else {
+    cout << "ceph_open: success" << std::endl;
+  }
 
-
+  struct dirent * result;
+  result = (struct dirent *) malloc(sizeof(struct dirent));
+  ret = ceph_readdir_r(cmount, readdir_r_test_dir, result);
+  if (ret != 0) {
+    cerr << "ceph_readdir_r: fail, returned: " << ret << std::endl;
+  } else {
+    cerr << "ceph_readdir_r: success: " << *result->d_name << std::endl;
+    return 1;
+  }
+  
   ceph_shutdown(cmount);
 
   return 0;
-- 
1.7.1

