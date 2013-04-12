From: Alex Elder <elder@inktank.com>
Subject: [PATCH 05/11] rbd: define image request originator flag
Date: Thu, 11 Apr 2013 21:17:51 -0500
Message-ID: <51676ECF.3020100@inktank.com>
References: <51676E0F.2010504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:41604 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab3DLCRw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 22:17:52 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so2889158ieb.31
        for <ceph-devel@vger.kernel.org>; Thu, 11 Apr 2013 19:17:51 -0700 (PDT)
In-Reply-To: <51676E0F.2010504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Define a flag indicating whether an image request originated from
the Linux block layer (from blk_fetch_request()) or whether it was
initiated in order to satisfy an object request for a child image
of a layered rbd device.  For image requests initiated by objects of
child images we'll save a pointer to the object request rather than
the Linux block request.

For now, only block requests are used.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5ea2e36..7ecd909 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -203,18 +203,22 @@ struct rbd_obj_request {
 };

 enum img_req_flags {
-	IMG_REQ_WRITE,		/* read = 0, write = 1 */
+	IMG_REQ_WRITE,		/* I/O direction: read = 0, write = 1 */
+	IMG_REQ_CHILD,		/* initiator: block = 0, child image = 1 */
 };

 struct rbd_img_request {
-	struct request		*rq;
 	struct rbd_device	*rbd_dev;
 	u64			offset;	/* starting image byte offset */
 	u64			length;	/* byte count from offset */
 	unsigned long		flags;
 	union {
+		u64			snap_id;	/* for reads */
 		struct ceph_snap_context *snapc;	/* for writes */
-		u64		snap_id;		/* for reads */
+	};
+	union {
+		struct request		*rq;		/* block request */
+		struct rbd_obj_request	*obj_request;	/* obj req initiator */
 	};
 	spinlock_t		completion_lock;/* protects next_completion */
 	u32			next_completion;
@@ -1231,6 +1235,18 @@ static bool img_request_write_test(struct
rbd_img_request *img_request)
 	return test_bit(IMG_REQ_WRITE, &img_request->flags) != 0;
 }

+static void img_request_child_set(struct rbd_img_request *img_request)
+{
+	set_bit(IMG_REQ_CHILD, &img_request->flags);
+	smp_mb();
+}
+
+static bool img_request_child_test(struct rbd_img_request *img_request)
+{
+	smp_mb();
+	return test_bit(IMG_REQ_CHILD, &img_request->flags) != 0;
+}
+
 static void
 rbd_img_obj_request_read_callback(struct rbd_obj_request *obj_request)
 {
@@ -1499,7 +1515,8 @@ static void rbd_obj_request_destroy(struct kref *kref)
 static struct rbd_img_request *rbd_img_request_create(
 					struct rbd_device *rbd_dev,
 					u64 offset, u64 length,
-					bool write_request)
+					bool write_request,
+					bool child_request)
 {
 	struct rbd_img_request *img_request;
 	struct ceph_snap_context *snapc = NULL;
@@ -1530,6 +1547,8 @@ static struct rbd_img_request *rbd_img_request_create(
 	} else {
 		img_request->snap_id = rbd_dev->spec->snap_id;
 	}
+	if (child_request)
+		img_request_child_set(img_request);
 	spin_lock_init(&img_request->completion_lock);
 	img_request->next_completion = 0;
 	img_request->callback = NULL;
@@ -1578,7 +1597,9 @@ static void rbd_img_obj_callback(struct
rbd_obj_request *obj_request)

 	dout("%s: img %p obj %p\n", __func__, img_request, obj_request);
 	rbd_assert(img_request != NULL);
+	rbd_assert(!img_request_child_test(img_request))
 	rbd_assert(img_request->rq != NULL);
+
 	rbd_assert(img_request->obj_request_count > 0);
 	rbd_assert(which != BAD_WHICH);
 	rbd_assert(which < img_request->obj_request_count);
@@ -2012,7 +2033,7 @@ static void rbd_request_fn(struct request_queue *q)

 		result = -ENOMEM;
 		img_request = rbd_img_request_create(rbd_dev, offset, length,
-							write_request);
+							write_request, false);
 		if (!img_request)
 			goto end_request;

-- 
1.7.9.5

