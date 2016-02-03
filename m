From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 3/5] crush: add chooseleaf_stable tunable
Date: Wed,  3 Feb 2016 15:23:19 +0100
Message-ID: <1454509401-19734-4-git-send-email-idryomov@gmail.com>
References: <1454509401-19734-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:32783 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbcBCOXc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 09:23:32 -0500
Received: by mail-wm0-f42.google.com with SMTP id l66so166030320wml.0
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 06:23:31 -0800 (PST)
In-Reply-To: <1454509401-19734-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>

Add a tunable to fix the bug that chooseleaf may cause unnecessary pg
migrations when some device fails.

Reflects ceph.git commit fdb3f664448e80d984470f32f04e2e6f03ab52ec.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/crush/crush.h |  8 +++++++-
 net/ceph/crush/mapper.c     | 18 ++++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 48b49305716b..be8f12b8f195 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -59,7 +59,8 @@ enum {
 	CRUSH_RULE_SET_CHOOSELEAF_TRIES = 9, /* override chooseleaf_descend_once */
 	CRUSH_RULE_SET_CHOOSE_LOCAL_TRIES = 10,
 	CRUSH_RULE_SET_CHOOSE_LOCAL_FALLBACK_TRIES = 11,
-	CRUSH_RULE_SET_CHOOSELEAF_VARY_R = 12
+	CRUSH_RULE_SET_CHOOSELEAF_VARY_R = 12,
+	CRUSH_RULE_SET_CHOOSELEAF_STABLE = 13
 };
 
 /*
@@ -205,6 +206,11 @@ struct crush_map {
 	 * mappings line up a bit better with previous mappings. */
 	__u8 chooseleaf_vary_r;
 
+	/* if true, it makes chooseleaf firstn to return stable results (if
+	 * no local retry) so that data migrations would be optimal when some
+	 * device fails. */
+	__u8 chooseleaf_stable;
+
 #ifndef __KERNEL__
 	/*
 	 * version 0 (original) of straw_calc has various flaws.  version 1
diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index abb700621e4a..5fcfb98f309e 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -403,6 +403,7 @@ static int is_out(const struct crush_map *map,
  * @local_retries: localized retries
  * @local_fallback_retries: localized fallback retries
  * @recurse_to_leaf: true if we want one device under each item of given type (chooseleaf instead of choose)
+ * @stable: stable mode starts rep=0 in the recursive call for all replicas
  * @vary_r: pass r to recursive calls
  * @out2: second output vector for leaf items (if @recurse_to_leaf)
  * @parent_r: r value passed from the parent
@@ -419,6 +420,7 @@ static int crush_choose_firstn(const struct crush_map *map,
 			       unsigned int local_fallback_retries,
 			       int recurse_to_leaf,
 			       unsigned int vary_r,
+			       unsigned int stable,
 			       int *out2,
 			       int parent_r)
 {
@@ -433,13 +435,13 @@ static int crush_choose_firstn(const struct crush_map *map,
 	int collide, reject;
 	int count = out_size;
 
-	dprintk("CHOOSE%s bucket %d x %d outpos %d numrep %d tries %d recurse_tries %d local_retries %d local_fallback_retries %d parent_r %d\n",
+	dprintk("CHOOSE%s bucket %d x %d outpos %d numrep %d tries %d recurse_tries %d local_retries %d local_fallback_retries %d parent_r %d stable %d\n",
 		recurse_to_leaf ? "_LEAF" : "",
 		bucket->id, x, outpos, numrep,
 		tries, recurse_tries, local_retries, local_fallback_retries,
-		parent_r);
+		parent_r, stable);
 
-	for (rep = outpos; rep < numrep && count > 0 ; rep++) {
+	for (rep = stable ? 0 : outpos; rep < numrep && count > 0 ; rep++) {
 		/* keep trying until we get a non-out, non-colliding item */
 		ftotal = 0;
 		skip_rep = 0;
@@ -512,13 +514,14 @@ static int crush_choose_firstn(const struct crush_map *map,
 						if (crush_choose_firstn(map,
 							 map->buckets[-1-item],
 							 weight, weight_max,
-							 x, outpos+1, 0,
+							 x, stable ? 1 : outpos+1, 0,
 							 out2, outpos, count,
 							 recurse_tries, 0,
 							 local_retries,
 							 local_fallback_retries,
 							 0,
 							 vary_r,
+							 stable,
 							 NULL,
 							 sub_r) <= outpos)
 							/* didn't get leaf */
@@ -816,6 +819,7 @@ int crush_do_rule(const struct crush_map *map,
 	int choose_local_fallback_retries = map->choose_local_fallback_tries;
 
 	int vary_r = map->chooseleaf_vary_r;
+	int stable = map->chooseleaf_stable;
 
 	if ((__u32)ruleno >= map->max_rules) {
 		dprintk(" bad ruleno %d\n", ruleno);
@@ -870,6 +874,11 @@ int crush_do_rule(const struct crush_map *map,
 				vary_r = curstep->arg1;
 			break;
 
+		case CRUSH_RULE_SET_CHOOSELEAF_STABLE:
+			if (curstep->arg1 >= 0)
+				stable = curstep->arg1;
+			break;
+
 		case CRUSH_RULE_CHOOSELEAF_FIRSTN:
 		case CRUSH_RULE_CHOOSE_FIRSTN:
 			firstn = 1;
@@ -932,6 +941,7 @@ int crush_do_rule(const struct crush_map *map,
 						choose_local_fallback_retries,
 						recurse_to_leaf,
 						vary_r,
+						stable,
 						c+osize,
 						0);
 				} else {
-- 
2.4.3

