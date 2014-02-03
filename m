From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 2/4] libceph: a per-osdc crush scratch buffer
Date: Mon,  3 Feb 2014 15:47:06 +0200
Message-ID: <1391435228-27874-3-git-send-email-ilya.dryomov@inktank.com>
References: <1391435228-27874-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:61106 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbaBCNrS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Feb 2014 08:47:18 -0500
Received: by mail-we0-f173.google.com with SMTP id x55so2237999wes.32
        for <ceph-devel@vger.kernel.org>; Mon, 03 Feb 2014 05:47:17 -0800 (PST)
Received: from localhost ([109.110.66.110])
        by mx.google.com with ESMTPSA id k10sm44014045wjf.11.2014.02.03.05.47.14
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 05:47:15 -0800 (PST)
In-Reply-To: <1391435228-27874-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

With the addition of erasure coding support in the future, scratch
variable-length array in crush_do_rule_ary() is going to grow to at
least 200 bytes on average, on top of another 128 bytes consumed by
rawosd/osd arrays in the call chain.  Replace it with a buffer inside
struct osdmap and a mutex.  This shouldn't result in any contention,
because all osd requests were already serialized by request_mutex at
that point; the only unlocked caller was ceph_ioctl_get_dataloc().

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/osdmap.h |    3 +++
 net/ceph/osdmap.c           |   25 ++++++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 49ff69f0746b..8c8b3cefc28b 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -84,6 +84,9 @@ struct ceph_osdmap {
 	/* the CRUSH map specifies the mapping of placement groups to
 	 * the list of osds that store+replicate them. */
 	struct crush_map *crush;
+
+	struct mutex crush_scratch_mutex;
+	int crush_scratch_ary[CEPH_PG_MAX_SIZE * 3];
 };
 
 static inline void ceph_oid_set_name(struct ceph_object_id *oid,
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index aade4a5c1c07..9d1aaa24def6 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -698,7 +698,9 @@ struct ceph_osdmap *osdmap_decode(void **p, void *end)
 	map = kzalloc(sizeof(*map), GFP_NOFS);
 	if (map == NULL)
 		return ERR_PTR(-ENOMEM);
+
 	map->pg_temp = RB_ROOT;
+	mutex_init(&map->crush_scratch_mutex);
 
 	ceph_decode_16_safe(p, end, version, bad);
 	if (version > 6) {
@@ -1142,14 +1144,20 @@ int ceph_oloc_oid_to_pg(struct ceph_osdmap *osdmap,
 }
 EXPORT_SYMBOL(ceph_oloc_oid_to_pg);
 
-static int crush_do_rule_ary(const struct crush_map *map, int ruleno, int x,
-			     int *result, int result_max,
-			     const __u32 *weight, int weight_max)
+static int do_crush(struct ceph_osdmap *map, int ruleno, int x,
+		    int *result, int result_max,
+		    const __u32 *weight, int weight_max)
 {
-	int scratch[result_max * 3];
+	int r;
+
+	BUG_ON(result_max > CEPH_PG_MAX_SIZE);
+
+	mutex_lock(&map->crush_scratch_mutex);
+	r = crush_do_rule(map->crush, ruleno, x, result, result_max,
+			  weight, weight_max, map->crush_scratch_ary);
+	mutex_unlock(&map->crush_scratch_mutex);
 
-	return crush_do_rule(map, ruleno, x, result, result_max,
-			     weight, weight_max, scratch);
+	return r;
 }
 
 /*
@@ -1205,9 +1213,8 @@ static int *calc_pg_raw(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
 				      pool->pgp_num_mask) +
 			(unsigned)pgid.pool;
 	}
-	r = crush_do_rule_ary(osdmap->crush, ruleno, pps,
-			      osds, min_t(int, pool->size, *num),
-			      osdmap->osd_weight, osdmap->max_osd);
+	r = do_crush(osdmap, ruleno, pps, osds, min_t(int, pool->size, *num),
+		     osdmap->osd_weight, osdmap->max_osd);
 	if (r < 0) {
 		pr_err("error %d from crush rule: pool %lld ruleset %d type %d"
 		       " size %d\n", r, pgid.pool, pool->crush_ruleset,
-- 
1.7.10.4

