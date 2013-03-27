From: Kent Overstreet <koverstreet@google.com>
Subject: [PATCH 16/22] rbd: Refactor bio cloning, don't clone biovecs
Date: Wed, 27 Mar 2013 10:39:46 -0700
Message-ID: <1364405992-28424-17-git-send-email-koverstreet@google.com>
References: <1364405992-28424-1-git-send-email-koverstreet@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1364405992-28424-1-git-send-email-koverstreet@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, dm-devel@vger.kernel.org
Cc: tj@kernel.org, neilb@suse.de, Kent Overstreet <koverstreet@google.com>, Yehuda Sadeh <yehuda@inktank.com>, Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Now that we've got drivers converted to the new immutable bvec
primitives, bio splitting becomes much easier. In a few patches,
bio_clone() will be changed to share the old bio's bvec instead of
copying it, by default.

Signed-off-by: Kent Overstreet <koverstreet@google.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>
Cc: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org
---
 drivers/block/rbd.c | 64 ++---------------------------------------------------
 1 file changed, 2 insertions(+), 62 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d1e4fd8..d4e2406 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -929,73 +929,13 @@ static struct bio *bio_clone_range(struct bio *bio_src,
 					unsigned int len,
 					gfp_t gfpmask)
 {
-	struct bio_vec bv;
-	struct bvec_iter iter;
-	struct bvec_iter end_iter;
-	unsigned int resid;
-	unsigned int voff;
-	unsigned short vcnt;
 	struct bio *bio;
 
-	/* Handle the easy case for the caller */
-
-	if (!offset && len == bio_src->bi_iter.bi_size)
-		return bio_clone(bio_src, gfpmask);
-
-	if (WARN_ON_ONCE(!len))
-		return NULL;
-	if (WARN_ON_ONCE(len > bio_src->bi_iter.bi_size))
-		return NULL;
-	if (WARN_ON_ONCE(offset > bio_src->bi_iter.bi_size - len))
-		return NULL;
-
-	/* Find first affected segment... */
-
-	resid = offset;
-	bio_for_each_segment(bv, bio_src, iter) {
-		if (resid < bv.bv_len)
-			break;
-		resid -= bv.bv_len;
-	}
-	voff = resid;
-
-	/* ...and the last affected segment */
-
-	resid += len;
-	__bio_for_each_segment(bv, bio_src, end_iter, iter) {
-		if (resid <= bv.bv_len)
-			break;
-		resid -= bv.bv_len;
-	}
-	vcnt = end_iter.bi_idx = iter.bi_idx + 1;
-
-	/* Build the clone */
-
-	bio = bio_alloc(gfpmask, (unsigned int) vcnt);
+	bio = bio_clone(bio_src, gfpmask);
 	if (!bio)
 		return NULL;	/* ENOMEM */
 
-	bio->bi_bdev = bio_src->bi_bdev;
-	bio->bi_iter.bi_sector = bio_src->bi_iter.bi_sector +
-		(offset >> SECTOR_SHIFT);
-	bio->bi_rw = bio_src->bi_rw;
-	bio->bi_flags |= 1 << BIO_CLONED;
-
-	/*
-	 * Copy over our part of the bio_vec, then update the first
-	 * and last (or only) entries.
-	 */
-	memcpy(&bio->bi_io_vec[0], &bio_src->bi_io_vec[iter.bi_idx],
-			vcnt * sizeof (struct bio_vec));
-	bio->bi_io_vec[0].bv_offset += voff;
-	if (vcnt > 1) {
-		bio->bi_io_vec[0].bv_len -= voff;
-		bio->bi_io_vec[vcnt - 1].bv_len = resid;
-	} else {
-		bio->bi_io_vec[0].bv_len = len;
-	}
-
-	bio->bi_vcnt = vcnt;
+	bio_advance(bio, offset);
 	bio->bi_iter.bi_size = len;
 
 	return bio;
-- 
1.8.1.3
