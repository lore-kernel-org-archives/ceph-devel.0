From: Alex Elder <elder@inktank.com>
Subject: [PATCH 8/9] rbd: fix ceph_pg_poolid_by_name()
Date: Thu, 13 Dec 2012 11:02:54 -0600
Message-ID: <50CA0A3E.7040501@inktank.com>
References: <50CA0915.1090801@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:35688 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539Ab2LMRIq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 12:08:46 -0500
Received: by mail-ia0-f180.google.com with SMTP id t4so2158239iag.11
        for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 09:08:46 -0800 (PST)
In-Reply-To: <50CA0915.1090801@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently ceph_pg_poolid_by_name() returns an int, which is used to
encode a ceph pool id.  This could be a problem because a pool id
(at least in some cases) is a 64-bit value.  We have a defined pool
id value that represents "no pool," and that's a very sensible
return value here.

This patch changes ceph_pg_poolid_by_name() to return a 64-bit
pool id value, or CEPH_NOPOOL if the named pool is not found.

The patch also gratuitously renames the function, separating "pool"
from "id" in the name by an underscore.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c         |    6 +++---
 include/linux/ceph/osdmap.h |    2 +-
 net/ceph/osdmap.c           |   14 ++++++++------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4daa400..706824b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3642,11 +3642,11 @@ static ssize_t rbd_add(struct bus_type *bus,
 	ceph_opts = NULL;	/* rbd_dev client now owns this */

 	/* pick the pool */
+	rc = -ENOENT;
 	osdc = &rbdc->client->osdc;
-	rc = ceph_pg_poolid_by_name(osdc->osdmap, spec->pool_name);
-	if (rc < 0)
+	spec->pool_id = ceph_pg_pool_id_by_name(osdc->osdmap, spec->pool_name);
+	if (spec->pool_id == CEPH_NOPOOL)
 		goto err_out_client;
-	spec->pool_id = (u64) rc;

 	rbd_dev = rbd_dev_create(rbdc, spec);
 	if (!rbd_dev)
diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 5ea57ba..c841396 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -124,6 +124,6 @@ extern int ceph_calc_pg_primary(struct ceph_osdmap
*osdmap,
 				struct ceph_pg pgid);

 extern const char *ceph_pg_pool_name_by_id(struct ceph_osdmap *map, u64
id);
-extern int ceph_pg_poolid_by_name(struct ceph_osdmap *map, const char
*name);
+extern __u64 ceph_pg_pool_id_by_name(struct ceph_osdmap *map, const
char *name);

 #endif
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index de73214..27e904e 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -485,19 +485,21 @@ const char *ceph_pg_pool_name_by_id(struct
ceph_osdmap *map, u64 id)
 }
 EXPORT_SYMBOL(ceph_pg_pool_name_by_id);

-int ceph_pg_poolid_by_name(struct ceph_osdmap *map, const char *name)
+__u64 ceph_pg_pool_id_by_name(struct ceph_osdmap *map, const char *name)
 {
 	struct rb_node *rbp;

 	for (rbp = rb_first(&map->pg_pools); rbp; rbp = rb_next(rbp)) {
-		struct ceph_pg_pool_info *pi =
-			rb_entry(rbp, struct ceph_pg_pool_info, node);
+		struct ceph_pg_pool_info *pi;
+
+		pi = rb_entry(rbp, struct ceph_pg_pool_info, node);
 		if (pi->name && strcmp(pi->name, name) == 0)
-			return pi->id;
+			return (__u64) pi->id;
 	}
-	return -ENOENT;
+
+	return CEPH_NOPOOL;
 }
-EXPORT_SYMBOL(ceph_pg_poolid_by_name);
+EXPORT_SYMBOL(ceph_pg_pool_id_by_name);

 static void __remove_pg_pool(struct rb_root *root, struct
ceph_pg_pool_info *pi)
 {
-- 
1.7.9.5

