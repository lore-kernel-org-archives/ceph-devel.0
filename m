From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ceph: fix non static symbol warning
Date: Mon, 17 Oct 2016 15:11:29 +0000
Message-ID: <1476717089-10359-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36453 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757006AbcJQPLi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Oct 2016 11:11:38 -0400
Received: by mail-pa0-f65.google.com with SMTP id os4so5258087pac.3
        for <ceph-devel@vger.kernel.org>; Mon, 17 Oct 2016 08:11:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, ceph-devel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warning:

fs/ceph/xattr.c:19:28: warning:
 symbol 'ceph_other_xattr_handler' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 fs/ceph/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 40b7032..febc28f 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -16,7 +16,7 @@
 static int __remove_xattr(struct ceph_inode_info *ci,
 			  struct ceph_inode_xattr *xattr);
 
-const struct xattr_handler ceph_other_xattr_handler;
+static const struct xattr_handler ceph_other_xattr_handler;
 
 /*
  * List of handlers for synthetic system.* attributes. Other
@@ -1086,7 +1086,7 @@ static int ceph_set_xattr_handler(const struct xattr_handler *handler,
 	return __ceph_setxattr(inode, name, value, size, flags);
 }
 
-const struct xattr_handler ceph_other_xattr_handler = {
+static const struct xattr_handler ceph_other_xattr_handler = {
 	.prefix = "",  /* match any name => handlers called with full name */
 	.get = ceph_get_xattr_handler,
 	.set = ceph_set_xattr_handler,



