From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [RFC PATCH 2/2] ceph: retry CRUSH map descent from root if leaf
 is failed
Date: Thu, 10 May 2012 16:38:26 -0600
Message-ID: <1336689506-15029-3-git-send-email-jaschut@sandia.gov>
References: <1336689506-15029-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:33060 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761692Ab2EJWjA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 18:39:00 -0400
In-Reply-To: <1336689506-15029-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: sam.just@dreamhost.com, ceph-devel@vger.kernel.org, Jim Schutt <jaschut@sandia.gov>

When an object is re-replicated after a leaf failure, the remapped replica
ends up under the bucket that held the failed leaf.  This causes uneven
data distribution across the storage cluster, to the point that when all
the leaves of a bucket but one fail, that remaining leaf holds all the
data from its failed peers.

For example, consider the crush rule
  step chooseleaf firstn 0 type <node_type>

This rule means that <n> replicas will be chosen in such a manner that
each chosen leaf's branch will contain a unique instance of <node_type>.

For such ops, the tree descent has two steps: call them the inner and
outer descent.

If the tree descent down to <node_type> is the outer descent, and the
descent from <node_type> down to a leaf is the inner descent, the issue
is that a down leaf is detected on the inner descent, but we want to
retry the outer descent.  This ensures that re-replication after a leaf
failure disperses the re-replicated objects as widely as possible across
the storage cluster.

Fix this by causing the inner descent to return immediately on choosing
a failed leaf, unless we've fallen back to exhaustive search.

Note that after this change, for a chooseleaf rule, if the primary OSD
in a placement group has failed, choosing a replacement may result in
one of the other OSDs in the PG colliding with the new primary.  This
requires that OSD's data for that PG to need moving as well.  This
seems unavoidable but should be relatively rare.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/crush/mapper.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/src/crush/mapper.c b/src/crush/mapper.c
index e5dc950..698da55 100644
--- a/src/crush/mapper.c
+++ b/src/crush/mapper.c
@@ -286,6 +286,7 @@ static int is_out(const struct crush_map *map, const __u32 *weight, int item, in
  * @param outpos our position in that vector
  * @param firstn true if choosing "first n" items, false if choosing "indep"
  * @param recurseto_leaf: true if we want one device under each item of given type
+ * @param descend_once true if we should only try one descent before giving up
  * @param out2 second output vector for leaf items (if @a recurse_to_leaf)
  */
 static int crush_choose(const struct crush_map *map,
@@ -293,7 +294,7 @@ static int crush_choose(const struct crush_map *map,
 			const __u32 *weight,
 			int x, int numrep, int type,
 			int *out, int outpos,
-			int firstn, int recurse_to_leaf,
+			int firstn, int recurse_to_leaf, int descend_once,
 			int *out2)
 {
 	int rep;
@@ -397,6 +398,7 @@ static int crush_choose(const struct crush_map *map,
 							 x, outpos+1, 0,
 							 out2, outpos,
 							 firstn, 0,
+							 ftotal < orig_tries,
 							 NULL) <= outpos)
 							/* didn't get leaf */
 							reject = 1;
@@ -430,7 +432,10 @@ reject:
 					 * descent during that phase so that multiple
 					 * buckets can be exhaustively searched.
 					 */
-					if (ftotal <= orig_tries)
+					if (reject && descend_once)
+						/* let outer call try again */
+						skip_rep = 1;
+					else if (ftotal <= orig_tries)
 						retry_descent = 1;
 					else if (flocal <= in->size + orig_tries)
 						/* exhaustive bucket search */
@@ -491,6 +496,7 @@ int crush_do_rule(const struct crush_map *map,
 	int i, j;
 	int numrep;
 	int firstn;
+	const int descend_once = 0;
 
 	if ((__u32)ruleno >= map->max_rules) {
 		dprintk(" bad ruleno %d\n", ruleno);
@@ -550,7 +556,7 @@ int crush_do_rule(const struct crush_map *map,
 						      curstep->arg2,
 						      o+osize, j,
 						      firstn,
-						      recurse_to_leaf, c+osize);
+						      recurse_to_leaf, descend_once, c+osize);
 			}
 
 			if (recurse_to_leaf)
-- 
1.7.8.2


