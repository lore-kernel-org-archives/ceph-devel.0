From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 11/19] crush: pass parent r value for indep call
Date: Mon, 23 Dec 2013 19:09:42 +0200
Message-ID: <1387818590-30483-12-git-send-email-ilya.dryomov@inktank.com>
References: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:58892 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757633Ab3LWRLB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 12:11:01 -0500
Received: by mail-ee0-f50.google.com with SMTP id c41so2436157eek.37
        for <ceph-devel@vger.kernel.org>; Mon, 23 Dec 2013 09:11:00 -0800 (PST)
In-Reply-To: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

Pass down the parent's 'r' value so that we will sample different values in
the recursive call when the parent tries multiple times.  This avoids doing
useless work (calling multiple times and trying the same values).

Reflects ceph.git commit 2731d3030d7a3e80922b7f1b7756f9a4a124bac5.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/crush/mapper.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 125dbd04f2b6..c727836b5860 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -460,7 +460,8 @@ static void crush_choose_indep(const struct crush_map *map,
 			       int x, int left, int numrep, int type,
 			      int *out, int outpos,
 			      int recurse_to_leaf,
-			      int *out2)
+			       int *out2,
+			       int parent_r)
 {
 	struct crush_bucket *in = bucket;
 	int endpos = outpos + left;
@@ -499,7 +500,7 @@ static void crush_choose_indep(const struct crush_map *map,
 				 * this will involve more devices in data
 				 * movement and tend to distribute the load.
 				 */
-				r = rep;
+				r = rep + parent_r;
 
 				/* be careful */
 				if (in->alg == CRUSH_BUCKET_UNIFORM &&
@@ -567,7 +568,7 @@ static void crush_choose_indep(const struct crush_map *map,
 								   weight, weight_max,
 								   x, 1, numrep, 0,
 								   out2, rep,
-								   0, NULL);
+								   0, NULL, r);
 						if (out2[rep] == CRUSH_ITEM_NONE) {
 							/* placed nothing; no leaf */
 							break;
@@ -702,7 +703,8 @@ int crush_do_rule(const struct crush_map *map,
 						curstep->arg2,
 						o+osize, j,
 						recurse_to_leaf,
-						c+osize);
+						c+osize,
+						0);
 					osize += numrep;
 				}
 			}
-- 
1.7.10.4

