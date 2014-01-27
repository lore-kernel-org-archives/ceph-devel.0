From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 04/11] libceph: introduce and start using oid abstraction
Date: Mon, 27 Jan 2014 17:58:46 +0200
Message-ID: <1390838333-32266-5-git-send-email-ilya.dryomov@inktank.com>
References: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35868 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbaA0QAD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jan 2014 11:00:03 -0500
Received: by mail-lb0-f175.google.com with SMTP id p9so4532110lbv.6
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jan 2014 08:00:00 -0800 (PST)
In-Reply-To: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

In preparation for tiering support, which would require having two
(base and target) object names for each osd request and also copying
those names around, introduce struct ceph_object_id (oid) and a couple
helpers to facilitate those copies and encapsulate the fact that object
name is not necessarily a NUL-terminated string.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c             |   10 ++--------
 include/linux/ceph/osd_client.h |    9 +--------
 include/linux/ceph/osdmap.h     |   36 ++++++++++++++++++++++++++++++++++++
 net/ceph/debugfs.c              |    3 ++-
 net/ceph/osd_client.c           |   17 +++++++++--------
 5 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 98792b2a7f65..6fdc5fc00447 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1809,10 +1809,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	osd_req->r_priv = obj_request;
 
 	osd_req->r_oloc.pool = ceph_file_layout_pg_pool(rbd_dev->layout);
-
-	osd_req->r_oid_len = strlen(obj_request->object_name);
-	rbd_assert(osd_req->r_oid_len < sizeof (osd_req->r_oid));
-	memcpy(osd_req->r_oid, obj_request->object_name, osd_req->r_oid_len);
+	ceph_oid_set_name(&osd_req->r_oid, obj_request->object_name);
 
 	return osd_req;
 }
@@ -1850,10 +1847,7 @@ rbd_osd_req_create_copyup(struct rbd_obj_request *obj_request)
 	osd_req->r_priv = obj_request;
 
 	osd_req->r_oloc.pool = ceph_file_layout_pg_pool(rbd_dev->layout);
-
-	osd_req->r_oid_len = strlen(obj_request->object_name);
-	rbd_assert(osd_req->r_oid_len < sizeof (osd_req->r_oid));
-	memcpy(osd_req->r_oid, obj_request->object_name, osd_req->r_oid_len);
+	ceph_oid_set_name(&osd_req->r_oid, obj_request->object_name);
 
 	return osd_req;
 }
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index b42f15848cae..8d8bb53994b1 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -12,12 +12,6 @@
 #include <linux/ceph/auth.h>
 #include <linux/ceph/pagelist.h>
 
-/* 
- * Maximum object name size 
- * (must be at least as big as RBD_MAX_MD_NAME_LEN -- currently 100) 
- */
-#define CEPH_MAX_OID_NAME_LEN 100
-
 struct ceph_msg;
 struct ceph_snap_context;
 struct ceph_osd_request;
@@ -160,9 +154,8 @@ struct ceph_osd_request {
 	void *r_priv;			      /* ditto */
 
 	struct ceph_object_locator r_oloc;
+	struct ceph_object_id r_oid;
 
-	char              r_oid[CEPH_MAX_OID_NAME_LEN];      /* object name */
-	int               r_oid_len;
 	u64               r_snapid;
 	unsigned long     r_stamp;            /* send OR check time */
 
diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index f2679c384625..c85f7d43b861 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -43,6 +43,18 @@ struct ceph_object_locator {
 	s64 pool;
 };
 
+/*
+ * Maximum supported by kernel client object name length
+ *
+ * (probably outdated: must be >= RBD_MAX_MD_NAME_LEN -- currently 100)
+ */
+#define CEPH_MAX_OID_NAME_LEN 100
+
+struct ceph_object_id {
+	char name[CEPH_MAX_OID_NAME_LEN];
+	int name_len;
+};
+
 struct ceph_pg_mapping {
 	struct rb_node node;
 	struct ceph_pg pgid;
@@ -72,6 +84,30 @@ struct ceph_osdmap {
 	struct crush_map *crush;
 };
 
+static inline void ceph_oid_set_name(struct ceph_object_id *oid,
+				     const char *name)
+{
+	int len;
+
+	len = strlen(name);
+	if (len > sizeof(oid->name)) {
+		WARN(1, "ceph_oid_set_name '%s' len %d vs %zu, truncating\n",
+		     name, len, sizeof(oid->name));
+		len = sizeof(oid->name);
+	}
+
+	memcpy(oid->name, name, len);
+	oid->name_len = len;
+}
+
+static inline void ceph_oid_copy(struct ceph_object_id *dest,
+				 struct ceph_object_id *src)
+{
+	BUG_ON(src->name_len > sizeof(dest->name));
+	memcpy(dest->name, src->name, src->name_len);
+	dest->name_len = src->name_len;
+}
+
 static inline int ceph_osd_is_up(struct ceph_osdmap *map, int osd)
 {
 	return (osd < map->max_osd) && (map->osd_state[osd] & CEPH_OSD_UP);
diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index 83661cdc0766..1f8562706393 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -132,7 +132,8 @@ static int osdc_show(struct seq_file *s, void *pp)
 			   req->r_osd ? req->r_osd->o_osd : -1,
 			   req->r_pgid.pool, req->r_pgid.seed);
 
-		seq_printf(s, "%.*s", req->r_oid_len, req->r_oid);
+		seq_printf(s, "%.*s", req->r_oid.name_len,
+			   req->r_oid.name);
 
 		if (req->r_reassert_version.epoch)
 			seq_printf(s, "\t%u'%llu",
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index a053e7e4a780..2988d68b24c6 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -765,9 +765,9 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 
 	req->r_oloc.pool = ceph_file_layout_pg_pool(*layout);
 
-	snprintf(req->r_oid, sizeof(req->r_oid), "%llx.%08llx",
-		vino.ino, objnum);
-	req->r_oid_len = strlen(req->r_oid);
+	snprintf(req->r_oid.name, sizeof(req->r_oid.name),
+		 "%llx.%08llx", vino.ino, objnum);
+	req->r_oid.name_len = strlen(req->r_oid.name);
 
 	return req;
 }
@@ -1269,7 +1269,7 @@ static int __map_request(struct ceph_osd_client *osdc,
 	bool was_paused;
 
 	dout("map_request %p tid %lld\n", req, req->r_tid);
-	err = ceph_calc_ceph_pg(&pgid, req->r_oid, osdc->osdmap,
+	err = ceph_calc_ceph_pg(&pgid, req->r_oid.name, osdc->osdmap,
 				req->r_oloc.pool);
 	if (err) {
 		list_move(&req->r_req_lru_item, &osdc->req_notarget);
@@ -2118,10 +2118,11 @@ void ceph_osdc_build_request(struct ceph_osd_request *req, u64 off,
 	ceph_encode_32(&p, -1);  /* preferred */
 
 	/* oid */
-	ceph_encode_32(&p, req->r_oid_len);
-	memcpy(p, req->r_oid, req->r_oid_len);
-	dout("oid '%.*s' len %d\n", req->r_oid_len, req->r_oid, req->r_oid_len);
-	p += req->r_oid_len;
+	ceph_encode_32(&p, req->r_oid.name_len);
+	memcpy(p, req->r_oid.name, req->r_oid.name_len);
+	dout("oid '%.*s' len %d\n", req->r_oid.name_len,
+	     req->r_oid.name, req->r_oid.name_len);
+	p += req->r_oid.name_len;
 
 	/* ops--can imply data */
 	ceph_encode_16(&p, (u16)req->r_num_ops);
-- 
1.7.10.4

