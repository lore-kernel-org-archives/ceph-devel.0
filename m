From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH v2] Ceph: Fix memory leak in chain_flistxattr()
Date: Thu,  7 Nov 2013 10:44:30 +0800
Message-ID: <1383792270-24537-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:35868 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab3KGCow (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Nov 2013 21:44:52 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>

Free allocated memory before return.

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/os/chain_xattr.cc |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/src/os/chain_xattr.cc b/src/os/chain_xattr.cc
index 8ca8156..c020c9d 100644
--- a/src/os/chain_xattr.cc
+++ b/src/os/chain_xattr.cc
@@ -388,6 +388,10 @@ done:
 
 int chain_flistxattr(int fd, char *names, size_t len) {
   int r;
+  char *p;
+  const char * end;
+  char *dest;
+  char *dest_end;
 
   if (!len)
     return sys_flistxattr(fd, names, len) * 2;
@@ -403,12 +407,12 @@ int chain_flistxattr(int fd, char *names, size_t len) {
 
   r = sys_flistxattr(fd, full_buf, total_len);
   if (r < 0)
-    return r;
+    goto done;
 
-  char *p = full_buf;
-  const char *end = full_buf + r;
-  char *dest = names;
-  char *dest_end = names + len;
+  p = full_buf;
+  end = full_buf + r;
+  dest = names;
+  dest_end = names + len;
 
   while (p < end) {
     char name[CHAIN_XATTR_MAX_NAME_LEN * 2 + 16];
-- 
1.7.9.5

