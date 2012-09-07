From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/5] rbd: define rbd_assert()
Date: Fri, 07 Sep 2012 08:39:15 -0500
Message-ID: <5049F903.4070003@inktank.com>
References: <5049F7F5.1070609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60946 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758909Ab2IGNjR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 09:39:17 -0400
Received: by ieje11 with SMTP id e11so5001652iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 06:39:17 -0700 (PDT)
In-Reply-To: <5049F7F5.1070609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Define rbd_assert() and use it in place of various BUG_ON() calls
now present in the code.  By default assertion checking is enabled;
we want to do this differently at some point.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7ba70c4..d84b534 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -41,6 +41,8 @@

 #include "rbd_types.h"

+#define RBD_DEBUG	/* Activate rbd_assert() calls */
+
 /*
  * The basic unit of block I/O is a sector.  It is interpreted in a
  * number of contexts in Linux (blk, bio, genhd), but the default is
@@ -232,6 +234,18 @@ static struct device rbd_root_dev = {
 	.release =      rbd_root_dev_release,
 };

+#ifdef RBD_DEBUG
+#define rbd_assert(expr)						\
+		if (unlikely(!(expr))) {				\
+			printk(KERN_ERR "\nAssertion failure in %s() "	\
+						"at line %d:\n\n"	\
+					"\trbd_assert(%s);\n\n",	\
+					__func__, __LINE__, #expr);	\
+			BUG();						\
+		}
+#else /* !RBD_DEBUG */
+#  define rbd_assert(expr)	((void) 0)
+#endif /* !RBD_DEBUG */

 static struct device *rbd_get_dev(struct rbd_device *rbd_dev)
 {
@@ -406,7 +420,8 @@ static int parse_rbd_opts_token(char *c, void *private)
 		rbd_opts->read_only = false;
 		break;
 	default:
-		BUG_ON(token);
+		rbd_assert(false);
+		break;
 	}
 	return 0;
 }
@@ -705,7 +720,7 @@ static u64 rbd_segment_length(struct rbd_device
*rbd_dev,

 	offset &= segment_size - 1;

-	BUG_ON(length > U64_MAX - offset);
+	rbd_assert(length <= U64_MAX - offset);
 	if (offset + length > segment_size)
 		length = segment_size - offset;

@@ -842,7 +857,7 @@ static struct bio *bio_chain_clone(struct bio **old,
struct bio **next,
 		total += tmp->bi_size;
 	}

-	BUG_ON(total < len);
+	rbd_assert(total == len);

 	*old = old_chain;

@@ -1101,7 +1116,7 @@ static int rbd_req_sync_op(struct rbd_device *rbd_dev,
 	struct page **pages;
 	int num_pages;

-	BUG_ON(ops == NULL);
+	rbd_assert(ops != NULL);

 	num_pages = calc_pages_for(ofs , len);
 	pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
@@ -1163,7 +1178,7 @@ static int rbd_do_op(struct request *rq,
 	/* we've taken care of segment sizes earlier when we
 	   cloned the bios. We should never have a segment
 	   truncated at this point */
-	BUG_ON(seg_len < len);
+	rbd_assert(seg_len == len);

 	ret = rbd_do_request(rq, rbd_dev, snapc, snapid,
 			     seg_name, seg_ofs, seg_len,
@@ -2186,7 +2201,7 @@ static int __rbd_init_snaps_header(struct
rbd_device *rbd_dev)
 					     : CEPH_NOSNAP;
 		snap = links != head ? list_entry(links, struct rbd_snap, node)
 				     : NULL;
-		BUG_ON(snap && snap->id == CEPH_NOSNAP);
+		rbd_assert(!snap || snap->id != CEPH_NOSNAP);

 		if (snap_id == CEPH_NOSNAP || (snap && snap->id > snap_id)) {
 			struct list_head *next = links->next;
@@ -2222,8 +2237,9 @@ static int __rbd_init_snaps_header(struct
rbd_device *rbd_dev)
 		} else {
 			/* Already have this one */

-			BUG_ON(snap->size != rbd_dev->header.snap_sizes[index]);
-			BUG_ON(strcmp(snap->name, snap_name));
+			rbd_assert(snap->size ==
+					rbd_dev->header.snap_sizes[index]);
+			rbd_assert(!strcmp(snap->name, snap_name));

 			/* Done with this list entry; advance */

@@ -2313,7 +2329,7 @@ static void rbd_id_put(struct rbd_device *rbd_dev)
 	int rbd_id = rbd_dev->dev_id;
 	int max_id;

-	BUG_ON(rbd_id < 1);
+	rbd_assert(rbd_id > 0);

 	spin_lock(&rbd_dev_list_lock);
 	list_del_init(&rbd_dev->node);
@@ -2705,6 +2721,7 @@ static ssize_t rbd_remove(struct bus_type *bus,

 done:
 	mutex_unlock(&ctl_mutex);
+
 	return ret;
 }

-- 
1.7.9.5

