From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/5] rbd: ignore result of ceph_copy_from_page_vector()
Date: Fri, 08 Feb 2013 10:33:10 -0600
Message-ID: <511528C6.2030804@inktank.com>
References: <51152847.2030305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:57344 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946736Ab3BHQdO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 11:33:14 -0500
Received: by mail-ie0-f169.google.com with SMTP id 13so5340028iea.28
        for <ceph-devel@vger.kernel.org>; Fri, 08 Feb 2013 08:33:13 -0800 (PST)
In-Reply-To: <51152847.2030305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The result of ceph_copy_from_page_vector() is simply the length
argument it is provided.

This is called by rbd_obj_method_sync(), which returns the result if
it's non-negative.  But we always either ignore or overwrite that
return value.  So explicitly ignore what's returned by the copy
function, and have rbd_obj_method_sync() always return either a
negative errno or 0.

We also return the result of ceph_copy_from_page_vector() in
rbd_obj_read_sync().  There we still want to return the number of
bytes transferred, but we can use the value we already have in hand
rather than what ceph_copy_from_page_vector() provides.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 99f1a29..958e733 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1889,7 +1889,8 @@ static int rbd_obj_method_sync(struct rbd_device
*rbd_dev,
 	ret = obj_request->result;
 	if (ret < 0)
 		goto out;
-	ret = ceph_copy_from_page_vector(pages, inbound, 0,
+	ret = 0;
+	(void) ceph_copy_from_page_vector(pages, inbound, 0,
 					obj_request->xferred);
 	if (version)
 		*version = obj_request->version;
@@ -2088,7 +2089,9 @@ static int rbd_obj_read_sync(struct rbd_device
*rbd_dev,

 	rbd_assert(obj_request->xferred <= (u64) SIZE_MAX);
 	size = (size_t) obj_request->xferred;
-	ret = ceph_copy_from_page_vector(pages, buf, 0, size);
+	(void) ceph_copy_from_page_vector(pages, buf, 0, size);
+	rbd_assert(size <= (size_t) INT_MAX);
+	ret = (int) size;
 	if (version)
 		*version = obj_request->version;
 out:
@@ -2141,7 +2144,6 @@ rbd_dev_v1_header_read(struct rbd_device *rbd_dev,
u64 *version)
 		ret = rbd_obj_read_sync(rbd_dev, rbd_dev->header_name,
 				       0, size,
 				       (char *) ondisk, version);
-
 		if (ret < 0)
 			goto out_err;
 		if (WARN_ON((size_t) ret < size)) {
@@ -2803,7 +2805,6 @@ static int rbd_dev_v2_object_prefix(struct
rbd_device *rbd_dev)
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out;
-	ret = 0;    /* rbd_obj_method_sync() can return positive */

 	p = reply_buf;
 	rbd_dev->header.object_prefix = ceph_extract_encoded_string(&p,
@@ -3742,7 +3743,6 @@ static int rbd_dev_image_id(struct rbd_device
*rbd_dev)
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out;
-	ret = 0;    /* rbd_obj_method_sync() can return positive */

 	p = response;
 	rbd_dev->spec->image_id = ceph_extract_encoded_string(&p,
-- 
1.7.9.5

