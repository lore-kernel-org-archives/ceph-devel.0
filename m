From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/5] rbd: kill rbd_spec->image_id_len
Date: Thu, 01 Nov 2012 08:54:23 -0500
Message-ID: <50927F0F.3030608@inktank.com>
References: <50927D03.9060900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43210 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758235Ab2KANyh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 09:54:37 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3590107iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 06:54:37 -0700 (PDT)
In-Reply-To: <50927D03.9060900@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is no real benefit to keeping the length of an image id, so
get rid of it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2e1d181..6512a8e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -145,7 +145,6 @@ struct rbd_spec {
 	char		*pool_name;

 	char		*image_id;
-	size_t		image_id_len;
 	char		*image_name;

 	u64		snap_id;
@@ -2494,7 +2493,6 @@ static int rbd_dev_v2_parent_info(struct
rbd_device *rbd_dev)
 	void *end;
 	char *image_id;
 	u64 overlap;
-	size_t len = 0;
 	int ret;

 	parent_spec = rbd_spec_alloc();
@@ -2528,13 +2526,12 @@ static int rbd_dev_v2_parent_info(struct
rbd_device *rbd_dev)
 	if (parent_spec->pool_id == CEPH_NOPOOL)
 		goto out;	/* No parent?  No problem. */

-	image_id = ceph_extract_encoded_string(&p, end, &len, GFP_KERNEL);
+	image_id = ceph_extract_encoded_string(&p, end, NULL, GFP_KERNEL);
 	if (IS_ERR(image_id)) {
 		ret = PTR_ERR(image_id);
 		goto out_err;
 	}
 	parent_spec->image_id = image_id;
-	parent_spec->image_id_len = len;
 	ceph_decode_64_safe(&p, end, parent_spec->snap_id, out_err);
 	ceph_decode_64_safe(&p, end, overlap, out_err);

@@ -3370,8 +3367,7 @@ static int rbd_dev_image_id(struct rbd_device
*rbd_dev)
 	p = response;
 	rbd_dev->spec->image_id = ceph_extract_encoded_string(&p,
 						p + RBD_IMAGE_ID_LEN_MAX,
-						&rbd_dev->spec->image_id_len,
-						GFP_NOIO);
+						NULL, GFP_NOIO);
 	if (IS_ERR(rbd_dev->spec->image_id)) {
 		ret = PTR_ERR(rbd_dev->spec->image_id);
 		rbd_dev->spec->image_id = NULL;
@@ -3395,7 +3391,6 @@ static int rbd_dev_v1_probe(struct rbd_device
*rbd_dev)
 	rbd_dev->spec->image_id = kstrdup("", GFP_KERNEL);
 	if (!rbd_dev->spec->image_id)
 		return -ENOMEM;
-	rbd_dev->spec->image_id_len = 0;

 	/* Record the header object name for this rbd image. */

@@ -3445,7 +3440,7 @@ static int rbd_dev_v2_probe(struct rbd_device
*rbd_dev)
 	 * Image id was filled in by the caller.  Record the header
 	 * object name for this rbd image.
 	 */
-	size = sizeof (RBD_HEADER_PREFIX) + rbd_dev->spec->image_id_len;
+	size = sizeof (RBD_HEADER_PREFIX) + strlen(rbd_dev->spec->image_id);
 	rbd_dev->header_name = kmalloc(size, GFP_KERNEL);
 	if (!rbd_dev->header_name)
 		return -ENOMEM;
-- 
1.7.9.5

