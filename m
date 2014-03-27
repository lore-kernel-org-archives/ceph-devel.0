From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 29/33] libceph: return primary from ceph_calc_pg_acting()
Date: Thu, 27 Mar 2014 20:18:15 +0200
Message-ID: <1395944299-21970-30-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:42626 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757189AbaC0STc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:19:32 -0400
Received: by mail-ee0-f44.google.com with SMTP id e49so3216376eek.31
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:19:31 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id x45sm5980508eef.15.2014.03.27.11.19.30
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:19:30 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In preparation for adding support for primary_temp, stop assuming
primaryness: add a primary out parameter to ceph_calc_pg_acting() and
change call sites accordingly.  Primary is now specified separately
from the order of osds in the set.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/osdmap.h |    2 +-
 net/ceph/osd_client.c       |   10 ++++------
 net/ceph/osdmap.c           |   20 ++++++++++++--------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index b0c8f8490663..561ea896c657 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -212,7 +212,7 @@ extern int ceph_oloc_oid_to_pg(struct ceph_osdmap *osdmap,
 
 extern int ceph_calc_pg_acting(struct ceph_osdmap *osdmap,
 			       struct ceph_pg pgid,
-			       int *osds);
+			       int *osds, int *primary);
 extern int ceph_calc_pg_primary(struct ceph_osdmap *osdmap,
 				struct ceph_pg pgid);
 
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 6f64eec18851..b4157dc22199 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1333,7 +1333,7 @@ static int __map_request(struct ceph_osd_client *osdc,
 {
 	struct ceph_pg pgid;
 	int acting[CEPH_PG_MAX_SIZE];
-	int o = -1, num = 0;
+	int num, o;
 	int err;
 	bool was_paused;
 
@@ -1346,11 +1346,9 @@ static int __map_request(struct ceph_osd_client *osdc,
 	}
 	req->r_pgid = pgid;
 
-	err = ceph_calc_pg_acting(osdc->osdmap, pgid, acting);
-	if (err > 0) {
-		o = acting[0];
-		num = err;
-	}
+	num = ceph_calc_pg_acting(osdc->osdmap, pgid, acting, &o);
+	if (num < 0)
+		num = 0;
 
 	was_paused = req->r_paused;
 	req->r_paused = __req_should_be_paused(osdc, req);
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 1963623bd488..7193b012ee02 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1644,19 +1644,21 @@ static int apply_temps(struct ceph_osdmap *osdmap,
 /*
  * Calculate acting set for given pgid.
  *
- * Return acting set length, or error.
+ * Return acting set length, or error.  *primary is set to acting
+ * primary osd id, or -1 if acting set is empty or on error.
  */
 int ceph_calc_pg_acting(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
-			int *osds)
+			int *osds, int *primary)
 {
 	struct ceph_pg_pool_info *pool;
 	u32 pps;
 	int len;
-	int primary;
 
 	pool = __lookup_pg_pool(&osdmap->pg_pools, pgid.pool);
-	if (!pool)
-		return 0;
+	if (!pool) {
+		*primary = -1;
+		return -ENOENT;
+	}
 
 	if (pool->flags & CEPH_POOL_FLAG_HASHPSPOOL) {
 		/* hash pool id and seed so that pool PGs do not overlap */
@@ -1677,12 +1679,14 @@ int ceph_calc_pg_acting(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
 	}
 
 	len = pg_to_raw_osds(osdmap, pool, pgid, pps, osds);
-	if (len < 0)
+	if (len < 0) {
+		*primary = -1;
 		return len;
+	}
 
-	len = raw_to_up_osds(osdmap, pool, osds, len, &primary);
+	len = raw_to_up_osds(osdmap, pool, osds, len, primary);
 
-	len = apply_temps(osdmap, pool, pgid, osds, len, &primary);
+	len = apply_temps(osdmap, pool, pgid, osds, len, primary);
 
 	return len;
 }
-- 
1.7.10.4

