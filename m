From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Subject: [PATCH] fs/ceph: delete unused ceph_file_layout_is_valid function
Date: Mon, 11 Dec 2017 20:56:41 -0500
Message-ID: <1513043801-9164-1-git-send-email-baiyaowei@cmss.chinamobile.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, baiyaowei@cmss.chinamobile.com
List-Id: ceph-devel.vger.kernel.org

There's no users of ceph_file_layout_is_valid, remove it.

Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
---
 include/linux/ceph/ceph_fs.h |  1 -
 net/ceph/ceph_fs.c           | 23 -----------------------
 2 files changed, 24 deletions(-)

diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 88dd513..4b63e7b 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -67,7 +67,6 @@ struct ceph_file_layout {
 	struct ceph_string __rcu *pool_ns; /* rados pool namespace */
 };
 
-extern int ceph_file_layout_is_valid(const struct ceph_file_layout *layout);
 extern void ceph_file_layout_from_legacy(struct ceph_file_layout *fl,
 				struct ceph_file_layout_legacy *legacy);
 extern void ceph_file_layout_to_legacy(struct ceph_file_layout *fl,
diff --git a/net/ceph/ceph_fs.c b/net/ceph/ceph_fs.c
index 756a2dc..020ae9f6 100644
--- a/net/ceph/ceph_fs.c
+++ b/net/ceph/ceph_fs.c
@@ -5,29 +5,6 @@
 #include <linux/module.h>
 #include <linux/ceph/types.h>
 
-/*
- * return true if @layout appears to be valid
- */
-int ceph_file_layout_is_valid(const struct ceph_file_layout *layout)
-{
-	__u32 su = layout->stripe_unit;
-	__u32 sc = layout->stripe_count;
-	__u32 os = layout->object_size;
-
-	/* stripe unit, object size must be non-zero, 64k increment */
-	if (!su || (su & (CEPH_MIN_STRIPE_UNIT-1)))
-		return 0;
-	if (!os || (os & (CEPH_MIN_STRIPE_UNIT-1)))
-		return 0;
-	/* object size must be a multiple of stripe unit */
-	if (os < su || os % su)
-		return 0;
-	/* stripe count must be non-zero */
-	if (!sc)
-		return 0;
-	return 1;
-}
-
 void ceph_file_layout_from_legacy(struct ceph_file_layout *fl,
 				  struct ceph_file_layout_legacy *legacy)
 {
-- 
1.8.3.1
