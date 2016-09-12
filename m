From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 37/47] block-rbd: Rename a jump label in
 bio_chain_clone_range()
Date: Mon, 12 Sep 2016 21:26:04 +0200
Message-ID: <2dd5023d-2f43-1110-674c-e9c4ece7ee9b@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, Alex Elder <elder@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Sep 2016 19:56:37 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8e9d30f7..abc2dcb 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1421,12 +1421,12 @@ static struct bio *bio_chain_clone_range(struct bio **bio_src,
 
 		if (!bi) {
 			rbd_warn(NULL, "bio_chain exhausted with %u left", len);
-			goto out_err;	/* EINVAL; ran out of bio's */
+			goto put_chain;	/* EINVAL; ran out of bio's */
 		}
 		bi_size = min_t(unsigned int, bi->bi_iter.bi_size - off, len);
 		bio = bio_clone_range(bi, off, bi_size, gfpmask);
 		if (!bio)
-			goto out_err;	/* ENOMEM */
+			goto put_chain;	/* ENOMEM */
 
 		*end = bio;
 		end = &bio->bi_next;
@@ -1442,7 +1442,7 @@ static struct bio *bio_chain_clone_range(struct bio **bio_src,
 	*offset = off;
 
 	return chain;
-out_err:
+ put_chain:
 	bio_chain_put(chain);
 
 	return NULL;
-- 
2.10.0
