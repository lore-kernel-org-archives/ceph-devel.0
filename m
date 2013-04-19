From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4] rbd: define separate read and write format funcs
Date: Fri, 19 Apr 2013 17:49:50 -0500
Message-ID: <5171CA0E.3020402@inktank.com>
References: <5171C963.2050402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:53779 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964846Ab3DSWtw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 18:49:52 -0400
Received: by mail-ia0-f171.google.com with SMTP id f27so3892524iae.2
        for <ceph-devel@vger.kernel.org>; Fri, 19 Apr 2013 15:49:51 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id wn10sm4977217igb.2.2013.04.19.15.49.50
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 15:49:51 -0700 (PDT)
In-Reply-To: <5171C963.2050402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Separate rbd_osd_req_format() into two functions, one for read
requests and the other for write requests.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   49
++++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ce2fb3a..a185239 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1489,28 +1489,31 @@ static void rbd_osd_req_callback(struct
ceph_osd_request *osd_req,
 		rbd_obj_request_complete(obj_request);
 }

-static void rbd_osd_req_format(struct rbd_obj_request *obj_request,
-					bool write_request)
+static void rbd_osd_req_format_read(struct rbd_obj_request *obj_request)
 {
 	struct rbd_img_request *img_request = obj_request->img_request;
 	struct ceph_osd_request *osd_req = obj_request->osd_req;
-	struct ceph_snap_context *snapc = NULL;
-	u64 snap_id = CEPH_NOSNAP;
-	struct timespec *mtime = NULL;
-	struct timespec now;
+	u64 snap_id;

 	rbd_assert(osd_req != NULL);

-	if (write_request) {
-		now = CURRENT_TIME;
-		mtime = &now;
-		if (img_request)
-			snapc = img_request->snapc;
-	} else if (img_request) {
-		snap_id = img_request->snap_id;
-	}
+	snap_id = img_request ? img_request->snap_id : CEPH_NOSNAP;
+	ceph_osdc_build_request(osd_req, obj_request->offset,
+			NULL, snap_id, NULL);
+}
+
+static void rbd_osd_req_format_write(struct rbd_obj_request *obj_request)
+{
+	struct rbd_img_request *img_request = obj_request->img_request;
+	struct ceph_osd_request *osd_req = obj_request->osd_req;
+	struct ceph_snap_context *snapc;
+	struct timespec mtime = CURRENT_TIME;
+
+	rbd_assert(osd_req != NULL);
+
+	snapc = img_request ? img_request->snapc : NULL;
 	ceph_osdc_build_request(osd_req, obj_request->offset,
-			snapc, snap_id, mtime);
+			snapc, CEPH_NOSNAP, &mtime);
 }

 static struct ceph_osd_request *rbd_osd_req_create(
@@ -1845,7 +1848,11 @@ static int rbd_img_request_fill_bio(struct
rbd_img_request *img_request,
 						0, 0);
 		osd_req_op_extent_osd_data_bio(osd_req, 0,
 				obj_request->bio_list, obj_request->length);
-		rbd_osd_req_format(obj_request, write_request);
+
+		if (write_request)
+			rbd_osd_req_format_write(obj_request);
+		else
+			rbd_osd_req_format_read(obj_request);

 		obj_request->img_offset = img_offset;
 		rbd_img_obj_request_add(img_request, obj_request);
@@ -1969,7 +1976,7 @@ static int rbd_img_obj_exists_submit(struct
rbd_obj_request *obj_request)
 	osd_req_op_init(stat_request->osd_req, 0, CEPH_OSD_OP_STAT);
 	osd_req_op_raw_data_in_pages(stat_request->osd_req, 0, pages, size, 0,
 					false, false);
-	rbd_osd_req_format(stat_request, false);
+	rbd_osd_req_format_read(stat_request);

 	osdc = &rbd_dev->rbd_client->client->osdc;
 	ret = rbd_obj_request_submit(osdc, stat_request);
@@ -2091,7 +2098,7 @@ static int rbd_obj_notify_ack(struct rbd_device
*rbd_dev,

 	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_NOTIFY_ACK,
 					notify_id, ver, 0);
-	rbd_osd_req_format(obj_request, false);
+	rbd_osd_req_format_read(obj_request);

 	ret = rbd_obj_request_submit(osdc, obj_request);
 out:
@@ -2161,7 +2168,7 @@ static int rbd_dev_header_watch_sync(struct
rbd_device *rbd_dev, int start)
 	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_WATCH,
 				rbd_dev->watch_event->cookie,
 				rbd_dev->header.obj_version, start);
-	rbd_osd_req_format(obj_request, true);
+	rbd_osd_req_format_write(obj_request);

 	ret = rbd_obj_request_submit(osdc, obj_request);
 	if (ret)
@@ -2262,7 +2269,7 @@ static int rbd_obj_method_sync(struct rbd_device
*rbd_dev,
 	osd_req_op_cls_response_data_pages(obj_request->osd_req, 0,
 					obj_request->pages, inbound_size,
 					0, false, false);
-	rbd_osd_req_format(obj_request, false);
+	rbd_osd_req_format_read(obj_request);

 	ret = rbd_obj_request_submit(osdc, obj_request);
 	if (ret)
@@ -2473,7 +2480,7 @@ static int rbd_obj_read_sync(struct rbd_device
*rbd_dev,
 					obj_request->length,
 					obj_request->offset & ~PAGE_MASK,
 					false, false);
-	rbd_osd_req_format(obj_request, false);
+	rbd_osd_req_format_read(obj_request);

 	ret = rbd_obj_request_submit(osdc, obj_request);
 	if (ret)
-- 
1.7.9.5

