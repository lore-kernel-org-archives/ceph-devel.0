From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [PATCH v2] rbd: convert to blk-mq
Date: Mon, 12 Jan 2015 14:32:51 +0100 (CET)
Message-ID: <775800704.3794356.1421069571230.JavaMail.zimbra@oxygem.tv>
References: <1420914688-27563-1-git-send-email-hch@lst.de> <54B1B864.4080008@ieee.org> <20150112124002.GA29490@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:48254 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbbALNcx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jan 2015 08:32:53 -0500
In-Reply-To: <1682521695.3794355.1421069570592.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alex Elder <elder@ieee.org>, Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, Alex Elder <elder@kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Christoph,

I'll have my production cluster ready around next month,

with a lot more powerfull nodes (each node : 2x10 cores 3,1ghz + 6 ssd =
intel s3500).

I'll redo benchmark and I post results as soon as possible.


----- Mail original -----
De: "Christoph Hellwig" <hch@lst.de>
=C3=80: "Alex Elder" <elder@ieee.org>
Cc: "Yehuda Sadeh" <yehuda@inktank.com>, "Sage Weil" <sage@inktank.com>=
, "Alex Elder" <elder@kernel.org>, "aderumier" <aderumier@odiso.com>, "=
ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Lundi 12 Janvier 2015 13:40:02
Objet: [PATCH v2] rbd: convert to blk-mq

This converts the rbd driver to use the blk-mq infrastructure. Except=20
for switching to a per-request work item this is almost mechanical.=20

This was tested by Alexandre DERUMIER in November, and found to give=20
him 120000 iops, although the only comparism available was an old=20
3.10 kernel which gave 80000iops.=20

Signed-off-by: Christoph Hellwig <hch@lst.de>=20
Reviewed-by: Alex Elder <elder@linaro.org>=20
---=20
drivers/block/rbd.c | 120 +++++++++++++++++++++++++++++----------------=
-------=20
1 file changed, 67 insertions(+), 53 deletions(-)=20

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c=20
index 3ec85df..c64a798 100644=20
--- a/drivers/block/rbd.c=20
+++ b/drivers/block/rbd.c=20
@@ -38,6 +38,7 @@=20
#include <linux/kernel.h>=20
#include <linux/device.h>=20
#include <linux/module.h>=20
+#include <linux/blk-mq.h>=20
#include <linux/fs.h>=20
#include <linux/blkdev.h>=20
#include <linux/slab.h>=20
@@ -340,9 +341,7 @@ struct rbd_device {=20

char name[DEV_NAME_LEN]; /* blkdev name, e.g. rbd3 */=20

- struct list_head rq_queue; /* incoming rq queue */=20
spinlock_t lock; /* queue, flags, open_count */=20
- struct work_struct rq_work;=20

struct rbd_image_header header;=20
unsigned long flags; /* possibly lock protected */=20
@@ -360,6 +359,9 @@ struct rbd_device {=20
atomic_t parent_ref;=20
struct rbd_device *parent;=20

+ /* Block layer tags. */=20
+ struct blk_mq_tag_set tag_set;=20
+=20
/* protects updating the header */=20
struct rw_semaphore header_rwsem;=20

@@ -1817,7 +1819,8 @@ static void rbd_osd_req_callback(struct ceph_osd_=
request *osd_req,=20

/*=20
* We support a 64-bit length, but ultimately it has to be=20
- * passed to blk_end_request(), which takes an unsigned int.=20
+ * passed to the block layer, which just supports a 32-bit=20
+ * length field.=20
*/=20
obj_request->xferred =3D osd_req->r_reply_op_len[0];=20
rbd_assert(obj_request->xferred < (u64)UINT_MAX);=20
@@ -2281,7 +2284,10 @@ static bool rbd_img_obj_end_request(struct rbd_o=
bj_request *obj_request)=20
more =3D obj_request->which < img_request->obj_request_count - 1;=20
} else {=20
rbd_assert(img_request->rq !=3D NULL);=20
- more =3D blk_end_request(img_request->rq, result, xferred);=20
+=20
+ more =3D blk_update_request(img_request->rq, result, xferred);=20
+ if (!more)=20
+ __blk_mq_end_request(img_request->rq, result);=20
}=20

return more;=20
@@ -3310,8 +3316,10 @@ out:=20
return ret;=20
}=20

-static void rbd_handle_request(struct rbd_device *rbd_dev, struct requ=
est *rq)=20
+static void rbd_queue_workfn(struct work_struct *work)=20
{=20
+ struct request *rq =3D blk_mq_rq_from_pdu(work);=20
+ struct rbd_device *rbd_dev =3D rq->q->queuedata;=20
struct rbd_img_request *img_request;=20
struct ceph_snap_context *snapc =3D NULL;=20
u64 offset =3D (u64)blk_rq_pos(rq) << SECTOR_SHIFT;=20
@@ -3320,6 +3328,13 @@ static void rbd_handle_request(struct rbd_device=
 *rbd_dev, struct request *rq)=20
u64 mapping_size;=20
int result;=20

+ if (rq->cmd_type !=3D REQ_TYPE_FS) {=20
+ dout("%s: non-fs request type %d\n", __func__,=20
+ (int) rq->cmd_type);=20
+ result =3D -EIO;=20
+ goto err;=20
+ }=20
+=20
if (rq->cmd_flags & REQ_DISCARD)=20
op_type =3D OBJ_OP_DISCARD;=20
else if (rq->cmd_flags & REQ_WRITE)=20
@@ -3358,6 +3373,8 @@ static void rbd_handle_request(struct rbd_device =
*rbd_dev, struct request *rq)=20
goto err_rq;=20
}=20

+ blk_mq_start_request(rq);=20
+=20
if (offset && length > U64_MAX - offset + 1) {=20
rbd_warn(rbd_dev, "bad request range (%llu~%llu)", offset,=20
length);=20
@@ -3411,52 +3428,18 @@ err_rq:=20
obj_op_name(op_type), length, offset, result);=20
ceph_put_snap_context(snapc);=20
blk_end_request_all(rq, result);=20
+err:=20
+ blk_mq_end_request(rq, result);=20
}=20

-static void rbd_request_workfn(struct work_struct *work)=20
+static int rbd_queue_rq(struct blk_mq_hw_ctx *hctx,=20
+ const struct blk_mq_queue_data *bd)=20
{=20
- struct rbd_device *rbd_dev =3D=20
- container_of(work, struct rbd_device, rq_work);=20
- struct request *rq, *next;=20
- LIST_HEAD(requests);=20
-=20
- spin_lock_irq(&rbd_dev->lock); /* rq->q->queue_lock */=20
- list_splice_init(&rbd_dev->rq_queue, &requests);=20
- spin_unlock_irq(&rbd_dev->lock);=20
-=20
- list_for_each_entry_safe(rq, next, &requests, queuelist) {=20
- list_del_init(&rq->queuelist);=20
- rbd_handle_request(rbd_dev, rq);=20
- }=20
-}=20
-=20
-/*=20
- * Called with q->queue_lock held and interrupts disabled, possibly on=
=20
- * the way to schedule(). Do not sleep here!=20
- */=20
-static void rbd_request_fn(struct request_queue *q)=20
-{=20
- struct rbd_device *rbd_dev =3D q->queuedata;=20
- struct request *rq;=20
- int queued =3D 0;=20
-=20
- rbd_assert(rbd_dev);=20
-=20
- while ((rq =3D blk_fetch_request(q))) {=20
- /* Ignore any non-FS requests that filter through. */=20
- if (rq->cmd_type !=3D REQ_TYPE_FS) {=20
- dout("%s: non-fs request type %d\n", __func__,=20
- (int) rq->cmd_type);=20
- __blk_end_request_all(rq, 0);=20
- continue;=20
- }=20
-=20
- list_add_tail(&rq->queuelist, &rbd_dev->rq_queue);=20
- queued++;=20
- }=20
+ struct request *rq =3D bd->rq;=20
+ struct work_struct *work =3D blk_mq_rq_to_pdu(rq);=20

- if (queued)=20
- queue_work(rbd_wq, &rbd_dev->rq_work);=20
+ queue_work(rbd_wq, work);=20
+ return BLK_MQ_RQ_QUEUE_OK;=20
}=20

/*=20
@@ -3517,6 +3500,7 @@ static void rbd_free_disk(struct rbd_device *rbd_=
dev)=20
del_gendisk(disk);=20
if (disk->queue)=20
blk_cleanup_queue(disk->queue);=20
+ blk_mq_free_tag_set(&rbd_dev->tag_set);=20
}=20
put_disk(disk);=20
}=20
@@ -3728,11 +3712,28 @@ static int rbd_dev_refresh(struct rbd_device *r=
bd_dev)=20
return 0;=20
}=20

+static int rbd_init_request(void *data, struct request *rq,=20
+ unsigned int hctx_idx, unsigned int request_idx,=20
+ unsigned int numa_node)=20
+{=20
+ struct work_struct *work =3D blk_mq_rq_to_pdu(rq);=20
+=20
+ INIT_WORK(work, rbd_queue_workfn);=20
+ return 0;=20
+}=20
+=20
+static struct blk_mq_ops rbd_mq_ops =3D {=20
+ .queue_rq =3D rbd_queue_rq,=20
+ .map_queue =3D blk_mq_map_queue,=20
+ .init_request =3D rbd_init_request,=20
+};=20
+=20
static int rbd_init_disk(struct rbd_device *rbd_dev)=20
{=20
struct gendisk *disk;=20
struct request_queue *q;=20
u64 segment_size;=20
+ int err;=20

/* create gendisk info */=20
disk =3D alloc_disk(single_major ?=20
@@ -3750,10 +3751,24 @@ static int rbd_init_disk(struct rbd_device *rbd=
_dev)=20
disk->fops =3D &rbd_bd_ops;=20
disk->private_data =3D rbd_dev;=20

- q =3D blk_init_queue(rbd_request_fn, &rbd_dev->lock);=20
- if (!q)=20
+ memset(&rbd_dev->tag_set, 0, sizeof(rbd_dev->tag_set));=20
+ rbd_dev->tag_set.ops =3D &rbd_mq_ops;=20
+ rbd_dev->tag_set.queue_depth =3D BLKDEV_MAX_RQ;=20
+ rbd_dev->tag_set.numa_node =3D NUMA_NO_NODE;=20
+ rbd_dev->tag_set.flags =3D=20
+ BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;=20
+ rbd_dev->tag_set.nr_hw_queues =3D 1;=20
+ rbd_dev->tag_set.cmd_size =3D sizeof(struct work_struct);=20
+=20
+ err =3D blk_mq_alloc_tag_set(&rbd_dev->tag_set);=20
+ if (err)=20
goto out_disk;=20

+ err =3D -ENOMEM;=20
+ q =3D blk_mq_init_queue(&rbd_dev->tag_set);=20
+ if (!q)=20
+ goto out_tag_set;=20
+=20
/* We use the default size, but let's be explicit about it. */=20
blk_queue_physical_block_size(q, SECTOR_SIZE);=20

@@ -3779,10 +3794,11 @@ static int rbd_init_disk(struct rbd_device *rbd=
_dev)=20
rbd_dev->disk =3D disk;=20

return 0;=20
+out_tag_set:=20
+ blk_mq_free_tag_set(&rbd_dev->tag_set);=20
out_disk:=20
put_disk(disk);=20
-=20
- return -ENOMEM;=20
+ return err;=20
}=20

/*=20
@@ -4039,8 +4055,6 @@ static struct rbd_device *rbd_dev_create(struct r=
bd_client *rbdc,=20
return NULL;=20

spin_lock_init(&rbd_dev->lock);=20
- INIT_LIST_HEAD(&rbd_dev->rq_queue);=20
- INIT_WORK(&rbd_dev->rq_work, rbd_request_workfn);=20
rbd_dev->flags =3D 0;=20
atomic_set(&rbd_dev->parent_ref, 0);=20
INIT_LIST_HEAD(&rbd_dev->node);=20
--=20
1.9.1=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
