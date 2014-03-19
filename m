From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 1/5] crush: fix off-by-one errors in total_tries refactor
Date: Wed, 19 Mar 2014 18:09:05 +0200
Message-ID: <1395245349-4513-2-git-send-email-ilya.dryomov@inktank.com>
References: <1395245349-4513-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:50552 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964941AbaCSQJP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Mar 2014 12:09:15 -0400
Received: by mail-ee0-f45.google.com with SMTP id d17so6732887eek.18
        for <ceph-devel@vger.kernel.org>; Wed, 19 Mar 2014 09:09:14 -0700 (PDT)
Received: from localhost ([109.110.66.126])
        by mx.google.com with ESMTPSA id 4sm43265319eeq.33.2014.03.19.09.09.13
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Mar 2014 09:09:13 -0700 (PDT)
In-Reply-To: <1395245349-4513-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Back in 27f4d1f6bc32c2ed7b2c5080cbd58b14df622607 we refactored the CRUSH
code to allow adjustment of the retry counts on a per-pool basis.  That
commit had an off-by-one bug: the previous "tries" counter was a *retry*
count, not a *try* count, but the new code was passing in 1 meaning
there should be no retries.

Fix the ftotal vs tries comparison to use < instead of <= to fix the
problem.  Note that the original code used <= here, which means the
global "choose_total_tries" tunable is actually counting retries.
Compensate for that by adding 1 in crush_do_rule when we pull the tunable
into the local variable.

This was noticed looking at output from a user provided osdmap.
Unfortunately the map doesn't illustrate the change in mapping behavior
and I haven't managed to construct one yet that does.  Inspection of the
crush debug output now aligns with prior versions, though.

Reflects ceph.git commit 795704fd615f0b008dcc81aa088a859b2d075138.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/crush/mapper.c |   46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index b703790b4e44..074bb2a5e675 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -292,8 +292,8 @@ static int is_out(const struct crush_map *map,
  * @outpos: our position in that vector
  * @tries: number of attempts to make
  * @recurse_tries: number of attempts to have recursive chooseleaf make
- * @local_tries: localized retries
- * @local_fallback_tries: localized fallback retries
+ * @local_retries: localized retries
+ * @local_fallback_retries: localized fallback retries
  * @recurse_to_leaf: true if we want one device under each item of given type (chooseleaf instead of choose)
  * @out2: second output vector for leaf items (if @recurse_to_leaf)
  */
@@ -304,8 +304,8 @@ static int crush_choose_firstn(const struct crush_map *map,
 			       int *out, int outpos,
 			       unsigned int tries,
 			       unsigned int recurse_tries,
-			       unsigned int local_tries,
-			       unsigned int local_fallback_tries,
+			       unsigned int local_retries,
+			       unsigned int local_fallback_retries,
 			       int recurse_to_leaf,
 			       int *out2)
 {
@@ -344,9 +344,9 @@ static int crush_choose_firstn(const struct crush_map *map,
 					reject = 1;
 					goto reject;
 				}
-				if (local_fallback_tries > 0 &&
+				if (local_fallback_retries > 0 &&
 				    flocal >= (in->size>>1) &&
-				    flocal > local_fallback_tries)
+				    flocal > local_fallback_retries)
 					item = bucket_perm_choose(in, x, r);
 				else
 					item = crush_bucket_choose(in, x, r);
@@ -393,8 +393,8 @@ static int crush_choose_firstn(const struct crush_map *map,
 							 x, outpos+1, 0,
 							 out2, outpos,
 							 recurse_tries, 0,
-							 local_tries,
-							 local_fallback_tries,
+							 local_retries,
+							 local_fallback_retries,
 							 0,
 							 NULL) <= outpos)
 							/* didn't get leaf */
@@ -420,14 +420,14 @@ reject:
 					ftotal++;
 					flocal++;
 
-					if (collide && flocal <= local_tries)
+					if (collide && flocal <= local_retries)
 						/* retry locally a few times */
 						retry_bucket = 1;
-					else if (local_fallback_tries > 0 &&
-						 flocal <= in->size + local_fallback_tries)
+					else if (local_fallback_retries > 0 &&
+						 flocal <= in->size + local_fallback_retries)
 						/* exhaustive bucket search */
 						retry_bucket = 1;
-					else if (ftotal <= tries)
+					else if (ftotal < tries)
 						/* then retry descent */
 						retry_descent = 1;
 					else
@@ -640,10 +640,18 @@ int crush_do_rule(const struct crush_map *map,
 	__u32 step;
 	int i, j;
 	int numrep;
-	int choose_tries = map->choose_total_tries;
-	int choose_local_tries = map->choose_local_tries;
-	int choose_local_fallback_tries = map->choose_local_fallback_tries;
+	/*
+	 * the original choose_total_tries value was off by one (it
+	 * counted "retries" and not "tries").  add one.
+	 */
+	int choose_tries = map->choose_total_tries + 1;
 	int choose_leaf_tries = 0;
+	/*
+	 * the local tries values were counted as "retries", though,
+	 * and need no adjustment
+	 */
+	int choose_local_retries = map->choose_local_tries;
+	int choose_local_fallback_retries = map->choose_local_fallback_tries;
 
 	if ((__u32)ruleno >= map->max_rules) {
 		dprintk(" bad ruleno %d\n", ruleno);
@@ -677,12 +685,12 @@ int crush_do_rule(const struct crush_map *map,
 
 		case CRUSH_RULE_SET_CHOOSE_LOCAL_TRIES:
 			if (curstep->arg1 > 0)
-				choose_local_tries = curstep->arg1;
+				choose_local_retries = curstep->arg1;
 			break;
 
 		case CRUSH_RULE_SET_CHOOSE_LOCAL_FALLBACK_TRIES:
 			if (curstep->arg1 > 0)
-				choose_local_fallback_tries = curstep->arg1;
+				choose_local_fallback_retries = curstep->arg1;
 			break;
 
 		case CRUSH_RULE_CHOOSELEAF_FIRSTN:
@@ -734,8 +742,8 @@ int crush_do_rule(const struct crush_map *map,
 						o+osize, j,
 						choose_tries,
 						recurse_tries,
-						choose_local_tries,
-						choose_local_fallback_tries,
+						choose_local_retries,
+						choose_local_fallback_retries,
 						recurse_to_leaf,
 						c+osize);
 				} else {
-- 
1.7.10.4

