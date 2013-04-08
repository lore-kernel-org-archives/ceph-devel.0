From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 14/20] rbd: rearrange some code for consistency
Date: Mon, 08 Apr 2013 11:15:48 -0700
Message-ID: <51630954.4090403@inktank.com>
References: <515ED849.9060901@inktank.com> <515EDA04.10903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f42.google.com ([209.85.210.42]:51910 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935317Ab3DHSQf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Apr 2013 14:16:35 -0400
Received: by mail-da0-f42.google.com with SMTP id n15so2716535dad.15
        for <ceph-devel@vger.kernel.org>; Mon, 08 Apr 2013 11:16:34 -0700 (PDT)
In-Reply-To: <515EDA04.10903@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Just a couple nits.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

Alex Elder <elder@inktank.com> wrote:
>This patch just trivially moves around some code for consistency.
>
>In preparation for initializing osd request data fields in
>ceph_osdc_build_request(), I wanted to verify that rbd did in fact
>call that immediatley before it called ceph_osdc_start_request().

typo in immediately

>It was true (although image requests are built in a group and then
>started as a group).  But I made the changes here just to make
>it more obvious, by making all of the calls follow a common
>sequence:
>	osd_req_op_<optype>_init();
>	ceph_osd_data_<type>_init()
>	osd_req_op_<optype>_<datafield>()
>	rbd_osd_req_format()
>	...
>	ret = rbd_obj_request_submit()
>
>I moved the initialization of the callback for image object requests
>into rbd_img_request_fill_bio(), again, for consistency.  To avoid
>a forward reference, I moved the definition of rbd_img_obj_callback()
>up in the file.
>
>Signed-off-by: Alex Elder <elder@inktank.com>
>---
> drivers/block/rbd.c |  129
>+++++++++++++++++++++++++--------------------------
> 1 file changed, 63 insertions(+), 66 deletions(-)
>
>diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>index 1cd776b..3e8e6d5 100644
>--- a/drivers/block/rbd.c
>+++ b/drivers/block/rbd.c
>@@ -1519,6 +1519,57 @@ static void rbd_img_request_destroy(struct kref
>*kref)
> 	kfree(img_request);
> }
>
>+static void rbd_img_obj_callback(struct rbd_obj_request *obj_request)
>+{
>+	struct rbd_img_request *img_request;
>+	u32 which = obj_request->which;
>+	bool more = true;
>+
>+	img_request = obj_request->img_request;
>+
>+	dout("%s: img %p obj %p\n", __func__, img_request, obj_request);
>+	rbd_assert(img_request != NULL);
>+	rbd_assert(img_request->rq != NULL);
>+	rbd_assert(img_request->obj_request_count > 0);
>+	rbd_assert(which != BAD_WHICH);
>+	rbd_assert(which < img_request->obj_request_count);
>+	rbd_assert(which >= img_request->next_completion);
>+
>+	spin_lock_irq(&img_request->completion_lock);
>+	if (which != img_request->next_completion)
>+		goto out;
>+
>+	for_each_obj_request_from(img_request, obj_request) {
>+		unsigned int xferred;
>+		int result;
>+
>+		rbd_assert(more);
>+		rbd_assert(which < img_request->obj_request_count);
>+
>+		if (!obj_request_done_test(obj_request))
>+			break;
>+
>+		rbd_assert(obj_request->xferred <= (u64) UINT_MAX);
>+		xferred = (unsigned int) obj_request->xferred;
>+		result = (int) obj_request->result;
>+		if (result)
>+			rbd_warn(NULL, "obj_request %s result %d xferred %u\n",
>+				img_request->write_request ? "write" : "read",
>+				result, xferred);
>+
>+		more = blk_end_request(img_request->rq, result, xferred);
>+		which++;
>+	}
>+
>+	rbd_assert(more ^ (which == img_request->obj_request_count));
>+	img_request->next_completion = which;
>+out:
>+	spin_unlock_irq(&img_request->completion_lock);
>+
>+	if (!more)
>+		rbd_img_request_complete(img_request);
>+}
>+
>static int rbd_img_request_fill_bio(struct rbd_img_request
>*img_request,
> 					struct bio *bio_list)
> {
>@@ -1572,6 +1623,7 @@ static int rbd_img_request_fill_bio(struct
>rbd_img_request *img_request,
> 		if (!osd_req)
> 			goto out_partial;
> 		obj_request->osd_req = osd_req;
>+		obj_request->callback = rbd_img_obj_callback;
>
> 		osd_data = write_request ? &osd_req->r_data_out
> 					 : &osd_req->r_data_in;
>@@ -1582,8 +1634,6 @@ static int rbd_img_request_fill_bio(struct
>rbd_img_request *img_request,
> 		osd_req_op_extent_osd_data(osd_req, 0, osd_data);
> 		rbd_osd_req_format(obj_request, write_request);
>
>-		/* status and version are initially zero-filled */
>-
> 		rbd_img_obj_request_add(img_request, obj_request);
>
> 		image_offset += length;
>@@ -1601,57 +1651,6 @@ out_unwind:
> 	return -ENOMEM;
> }
>
>-static void rbd_img_obj_callback(struct rbd_obj_request *obj_request)
>-{
>-	struct rbd_img_request *img_request;
>-	u32 which = obj_request->which;
>-	bool more = true;
>-
>-	img_request = obj_request->img_request;
>-
>-	dout("%s: img %p obj %p\n", __func__, img_request, obj_request);
>-	rbd_assert(img_request != NULL);
>-	rbd_assert(img_request->rq != NULL);
>-	rbd_assert(img_request->obj_request_count > 0);
>-	rbd_assert(which != BAD_WHICH);
>-	rbd_assert(which < img_request->obj_request_count);
>-	rbd_assert(which >= img_request->next_completion);
>-
>-	spin_lock_irq(&img_request->completion_lock);
>-	if (which != img_request->next_completion)
>-		goto out;
>-
>-	for_each_obj_request_from(img_request, obj_request) {
>-		unsigned int xferred;
>-		int result;
>-
>-		rbd_assert(more);
>-		rbd_assert(which < img_request->obj_request_count);
>-
>-		if (!obj_request_done_test(obj_request))
>-			break;
>-
>-		rbd_assert(obj_request->xferred <= (u64) UINT_MAX);
>-		xferred = (unsigned int) obj_request->xferred;
>-		result = (int) obj_request->result;
>-		if (result)
>-			rbd_warn(NULL, "obj_request %s result %d xferred %u\n",
>-				img_request->write_request ? "write" : "read",
>-				result, xferred);
>-
>-		more = blk_end_request(img_request->rq, result, xferred);
>-		which++;
>-	}
>-
>-	rbd_assert(more ^ (which == img_request->obj_request_count));
>-	img_request->next_completion = which;
>-out:
>-	spin_unlock_irq(&img_request->completion_lock);
>-
>-	if (!more)
>-		rbd_img_request_complete(img_request);
>-}
>-
> static int rbd_img_request_submit(struct rbd_img_request *img_request)
> {
> 	struct rbd_device *rbd_dev = img_request->rbd_dev;
>@@ -1662,7 +1661,6 @@ static int rbd_img_request_submit(struct
>rbd_img_request *img_request)
> 	for_each_obj_request(img_request, obj_request) {
> 		int ret;
>
>-		obj_request->callback = rbd_img_obj_callback;
> 		ret = rbd_obj_request_submit(osdc, obj_request);
> 		if (ret)
> 			return ret;
>@@ -1681,8 +1679,9 @@ static int rbd_obj_notify_ack(struct rbd_device
>*rbd_dev,
> 				   u64 ver, u64 notify_id)
> {
> 	struct rbd_obj_request *obj_request;
>-	struct ceph_osd_client *osdc;
>+	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
> 	int ret;
>+	osdc = &rbd_dev->rbd_client->client->osdc;

This is the same as two lines up.

>
> 	obj_request = rbd_obj_request_create(rbd_dev->header_name, 0, 0,
> 							OBJ_REQUEST_NODATA);
>@@ -1693,13 +1692,12 @@ static int rbd_obj_notify_ack(struct rbd_device
>*rbd_dev,
>	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false,
>obj_request);
> 	if (!obj_request->osd_req)
> 		goto out;
>+	obj_request->callback = rbd_obj_request_put;
>
>	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_NOTIFY_ACK,
> 					notify_id, ver, 0);
> 	rbd_osd_req_format(obj_request, false);
>
>-	osdc = &rbd_dev->rbd_client->client->osdc;
>-	obj_request->callback = rbd_obj_request_put;
> 	ret = rbd_obj_request_submit(osdc, obj_request);
> out:
> 	if (ret)
>@@ -1759,16 +1757,17 @@ static int rbd_dev_header_watch_sync(struct
>rbd_device *rbd_dev, int start)
> 	if (!obj_request->osd_req)
> 		goto out_cancel;
>
>-	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_WATCH,
>-				rbd_dev->watch_event->cookie,
>-				rbd_dev->header.obj_version, start);
>-	rbd_osd_req_format(obj_request, true);
>-
> 	if (start)
> 		ceph_osdc_set_request_linger(osdc, obj_request->osd_req);
> 	else
> 		ceph_osdc_unregister_linger_request(osdc,
> 					rbd_dev->watch_request->osd_req);
>+
>+	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_WATCH,
>+				rbd_dev->watch_event->cookie,
>+				rbd_dev->header.obj_version, start);
>+	rbd_osd_req_format(obj_request, true);
>+
> 	ret = rbd_obj_request_submit(osdc, obj_request);
> 	if (ret)
> 		goto out_cancel;
>@@ -1820,9 +1819,9 @@ static int rbd_obj_method_sync(struct rbd_device
>*rbd_dev,
> 			     size_t inbound_size,
> 			     u64 *version)
> {
>+	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
> 	struct rbd_obj_request *obj_request;
> 	struct ceph_osd_data *osd_data;
>-	struct ceph_osd_client *osdc;
> 	struct page **pages;
> 	u32 page_count;
> 	int ret;
>@@ -1861,7 +1860,6 @@ static int rbd_obj_method_sync(struct rbd_device
>*rbd_dev,
> 	osd_req_op_cls_response_data(obj_request->osd_req, 0, osd_data);
> 	rbd_osd_req_format(obj_request, false);
>
>-	osdc = &rbd_dev->rbd_client->client->osdc;
> 	ret = rbd_obj_request_submit(osdc, obj_request);
> 	if (ret)
> 		goto out;
>@@ -2037,9 +2035,9 @@ static int rbd_obj_read_sync(struct rbd_device
>*rbd_dev,
> 				char *buf, u64 *version)
>
> {
>+	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
> 	struct rbd_obj_request *obj_request;
> 	struct ceph_osd_data *osd_data;
>-	struct ceph_osd_client *osdc;
> 	struct page **pages = NULL;
> 	u32 page_count;
> 	size_t size;
>@@ -2073,7 +2071,6 @@ static int rbd_obj_read_sync(struct rbd_device
>*rbd_dev,
> 	osd_req_op_extent_osd_data(obj_request->osd_req, 0, osd_data);
> 	rbd_osd_req_format(obj_request, false);
>
>-	osdc = &rbd_dev->rbd_client->client->osdc;
> 	ret = rbd_obj_request_submit(osdc, obj_request);
> 	if (ret)
> 		goto out;

