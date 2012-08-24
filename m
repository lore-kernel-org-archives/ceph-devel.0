From: Alex Elder <elder@inktank.com>
Subject: [PATCH 08/11] rbd: bio_chain_clone() cleanups
Date: Fri, 24 Aug 2012 11:35:04 -0500
Message-ID: <5037AD38.9070701@inktank.com>
References: <5037AB20.4000103@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45658 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964839Ab2HXQfL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 12:35:11 -0400
Received: by mail-iy0-f174.google.com with SMTP id o24so3735552ial.19
        for <ceph-devel@vger.kernel.org>; Fri, 24 Aug 2012 09:35:11 -0700 (PDT)
In-Reply-To: <5037AB20.4000103@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In bio_chain_clone(), at the end of the function the bi_next field
of the tail of the new bio chain is nulled.  This isn't necessary,
because if "tail" is non-null, its value will be the last bio
structure allocated at the top of the while loop in that function.
And before that structure is added to the end of the new chain, its
bi_next pointer is always made null.

While touching that function, clean a few other things:
    - define each local variable on its own line
    - move the definition of "tmp" to an inner scope
    - move the modification of gfpmask closer to where it's used
    - rearrange the logic that sets the chain's tail pointer

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e94336d..bb8dad7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -741,7 +741,9 @@ static struct bio *bio_chain_clone(struct bio **old,
struct bio **next,
 				   struct bio_pair **bp,
 				   int len, gfp_t gfpmask)
 {
-	struct bio *tmp, *old_chain = *old, *new_chain = NULL, *tail = NULL;
+	struct bio *old_chain = *old;
+	struct bio *new_chain = NULL;
+	struct bio *tail;
 	int total = 0;

 	if (*bp) {
@@ -750,9 +752,12 @@ static struct bio *bio_chain_clone(struct bio
**old, struct bio **next,
 	}

 	while (old_chain && (total < len)) {
+		struct bio *tmp;
+
 		tmp = bio_kmalloc(gfpmask, old_chain->bi_max_vecs);
 		if (!tmp)
 			goto err_out;
+		gfpmask &= ~__GFP_WAIT;	/* can't wait after the first */

 		if (total + old_chain->bi_size > len) {
 			struct bio_pair *bp;
@@ -780,15 +785,12 @@ static struct bio *bio_chain_clone(struct bio
**old, struct bio **next,
 		}

 		tmp->bi_bdev = NULL;
-		gfpmask &= ~__GFP_WAIT;
 		tmp->bi_next = NULL;
-
-		if (!new_chain) {
-			new_chain = tail = tmp;
-		} else {
+		if (new_chain)
 			tail->bi_next = tmp;
-			tail = tmp;
-		}
+		else
+			new_chain = tmp;
+		tail = tmp;
 		old_chain = old_chain->bi_next;

 		total += tmp->bi_size;
@@ -796,9 +798,6 @@ static struct bio *bio_chain_clone(struct bio **old,
struct bio **next,

 	BUG_ON(total < len);

-	if (tail)
-		tail->bi_next = NULL;
-
 	*old = old_chain;

 	return new_chain;
-- 
1.7.9.5

