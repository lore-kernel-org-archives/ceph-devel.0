From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 17/19] crush: add set_choose_local_[fallback_]tries steps
Date: Mon, 23 Dec 2013 19:09:48 +0200
Message-ID: <1387818590-30483-18-git-send-email-ilya.dryomov@inktank.com>
References: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:47405 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757713Ab3LWRLM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 12:11:12 -0500
Received: by mail-ee0-f41.google.com with SMTP id t10so2486005eei.0
        for <ceph-devel@vger.kernel.org>; Mon, 23 Dec 2013 09:11:11 -0800 (PST)
In-Reply-To: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

This allows all of the tunables to be overridden by a specific rule.

Reflects ceph.git commits d129e09e57fbc61cfd4f492e3ee77d0750c9d292,
                          0497db49e5973b50df26251ed0e3f4ac7578e66e.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/crush/crush.h |    2 ++
 net/ceph/crush/mapper.c     |   28 +++++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 7b0fc4aba75b..acaa5615d634 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -49,6 +49,8 @@ enum {
 
 	CRUSH_RULE_SET_CHOOSE_TRIES = 8, /* override choose_total_tries */
 	CRUSH_RULE_SET_CHOOSELEAF_TRIES = 9, /* override chooseleaf_descend_once */
+	CRUSH_RULE_SET_CHOOSE_LOCAL_TRIES = 10,
+	CRUSH_RULE_SET_CHOOSE_LOCAL_FALLBACK_TRIES = 11,
 };
 
 /*
diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 0613dd2d5fa3..8cde4818e18b 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -300,6 +300,8 @@ static int crush_choose_firstn(const struct crush_map *map,
 			       int *out, int outpos,
 			       unsigned int attempts,
 			       unsigned int recurse_attempts,
+			       unsigned int local_tries,
+			       unsigned int local_fallback_tries,
 			       int recurse_to_leaf,
 			       int *out2)
 {
@@ -338,9 +340,9 @@ static int crush_choose_firstn(const struct crush_map *map,
 					reject = 1;
 					goto reject;
 				}
-				if (map->choose_local_fallback_tries > 0 &&
+				if (local_fallback_tries > 0 &&
 				    flocal >= (in->size>>1) &&
-				    flocal > map->choose_local_fallback_tries)
+				    flocal > local_fallback_tries)
 					item = bucket_perm_choose(in, x, r);
 				else
 					item = crush_bucket_choose(in, x, r);
@@ -387,6 +389,8 @@ static int crush_choose_firstn(const struct crush_map *map,
 							 x, outpos+1, 0,
 							 out2, outpos,
 							 recurse_attempts, 0,
+							 local_tries,
+							 local_fallback_tries,
 							 0,
 							 NULL) <= outpos)
 							/* didn't get leaf */
@@ -412,11 +416,11 @@ reject:
 					ftotal++;
 					flocal++;
 
-					if (collide && flocal <= map->choose_local_tries)
+					if (collide && flocal <= local_tries)
 						/* retry locally a few times */
 						retry_bucket = 1;
-					else if (map->choose_local_fallback_tries > 0 &&
-						 flocal <= in->size + map->choose_local_fallback_tries)
+					else if (local_fallback_tries > 0 &&
+						 flocal <= in->size + local_fallback_tries)
 						/* exhaustive bucket search */
 						retry_bucket = 1;
 					else if (ftotal <= attempts)
@@ -633,6 +637,8 @@ int crush_do_rule(const struct crush_map *map,
 	int i, j;
 	int numrep;
 	int choose_tries = map->choose_total_tries;
+	int choose_local_tries = map->choose_local_tries;
+	int choose_local_fallback_tries = map->choose_local_fallback_tries;
 	int choose_leaf_tries = 0;
 
 	if ((__u32)ruleno >= map->max_rules) {
@@ -665,6 +671,16 @@ int crush_do_rule(const struct crush_map *map,
 				choose_leaf_tries = curstep->arg1;
 			break;
 
+		case CRUSH_RULE_SET_CHOOSE_LOCAL_TRIES:
+			if (curstep->arg1 > 0)
+				choose_local_tries = curstep->arg1;
+			break;
+
+		case CRUSH_RULE_SET_CHOOSE_LOCAL_FALLBACK_TRIES:
+			if (curstep->arg1 > 0)
+				choose_local_fallback_tries = curstep->arg1;
+			break;
+
 		case CRUSH_RULE_CHOOSELEAF_FIRSTN:
 		case CRUSH_RULE_CHOOSE_FIRSTN:
 			firstn = 1;
@@ -714,6 +730,8 @@ int crush_do_rule(const struct crush_map *map,
 						o+osize, j,
 						choose_tries,
 						recurse_tries,
+						choose_local_tries,
+						choose_local_fallback_tries,
 						recurse_to_leaf,
 						c+osize);
 				} else {
-- 
1.7.10.4

