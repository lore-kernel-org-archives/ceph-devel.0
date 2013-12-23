From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 05/19] crush: eliminate CRUSH_MAX_SET result size limitation
Date: Mon, 23 Dec 2013 19:09:36 +0200
Message-ID: <1387818590-30483-6-git-send-email-ilya.dryomov@inktank.com>
References: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:56370 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab3LWRKu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 12:10:50 -0500
Received: by mail-ea0-f177.google.com with SMTP id n15so2478995ead.36
        for <ceph-devel@vger.kernel.org>; Mon, 23 Dec 2013 09:10:49 -0800 (PST)
In-Reply-To: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

This is only present to size the temporary scratch arrays that we put on
the stack.  Let the caller allocate them as they wish and remove the
limitation.

Reflects ceph.git commit 1cfe140bf2dab99517589a82a916f4c75b9492d1.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/crush/crush.h  |    1 -
 include/linux/crush/mapper.h |    3 ++-
 net/ceph/crush/mapper.c      |   10 ++++++----
 net/ceph/osdmap.c            |   16 +++++++++++++---
 4 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 09561a04c127..83543c504b5a 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -21,7 +21,6 @@
 
 
 #define CRUSH_MAX_DEPTH 10  /* max crush hierarchy depth */
-#define CRUSH_MAX_SET   10  /* max size of a mapping result */
 
 
 /*
diff --git a/include/linux/crush/mapper.h b/include/linux/crush/mapper.h
index 69310b031875..eab367446eea 100644
--- a/include/linux/crush/mapper.h
+++ b/include/linux/crush/mapper.h
@@ -14,6 +14,7 @@ extern int crush_find_rule(const struct crush_map *map, int ruleset, int type, i
 extern int crush_do_rule(const struct crush_map *map,
 			 int ruleno,
 			 int x, int *result, int result_max,
-			 const __u32 *weights, int weight_max);
+			 const __u32 *weights, int weight_max,
+			 int *scratch);
 
 #endif
diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 82cab7d3e89d..dcf48bc504ea 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -478,15 +478,17 @@ reject:
  * @result_max: maximum result size
  * @weight: weight vector (for map leaves)
  * @weight_max: size of weight vector
+ * @scratch: scratch vector for private use; must be >= 3 * result_max
  */
 int crush_do_rule(const struct crush_map *map,
 		  int ruleno, int x, int *result, int result_max,
-		  const __u32 *weight, int weight_max)
+		  const __u32 *weight, int weight_max,
+		  int *scratch)
 {
 	int result_len;
-	int a[CRUSH_MAX_SET];
-	int b[CRUSH_MAX_SET];
-	int c[CRUSH_MAX_SET];
+	int *a = scratch;
+	int *b = scratch + result_max;
+	int *c = scratch + result_max*2;
 	int recurse_to_leaf;
 	int *w;
 	int wsize = 0;
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 6477a68ddecb..8b1a6b48bb5d 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1110,6 +1110,16 @@ int ceph_calc_ceph_pg(struct ceph_pg *pg, const char *oid,
 }
 EXPORT_SYMBOL(ceph_calc_ceph_pg);
 
+static int crush_do_rule_ary(const struct crush_map *map, int ruleno, int x,
+			     int *result, int result_max,
+			     const __u32 *weight, int weight_max)
+{
+	int scratch[result_max * 3];
+
+	return crush_do_rule(map, ruleno, x, result, result_max,
+			     weight, weight_max, scratch);
+}
+
 /*
  * Calculate raw osd vector for the given pgid.  Return pointer to osd
  * array, or NULL on failure.
@@ -1163,9 +1173,9 @@ static int *calc_pg_raw(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
 				      pool->pgp_num_mask) +
 			(unsigned)pgid.pool;
 	}
-	r = crush_do_rule(osdmap->crush, ruleno, pps, osds,
-			  min_t(int, pool->size, *num),
-			  osdmap->osd_weight, osdmap->max_osd);
+	r = crush_do_rule_ary(osdmap->crush, ruleno, pps,
+			      osds, min_t(int, pool->size, *num),
+			      osdmap->osd_weight, osdmap->max_osd);
 	if (r < 0) {
 		pr_err("error %d from crush rule: pool %lld ruleset %d type %d"
 		       " size %d\n", r, pgid.pool, pool->crush_ruleset,
-- 
1.7.10.4

