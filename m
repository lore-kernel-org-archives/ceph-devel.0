From: Alex Elder <elder@inktank.com>
Subject: [PATCH 04/11] rbd: define image request flags
Date: Thu, 11 Apr 2013 21:17:40 -0500
Message-ID: <51676EC4.1070601@inktank.com>
References: <51676E0F.2010504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41872 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab3DLCRl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 22:17:41 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so2803167iec.19
        for <ceph-devel@vger.kernel.org>; Thu, 11 Apr 2013 19:17:40 -0700 (PDT)
In-Reply-To: <51676E0F.2010504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There are several Boolean values we'll be maintaining for image
requests.  Switch from the single write_request field to a
general-purpose flags field, and use one if its bits to represent
the direction of I/O for the image request.  Define helper functions
for setting and testing that flag.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f0124c5..5ea2e36 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -202,12 +202,16 @@ struct rbd_obj_request {
 	struct kref		kref;
 };

+enum img_req_flags {
+	IMG_REQ_WRITE,		/* read = 0, write = 1 */
+};
+
 struct rbd_img_request {
 	struct request		*rq;
 	struct rbd_device	*rbd_dev;
 	u64			offset;	/* starting image byte offset */
 	u64			length;	/* byte count from offset */
-	bool			write_request;	/* false for read */
+	unsigned long		flags;
 	union {
 		struct ceph_snap_context *snapc;	/* for writes */
 		u64		snap_id;		/* for reads */
@@ -1210,6 +1214,23 @@ static bool obj_request_done_test(struct
rbd_obj_request *obj_request)
 	return atomic_read(&obj_request->done) != 0;
 }

+/*
+ * The default/initial value for all image request flags is 0.  Each
+ * is conditionally set to 1 at image request initialization time
+ * and currently never change thereafter.
+ */
+static void img_request_write_set(struct rbd_img_request *img_request)
+{
+	set_bit(IMG_REQ_WRITE, &img_request->flags);
+	smp_mb();
+}
+
+static bool img_request_write_test(struct rbd_img_request *img_request)
+{
+	smp_mb();
+	return test_bit(IMG_REQ_WRITE, &img_request->flags) != 0;
+}
+
 static void
 rbd_img_obj_request_read_callback(struct rbd_obj_request *obj_request)
 {
@@ -1369,8 +1390,9 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	struct ceph_osd_request *osd_req;

 	if (img_request) {
-		rbd_assert(img_request->write_request == write_request);
-		if (img_request->write_request)
+		rbd_assert(write_request ==
+				img_request_write_test(img_request));
+		if (write_request)
 			snapc = img_request->snapc;
 	}

@@ -1494,17 +1516,20 @@ static struct rbd_img_request
*rbd_img_request_create(
 			kfree(img_request);
 			return NULL;	/* Shouldn't happen */
 		}
+
 	}

 	img_request->rq = NULL;
 	img_request->rbd_dev = rbd_dev;
 	img_request->offset = offset;
 	img_request->length = length;
-	img_request->write_request = write_request;
-	if (write_request)
+	img_request->flags = 0;
+	if (write_request) {
+		img_request_write_set(img_request);
 		img_request->snapc = snapc;
-	else
+	} else {
 		img_request->snap_id = rbd_dev->spec->snap_id;
+	}
 	spin_lock_init(&img_request->completion_lock);
 	img_request->next_completion = 0;
 	img_request->callback = NULL;
@@ -1537,7 +1562,7 @@ static void rbd_img_request_destroy(struct kref *kref)
 		rbd_img_obj_request_del(img_request, obj_request);
 	rbd_assert(img_request->obj_request_count == 0);

-	if (img_request->write_request)
+	if (img_request_write_test(img_request))
 		ceph_put_snap_context(img_request->snapc);

 	kfree(img_request);
@@ -1580,7 +1605,8 @@ static void rbd_img_obj_callback(struct
rbd_obj_request *obj_request)
 			struct rbd_device *rbd_dev = img_request->rbd_dev;

 			rbd_warn(rbd_dev, "%s %llx at %llx (%llx)\n",
-				img_request->write_request ? "write" : "read",
+				img_request_write_test(img_request) ? "write"
+								    : "read",
 				obj_request->length, obj_request->img_offset,
 				obj_request->offset);
 			rbd_warn(rbd_dev, "  result %d xferred %x\n",
@@ -1608,7 +1634,7 @@ static int rbd_img_request_fill_bio(struct
rbd_img_request *img_request,
 	struct rbd_device *rbd_dev = img_request->rbd_dev;
 	struct rbd_obj_request *obj_request = NULL;
 	struct rbd_obj_request *next_obj_request;
-	bool write_request = img_request->write_request;
+	bool write_request = img_request_write_test(img_request);
 	unsigned int bio_offset;
 	u64 img_offset;
 	u64 resid;
-- 
1.7.9.5

