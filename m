From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 01/19] crush: pass weight vector size to map function
Date: Mon, 23 Dec 2013 19:09:32 +0200
Message-ID: <1387818590-30483-2-git-send-email-ilya.dryomov@inktank.com>
References: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:39520 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab3LWRKm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 12:10:42 -0500
Received: by mail-ea0-f178.google.com with SMTP id d10so2435223eaj.37
        for <ceph-devel@vger.kernel.org>; Mon, 23 Dec 2013 09:10:41 -0800 (PST)
In-Reply-To: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

Pass the size of the weight vector into crush_do_rule() to ensure that we
don't access values past the end.  This can happen if the caller misbehaves
and passes a weight vector that is smaller than max_devices.

Currently the monitor tries to prevent that from happening, but this will
gracefully tolerate previous bad osdmaps that got into this state.  It's
also a bit more defensive.

Reflects ceph.git commit 5922e2c2b8335b5e46c9504349c3a55b7434c01a.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/crush/mapper.h |    2 +-
 net/ceph/crush/mapper.c      |   17 ++++++++++++-----
 net/ceph/osdmap.c            |    2 +-
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/crush/mapper.h b/include/linux/crush/mapper.h
index 5772dee3ecbf..69310b031875 100644
--- a/include/linux/crush/mapper.h
+++ b/include/linux/crush/mapper.h
@@ -14,6 +14,6 @@ extern int crush_find_rule(const struct crush_map *map, int ruleset, int type, i
 extern int crush_do_rule(const struct crush_map *map,
 			 int ruleno,
 			 int x, int *result, int result_max,
-			 const __u32 *weights);
+			 const __u32 *weights, int weight_max);
 
 #endif
diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index cbd06a91941c..18d2cf66f102 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -264,8 +264,12 @@ static int crush_bucket_choose(struct crush_bucket *in, int x, int r)
  * true if device is marked "out" (failed, fully offloaded)
  * of the cluster
  */
-static int is_out(const struct crush_map *map, const __u32 *weight, int item, int x)
+static int is_out(const struct crush_map *map,
+		  const __u32 *weight, int weight_max,
+		  int item, int x)
 {
+	if (item >= weight_max)
+		return 1;
 	if (weight[item] >= 0x10000)
 		return 0;
 	if (weight[item] == 0)
@@ -292,7 +296,7 @@ static int is_out(const struct crush_map *map, const __u32 *weight, int item, in
  */
 static int crush_choose(const struct crush_map *map,
 			struct crush_bucket *bucket,
-			const __u32 *weight,
+			const __u32 *weight, int weight_max,
 			int x, int numrep, int type,
 			int *out, int outpos,
 			int firstn, int recurse_to_leaf,
@@ -396,7 +400,7 @@ static int crush_choose(const struct crush_map *map,
 					if (item < 0) {
 						if (crush_choose(map,
 							 map->buckets[-1-item],
-							 weight,
+							 weight, weight_max,
 							 x, outpos+1, 0,
 							 out2, outpos,
 							 firstn, 0,
@@ -414,6 +418,7 @@ static int crush_choose(const struct crush_map *map,
 					/* out? */
 					if (itemtype == 0)
 						reject = is_out(map, weight,
+								weight_max,
 								item, x);
 					else
 						reject = 0;
@@ -470,10 +475,12 @@ reject:
  * @x: hash input
  * @result: pointer to result vector
  * @result_max: maximum result size
+ * @weight: weight vector (for map leaves)
+ * @weight_max: size of weight vector
  */
 int crush_do_rule(const struct crush_map *map,
 		  int ruleno, int x, int *result, int result_max,
-		  const __u32 *weight)
+		  const __u32 *weight, int weight_max)
 {
 	int result_len;
 	int a[CRUSH_MAX_SET];
@@ -545,7 +552,7 @@ int crush_do_rule(const struct crush_map *map,
 				j = 0;
 				osize += crush_choose(map,
 						      map->buckets[-1-w[i]],
-						      weight,
+						      weight, weight_max,
 						      x, numrep,
 						      curstep->arg2,
 						      o+osize, j,
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index dbd9a4792427..6477a68ddecb 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1165,7 +1165,7 @@ static int *calc_pg_raw(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
 	}
 	r = crush_do_rule(osdmap->crush, ruleno, pps, osds,
 			  min_t(int, pool->size, *num),
-			  osdmap->osd_weight);
+			  osdmap->osd_weight, osdmap->max_osd);
 	if (r < 0) {
 		pr_err("error %d from crush rule: pool %lld ruleset %d type %d"
 		       " size %d\n", r, pgid.pool, pool->crush_ruleset,
-- 
1.7.10.4

