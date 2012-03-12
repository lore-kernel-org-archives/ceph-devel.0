From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 1/5] ceph: move file layout helpers to ceph_fs.h
Date: Mon, 12 Mar 2012 17:57:41 -0500
Message-ID: <4F5E7F65.1010006@dreamhost.com>
References: <4F5E7DA5.4040802@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44853 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757436Ab2CLW5i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Mar 2012 18:57:38 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id CB0A6243A2
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:58:12 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 9CABD2439E
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:58:12 -0700 (PDT)
In-Reply-To: <4F5E7DA5.4040802@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The helper macros for accessing fields from struct ceph_file_layout
(which is defined in "include/linux/ceph/ceph_fs.h") are defined
instead in "include/linux/ceph/osdmap.h".

Move them, so they are defined in the same place as the structure
they apply to.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  include/linux/ceph/ceph_fs.h |   29 +++++++++++++++++++++++++++++
  include/linux/ceph/osdmap.h  |   29 -----------------------------
  2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index b8c6069..62e3bb3 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -69,7 +69,36 @@ struct ceph_file_layout {
  	__le32 fl_pg_pool;      /* namespace, crush ruleset, rep level */
  } __attribute__ ((packed));

+/*
+ * file layout helpers
+ */
+
  #define CEPH_MIN_STRIPE_UNIT 65536
+#define ceph_file_layout_su(l) ((__s32)le32_to_cpu((l).fl_stripe_unit))
+#define ceph_file_layout_stripe_count(l) \
+	((__s32)le32_to_cpu((l).fl_stripe_count))
+#define ceph_file_layout_object_size(l) 
((__s32)le32_to_cpu((l).fl_object_size))
+#define ceph_file_layout_cas_hash(l) ((__s32)le32_to_cpu((l).fl_cas_hash))
+#define ceph_file_layout_object_su(l) \
+	((__s32)le32_to_cpu((l).fl_object_stripe_unit))
+#define ceph_file_layout_pg_preferred(l) \
+	((__s32)le32_to_cpu((l).fl_pg_preferred))
+#define ceph_file_layout_pg_pool(l) \
+	((__s32)le32_to_cpu((l).fl_pg_pool))
+
+static inline unsigned ceph_file_layout_stripe_width(struct 
ceph_file_layout *l)
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

  int ceph_file_layout_is_valid(const struct ceph_file_layout *layout);

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index ba4c205..fb588b7 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -55,35 +55,6 @@ struct ceph_osdmap {
  	struct crush_map *crush;
  };

-/*
- * file layout helpers
- */
-#define ceph_file_layout_su(l) ((__s32)le32_to_cpu((l).fl_stripe_unit))
-#define ceph_file_layout_stripe_count(l) \
-	((__s32)le32_to_cpu((l).fl_stripe_count))
-#define ceph_file_layout_object_size(l) 
((__s32)le32_to_cpu((l).fl_object_size))
-#define ceph_file_layout_cas_hash(l) ((__s32)le32_to_cpu((l).fl_cas_hash))
-#define ceph_file_layout_object_su(l) \
-	((__s32)le32_to_cpu((l).fl_object_stripe_unit))
-#define ceph_file_layout_pg_preferred(l) \
-	((__s32)le32_to_cpu((l).fl_pg_preferred))
-#define ceph_file_layout_pg_pool(l) \
-	((__s32)le32_to_cpu((l).fl_pg_pool))
-
-static inline unsigned ceph_file_layout_stripe_width(struct 
ceph_file_layout *l)
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
1.7.5.4

