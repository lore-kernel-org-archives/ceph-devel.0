From: Li Wang <liwang@ubuntukylin.com>
Subject: [RESEND PATCH] ceph: Fix memory leak in chain_listxattr
Date: Wed, 30 Oct 2013 16:39:09 +0800
Message-ID: <1383122349-18950-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:32940 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab3J3Irh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Oct 2013 04:47:37 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>

Free allocated memory before return

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/os/chain_xattr.cc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/os/chain_xattr.cc b/src/os/chain_xattr.cc
index 62733e3..52ae8db 100644
--- a/src/os/chain_xattr.cc
+++ b/src/os/chain_xattr.cc
@@ -355,7 +355,7 @@ int chain_listxattr(const char *fn, char *names, size_t len) {
 
   r = sys_listxattr(fn, full_buf, total_len);
   if (r < 0)
-    return r;
+    goto done;
 
   char *p = full_buf;
   const char *end = full_buf + r;
-- 
1.7.9.5

