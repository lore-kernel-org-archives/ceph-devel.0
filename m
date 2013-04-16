From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/7] rbd: add target object existence flags
Date: Mon, 15 Apr 2013 22:38:40 -0500
Message-ID: <516CC7C0.2070109@inktank.com>
References: <516CC6E4.6070307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:59916 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935355Ab3DPDin (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 23:38:43 -0400
Received: by mail-ia0-f169.google.com with SMTP id h23so50498iae.0
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 20:38:42 -0700 (PDT)
In-Reply-To: <516CC6E4.6070307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This creates two new flags for object requests to indicate what is
known about the existence of the object to which a request is to be
sent.  The KNOWN flag will be true if the the EXISTS flag is
meaningful.  That is:

    KNOWN   EXISTS
    -----   ------
      0       0     don't know whether the object exists
      0       1     (no used/invalid)
      1       0     object is known to not exist
      1       0     object is known to exist

This will be used in determining how to handle write requests for
data objects for layered rbd images.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 211baa7f..b1b8ef8 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -173,6 +173,8 @@ enum obj_request_type {
 enum obj_req_flags {
 	OBJ_REQ_DONE,		/* completion flag: not done = 0, done = 1 */
 	OBJ_REQ_IMG_DATA,	/* object usage: standalone = 0, image = 1 */
+	OBJ_REQ_KNOWN,		/* EXISTS flag valid: no = 0, yes = 1 */
+	OBJ_REQ_EXISTS,		/* target exists: no = 0, yes = 1 */
 };

 struct rbd_obj_request {
@@ -1129,6 +1131,37 @@ static bool obj_request_done_test(struct
rbd_obj_request *obj_request)
 	return test_bit(OBJ_REQ_DONE, &obj_request->flags) != 0;
 }

+/*
+ * This sets the KNOWN flag after (possibly) setting the EXISTS
+ * flag.  The latter is set based on the "exists" value provided.
+ *
+ * Note that for our purposes once an object exists it never goes
+ * away again.  It's possible that the response from two existence
+ * checks are separated by the creation of the target object, and
+ * the first ("doesn't exist") response arrives *after* the second
+ * ("does exist").  In that case we ignore the second one.
+ */
+static void obj_request_existence_set(struct rbd_obj_request *obj_request,
+				bool exists)
+{
+	if (exists)
+		set_bit(OBJ_REQ_EXISTS, &obj_request->flags);
+	set_bit(OBJ_REQ_KNOWN, &obj_request->flags);
+	smp_mb();
+}
+
+static bool obj_request_known_test(struct rbd_obj_request *obj_request)
+{
+	smp_mb();
+	return test_bit(OBJ_REQ_KNOWN, &obj_request->flags) != 0;
+}
+
+static bool obj_request_exists_test(struct rbd_obj_request *obj_request)
+{
+	smp_mb();
+	return test_bit(OBJ_REQ_EXISTS, &obj_request->flags) != 0;
+}
+
 static void rbd_obj_request_get(struct rbd_obj_request *obj_request)
 {
 	dout("%s: obj %p (was %d)\n", __func__, obj_request,
@@ -1623,6 +1656,10 @@ static struct rbd_img_request
*rbd_img_request_create(
 	INIT_LIST_HEAD(&img_request->obj_requests);
 	kref_init(&img_request->kref);

+	(void) obj_request_existence_set;
+	(void) obj_request_known_test;
+	(void) obj_request_exists_test;
+
 	rbd_img_request_get(img_request);	/* Avoid a warning */
 	rbd_img_request_put(img_request);	/* TEMPORARY */

-- 
1.7.9.5

