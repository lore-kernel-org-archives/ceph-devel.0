From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 28/33] libceph: switch ceph_calc_pg_acting() to new helpers
Date: Thu, 27 Mar 2014 20:18:14 +0200
Message-ID: <1395944299-21970-29-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:46112 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154AbaC0ST3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:19:29 -0400
Received: by mail-ee0-f53.google.com with SMTP id b57so3199542eek.40
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:19:28 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id cb5sm5974674eeb.18.2014.03.27.11.19.27
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:19:28 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Switch ceph_calc_pg_acting() to new helpers: pg_to_raw_osds(),
raw_to_up_osds() and apply_temps().

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/osdmap.h |    2 +-
 net/ceph/osdmap.c           |   51 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 4e28c1e5d62f..b0c8f8490663 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -212,7 +212,7 @@ extern int ceph_oloc_oid_to_pg(struct ceph_osdmap *osdmap,
 
 extern int ceph_calc_pg_acting(struct ceph_osdmap *osdmap,
 			       struct ceph_pg pgid,
-			       int *acting);
+			       int *osds);
 extern int ceph_calc_pg_primary(struct ceph_osdmap *osdmap,
 				struct ceph_pg pgid);
 
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 6d418433d80d..1963623bd488 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1642,24 +1642,49 @@ static int apply_temps(struct ceph_osdmap *osdmap,
 }
 
 /*
- * Return acting set for given pgid.
+ * Calculate acting set for given pgid.
+ *
+ * Return acting set length, or error.
  */
 int ceph_calc_pg_acting(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
-			int *acting)
+			int *osds)
 {
-	int rawosds[CEPH_PG_MAX_SIZE], *osds;
-	int i, o, num = CEPH_PG_MAX_SIZE;
+	struct ceph_pg_pool_info *pool;
+	u32 pps;
+	int len;
+	int primary;
 
-	osds = calc_pg_raw(osdmap, pgid, rawosds, &num);
-	if (!osds)
-		return -1;
+	pool = __lookup_pg_pool(&osdmap->pg_pools, pgid.pool);
+	if (!pool)
+		return 0;
 
-	/* primary is first up osd */
-	o = 0;
-	for (i = 0; i < num; i++)
-		if (ceph_osd_is_up(osdmap, osds[i]))
-			acting[o++] = osds[i];
-	return o;
+	if (pool->flags & CEPH_POOL_FLAG_HASHPSPOOL) {
+		/* hash pool id and seed so that pool PGs do not overlap */
+		pps = crush_hash32_2(CRUSH_HASH_RJENKINS1,
+				     ceph_stable_mod(pgid.seed, pool->pgp_num,
+						     pool->pgp_num_mask),
+				     pgid.pool);
+	} else {
+		/*
+		 * legacy ehavior: add ps and pool together.  this is
+		 * not a great approach because the PGs from each pool
+		 * will overlap on top of each other: 0.5 == 1.4 ==
+		 * 2.3 == ...
+		 */
+		pps = ceph_stable_mod(pgid.seed, pool->pgp_num,
+				      pool->pgp_num_mask) +
+			(unsigned)pgid.pool;
+	}
+
+	len = pg_to_raw_osds(osdmap, pool, pgid, pps, osds);
+	if (len < 0)
+		return len;
+
+	len = raw_to_up_osds(osdmap, pool, osds, len, &primary);
+
+	len = apply_temps(osdmap, pool, pgid, osds, len, &primary);
+
+	return len;
 }
 
 /*
-- 
1.7.10.4

