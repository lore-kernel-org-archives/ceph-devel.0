From: Guangliang Zhao <lucienchao@gmail.com>
Subject: [PATCH 1/3] ceph: make ceph_forget_all_cached_acls() static inline
Date: Fri, 14 Feb 2014 13:29:42 +0800
Message-ID: <1392355784-10422-2-git-send-email-lucienchao@gmail.com>
References: <1392355784-10422-1-git-send-email-lucienchao@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:34878 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbaBNF34 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Feb 2014 00:29:56 -0500
Received: by mail-pb0-f52.google.com with SMTP id jt11so11822814pbb.25
        for <ceph-devel@vger.kernel.org>; Thu, 13 Feb 2014 21:29:55 -0800 (PST)
In-Reply-To: <1392355784-10422-1-git-send-email-lucienchao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com

Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
---
 fs/ceph/acl.c   |    5 -----
 fs/ceph/super.h |    6 +++++-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 64fddbc..48af0b3 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -54,11 +54,6 @@ static inline struct posix_acl *ceph_get_cached_acl(struct inode *inode,
 	return acl;
 }
 
-void ceph_forget_all_cached_acls(struct inode *inode)
-{
-	forget_all_cached_acls(inode);
-}
-
 struct posix_acl *ceph_get_acl(struct inode *inode, int type)
 {
 	int size;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index c299f7d..8851dc2 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -13,6 +13,7 @@
 #include <linux/wait.h>
 #include <linux/writeback.h>
 #include <linux/slab.h>
+#include <linux/posix_acl.h>
 
 #include <linux/ceph/libceph.h>
 
@@ -745,7 +746,10 @@ extern const struct xattr_handler *ceph_xattr_handlers[];
 struct posix_acl *ceph_get_acl(struct inode *, int);
 int ceph_init_acl(struct dentry *, struct inode *, struct inode *);
 int ceph_acl_chmod(struct dentry *, struct inode *);
-void ceph_forget_all_cached_acls(struct inode *inode);
+static inline void ceph_forget_all_cached_acls(struct inode *inode)
+{
+	forget_all_cached_acls(inode);
+}
 
 #else
 
-- 
1.7.9.5

