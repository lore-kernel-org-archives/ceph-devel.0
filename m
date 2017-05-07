From: Loic Dachary <loic@dachary.org>
Subject: Re: Proposal for a CRUSH collision fallback
Date: Sun, 7 May 2017 23:34:15 +0200
Message-ID: <75022339-f009-420f-dc22-3c93263fc567@dachary.org>
References: <af0b13a9-cb6c-fccf-c80a-52a15ed8a328@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:56033 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755264AbdEGVl1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 7 May 2017 17:41:27 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 0307A4964A5
        for <ceph-devel@vger.kernel.org>; Sun,  7 May 2017 23:34:18 +0200 (CEST)
In-Reply-To: <af0b13a9-cb6c-fccf-c80a-52a15ed8a328@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

FWIW the example provided ( 5 1 1 1 1 ) cannot lead to an even distribution with or without the proposed patch for two replica because the item with weight 5 gets 56% of the values for the first replica. As a consequence only 44 of the values for the second replica can be placed on the same item. The 9% difference remains.

A draft of the proposed implementation is below and allows the opimitzation to get very close to the optimum distribution.

On 05/07/2017 08:45 PM, Loic Dachary wrote:
> Hi Sage,
> 
> When choosing the second replica, crush_bucket_choose picks an item and crush_choose_{indep,firstn} checks if it has already been chosen for the first replica. If so, it is discarded as a collision[1], r is modified and another attempt is made to get a different item. If no value is found after choose_tries attempt, the mapping is incomplete.
> 
> Another way to do the same would be that crush_bucket_choose / bucket_straw2_choose[2] ignores the items that have already been chosen. It could be done by looping over the list but that would mean N (number of replicas) lookups for each item.
> 
> The current implementation is optimized for the cases where collisions are rare. However, when the weights of the items are two order of magnitude appart or more, choose_tries has to be set to a very large value (more than 1000) for the mapping to succeed. In practice that is not a problem as it is unlikely that a host is 100 times bigger than another host ;-)
> 
> When fixing an uneven distribution[3], CRUSH weights are sometime set to values with that kind of difference (1 against 100) to compensate for the probability bias and/or a small number of samples. For instance when there are 5 hosts with weights 5 1 1 1 1, modifying the weight set fails. It goes as far as 8.9, 0.01, 0.01, 0.01, 0.01 with choose_tries 2000. The value of choose_tries has to be increased a lot for a gain that is smaller and smaller and the CPU usage goes up. In this situation, an alternative implementation of the CRUSH collision seems a good idea.
> 
> Instead of failing after choose_tries attempts, crush_bucket_choose could be called with the list of already chosen items and loop over them to ensure none of them are candidate. The result will always be correct but the implementation more expensive. The default choose_tries could even be set to a lower value (19 instead of 50 ?) since it is likely more expensive to handle 30 more collisions rather than looping over each item already selected.
> 
> What do you think ?
> 
> Cheers
> 
> P.S. Note that even in this border case modifying the weights to 7.1, 0.5, 0.5, 0.4, 0.4 significantly improves the distribution (twice better instead of ten times better). Only it cannot do better because it hits a limitation of the current CRUSH implementation. But it looks like it is not too difficult to fix.
> 
> 
> [1] https://github.com/ceph/ceph/blob/master/src/crush/mapper.c#L541
> [2] https://github.com/ceph/ceph/blob/master/src/crush/mapper.c#L332
> [3] http://marc.info/?l=ceph-devel&m=149407691823750&w=2
> 

diff --git a/crush/libcrush/crush/mapper.c b/crush/libcrush/crush/mapper.c
index c71b614..7d422dc 100644
--- a/crush/libcrush/crush/mapper.c
+++ b/crush/libcrush/crush/mapper.c
@@ -322,7 +322,7 @@ static inline int *get_choose_arg_ids(const struct crush_bucket_straw2 *bucket,
 
 static int bucket_straw2_choose(const struct crush_bucket_straw2 *bucket,
 				int x, int r, const struct crush_choose_arg *arg,
-                                int position)
+                                int position, int *out)
 {
 	unsigned int i, high = 0;
 	unsigned int u;
@@ -331,7 +331,14 @@ static int bucket_straw2_choose(const struct crush_bucket_straw2 *bucket,
         int *ids = get_choose_arg_ids(bucket, arg);
 	for (i = 0; i < bucket->h.size; i++) {
                 dprintk("weight 0x%x item %d\n", weights[i], ids[i]);
-		if (weights[i]) {
+                int skip = 0;
+                for (int j = 0; j < position; j++) {
+                  if (bucket->h.items[i] == out[j]) {
+                    skip = 1;
+                    break;
+                  }
+                }
+		if (skip == 0 && weights[i]) {
 			u = crush_hash32_3(bucket->h.hash, x, ids[i], r);
 			u &= 0xffff;
 
@@ -372,7 +379,7 @@ static int crush_bucket_choose(const struct crush_bucket *in,
 			       struct crush_work_bucket *work,
 			       int x, int r,
                                const struct crush_choose_arg *arg,
-                               int position)
+                               int position, int *out)
 {
 	dprintk(" crush_bucket_choose %d x=%d r=%d\n", in->id, x, r);
 	BUG_ON(in->size == 0);
@@ -394,7 +401,7 @@ static int crush_bucket_choose(const struct crush_bucket *in,
 	case CRUSH_BUCKET_STRAW2:
 		return bucket_straw2_choose(
 			(const struct crush_bucket_straw2 *)in,
-			x, r, arg, position);
+			x, r, arg, position, out);
 	default:
 		dprintk("unknown bucket %d alg %d\n", in->id, in->alg);
 		return in->items[0];
@@ -511,7 +518,7 @@ parent_r %d stable %d\n",
 						in, work->work[-1-in->id],
 						x, r,
                                                 (choose_args ? &choose_args[-1-in->id] : 0),
-                                                outpos);
+                                                outpos, out);
 				if (item >= map->max_devices) {
 					dprintk("   bad item %d\n", item);
 					skip_rep = 1;
@@ -721,7 +728,7 @@ static void crush_choose_indep(const struct crush_map *map,
 					in, work->work[-1-in->id],
 					x, r,
                                         (choose_args ? &choose_args[-1-in->id] : 0),
-                                        outpos);
+                                        outpos, out);
 				if (item >= map->max_devices) {
 					dprintk("   bad item %d\n", item);
 					out[rep] = CRUSH_ITEM_NONE;


-- 
Loïc Dachary, Artisan Logiciel Libre
