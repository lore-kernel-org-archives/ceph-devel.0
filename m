From: Alex Elder <elder@inktank.com>
Subject: [PATCH 06/11] rbd: define image request layered flag
Date: Thu, 11 Apr 2013 21:18:02 -0500
Message-ID: <51676EDA.5070107@inktank.com>
References: <51676E0F.2010504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:41234 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab3DLCSE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 22:18:04 -0400
Received: by mail-ia0-f169.google.com with SMTP id h23so1877200iae.14
        for <ceph-devel@vger.kernel.org>; Thu, 11 Apr 2013 19:18:03 -0700 (PDT)
In-Reply-To: <51676E0F.2010504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Define a flag indicating whether an image request is for a layered
image (one with a parent image to which requests will be redirected
if the target object of a request does not exist).  The code that
checks this flag will be added shortly.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7ecd909..a77157d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -205,6 +205,7 @@ struct rbd_obj_request {
 enum img_req_flags {
 	IMG_REQ_WRITE,		/* I/O direction: read = 0, write = 1 */
 	IMG_REQ_CHILD,		/* initiator: block = 0, child image = 1 */
+	IMG_REQ_LAYERED,	/* ENOENT handling: normal = 0, layered = 1 */
 };

 struct rbd_img_request {
@@ -1247,6 +1248,18 @@ static bool img_request_child_test(struct
rbd_img_request *img_request)
 	return test_bit(IMG_REQ_CHILD, &img_request->flags) != 0;
 }

+static void img_request_layered_set(struct rbd_img_request *img_request)
+{
+	set_bit(IMG_REQ_LAYERED, &img_request->flags);
+	smp_mb();
+}
+
+static bool img_request_layered_test(struct rbd_img_request *img_request)
+{
+	smp_mb();
+	return test_bit(IMG_REQ_LAYERED, &img_request->flags) != 0;
+}
+
 static void
 rbd_img_obj_request_read_callback(struct rbd_obj_request *obj_request)
 {
@@ -1549,6 +1562,8 @@ static struct rbd_img_request *rbd_img_request_create(
 	}
 	if (child_request)
 		img_request_child_set(img_request);
+	if (rbd_dev->parent_spec)
+		img_request_layered_set(img_request);
 	spin_lock_init(&img_request->completion_lock);
 	img_request->next_completion = 0;
 	img_request->callback = NULL;
@@ -1557,6 +1572,7 @@ static struct rbd_img_request *rbd_img_request_create(
 	INIT_LIST_HEAD(&img_request->obj_requests);
 	kref_init(&img_request->kref);

+	(void) img_request_layered_test(img_request);	/* Avoid a warning */
 	rbd_img_request_get(img_request);	/* Avoid a warning */
 	rbd_img_request_put(img_request);	/* TEMPORARY */

-- 
1.7.9.5

