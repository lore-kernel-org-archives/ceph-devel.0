From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] rbd: re-submit read request for flattened clone
Date: Sat, 11 May 2013 12:47:20 -0500
Message-ID: <518E8428.2060403@inktank.com>
References: <518E83D3.4050709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:41815 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab3EKRrW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 May 2013 13:47:22 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so10050844iea.4
        for <ceph-devel@vger.kernel.org>; Sat, 11 May 2013 10:47:21 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id wx2sm6116856igb.4.2013.05.11.10.47.20
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 10:47:21 -0700 (PDT)
In-Reply-To: <518E83D3.4050709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If a clone image gets flattened while a parent read request is
underway, the original rbd object request needs to be resubmitted.

The reason is that by the time we get the response to the parent
read request, the data read from the parent may be out of date.
In other words, we could see this sequence of events:

    rbd client                      parent image/osd
    ----------                      ----------------
    original object ENOENT;
        issue parent read
                                    respond to parent read
                                    child image flattened
    original image header refresh
             <--- original object written independently here
    parent read response received

Add code to rbd_img_parent_read_callback() to detect when a clone's
parent image has disappeared (as evidenced by its parent overlap
becoming 0), and re-submit the original read request in that case.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6cd08ba..4dca3ce 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2672,14 +2672,36 @@ static void rbd_img_parent_read_callback(struct
rbd_img_request *img_request)
 	struct rbd_obj_request *obj_request;
 	struct rbd_device *rbd_dev;
 	u64 obj_end;
+	u64 img_xferred;
+	int img_result;

 	rbd_assert(img_request_child_test(img_request));

+	/* First get what we need from the image request and release it */
+
 	obj_request = img_request->obj_request;
+	img_xferred = img_request->xferred;
+	img_result = img_request->result;
+	rbd_img_request_put(img_request);
+
+	/*
+	 * If the overlap has become 0 (most likely because the
+	 * image has been flattened) we need to re-submit the
+	 * original request.
+	 */
 	rbd_assert(obj_request);
 	rbd_assert(obj_request->img_request);
+	rbd_dev = obj_request->img_request->rbd_dev;
+	if (!rbd_dev->parent_overlap) {
+		struct ceph_osd_client *osdc;
+
+		osdc = &rbd_dev->rbd_client->client->osdc;
+		img_result = rbd_obj_request_submit(osdc, obj_request);
+		if (!img_result)
+			return;
+	}

-	obj_request->result = img_request->result;
+	obj_request->result = img_result;
 	if (obj_request->result)
 		goto out;

@@ -2692,7 +2714,6 @@ static void rbd_img_parent_read_callback(struct
rbd_img_request *img_request)
 	 */
 	rbd_assert(obj_request->img_offset < U64_MAX - obj_request->length);
 	obj_end = obj_request->img_offset + obj_request->length;
-	rbd_dev = obj_request->img_request->rbd_dev;
 	if (obj_end > rbd_dev->parent_overlap) {
 		u64 xferred = 0;

@@ -2700,12 +2721,11 @@ static void rbd_img_parent_read_callback(struct
rbd_img_request *img_request)
 			xferred = rbd_dev->parent_overlap -
 					obj_request->img_offset;

-		obj_request->xferred = min(img_request->xferred, xferred);
+		obj_request->xferred = min(img_xferred, xferred);
 	} else {
-		obj_request->xferred = img_request->xferred;
+		obj_request->xferred = img_xferred;
 	}
 out:
-	rbd_img_request_put(img_request);
 	rbd_img_obj_request_read_callback(obj_request);
 	rbd_obj_request_complete(obj_request);
 }
-- 
1.7.9.5

