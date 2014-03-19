From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 3/5] crush: add chooseleaf_vary_r tunable
Date: Wed, 19 Mar 2014 18:09:07 +0200
Message-ID: <1395245349-4513-4-git-send-email-ilya.dryomov@inktank.com>
References: <1395245349-4513-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:61794 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965684AbaCSQJU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Mar 2014 12:09:20 -0400
Received: by mail-ee0-f51.google.com with SMTP id c13so6848444eek.10
        for <ceph-devel@vger.kernel.org>; Wed, 19 Mar 2014 09:09:19 -0700 (PDT)
Received: from localhost ([109.110.66.126])
        by mx.google.com with ESMTPSA id e42sm43265815eev.32.2014.03.19.09.09.18
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Mar 2014 09:09:18 -0700 (PDT)
In-Reply-To: <1395245349-4513-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The current crush_choose_firstn code will re-use the same 'r' value for
the recursive call.  That means that if we are hitting a collision or
rejection for some reason (say, an OSD that is marked out) and need to
retry, we will keep making the same (bad) choice in that recursive
selection.

Introduce a tunable that fixes that behavior by incorporating the parent
'r' value into the recursive starting point, so that a different path
will be taken in subsequent placement attempts.

Note that this was done from the get-go for the new crush_choose_indep
algorithm.

This was exposed by a user who was seeing PGs stuck in active+remapped
after reweight-by-utilization because the up set mapped to a single OSD.

Reflects ceph.git commit a8e6c9fbf88bad056dd05d3eb790e98a5e43451a.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/crush/crush.h |    6 ++++++
 net/ceph/crush/mapper.c     |   30 ++++++++++++++++++++++++------
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index acaa5615d634..75f36a6c7f67 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -173,6 +173,12 @@ struct crush_map {
 	 * apply to a collision: in that case we will retry as we used
 	 * to. */
 	__u32 chooseleaf_descend_once;
+
+	/* if non-zero, feed r into chooseleaf, bit-shifted right by (r-1)
+	 * bits.  a value of 1 is best for new clusters.  for legacy clusters
+	 * that want to limit reshuffling, a value of 3 or 4 will make the
+	 * mappings line up a bit better with previous mappings. */
+	__u8 chooseleaf_vary_r;
 };
 
 
diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index b3fb84903b30..947150cde297 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -295,7 +295,9 @@ static int is_out(const struct crush_map *map,
  * @local_retries: localized retries
  * @local_fallback_retries: localized fallback retries
  * @recurse_to_leaf: true if we want one device under each item of given type (chooseleaf instead of choose)
+ * @vary_r: pass r to recursive calls
  * @out2: second output vector for leaf items (if @recurse_to_leaf)
+ * @parent_r: r value passed from the parent
  */
 static int crush_choose_firstn(const struct crush_map *map,
 			       struct crush_bucket *bucket,
@@ -307,7 +309,9 @@ static int crush_choose_firstn(const struct crush_map *map,
 			       unsigned int local_retries,
 			       unsigned int local_fallback_retries,
 			       int recurse_to_leaf,
-			       int *out2)
+			       unsigned int vary_r,
+			       int *out2,
+			       int parent_r)
 {
 	int rep;
 	unsigned int ftotal, flocal;
@@ -319,8 +323,11 @@ static int crush_choose_firstn(const struct crush_map *map,
 	int itemtype;
 	int collide, reject;
 
-	dprintk("CHOOSE%s bucket %d x %d outpos %d numrep %d\n", recurse_to_leaf ? "_LEAF" : "",
-		bucket->id, x, outpos, numrep);
+	dprintk("CHOOSE%s bucket %d x %d outpos %d numrep %d tries %d recurse_tries %d local_retries %d local_fallback_retries %d parent_r %d\n",
+		recurse_to_leaf ? "_LEAF" : "",
+		bucket->id, x, outpos, numrep,
+		tries, recurse_tries, local_retries, local_fallback_retries,
+		parent_r);
 
 	for (rep = outpos; rep < numrep; rep++) {
 		/* keep trying until we get a non-out, non-colliding item */
@@ -335,7 +342,7 @@ static int crush_choose_firstn(const struct crush_map *map,
 			do {
 				collide = 0;
 				retry_bucket = 0;
-				r = rep;
+				r = rep + parent_r;
 				/* r' = r + f_total */
 				r += ftotal;
 
@@ -387,6 +394,11 @@ static int crush_choose_firstn(const struct crush_map *map,
 				reject = 0;
 				if (!collide && recurse_to_leaf) {
 					if (item < 0) {
+						int sub_r;
+						if (vary_r)
+							sub_r = r >> (vary_r-1);
+						else
+							sub_r = 0;
 						if (crush_choose_firstn(map,
 							 map->buckets[-1-item],
 							 weight, weight_max,
@@ -396,7 +408,9 @@ static int crush_choose_firstn(const struct crush_map *map,
 							 local_retries,
 							 local_fallback_retries,
 							 0,
-							 NULL) <= outpos)
+							 vary_r,
+							 NULL,
+							 sub_r) <= outpos)
 							/* didn't get leaf */
 							reject = 1;
 					} else {
@@ -653,6 +667,8 @@ int crush_do_rule(const struct crush_map *map,
 	int choose_local_retries = map->choose_local_tries;
 	int choose_local_fallback_retries = map->choose_local_fallback_tries;
 
+	int vary_r = map->chooseleaf_vary_r;
+
 	if ((__u32)ruleno >= map->max_rules) {
 		dprintk(" bad ruleno %d\n", ruleno);
 		return 0;
@@ -745,7 +761,9 @@ int crush_do_rule(const struct crush_map *map,
 						choose_local_retries,
 						choose_local_fallback_retries,
 						recurse_to_leaf,
-						c+osize);
+						vary_r,
+						c+osize,
+						0);
 				} else {
 					crush_choose_indep(
 						map,
-- 
1.7.10.4

