From: Sage Weil <sage@newdream.net>
Subject: [PATCH 05/11] crush: be more tolerant of nonsensical crush maps
Date: Fri,  4 May 2012 15:54:02 -0700
Message-ID: <1336172048-6848-6-git-send-email-sage@newdream.net>
References: <1336172048-6848-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37645 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606Ab2EDWyT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 May 2012 18:54:19 -0400
In-Reply-To: <1336172048-6848-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

If we get a map that doesn't make sense, error out or ignore the badness
instead of BUGging out.  This reflects the ceph.git commits
9895f0bff7dc68e9b49b572613d242315fb11b6c and
8ded26472058d5205803f244c2f33cb6cb10de79.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 net/ceph/crush/mapper.c |   33 ++++++++++++++++++++++++---------
 1 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 4df0607..c39bb9c 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -152,8 +152,8 @@ static int bucket_list_choose(struct crush_bucket_list *bucket,
 			return bucket->h.items[i];
 	}
 
-	BUG_ON(1);
-	return 0;
+	dprintk("bad list sums for bucket %d\n", bucket->h.id);
+	return bucket->h.items[0];
 }
 
 
@@ -239,6 +239,7 @@ static int bucket_straw_choose(struct crush_bucket_straw *bucket,
 static int crush_bucket_choose(struct crush_bucket *in, int x, int r)
 {
 	dprintk(" crush_bucket_choose %d x=%d r=%d\n", in->id, x, r);
+	BUG_ON(in->size == 0);
 	switch (in->alg) {
 	case CRUSH_BUCKET_UNIFORM:
 		return bucket_uniform_choose((struct crush_bucket_uniform *)in,
@@ -253,7 +254,7 @@ static int crush_bucket_choose(struct crush_bucket *in, int x, int r)
 		return bucket_straw_choose((struct crush_bucket_straw *)in,
 					   x, r);
 	default:
-		BUG_ON(1);
+		dprintk("unknown bucket %d alg %d\n", in->id, in->alg);
 		return in->items[0];
 	}
 }
@@ -354,7 +355,11 @@ static int crush_choose(const struct crush_map *map,
 					item = bucket_perm_choose(in, x, r);
 				else
 					item = crush_bucket_choose(in, x, r);
-				BUG_ON(item >= map->max_devices);
+				if (item >= map->max_devices) {
+					dprintk("   bad item %d\n", item);
+					skip_rep = 1;
+					break;
+				}
 
 				/* desired type? */
 				if (item < 0)
@@ -365,8 +370,12 @@ static int crush_choose(const struct crush_map *map,
 
 				/* keep going? */
 				if (itemtype != type) {
-					BUG_ON(item >= 0 ||
-					       (-1-item) >= map->max_buckets);
+					if (item >= 0 ||
+					    (-1-item) >= map->max_buckets) {
+						dprintk("   bad item type %d\n", type);
+						skip_rep = 1;
+						break;
+					}
 					in = map->buckets[-1-item];
 					retry_bucket = 1;
 					continue;
@@ -478,7 +487,10 @@ int crush_do_rule(const struct crush_map *map,
 	int numrep;
 	int firstn;
 
-	BUG_ON(ruleno >= map->max_rules);
+	if ((__u32)ruleno >= map->max_rules) {
+		dprintk(" bad ruleno %d\n", ruleno);
+		return 0;
+	}
 
 	rule = map->rules[ruleno];
 	result_len = 0;
@@ -528,7 +540,8 @@ int crush_do_rule(const struct crush_map *map,
 			firstn = 1;
 		case CRUSH_RULE_CHOOSE_LEAF_INDEP:
 		case CRUSH_RULE_CHOOSE_INDEP:
-			BUG_ON(wsize == 0);
+			if (wsize == 0)
+				break;
 
 			recurse_to_leaf =
 				rule->steps[step].op ==
@@ -597,7 +610,9 @@ int crush_do_rule(const struct crush_map *map,
 			break;
 
 		default:
-			BUG_ON(1);
+			dprintk(" unknown op %d at step %d\n",
+				curstep->op, step);
+			break;
 		}
 	}
 	return result_len;
-- 
1.7.9

