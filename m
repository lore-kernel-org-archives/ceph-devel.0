From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] rbd: simplify rbd_merge_bvec()
Date: Mon, 22 Oct 2012 11:51:43 -0500
Message-ID: <5085799F.6090405@inktank.com>
References: <5085791C.9010205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:41228 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab2JVQvq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 12:51:46 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2214021iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 09:51:46 -0700 (PDT)
In-Reply-To: <5085791C.9010205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The aim of this patch is to make what's going on rbd_merge_bvec() a
bit more obvious than it was before.  This was an issue when a
recent btrfs bug led us to question whether the merge function was
working correctly.

Use "seg" rather than "chunk" to indicate the units whose boundaries
we care about we call "segments."

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   51
+++++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4858d92..4ccce4d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1566,22 +1566,41 @@ static int rbd_merge_bvec(struct request_queue
*q, struct bvec_merge_data *bmd,
 			  struct bio_vec *bvec)
 {
 	struct rbd_device *rbd_dev = q->queuedata;
-	unsigned int chunk_sectors;
-	sector_t sector;
-	unsigned int bio_sectors;
-	int max;
-
-	chunk_sectors = 1 << (rbd_dev->header.obj_order - SECTOR_SHIFT);
-	sector = bmd->bi_sector + get_start_sect(bmd->bi_bdev);
-	bio_sectors = bmd->bi_size >> SECTOR_SHIFT;
-
-	max =  (chunk_sectors - ((sector & (chunk_sectors - 1))
-				 + bio_sectors)) << SECTOR_SHIFT;
-	if (max < 0)
-		max = 0; /* bio_add cannot handle a negative return */
-	if (max <= bvec->bv_len && bio_sectors == 0)
-		return bvec->bv_len;
-	return max;
+	sector_t sector_offset;
+	sector_t sectors_per_seg;
+	sector_t seg_sector_offset;
+	int ret;
+
+	/*
+	 * Find how far into its rbd segment the partition-relative
+	 * bio start sector is to offset relative to the enclosing
+	 * device.
+	 */
+	sector_offset = get_start_sect(bmd->bi_bdev) + bmd->bi_sector;
+	sectors_per_seg = 1 << (rbd_dev->header.obj_order - SECTOR_SHIFT);
+	seg_sector_offset = sector_offset & (sectors_per_seg - 1);
+
+	/*
+	 * Compute the number of bytes from that offset to the end
+	 * of the segment.  Account for what's already used by the bio.
+	 */
+	ret = (int) (sectors_per_seg - seg_sector_offset) << SECTOR_SHIFT;
+	if (ret >= bmd->bi_size)
+		ret -= bmd->bi_size;
+	else
+		ret = 0;
+
+	/*
+	 * Don't send back more than was asked for.  And if the bio
+	 * was empty, let the whole thing through because:  "Note
+	 * that a block device *must* allow a single page to be
+	 * added to an empty bio."
+	 */
+	rbd_assert(bvec->bv_len <= PAGE_SIZE);
+	if (ret > (int) bvec->bv_len || !bmd->bi_size)
+		ret = (int) bvec->bv_len;
+
+	return ret;
 }

 static void rbd_free_disk(struct rbd_device *rbd_dev)
-- 
1.7.9.5

