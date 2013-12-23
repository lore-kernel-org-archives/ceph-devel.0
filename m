From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 12/19] crush: new SET_CHOOSE_LEAF_TRIES command
Date: Mon, 23 Dec 2013 19:09:43 +0200
Message-ID: <1387818590-30483-13-git-send-email-ilya.dryomov@inktank.com>
References: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:46220 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757649Ab3LWRLD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 12:11:03 -0500
Received: by mail-ea0-f177.google.com with SMTP id n15so2462548ead.8
        for <ceph-devel@vger.kernel.org>; Mon, 23 Dec 2013 09:11:02 -0800 (PST)
In-Reply-To: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

Explicitly control the number of sample attempts, and allow the number of
tries in the recursive call to be explicitly controlled via the rule. This
is important because the amount of time we want to spend looking for a
solution may be rule dependent (e.g., higher for the wide indep pool than
the rep pools).

(We should do the same for the other tunables, by the way!)

Reflects ceph.git commit c43c893be872f709c787bc57f46c0e97876ff681.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/crush/crush.h |    2 ++
 net/ceph/crush/mapper.c     |   31 +++++++++++++++++++++----------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 4023b1b52296..2e50bab91655 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -46,6 +46,8 @@ enum {
 	CRUSH_RULE_EMIT = 4,          /* no args */
 	CRUSH_RULE_CHOOSE_LEAF_FIRSTN = 6,
 	CRUSH_RULE_CHOOSE_LEAF_INDEP = 7,
+
+	CRUSH_RULE_SET_CHOOSE_LEAF_TRIES = 9,
 };
 
 /*
diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index c727836b5860..e3ade074541c 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -455,11 +455,13 @@ reject:
  *
  */
 static void crush_choose_indep(const struct crush_map *map,
-			      struct crush_bucket *bucket,
-			      const __u32 *weight, int weight_max,
+			       struct crush_bucket *bucket,
+			       const __u32 *weight, int weight_max,
 			       int x, int left, int numrep, int type,
-			      int *out, int outpos,
-			      int recurse_to_leaf,
+			       int *out, int outpos,
+			       unsigned int attempts,
+			       unsigned int recurse_attempts,
+			       int recurse_to_leaf,
 			       int *out2,
 			       int parent_r)
 {
@@ -483,7 +485,7 @@ static void crush_choose_indep(const struct crush_map *map,
 			out2[rep] = CRUSH_ITEM_UNDEF;
 	}
 
-	for (ftotal = 0; left > 0 && ftotal < map->choose_total_tries; ftotal++) {
+	for (ftotal = 0; left > 0 && ftotal < attempts; ftotal++) {
 		for (rep = outpos; rep < endpos; rep++) {
 			if (out[rep] != CRUSH_ITEM_UNDEF)
 				continue;
@@ -564,11 +566,12 @@ static void crush_choose_indep(const struct crush_map *map,
 				if (recurse_to_leaf) {
 					if (item < 0) {
 						crush_choose_indep(map,
-								   map->buckets[-1-item],
-								   weight, weight_max,
-								   x, 1, numrep, 0,
-								   out2, rep,
-								   0, NULL, r);
+						   map->buckets[-1-item],
+						   weight, weight_max,
+						   x, 1, numrep, 0,
+						   out2, rep,
+						   recurse_attempts, 0,
+						   0, NULL, r);
 						if (out2[rep] == CRUSH_ITEM_NONE) {
 							/* placed nothing; no leaf */
 							break;
@@ -631,6 +634,7 @@ int crush_do_rule(const struct crush_map *map,
 	__u32 step;
 	int i, j;
 	int numrep;
+	int choose_leaf_tries = 1;
 	const int descend_once = 0;
 
 	if ((__u32)ruleno >= map->max_rules) {
@@ -653,6 +657,11 @@ int crush_do_rule(const struct crush_map *map,
 			wsize = 1;
 			break;
 
+		case CRUSH_RULE_SET_CHOOSE_LEAF_TRIES:
+			if (curstep->arg1 > 0)
+				choose_leaf_tries = curstep->arg1;
+			break;
+
 		case CRUSH_RULE_CHOOSE_LEAF_FIRSTN:
 		case CRUSH_RULE_CHOOSE_FIRSTN:
 			firstn = 1;
@@ -702,6 +711,8 @@ int crush_do_rule(const struct crush_map *map,
 						x, numrep, numrep,
 						curstep->arg2,
 						o+osize, j,
+						map->choose_total_tries,
+						choose_leaf_tries,
 						recurse_to_leaf,
 						c+osize,
 						0);
-- 
1.7.10.4

