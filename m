From: Guangliang Zhao <gzhao@suse.com>
Subject: [PATCH] rbd: fix the memory leak of bio_chain_clone
Date: Mon, 25 Jun 2012 15:37:43 +0800
Message-ID: <1340609863-10971-1-git-send-email-gzhao@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:54772 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988Ab2FYHh6 (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 25 Jun 2012 03:37:58 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: gzhao@suse.com

Signed-off-by: Guangliang Zhao <gzhao@suse.com>
---
 drivers/block/rbd.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 65665c9..3d6dfc8 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -719,8 +719,6 @@ static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
 			goto err_out;
 
 		if (total + old_chain->bi_size > len) {
-			struct bio_pair *bp;
-
 			/*
 			 * this split can only happen with a single paged bio,
 			 * split_bio will BUG_ON if this is not the case
@@ -732,13 +730,13 @@ static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
 
 			/* split the bio. We'll release it either in the next
 			   call, or it will have to be released outside */
-			bp = bio_split(old_chain, (len - total) / SECTOR_SIZE);
-			if (!bp)
+			*bp = bio_split(old_chain, (len - total) / SECTOR_SIZE);
+			if (!*bp)
 				goto err_out;
 
-			__bio_clone(tmp, &bp->bio1);
+			__bio_clone(tmp, &(*bp)->bio1);
 
-			*next = &bp->bio2;
+			*next = &(*bp)->bio2;
 		} else {
 			__bio_clone(tmp, old_chain);
 			*next = old_chain->bi_next;
-- 
1.7.3.4

