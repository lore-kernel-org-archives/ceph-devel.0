From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 05/11] libceph: replace ceph_calc_ceph_pg() with ceph_oloc_oid_to_pg()
Date: Mon, 27 Jan 2014 17:58:47 +0200
Message-ID: <1390838333-32266-6-git-send-email-ilya.dryomov@inktank.com>
References: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:50585 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828AbaA0QAD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jan 2014 11:00:03 -0500
Received: by mail-la0-f42.google.com with SMTP id hr13so4697211lab.1
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jan 2014 08:00:02 -0800 (PST)
In-Reply-To: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Switch ceph_calc_ceph_pg() to new oloc and oid abstractions and rename
it to ceph_oloc_oid_to_pg() to make its purpose more clear.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 fs/ceph/ioctl.c             |    8 ++++++--
 include/linux/ceph/osdmap.h |    7 +++++--
 net/ceph/osd_client.c       |    4 ++--
 net/ceph/osdmap.c           |   29 +++++++++++++++++------------
 4 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 669622fd1ae3..dc66c9e023e4 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -183,6 +183,8 @@ static long ceph_ioctl_get_dataloc(struct file *file, void __user *arg)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_osd_client *osdc =
 		&ceph_sb_to_client(inode->i_sb)->client->osdc;
+	struct ceph_object_locator oloc;
+	struct ceph_object_id oid;
 	u64 len = 1, olen;
 	u64 tmp;
 	struct ceph_pg pgid;
@@ -211,8 +213,10 @@ static long ceph_ioctl_get_dataloc(struct file *file, void __user *arg)
 	snprintf(dl.object_name, sizeof(dl.object_name), "%llx.%08llx",
 		 ceph_ino(inode), dl.object_no);
 
-	r = ceph_calc_ceph_pg(&pgid, dl.object_name, osdc->osdmap,
-				ceph_file_layout_pg_pool(ci->i_layout));
+	oloc.pool = ceph_file_layout_pg_pool(ci->i_layout);
+	ceph_oid_set_name(&oid, dl.object_name);
+
+	r = ceph_oloc_oid_to_pg(osdc->osdmap, &oloc, &oid, &pgid);
 	if (r < 0) {
 		up_read(&osdc->map_sem);
 		return r;
diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index c85f7d43b861..ebb8ec285de6 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -163,8 +163,11 @@ extern int ceph_calc_file_object_mapping(struct ceph_file_layout *layout,
 					 u64 *bno, u64 *oxoff, u64 *oxlen);
 
 /* calculate mapping of object to a placement group */
-extern int ceph_calc_ceph_pg(struct ceph_pg *pg, const char *oid,
-			  struct ceph_osdmap *osdmap, uint64_t pool);
+extern int ceph_oloc_oid_to_pg(struct ceph_osdmap *osdmap,
+			       struct ceph_object_locator *oloc,
+			       struct ceph_object_id *oid,
+			       struct ceph_pg *pg_out);
+
 extern int ceph_calc_pg_acting(struct ceph_osdmap *osdmap,
 			       struct ceph_pg pgid,
 			       int *acting);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2988d68b24c6..10360dedcdad 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1269,8 +1269,8 @@ static int __map_request(struct ceph_osd_client *osdc,
 	bool was_paused;
 
 	dout("map_request %p tid %lld\n", req, req->r_tid);
-	err = ceph_calc_ceph_pg(&pgid, req->r_oid.name, osdc->osdmap,
-				req->r_oloc.pool);
+	err = ceph_oloc_oid_to_pg(osdc->osdmap, &req->r_oloc, &req->r_oid,
+				  &pgid);
 	if (err) {
 		list_move(&req->r_req_lru_item, &osdc->req_notarget);
 		return err;
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 8b1a6b48bb5d..768dd04eb9b1 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1090,25 +1090,30 @@ invalid:
 EXPORT_SYMBOL(ceph_calc_file_object_mapping);
 
 /*
- * calculate an object layout (i.e. pgid) from an oid,
- * file_layout, and osdmap
+ * Calculate mapping of a (oloc, oid) pair to a PG.  Should only be
+ * called with target's (oloc, oid), since tiering isn't taken into
+ * account.
  */
-int ceph_calc_ceph_pg(struct ceph_pg *pg, const char *oid,
-			struct ceph_osdmap *osdmap, uint64_t pool)
+int ceph_oloc_oid_to_pg(struct ceph_osdmap *osdmap,
+			struct ceph_object_locator *oloc,
+			struct ceph_object_id *oid,
+			struct ceph_pg *pg_out)
 {
-	struct ceph_pg_pool_info *pool_info;
+	struct ceph_pg_pool_info *pi;
 
-	BUG_ON(!osdmap);
-	pool_info = __lookup_pg_pool(&osdmap->pg_pools, pool);
-	if (!pool_info)
+	pi = __lookup_pg_pool(&osdmap->pg_pools, oloc->pool);
+	if (!pi)
 		return -EIO;
-	pg->pool = pool;
-	pg->seed = ceph_str_hash(pool_info->object_hash, oid, strlen(oid));
 
-	dout("%s '%s' pgid %lld.%x\n", __func__, oid, pg->pool, pg->seed);
+	pg_out->pool = oloc->pool;
+	pg_out->seed = ceph_str_hash(pi->object_hash, oid->name,
+				     oid->name_len);
+
+	dout("%s '%.*s' pgid %llu.%x\n", __func__, oid->name_len, oid->name,
+	     pg_out->pool, pg_out->seed);
 	return 0;
 }
-EXPORT_SYMBOL(ceph_calc_ceph_pg);
+EXPORT_SYMBOL(ceph_oloc_oid_to_pg);
 
 static int crush_do_rule_ary(const struct crush_map *map, int ruleno, int x,
 			     int *result, int result_max,
-- 
1.7.10.4

