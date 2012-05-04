From: Sage Weil <sage@newdream.net>
Subject: [PATCH 06/11] crush: use a temporary variable to simplify crush_do_rule
Date: Fri,  4 May 2012 15:54:03 -0700
Message-ID: <1336172048-6848-7-git-send-email-sage@newdream.net>
References: <1336172048-6848-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37649 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760573Ab2EDWyW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 May 2012 18:54:22 -0400
In-Reply-To: <1336172048-6848-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Use a temporary variable here to avoid repeated array lookups and clean up
the code a bit.

This reflects ceph.git commit 6b5be27634ad307b471a5bf0db85c4f5c834885f.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 net/ceph/crush/mapper.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index c39bb9c..9f407c5 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -519,14 +519,15 @@ int crush_do_rule(const struct crush_map *map,
 	}
 
 	for (step = 0; step < rule->len; step++) {
+		struct crush_rule_step *curstep = &rule->steps[step];
+
 		firstn = 0;
-		switch (rule->steps[step].op) {
+		switch (curstep->op) {
 		case CRUSH_RULE_TAKE:
-			w[0] = rule->steps[step].arg1;
+			w[0] = curstep->arg1;
 
 			/* find position in force_context/hierarchy */
-			while (force_pos >= 0 &&
-			       force_context[force_pos] != w[0])
+			while (force_pos >= 0 && force_context[force_pos] != w[0])
 				force_pos--;
 			/* and move past it */
 			if (force_pos >= 0)
@@ -538,15 +539,16 @@ int crush_do_rule(const struct crush_map *map,
 		case CRUSH_RULE_CHOOSE_LEAF_FIRSTN:
 		case CRUSH_RULE_CHOOSE_FIRSTN:
 			firstn = 1;
+			/* fall through */
 		case CRUSH_RULE_CHOOSE_LEAF_INDEP:
 		case CRUSH_RULE_CHOOSE_INDEP:
 			if (wsize == 0)
 				break;
 
 			recurse_to_leaf =
-				rule->steps[step].op ==
+				curstep->op ==
 				 CRUSH_RULE_CHOOSE_LEAF_FIRSTN ||
-				rule->steps[step].op ==
+				curstep->op ==
 				CRUSH_RULE_CHOOSE_LEAF_INDEP;
 
 			/* reset output */
@@ -558,7 +560,7 @@ int crush_do_rule(const struct crush_map *map,
 				 * basically, numrep <= 0 means relative to
 				 * the provided result_max
 				 */
-				numrep = rule->steps[step].arg1;
+				numrep = curstep->arg1;
 				if (numrep <= 0) {
 					numrep += result_max;
 					if (numrep <= 0)
@@ -569,7 +571,7 @@ int crush_do_rule(const struct crush_map *map,
 					/* skip any intermediate types */
 					while (force_pos &&
 					       force_context[force_pos] < 0 &&
-					       rule->steps[step].arg2 !=
+					       curstep->arg2 !=
 					       map->buckets[-1 -
 					       force_context[force_pos]]->type)
 						force_pos--;
@@ -583,7 +585,7 @@ int crush_do_rule(const struct crush_map *map,
 						      map->buckets[-1-w[i]],
 						      weight,
 						      x, numrep,
-						      rule->steps[step].arg2,
+						      curstep->arg2,
 						      o+osize, j,
 						      firstn,
 						      recurse_to_leaf, c+osize);
-- 
1.7.9

