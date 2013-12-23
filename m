From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 18/19] crush: attempts -> tries
Date: Mon, 23 Dec 2013 19:09:49 +0200
Message-ID: <1387818590-30483-19-git-send-email-ilya.dryomov@inktank.com>
References: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:37242 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757703Ab3LWRLO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 12:11:14 -0500
Received: by mail-ea0-f181.google.com with SMTP id m10so2464699eaj.40
        for <ceph-devel@vger.kernel.org>; Mon, 23 Dec 2013 09:11:13 -0800 (PST)
In-Reply-To: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

Reflects ceph.git commit ea3a0bb8b773360d73b8b77fa32115ef091c9857.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/crush/mapper.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 8cde4818e18b..71ce4f12a7c9 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -298,8 +298,8 @@ static int crush_choose_firstn(const struct crush_map *map,
 			       const __u32 *weight, int weight_max,
 			       int x, int numrep, int type,
 			       int *out, int outpos,
-			       unsigned int attempts,
-			       unsigned int recurse_attempts,
+			       unsigned int tries,
+			       unsigned int recurse_tries,
 			       unsigned int local_tries,
 			       unsigned int local_fallback_tries,
 			       int recurse_to_leaf,
@@ -388,7 +388,7 @@ static int crush_choose_firstn(const struct crush_map *map,
 							 weight, weight_max,
 							 x, outpos+1, 0,
 							 out2, outpos,
-							 recurse_attempts, 0,
+							 recurse_tries, 0,
 							 local_tries,
 							 local_fallback_tries,
 							 0,
@@ -423,7 +423,7 @@ reject:
 						 flocal <= in->size + local_fallback_tries)
 						/* exhaustive bucket search */
 						retry_bucket = 1;
-					else if (ftotal <= attempts)
+					else if (ftotal <= tries)
 						/* then retry descent */
 						retry_descent = 1;
 					else
@@ -461,8 +461,8 @@ static void crush_choose_indep(const struct crush_map *map,
 			       const __u32 *weight, int weight_max,
 			       int x, int left, int numrep, int type,
 			       int *out, int outpos,
-			       unsigned int attempts,
-			       unsigned int recurse_attempts,
+			       unsigned int tries,
+			       unsigned int recurse_tries,
 			       int recurse_to_leaf,
 			       int *out2,
 			       int parent_r)
@@ -487,7 +487,7 @@ static void crush_choose_indep(const struct crush_map *map,
 			out2[rep] = CRUSH_ITEM_UNDEF;
 	}
 
-	for (ftotal = 0; left > 0 && ftotal < attempts; ftotal++) {
+	for (ftotal = 0; left > 0 && ftotal < tries; ftotal++) {
 		for (rep = outpos; rep < endpos; rep++) {
 			if (out[rep] != CRUSH_ITEM_UNDEF)
 				continue;
@@ -572,7 +572,7 @@ static void crush_choose_indep(const struct crush_map *map,
 						   weight, weight_max,
 						   x, 1, numrep, 0,
 						   out2, rep,
-						   recurse_attempts, 0,
+						   recurse_tries, 0,
 						   0, NULL, r);
 						if (out2[rep] == CRUSH_ITEM_NONE) {
 							/* placed nothing; no leaf */
-- 
1.7.10.4

