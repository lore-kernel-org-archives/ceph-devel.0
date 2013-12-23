From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 09/19] crush: strip firstn conditionals out of crush_choose, rename
Date: Mon, 23 Dec 2013 19:09:40 +0200
Message-ID: <1387818590-30483-10-git-send-email-ilya.dryomov@inktank.com>
References: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:51197 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757633Ab3LWRK6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 12:10:58 -0500
Received: by mail-ea0-f179.google.com with SMTP id r15so2491102ead.10
        for <ceph-devel@vger.kernel.org>; Mon, 23 Dec 2013 09:10:57 -0800 (PST)
In-Reply-To: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

Now that indep is handled by crush_choose_indep, rename crush_choose to
crush_choose_firstn and remove all the conditionals.  This ends up
stripping out *lots* of code.

Note that it *also* makes it obvious that the shenanigans we were playing
with r' for uniform buckets were broken for firstn mode.  This appears to
have happened waaaay back in commit dae8bec9 (or earlier)... 2007.

Reflects ceph.git commit 94350996cb2035850bcbece6a77a9b0394177ec9.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/crush/mapper.c |   88 ++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 55 deletions(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 77b7a73e65cf..a71f8c4c78ec 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -282,7 +282,7 @@ static int is_out(const struct crush_map *map,
 }
 
 /**
- * crush_choose - choose numrep distinct items of given type
+ * crush_choose_firstn - choose numrep distinct items of given type
  * @map: the crush_map
  * @bucket: the bucket we are choose an item from
  * @x: crush input value
@@ -290,18 +290,17 @@ static int is_out(const struct crush_map *map,
  * @type: the type of item to choose
  * @out: pointer to output vector
  * @outpos: our position in that vector
- * @firstn: true if choosing "first n" items, false if choosing "indep"
  * @recurse_to_leaf: true if we want one device under each item of given type
  * @descend_once: true if we should only try one descent before giving up
  * @out2: second output vector for leaf items (if @recurse_to_leaf)
  */
-static int crush_choose(const struct crush_map *map,
-			struct crush_bucket *bucket,
-			const __u32 *weight, int weight_max,
-			int x, int numrep, int type,
-			int *out, int outpos,
-			int firstn, int recurse_to_leaf,
-			int descend_once, int *out2)
+static int crush_choose_firstn(const struct crush_map *map,
+			       struct crush_bucket *bucket,
+			       const __u32 *weight, int weight_max,
+			       int x, int numrep, int type,
+			       int *out, int outpos,
+			       int recurse_to_leaf,
+			       int descend_once, int *out2)
 {
 	int rep;
 	unsigned int ftotal, flocal;
@@ -330,26 +329,8 @@ static int crush_choose(const struct crush_map *map,
 				collide = 0;
 				retry_bucket = 0;
 				r = rep;
-				if (in->alg == CRUSH_BUCKET_UNIFORM) {
-					/* be careful */
-					if (firstn || (__u32)numrep >= in->size)
-						/* r' = r + f_total */
-						r += ftotal;
-					else if (in->size % numrep == 0)
-						/* r'=r+(n+1)*f_local */
-						r += (numrep+1) *
-							(flocal+ftotal);
-					else
-						/* r' = r + n*f_local */
-						r += numrep * (flocal+ftotal);
-				} else {
-					if (firstn)
-						/* r' = r + f_total */
-						r += ftotal;
-					else
-						/* r' = r + n*f_local */
-						r += numrep * (flocal+ftotal);
-				}
+				/* r' = r + f_total */
+				r += ftotal;
 
 				/* bucket choose */
 				if (in->size == 0) {
@@ -399,12 +380,12 @@ static int crush_choose(const struct crush_map *map,
 				reject = 0;
 				if (!collide && recurse_to_leaf) {
 					if (item < 0) {
-						if (crush_choose(map,
+						if (crush_choose_firstn(map,
 							 map->buckets[-1-item],
 							 weight, weight_max,
 							 x, outpos+1, 0,
 							 out2, outpos,
-							 firstn, 0,
+							 0,
 							 map->chooseleaf_descend_once,
 							 NULL) <= outpos)
 							/* didn't get leaf */
@@ -455,12 +436,8 @@ reject:
 		} while (retry_descent);
 
 		if (skip_rep) {
-			if (firstn) {
-				dprintk("skip rep\n");
-				continue;
-			}
-			dprintk("undef rep, continuing\n");
-			item = CRUSH_ITEM_UNDEF;
+			dprintk("skip rep\n");
+			continue;
 		}
 
 		dprintk("CHOOSE got %d\n", item);
@@ -474,7 +451,7 @@ reject:
 
 
 /**
- * choose indep: alternative breadth-first positionally stable mapping
+ * crush_choose_indep: alternative breadth-first positionally stable mapping
  *
  */
 static void crush_choose_indep(const struct crush_map *map,
@@ -707,24 +684,25 @@ int crush_do_rule(const struct crush_map *map,
 				}
 				j = 0;
 				if (firstn) {
-					osize += crush_choose(map,
-							      map->buckets[-1-w[i]],
-							      weight, weight_max,
-							      x, numrep,
-							      curstep->arg2,
-							      o+osize, j,
-							      firstn,
-							      recurse_to_leaf,
-							      descend_once, c+osize);
+					osize += crush_choose_firstn(
+						map,
+						map->buckets[-1-w[i]],
+						weight, weight_max,
+						x, numrep,
+						curstep->arg2,
+						o+osize, j,
+						recurse_to_leaf,
+						descend_once, c+osize);
 				} else {
-					crush_choose_indep(map,
-							   map->buckets[-1-w[i]],
-							   weight, weight_max,
-							   x, numrep,
-							   curstep->arg2,
-							   o+osize, j,
-							   recurse_to_leaf,
-							   c+osize);
+					crush_choose_indep(
+						map,
+						map->buckets[-1-w[i]],
+						weight, weight_max,
+						x, numrep,
+						curstep->arg2,
+						o+osize, j,
+						recurse_to_leaf,
+						c+osize);
 					osize += numrep;
 				}
 			}
-- 
1.7.10.4

