From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/3] libceph: rename ceph_calc_object_layout()
Date: Mon, 04 Mar 2013 12:09:44 -0600
Message-ID: <5134E368.7040609@inktank.com>
References: <5134E25E.4030701@inktank.com> <5134E30E.2090400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:41006 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758049Ab3CDSJo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:09:44 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so5111663iaf.14
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 10:09:44 -0800 (PST)
In-Reply-To: <5134E30E.2090400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The purpose of ceph_calc_object_layout() is to fill in the pool
number and seed for a ceph_pg structure provided, based on a given
osd map and target object id.

Currently that function takes a file layout parameter, but the only
thing used out of that is its pool number.

Change the function so it takes a pool number rather than the full
file layout structure.  Only update the ceph_pg if the pool is found
in the osd map.  Get rid of few useless lines of code from the
function while there.

Since the function now very clearly just fills in the ceph_pg
structure it's provided, rename it ceph_calc_ceph_pg().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/ioctl.c             |    5 +++--
 include/linux/ceph/osdmap.h |    6 ++----
 net/ceph/osd_client.c       |    4 ++--
 net/ceph/osdmap.c           |   23 +++++++++--------------
 4 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 7d85991..6c74987 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -208,8 +208,9 @@ static long ceph_ioctl_get_dataloc(struct file
*file, void __user *arg)

 	snprintf(dl.object_name, sizeof(dl.object_name), "%llx.%08llx",
 		 ceph_ino(inode), dl.object_no);
-	ceph_calc_object_layout(&pgid, dl.object_name, &ci->i_layout,
-				osdc->osdmap);
+
+	ceph_calc_ceph_pg(&pgid, dl.object_name, osdc->osdmap,
+		ceph_file_layout_pg_pool(ci->i_layout));

 	dl.osd = ceph_calc_pg_primary(osdc->osdmap, pgid);
 	if (dl.osd >= 0) {
diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index c819190..167daf6 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -131,10 +131,8 @@ extern int ceph_calc_file_object_mapping(struct
ceph_file_layout *layout,
 					 u64 *bno, u64 *oxoff, u64 *oxlen);

 /* calculate mapping of object to a placement group */
-extern int ceph_calc_object_layout(struct ceph_pg *pg,
-				   const char *oid,
-				   struct ceph_file_layout *fl,
-				   struct ceph_osdmap *osdmap);
+extern int ceph_calc_ceph_pg(struct ceph_pg *pg, const char *oid,
+			  struct ceph_osdmap *osdmap, uint64_t pool);
 extern int ceph_calc_pg_acting(struct ceph_osdmap *osdmap,
 			       struct ceph_pg pgid,
 			       int *acting);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index d7ce457..38d09d1 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -948,8 +948,8 @@ static int __map_request(struct ceph_osd_client *osdc,
 	int err;

 	dout("map_request %p tid %lld\n", req, req->r_tid);
-	err = ceph_calc_object_layout(&pgid, req->r_oid,
-				      &req->r_file_layout, osdc->osdmap);
+	err = ceph_calc_ceph_pg(&pgid, req->r_oid, osdc->osdmap,
+				ceph_file_layout_pg_pool(req->r_file_layout));
 	if (err) {
 		list_move(&req->r_req_lru_item, &osdc->req_notarget);
 		return err;
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 69bc4bf..a47ee06 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1095,27 +1095,22 @@ EXPORT_SYMBOL(ceph_calc_file_object_mapping);
  * calculate an object layout (i.e. pgid) from an oid,
  * file_layout, and osdmap
  */
-int ceph_calc_object_layout(struct ceph_pg *pg,
-			    const char *oid,
-			    struct ceph_file_layout *fl,
-			    struct ceph_osdmap *osdmap)
+int ceph_calc_ceph_pg(struct ceph_pg *pg, const char *oid,
+			struct ceph_osdmap *osdmap, uint64_t pool)
 {
-	unsigned int num, num_mask;
-	struct ceph_pg_pool_info *pool;
+	struct ceph_pg_pool_info *pool_info;

 	BUG_ON(!osdmap);
-	pg->pool = le32_to_cpu(fl->fl_pg_pool);
-	pool = __lookup_pg_pool(&osdmap->pg_pools, pg->pool);
-	if (!pool)
+	pool_info = __lookup_pg_pool(&osdmap->pg_pools, pool);
+	if (!pool_info)
 		return -EIO;
-	pg->seed = ceph_str_hash(pool->object_hash, oid, strlen(oid));
-	num = pool->pg_num;
-	num_mask = pool->pg_num_mask;
+	pg->pool = pool;
+	pg->seed = ceph_str_hash(pool_info->object_hash, oid, strlen(oid));

-	dout("calc_object_layout '%s' pgid %lld.%x\n", oid, pg->pool, pg->seed);
+	dout("%s '%s' pgid %lld.%x\n", __func__, oid, pg->pool, pg->seed);
 	return 0;
 }
-EXPORT_SYMBOL(ceph_calc_object_layout);
+EXPORT_SYMBOL(ceph_calc_ceph_pg);

 /*
  * Calculate raw osd vector for the given pgid.  Return pointer to osd
-- 
1.7.9.5

