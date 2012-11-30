From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH] libceph: for chooseleaf rules, retry CRUSH map descent
 from root if leaf is failed
Date: Fri, 30 Nov 2012 09:15:25 -0700
Message-ID: <1354292125-174877-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:37820 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757128Ab2K3QQE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Nov 2012 11:16:04 -0500
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 18DD2D2C5E7
	for <ceph-devel@vger.kernel.org>; Fri, 30 Nov 2012 09:15:58 -0700 (MST)
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Fri, 30 Nov 2012 09:15:45 -0700
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

Add libceph support for a new CRUSH tunable recently added to Ceph servers.

Consider the CRUSH rule
  step chooseleaf firstn 0 type <node_type>

This rule means that <n> replicas will be chosen in a manner such that
each chosen leaf's branch will contain a unique instance of <node_type>.

When an object is re-replicated after a leaf failure, if the CRUSH map uses
a chooseleaf rule the remapped replica ends up under the <node_type> bucket
that held the failed leaf.  This causes uneven data distribution across the
storage cluster, to the point that when all the leaves but one fail under a
particular <node_type> bucket, that remaining leaf holds all the data from
its failed peers.

This behavior also limits the number of peers that can participate in the
re-replication of the data held by the failed leaf, which increases the
time required to re-replicate after a failure.

For a chooseleaf CRUSH rule, the tree descent has two steps: call them the
inner and outer descents.

If the tree descent down to <node_type> is the outer descent, and the descent
from <node_type> down to a leaf is the inner descent, the issue is that a
down leaf is detected on the inner descent, so only the inner descent is
retried.

In order to disperse re-replicated data as widely as possible across a
storage cluster after a failure, we want to retry the outer descent. So,
fix up crush_choose() to allow the inner descent to return immediately on
choosing a failed leaf.  Wire this up as a new CRUSH tunable.

Note that after this change, for a chooseleaf rule, if the primary OSD
in a placement group has failed, choosing a replacement may result in
one of the other OSDs in the PG colliding with the new primary.  This
requires that OSD's data for that PG to need moving as well.  This
seems unavoidable but should be relatively rare.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 include/linux/ceph/ceph_features.h |    4 +++-
 include/linux/crush/crush.h        |    2 ++
 net/ceph/crush/mapper.c            |   13 ++++++++++---
 net/ceph/osdmap.c                  |    6 ++++++
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index dad579b..61e5af4 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -14,13 +14,15 @@
 #define CEPH_FEATURE_DIRLAYOUTHASH  (1<<7)
 /* bits 8-17 defined by user-space; not supported yet here */
 #define CEPH_FEATURE_CRUSH_TUNABLES (1<<18)
+#define CEPH_FEATURE_CRUSH_TUNABLES2 (1<<25)
 
 /*
  * Features supported.
  */
 #define CEPH_FEATURES_SUPPORTED_DEFAULT  \
 	(CEPH_FEATURE_NOSRCADDR |	 \
-	 CEPH_FEATURE_CRUSH_TUNABLES)
+	 CEPH_FEATURE_CRUSH_TUNABLES |	 \
+	 CEPH_FEATURE_CRUSH_TUNABLES2)
 
 #define CEPH_FEATURES_REQUIRED_DEFAULT   \
 	(CEPH_FEATURE_NOSRCADDR)
diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 25baa28..6a1101f 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -162,6 +162,8 @@ struct crush_map {
 	__u32 choose_local_fallback_tries;
 	/* choose attempts before giving up */ 
 	__u32 choose_total_tries;
+	/* attempt chooseleaf inner descent once; on failure retry outer descent */
+	__u32 chooseleaf_descend_once;
 };
 
 
diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 35fce75..96c8a58 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -287,6 +287,7 @@ static int is_out(const struct crush_map *map, const __u32 *weight, int item, in
  * @outpos: our position in that vector
  * @firstn: true if choosing "first n" items, false if choosing "indep"
  * @recurse_to_leaf: true if we want one device under each item of given type
+ * @descend_once: true if we should only try one descent before giving up
  * @out2: second output vector for leaf items (if @recurse_to_leaf)
  */
 static int crush_choose(const struct crush_map *map,
@@ -295,7 +296,7 @@ static int crush_choose(const struct crush_map *map,
 			int x, int numrep, int type,
 			int *out, int outpos,
 			int firstn, int recurse_to_leaf,
-			int *out2)
+			int descend_once, int *out2)
 {
 	int rep;
 	unsigned int ftotal, flocal;
@@ -399,6 +400,7 @@ static int crush_choose(const struct crush_map *map,
 							 x, outpos+1, 0,
 							 out2, outpos,
 							 firstn, 0,
+							 map->chooseleaf_descend_once,
 							 NULL) <= outpos)
 							/* didn't get leaf */
 							reject = 1;
@@ -422,7 +424,10 @@ reject:
 					ftotal++;
 					flocal++;
 
-					if (collide && flocal <= map->choose_local_tries)
+					if (reject && descend_once)
+						/* let outer call try again */
+						skip_rep = 1;
+					else if (collide && flocal <= map->choose_local_tries)
 						/* retry locally a few times */
 						retry_bucket = 1;
 					else if (map->choose_local_fallback_tries > 0 &&
@@ -485,6 +490,7 @@ int crush_do_rule(const struct crush_map *map,
 	int i, j;
 	int numrep;
 	int firstn;
+	const int descend_once = 0;
 
 	if ((__u32)ruleno >= map->max_rules) {
 		dprintk(" bad ruleno %d\n", ruleno);
@@ -544,7 +550,8 @@ int crush_do_rule(const struct crush_map *map,
 						      curstep->arg2,
 						      o+osize, j,
 						      firstn,
-						      recurse_to_leaf, c+osize);
+						      recurse_to_leaf,
+						      descend_once, c+osize);
 			}
 
 			if (recurse_to_leaf)
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 3124b71..72f878e 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -170,6 +170,7 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
         c->choose_local_tries = 2;
         c->choose_local_fallback_tries = 5;
         c->choose_total_tries = 19;
+	c->chooseleaf_descend_once = 0;
 
 	ceph_decode_need(p, end, 4*sizeof(u32), bad);
 	magic = ceph_decode_32(p);
@@ -336,6 +337,11 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
         dout("crush decode tunable choose_total_tries = %d",
              c->choose_total_tries);
 
+	ceph_decode_need(p, end, sizeof(u32), done);
+	c->chooseleaf_descend_once = ceph_decode_32(p);
+	dout("crush decode tunable chooseleaf_descend_once = %d",
+	     c->chooseleaf_descend_once);
+
 done:
 	dout("crush_decode success\n");
 	return c;
-- 
1.7.8.2


