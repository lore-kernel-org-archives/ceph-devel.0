From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 02/11] libceph: move ceph_file_layout helpers to ceph_fs.h
Date: Mon, 27 Jan 2014 17:58:44 +0200
Message-ID: <1390838333-32266-3-git-send-email-ilya.dryomov@inktank.com>
References: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:42364 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbaA0P76 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jan 2014 10:59:58 -0500
Received: by mail-lb0-f171.google.com with SMTP id c11so4559883lbj.2
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jan 2014 07:59:57 -0800 (PST)
In-Reply-To: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Move ceph_file_layout helper macros and inline functions to ceph_fs.h.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/ceph_fs.h |   23 +++++++++++++++++++++++
 include/linux/ceph/osdmap.h  |   27 ---------------------------
 2 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 0a37b989b52f..2623cffc73a1 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -53,6 +53,29 @@ struct ceph_file_layout {
 	__le32 fl_pg_pool;      /* namespace, crush ruleset, rep level */
 } __attribute__ ((packed));
 
+#define ceph_file_layout_su(l) ((__s32)le32_to_cpu((l).fl_stripe_unit))
+#define ceph_file_layout_stripe_count(l) \
+	((__s32)le32_to_cpu((l).fl_stripe_count))
+#define ceph_file_layout_object_size(l) ((__s32)le32_to_cpu((l).fl_object_size))
+#define ceph_file_layout_cas_hash(l) ((__s32)le32_to_cpu((l).fl_cas_hash))
+#define ceph_file_layout_object_su(l) \
+	((__s32)le32_to_cpu((l).fl_object_stripe_unit))
+#define ceph_file_layout_pg_pool(l) \
+	((__s32)le32_to_cpu((l).fl_pg_pool))
+
+static inline unsigned ceph_file_layout_stripe_width(struct ceph_file_layout *l)
+{
+	return le32_to_cpu(l->fl_stripe_unit) *
+		le32_to_cpu(l->fl_stripe_count);
+}
+
+/* "period" == bytes before i start on a new set of objects */
+static inline unsigned ceph_file_layout_period(struct ceph_file_layout *l)
+{
+	return le32_to_cpu(l->fl_object_size) *
+		le32_to_cpu(l->fl_stripe_count);
+}
+
 #define CEPH_MIN_STRIPE_UNIT 65536
 
 int ceph_file_layout_is_valid(const struct ceph_file_layout *layout);
diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 256134af4ad4..f2679c384625 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -72,33 +72,6 @@ struct ceph_osdmap {
 	struct crush_map *crush;
 };
 
-/*
- * file layout helpers
- */
-#define ceph_file_layout_su(l) ((__s32)le32_to_cpu((l).fl_stripe_unit))
-#define ceph_file_layout_stripe_count(l) \
-	((__s32)le32_to_cpu((l).fl_stripe_count))
-#define ceph_file_layout_object_size(l) ((__s32)le32_to_cpu((l).fl_object_size))
-#define ceph_file_layout_cas_hash(l) ((__s32)le32_to_cpu((l).fl_cas_hash))
-#define ceph_file_layout_object_su(l) \
-	((__s32)le32_to_cpu((l).fl_object_stripe_unit))
-#define ceph_file_layout_pg_pool(l) \
-	((__s32)le32_to_cpu((l).fl_pg_pool))
-
-static inline unsigned ceph_file_layout_stripe_width(struct ceph_file_layout *l)
-{
-	return le32_to_cpu(l->fl_stripe_unit) *
-		le32_to_cpu(l->fl_stripe_count);
-}
-
-/* "period" == bytes before i start on a new set of objects */
-static inline unsigned ceph_file_layout_period(struct ceph_file_layout *l)
-{
-	return le32_to_cpu(l->fl_object_size) *
-		le32_to_cpu(l->fl_stripe_count);
-}
-
-
 static inline int ceph_osd_is_up(struct ceph_osdmap *map, int osd)
 {
 	return (osd < map->max_osd) && (map->osd_state[osd] & CEPH_OSD_UP);
-- 
1.7.10.4

