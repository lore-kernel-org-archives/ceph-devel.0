From: Sage Weil <sage@newdream.net>
Subject: [PATCH 03/11] crush: clean up types, const-ness
Date: Fri,  4 May 2012 15:54:00 -0700
Message-ID: <1336172048-6848-4-git-send-email-sage@newdream.net>
References: <1336172048-6848-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37641 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760563Ab2EDWyN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 May 2012 18:54:13 -0400
In-Reply-To: <1336172048-6848-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Move various types from int -> __u32 (or similar), and add const as
appropriate.

This reflects changes that have been present in the userland implementation
for some time.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 include/linux/crush/crush.h  |    2 +-
 include/linux/crush/mapper.h |    6 ++--
 net/ceph/crush/crush.c       |   14 ++++----
 net/ceph/crush/mapper.c      |   71 +++++++++++++++++++++--------------------
 4 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 97e435b..3f50369 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -168,7 +168,7 @@ struct crush_map {
 
 
 /* crush.c */
-extern int crush_get_bucket_item_weight(struct crush_bucket *b, int pos);
+extern int crush_get_bucket_item_weight(const struct crush_bucket *b, int pos);
 extern void crush_calc_parents(struct crush_map *map);
 extern void crush_destroy_bucket_uniform(struct crush_bucket_uniform *b);
 extern void crush_destroy_bucket_list(struct crush_bucket_list *b);
diff --git a/include/linux/crush/mapper.h b/include/linux/crush/mapper.h
index c46b99c..9322ab8 100644
--- a/include/linux/crush/mapper.h
+++ b/include/linux/crush/mapper.h
@@ -10,11 +10,11 @@
 
 #include "crush.h"
 
-extern int crush_find_rule(struct crush_map *map, int pool, int type, int size);
-extern int crush_do_rule(struct crush_map *map,
+extern int crush_find_rule(const struct crush_map *map, int ruleset, int type, int size);
+extern int crush_do_rule(const struct crush_map *map,
 			 int ruleno,
 			 int x, int *result, int result_max,
 			 int forcefeed,    /* -1 for none */
-			 __u32 *weights);
+			 const __u32 *weights);
 
 #endif
diff --git a/net/ceph/crush/crush.c b/net/ceph/crush/crush.c
index d6ebb13..8c2201d 100644
--- a/net/ceph/crush/crush.c
+++ b/net/ceph/crush/crush.c
@@ -23,12 +23,12 @@ const char *crush_bucket_alg_name(int alg)
 
 /**
  * crush_get_bucket_item_weight - Get weight of an item in given bucket
- * @b: bucket pointer
- * @p: item index in bucket
+ * @param b bucket pointer
+ * @param p item index in bucket
  */
-int crush_get_bucket_item_weight(struct crush_bucket *b, int p)
+int crush_get_bucket_item_weight(const struct crush_bucket *b, int p)
 {
-	if (p >= b->size)
+	if ((__u32)p >= b->size)
 		return 0;
 
 	switch (b->alg) {
@@ -120,14 +120,13 @@ void crush_destroy_bucket(struct crush_bucket *b)
 
 /**
  * crush_destroy - Destroy a crush_map
- * @map: crush_map pointer
+ * @param map crush_map pointer
  */
 void crush_destroy(struct crush_map *map)
 {
-	int b;
-
 	/* buckets */
 	if (map->buckets) {
+		__s32 b;
 		for (b = 0; b < map->max_buckets; b++) {
 			if (map->buckets[b] == NULL)
 				continue;
@@ -138,6 +137,7 @@ void crush_destroy(struct crush_map *map)
 
 	/* rules */
 	if (map->rules) {
+		__u32 b;
 		for (b = 0; b < map->max_rules; b++)
 			kfree(map->rules[b]);
 		kfree(map->rules);
diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index b79747c..7aa79a4 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -27,14 +27,14 @@
 
 /**
  * crush_find_rule - find a crush_rule id for a given ruleset, type, and size.
- * @map: the crush_map
- * @ruleset: the storage ruleset id (user defined)
- * @type: storage ruleset type (user defined)
- * @size: output set size
+ * @param map the crush_map
+ * @param ruleset the storage ruleset id (user defined)
+ * @param type storage ruleset type (user defined)
+ * @param size output set size
  */
-int crush_find_rule(struct crush_map *map, int ruleset, int type, int size)
+int crush_find_rule(const struct crush_map *map, int ruleset, int type, int size)
 {
-	int i;
+	__u32 i;
 
 	for (i = 0; i < map->max_rules; i++) {
 		if (map->rules[i] &&
@@ -72,7 +72,7 @@ static int bucket_perm_choose(struct crush_bucket *bucket,
 	unsigned i, s;
 
 	/* start a new permutation if @x has changed */
-	if (bucket->perm_x != x || bucket->perm_n == 0) {
+	if (bucket->perm_x != (__u32)x || bucket->perm_n == 0) {
 		dprintk("bucket %d new x=%d\n", bucket->id, x);
 		bucket->perm_x = x;
 
@@ -219,7 +219,7 @@ static int bucket_tree_choose(struct crush_bucket_tree *bucket,
 static int bucket_straw_choose(struct crush_bucket_straw *bucket,
 			       int x, int r)
 {
-	int i;
+	__u32 i;
 	int high = 0;
 	__u64 high_draw = 0;
 	__u64 draw;
@@ -262,7 +262,7 @@ static int crush_bucket_choose(struct crush_bucket *in, int x, int r)
  * true if device is marked "out" (failed, fully offloaded)
  * of the cluster
  */
-static int is_out(struct crush_map *map, __u32 *weight, int item, int x)
+static int is_out(const struct crush_map *map, const __u32 *weight, int item, int x)
 {
 	if (weight[item] >= 0x10000)
 		return 0;
@@ -276,27 +276,27 @@ static int is_out(struct crush_map *map, __u32 *weight, int item, int x)
 
 /**
  * crush_choose - choose numrep distinct items of given type
- * @map: the crush_map
- * @bucket: the bucket we are choose an item from
- * @x: crush input value
- * @numrep: the number of items to choose
- * @type: the type of item to choose
- * @out: pointer to output vector
- * @outpos: our position in that vector
- * @firstn: true if choosing "first n" items, false if choosing "indep"
- * @recurse_to_leaf: true if we want one device under each item of given type
- * @out2: second output vector for leaf items (if @recurse_to_leaf)
+ * @param map the crush_map
+ * @param bucket the bucket we are choose an item from
+ * @param x crush input value
+ * @param numrep the number of items to choose
+ * @param type the type of item to choose
+ * @param out pointer to output vector
+ * @param outpos our position in that vector
+ * @param firstn true if choosing "first n" items, false if choosing "indep"
+ * @param recurseto_leaf: true if we want one device under each item of given type
+ * @param out2 second output vector for leaf items (if @a recurse_to_leaf)
  */
-static int crush_choose(struct crush_map *map,
+static int crush_choose(const struct crush_map *map,
 			struct crush_bucket *bucket,
-			__u32 *weight,
+			const __u32 *weight,
 			int x, int numrep, int type,
 			int *out, int outpos,
 			int firstn, int recurse_to_leaf,
 			int *out2)
 {
 	int rep;
-	int ftotal, flocal;
+	unsigned int ftotal, flocal;
 	int retry_descent, retry_bucket, skip_rep;
 	struct crush_bucket *in = bucket;
 	int r;
@@ -304,7 +304,7 @@ static int crush_choose(struct crush_map *map,
 	int item = 0;
 	int itemtype;
 	int collide, reject;
-	const int orig_tries = 5; /* attempts before we fall back to search */
+	const unsigned int orig_tries = 5; /* attempts before we fall back to search */
 
 	dprintk("CHOOSE%s bucket %d x %d outpos %d numrep %d\n", recurse_to_leaf ? "_LEAF" : "",
 		bucket->id, x, outpos, numrep);
@@ -325,7 +325,7 @@ static int crush_choose(struct crush_map *map,
 				r = rep;
 				if (in->alg == CRUSH_BUCKET_UNIFORM) {
 					/* be careful */
-					if (firstn || numrep >= in->size)
+					if (firstn || (__u32)numrep >= in->size)
 						/* r' = r + f_total */
 						r += ftotal;
 					else if (in->size % numrep == 0)
@@ -425,7 +425,7 @@ reject:
 						/* else give up */
 						skip_rep = 1;
 					dprintk("  reject %d  collide %d  "
-						"ftotal %d  flocal %d\n",
+						"ftotal %u  flocal %u\n",
 						reject, collide, ftotal,
 						flocal);
 				}
@@ -449,16 +449,16 @@ reject:
 
 /**
  * crush_do_rule - calculate a mapping with the given input and rule
- * @map: the crush_map
- * @ruleno: the rule id
- * @x: hash input
- * @result: pointer to result vector
- * @result_max: maximum result size
- * @force: force initial replica choice; -1 for none
+ * @param map the crush_map
+ * @param ruleno the rule id
+ * @param x hash input
+ * @param result pointer to result vector
+ * @param resultmax: maximum result size
+ * @param force force initial replica choice; -1 for none
  */
-int crush_do_rule(struct crush_map *map,
+int crush_do_rule(const struct crush_map *map,
 		  int ruleno, int x, int *result, int result_max,
-		  int force, __u32 *weight)
+		  int force, const __u32 *weight)
 {
 	int result_len;
 	int force_context[CRUSH_MAX_DEPTH];
@@ -473,7 +473,7 @@ int crush_do_rule(struct crush_map *map,
 	int osize;
 	int *tmp;
 	struct crush_rule *rule;
-	int step;
+	__u32 step;
 	int i, j;
 	int numrep;
 	int firstn;
@@ -488,7 +488,8 @@ int crush_do_rule(struct crush_map *map,
 	/*
 	 * determine hierarchical context of force, if any.  note
 	 * that this may or may not correspond to the specific types
-	 * referenced by the crush rule.
+	 * referenced by the crush rule.  it will also only affect
+	 * the first descent (TAKE).
 	 */
 	if (force >= 0 &&
 	    force < map->max_devices &&
-- 
1.7.9

