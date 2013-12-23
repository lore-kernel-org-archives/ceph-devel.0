From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 10/19] crush: clarify numrep vs endpos
Date: Mon, 23 Dec 2013 19:09:41 +0200
Message-ID: <1387818590-30483-11-git-send-email-ilya.dryomov@inktank.com>
References: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:64391 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757640Ab3LWRK7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 12:10:59 -0500
Received: by mail-ea0-f173.google.com with SMTP id o10so2472094eaj.4
        for <ceph-devel@vger.kernel.org>; Mon, 23 Dec 2013 09:10:58 -0800 (PST)
In-Reply-To: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

Pass numrep (the width of the result) separately from the number of results
we want *this* iteration.  This makes things less awkward when we do a
recursive call (for chooseleaf) and want only one item.

Reflects ceph.git commit 1b567ee08972f268c11b43fc881e57b5984dd08b.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/crush/mapper.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index a71f8c4c78ec..125dbd04f2b6 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -457,13 +457,13 @@ reject:
 static void crush_choose_indep(const struct crush_map *map,
 			      struct crush_bucket *bucket,
 			      const __u32 *weight, int weight_max,
-			      int x, int numrep, int type,
+			       int x, int left, int numrep, int type,
 			      int *out, int outpos,
 			      int recurse_to_leaf,
 			      int *out2)
 {
 	struct crush_bucket *in = bucket;
-	int left = numrep - outpos;
+	int endpos = outpos + left;
 	int rep;
 	unsigned int ftotal;
 	int r;
@@ -476,14 +476,14 @@ static void crush_choose_indep(const struct crush_map *map,
 		bucket->id, x, outpos, numrep);
 
 	/* initially my result is undefined */
-	for (rep = outpos; rep < numrep; rep++) {
+	for (rep = outpos; rep < endpos; rep++) {
 		out[rep] = CRUSH_ITEM_UNDEF;
 		if (out2)
 			out2[rep] = CRUSH_ITEM_UNDEF;
 	}
 
 	for (ftotal = 0; left > 0 && ftotal < map->choose_total_tries; ftotal++) {
-		for (rep = outpos; rep < numrep; rep++) {
+		for (rep = outpos; rep < endpos; rep++) {
 			if (out[rep] != CRUSH_ITEM_UNDEF)
 				continue;
 
@@ -551,7 +551,7 @@ static void crush_choose_indep(const struct crush_map *map,
 
 				/* collision? */
 				collide = 0;
-				for (i = outpos; i < numrep; i++) {
+				for (i = outpos; i < endpos; i++) {
 					if (out[i] == item) {
 						collide = 1;
 						break;
@@ -565,7 +565,7 @@ static void crush_choose_indep(const struct crush_map *map,
 						crush_choose_indep(map,
 								   map->buckets[-1-item],
 								   weight, weight_max,
-								   x, rep+1, 0,
+								   x, 1, numrep, 0,
 								   out2, rep,
 								   0, NULL);
 						if (out2[rep] == CRUSH_ITEM_NONE) {
@@ -590,7 +590,7 @@ static void crush_choose_indep(const struct crush_map *map,
 			}
 		}
 	}
-	for (rep = outpos; rep < numrep; rep++) {
+	for (rep = outpos; rep < endpos; rep++) {
 		if (out[rep] == CRUSH_ITEM_UNDEF) {
 			out[rep] = CRUSH_ITEM_NONE;
 		}
@@ -698,7 +698,7 @@ int crush_do_rule(const struct crush_map *map,
 						map,
 						map->buckets[-1-w[i]],
 						weight, weight_max,
-						x, numrep,
+						x, numrep, numrep,
 						curstep->arg2,
 						o+osize, j,
 						recurse_to_leaf,
-- 
1.7.10.4

