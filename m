From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] ceph: Fix memory leak in chain_listxattr()
Date: Wed, 30 Oct 2013 16:33:13 +0800
Message-ID: <1383121993-18876-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:56349 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401Ab3J3IdV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Oct 2013 04:33:21 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>

Free allocated memory before return

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/os/chain_xattr.cc |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/os/chain_xattr.cc b/src/os/chain_xattr.cc
index 62733e3..0859564 100644
--- a/src/os/chain_xattr.cc
+++ b/src/os/chain_xattr.cc
@@ -354,8 +354,10 @@ int chain_listxattr(const char *fn, char *names, size_t len) {
     return -ENOMEM;
 
   r = sys_listxattr(fn, full_buf, total_len);
-  if (r < 0)
+  if (r < 0) {
+    goto done;
     return r;
+  }
 
   char *p = full_buf;
   const char *end = full_buf + r;
-- 
1.7.9.5

