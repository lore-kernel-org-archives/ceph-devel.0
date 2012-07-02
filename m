From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH] rbd: fix the memory leak of bio_chain_clone
Date: Mon, 2 Jul 2012 15:48:14 -0700
Message-ID: <CAC-hyiFJSDtmgbSXn=N-mNKcuWuqiE9fPxtVz1fRFw4Q-j7HMg@mail.gmail.com>
References: <1340609863-10971-1-git-send-email-gzhao@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62318 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab2GBWsQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 18:48:16 -0400
Received: by bkwj10 with SMTP id j10so1146378bkw.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 15:48:14 -0700 (PDT)
In-Reply-To: <1340609863-10971-1-git-send-email-gzhao@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guangliang Zhao <gzhao@suse.com>
Cc: ceph-devel@vger.kernel.org, Alex Elder <elder@inktank.com>

On Mon, Jun 25, 2012 at 12:37 AM, Guangliang Zhao <gzhao@suse.com> wrote:
> Signed-off-by: Guangliang Zhao <gzhao@suse.com>
> ---
>  drivers/block/rbd.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 65665c9..3d6dfc8 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -719,8 +719,6 @@ static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
>                         goto err_out;
>
>                 if (total + old_chain->bi_size > len) {
> -                       struct bio_pair *bp;
> -
>                         /*
>                          * this split can only happen with a single paged bio,
>                          * split_bio will BUG_ON if this is not the case
> @@ -732,13 +730,13 @@ static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
>
>                         /* split the bio. We'll release it either in the next
>                            call, or it will have to be released outside */
> -                       bp = bio_split(old_chain, (len - total) / SECTOR_SIZE);
> -                       if (!bp)
> +                       *bp = bio_split(old_chain, (len - total) / SECTOR_SIZE);
> +                       if (!*bp)
>                                 goto err_out;
>
> -                       __bio_clone(tmp, &bp->bio1);
> +                       __bio_clone(tmp, &(*bp)->bio1);
>
> -                       *next = &bp->bio2;
> +                       *next = &(*bp)->bio2;
>                 } else {
>                         __bio_clone(tmp, old_chain);
>                         *next = old_chain->bi_next;

The above patch looks right, that is, fixes a leak. However, I'm not
too sure that we're not missing some bigger problem that was hidden
(due to the leak). Effectively we never called bio_pair_release() on
the bio_pair that we created in bio_chain_clone(). However, I think we
should only call that after we're done with sending the data. So we
should keep the bio_pair with the request and clear it up when we're
done with the request. Something along the lines of:


diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 013c7a5..7bf3e36 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -131,6 +131,7 @@ struct rbd_req_coll {
  */
 struct rbd_request {
 	struct request		*rq;		/* blk layer request */
+	struct bio_pair		*bp;
 	struct bio		*bio;		/* cloned bio */
 	struct page		**pages;	/* list of used pages */
 	u64			len;
@@ -867,6 +868,7 @@ static int rbd_do_request(struct request *rq,
 			  struct ceph_snap_context *snapc,
 			  u64 snapid,
 			  const char *obj, u64 ofs, u64 len,
+			  struct bio_pair *bp,
 			  struct bio *bio,
 			  struct page **pages,
 			  int num_pages,
@@ -918,6 +920,7 @@ static int rbd_do_request(struct request *rq,
 	req->r_callback = rbd_cb;

 	req_data->rq = rq;
+	req_data->bp = bp;
 	req_data->bio = bio;
 	req_data->pages = pages;
 	req_data->len = len;
@@ -968,6 +971,7 @@ static int rbd_do_request(struct request *rq,

 done_err:
 	bio_chain_put(req_data->bio);
+	bio_pair_release(req_data->bp);
 	ceph_osdc_put_request(req);
 done_pages:
 	rbd_coll_end_req(req_data, ret, len);
@@ -1010,6 +1014,9 @@ static void rbd_req_cb(struct ceph_osd_request
*req, struct ceph_msg *msg)
 	if (req_data->bio)
 		bio_chain_put(req_data->bio);

+	if (req_data->bp)
+		bio_pair_release(req_data->bp);
+
 	ceph_osdc_put_request(req);
 	kfree(req_data);
 }
@@ -1060,7 +1067,7 @@ static int rbd_req_sync_op(struct rbd_device *dev,
 	}

 	ret = rbd_do_request(NULL, dev, snapc, snapid,
-			  obj, ofs, len, NULL,
+			  obj, ofs, len, NULL, NULL,
 			  pages, num_pages,
 			  flags,
 			  ops,
@@ -1091,6 +1098,7 @@ static int rbd_do_op(struct request *rq,
 		     u64 snapid,
 		     int opcode, int flags, int num_reply,
 		     u64 ofs, u64 len,
+		     struct bio_pair *bp,
 		     struct bio *bio,
 		     struct rbd_req_coll *coll,
 		     int coll_index)
@@ -1124,6 +1132,7 @@ static int rbd_do_op(struct request *rq,

 	ret = rbd_do_request(rq, rbd_dev, snapc, snapid,
 			     seg_name, seg_ofs, seg_len,
+			     bp,
 			     bio,
 			     NULL, 0,
 			     flags,
@@ -1145,6 +1154,7 @@ static int rbd_req_write(struct request *rq,
 			 struct rbd_device *rbd_dev,
 			 struct ceph_snap_context *snapc,
 			 u64 ofs, u64 len,
+			 struct bio_pair *bp,
 			 struct bio *bio,
 			 int coll_index)
@@ -1153,7 +1163,7 @@ static int rbd_req_write(struct request *rq,
 			 CEPH_OSD_OP_WRITE,
 			 CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
 			 2,
-			 ofs, len, bio, coll, coll_index);
+			 ofs, len, bp, bio, coll, coll_index);
 }

 /*
@@ -1163,6 +1173,7 @@ static int rbd_req_read(struct request *rq,
 			 struct rbd_device *rbd_dev,
 			 u64 snapid,
 			 u64 ofs, u64 len,
+			 struct bio_pair *bp,
 			 struct bio *bio,
 			 struct rbd_req_coll *coll,
 			 int coll_index)
@@ -1172,7 +1183,7 @@ static int rbd_req_read(struct request *rq,
 			 CEPH_OSD_OP_READ,
 			 CEPH_OSD_FLAG_READ,
 			 2,
-			 ofs, len, bio, coll, coll_index);
+			 ofs, len, bp, bio, coll, coll_index);
 }

 /*
@@ -1215,7 +1226,7 @@ static int rbd_req_sync_notify_ack(struct rbd_device *dev,
 	ops[0].watch.flag = 0;

 	ret = rbd_do_request(NULL, dev, NULL, CEPH_NOSNAP,
-			  obj, 0, 0, NULL,
+			  obj, 0, 0, NULL, NULL,
 			  pages, 0,
 			  CEPH_OSD_FLAG_READ,
 			  ops,
@@ -1517,13 +1528,13 @@ static void rbd_rq_fn(struct request_queue *q)
 				rbd_req_write(rq, rbd_dev,
 					      rbd_dev->header.snapc,
 					      ofs,
-					      op_size, bio,
+					      op_size, bp, bio,
 					      coll, cur_seg);
 			else
 				rbd_req_read(rq, rbd_dev,
 					     cur_snap_id(rbd_dev),
 					     ofs,
-					     op_size, bio,
+					     op_size, bp, bio,
 					     coll, cur_seg);

 next_seg:
@@ -1535,8 +1546,6 @@ next_seg:
 		} while (size > 0);
 		kref_put(&coll->kref, rbd_coll_release);

-		if (bp)
-			bio_pair_release(bp);
 		spin_lock_irq(q->queue_lock);
 	}
 }
