From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] ceph: Fix memory leak in chain_flistxattr()
Date: Wed, 30 Oct 2013 16:44:08 +0800
Message-ID: <1383122648-19110-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:37666 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab3J3Iwh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Oct 2013 04:52:37 -0400
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
index 62733e3..d0a149c 100644
--- a/src/os/chain_xattr.cc
+++ b/src/os/chain_xattr.cc
@@ -401,7 +401,7 @@ int chain_flistxattr(int fd, char *names, size_t len) {
 
   r = sys_flistxattr(fd, full_buf, total_len);
   if (r < 0)
-    return r;
+    goto done;
 
   char *p = full_buf;
   const char *end = full_buf + r;
-- 
1.7.9.5

