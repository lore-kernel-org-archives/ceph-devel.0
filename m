From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 05/33] libceph: split osdmap allocation and decode steps
Date: Thu, 27 Mar 2014 20:17:51 +0200
Message-ID: <1395944299-21970-6-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:64523 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922AbaC0SSg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:18:36 -0400
Received: by mail-ee0-f50.google.com with SMTP id c13so3171801eek.23
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:18:35 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id m8sm5978521eeg.11.2014.03.27.11.18.34
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:18:34 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Split osdmap allocation and initialization into a separate function,
ceph_osdmap_decode().

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/osdmap.h |    2 +-
 net/ceph/osd_client.c       |    2 +-
 net/ceph/osdmap.c           |   44 ++++++++++++++++++++++++++++---------------
 3 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 8c8b3cefc28b..46c3e304c3d8 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -156,7 +156,7 @@ static inline int ceph_decode_pgid(void **p, void *end, struct ceph_pg *pgid)
 	return 0;
 }
 
-extern struct ceph_osdmap *osdmap_decode(void **p, void *end);
+extern struct ceph_osdmap *ceph_osdmap_decode(void **p, void *end);
 extern struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
 					    struct ceph_osdmap *map,
 					    struct ceph_messenger *msgr);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 71830d79b0f4..6f64eec18851 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2062,7 +2062,7 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 			int skipped_map = 0;
 
 			dout("taking full map %u len %d\n", epoch, maplen);
-			newmap = osdmap_decode(&p, p+maplen);
+			newmap = ceph_osdmap_decode(&p, p+maplen);
 			if (IS_ERR(newmap)) {
 				err = PTR_ERR(newmap);
 				goto bad;
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 4dd000d128fd..a82df6ea0749 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -684,9 +684,8 @@ static int osdmap_set_max_osd(struct ceph_osdmap *map, int max)
 /*
  * decode a full map.
  */
-struct ceph_osdmap *osdmap_decode(void **p, void *end)
+static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
 {
-	struct ceph_osdmap *map;
 	u16 version;
 	u32 len, max, i;
 	int err = -EINVAL;
@@ -694,14 +693,7 @@ struct ceph_osdmap *osdmap_decode(void **p, void *end)
 	void *start = *p;
 	struct ceph_pg_pool_info *pi;
 
-	dout("osdmap_decode %p to %p len %d\n", *p, end, (int)(end - *p));
-
-	map = kzalloc(sizeof(*map), GFP_NOFS);
-	if (map == NULL)
-		return ERR_PTR(-ENOMEM);
-
-	map->pg_temp = RB_ROOT;
-	mutex_init(&map->crush_scratch_mutex);
+	dout("%s %p to %p len %d\n", __func__, *p, end, (int)(end - *p));
 
 	ceph_decode_16_safe(p, end, version, bad);
 	if (version > 6) {
@@ -751,7 +743,6 @@ struct ceph_osdmap *osdmap_decode(void **p, void *end)
 	err = osdmap_set_max_osd(map, max);
 	if (err < 0)
 		goto bad;
-	dout("osdmap_decode max_osd = %d\n", map->max_osd);
 
 	/* osds */
 	err = -EINVAL;
@@ -819,7 +810,7 @@ struct ceph_osdmap *osdmap_decode(void **p, void *end)
 	*p = end;
 
 	dout("full osdmap epoch %d max_osd %d\n", map->epoch, map->max_osd);
-	return map;
+	return 0;
 
 bad:
 	pr_err("corrupt full osdmap (%d) epoch %d off %d (%p of %p-%p)\n",
@@ -827,8 +818,31 @@ bad:
 	print_hex_dump(KERN_DEBUG, "osdmap: ",
 		       DUMP_PREFIX_OFFSET, 16, 1,
 		       start, end - start, true);
-	ceph_osdmap_destroy(map);
-	return ERR_PTR(err);
+	return err;
+}
+
+/*
+ * Allocate and decode a full map.
+ */
+struct ceph_osdmap *ceph_osdmap_decode(void **p, void *end)
+{
+	struct ceph_osdmap *map;
+	int ret;
+
+	map = kzalloc(sizeof(*map), GFP_NOFS);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+
+	map->pg_temp = RB_ROOT;
+	mutex_init(&map->crush_scratch_mutex);
+
+	ret = osdmap_decode(p, end, map);
+	if (ret) {
+		ceph_osdmap_destroy(map);
+		return ERR_PTR(ret);
+	}
+
+	return map;
 }
 
 /*
@@ -872,7 +886,7 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
 	if (len > 0) {
 		dout("apply_incremental full map len %d, %p to %p\n",
 		     len, *p, end);
-		return osdmap_decode(p, min(*p+len, end));
+		return ceph_osdmap_decode(p, min(*p+len, end));
 	}
 
 	/* new crush? */
-- 
1.7.10.4

