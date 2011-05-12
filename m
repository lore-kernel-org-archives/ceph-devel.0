From: Brian Chrisman <brchrisman@gmail.com>
Subject: [PATCH 2/2] updated test to cover "." directory stat
Date: Wed, 11 May 2011 22:26:47 -0700
Message-ID: <1305178007-2927-3-git-send-email-brchrisman@gmail.com>
References: <1305178007-2927-1-git-send-email-brchrisman@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59031 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab1ELF3J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2011 01:29:09 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so568133pwi.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2011 22:29:09 -0700 (PDT)
In-Reply-To: <1305178007-2927-1-git-send-email-brchrisman@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Brian Chrisman <brchrisman@gmail.com>


Signed-off-by: Brian Chrisman <brchrisman@gmail.com>
---
 src/client/testceph.cc |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/src/client/testceph.cc b/src/client/testceph.cc
index da4b7a2..520fa75 100644
--- a/src/client/testceph.cc
+++ b/src/client/testceph.cc
@@ -174,6 +174,23 @@ int main(int argc, const char **argv)
   if (strncmp((char *) aybabtu, aybabtu_reference,7)) {
     cerr << "ceph_getxattr error: no match (" << aybabtu << ") should be (" << aybabtu_reference << cpp_strerror(ret) << std::endl;
   }
+  cout << "Attempting lstat on '/.'" << std::endl;
+  ret = ceph_lstat(cmount, "/.", &stbuf);
+  if (ret) {
+    cerr << "ceph_lstat error: " << cpp_strerror(ret) << std::endl;
+    return 1;
+  } else {
+    cout << "ceph_lstat: success" << std::endl;
+  }
+  cout << "Attempting lstat on '.'" << std::endl;
+  ret = ceph_lstat(cmount, ".", &stbuf);
+  if (ret) {
+    cerr << "ceph_lstat error: " << cpp_strerror(ret) << std::endl;
+    return 1;
+  } else {
+    cout << "ceph_lstat: success" << std::endl;
+  }
+
 
   ceph_shutdown(cmount);
 
-- 
1.7.1

