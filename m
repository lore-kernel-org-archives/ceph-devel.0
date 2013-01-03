From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 3/4] rbd: kill rbd_spec->image_id_len
Date: Thu, 03 Jan 2013 13:06:25 -0600
Message-ID: <50E5D6B1.50008@inktank.com>
References: <50E5D641.2010405@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:59051 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707Ab3ACTG2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 14:06:28 -0500
Received: by mail-ie0-f178.google.com with SMTP id c12so19056955ieb.9
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 11:06:27 -0800 (PST)
In-Reply-To: <50E5D641.2010405@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

There is no real benefit to keeping the length of an image id, so
get rid of it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a002984..e01dbb1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -145,7 +145,6 @@ struct rbd_spec {
 	char		*pool_name;

 	char		*image_id;
-	size_t		image_id_len;
 	char		*image_name;

 	u64		snap_id;
@@ -2492,7 +2491,6 @@ static int rbd_dev_v2_parent_info(struct
rbd_device *rbd_dev)
 	void *end;
 	char *image_id;
 	u64 overlap;
-	size_t len = 0;
 	int ret;

 	parent_spec = rbd_spec_alloc();
@@ -2526,13 +2524,12 @@ static int rbd_dev_v2_parent_info(struct
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

@@ -3368,8 +3365,7 @@ static int rbd_dev_image_id(struct rbd_device
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
@@ -3393,7 +3389,6 @@ static int rbd_dev_v1_probe(struct rbd_device
*rbd_dev)
 	rbd_dev->spec->image_id = kstrdup("", GFP_KERNEL);
 	if (!rbd_dev->spec->image_id)
 		return -ENOMEM;
-	rbd_dev->spec->image_id_len = 0;

 	/* Record the header object name for this rbd image. */

@@ -3443,7 +3438,7 @@ static int rbd_dev_v2_probe(struct rbd_device
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

