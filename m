From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/5] rbd: kill rbd_spec->image_name_len
Date: Thu, 01 Nov 2012 08:53:00 -0500
Message-ID: <50927EBC.7040501@inktank.com>
References: <50927D03.9060900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:51874 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758176Ab2KANxd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 09:53:33 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so1921052iag.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 06:53:32 -0700 (PDT)
In-Reply-To: <50927D03.9060900@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There may have been a benefit to hanging on to the length of an
image name before, but there is really none now.  The only time it's
used is when probing for rbd images, so we can just compute the
length then.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 32ed6e6..2e1d181 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -147,7 +147,6 @@ struct rbd_spec {
 	char		*image_id;
 	size_t		image_id_len;
 	char		*image_name;
-	size_t		image_name_len;

 	u64		snap_id;
 	char		*snap_name;
@@ -2565,15 +2564,15 @@ static char *rbd_dev_image_name(struct
rbd_device *rbd_dev)

 	rbd_assert(!rbd_dev->spec->image_name);

-	image_id_size = sizeof (__le32) + rbd_dev->spec->image_id_len;
+	len = strlen(rbd_dev->spec->image_id);
+	image_id_size = sizeof (__le32) + len;
 	image_id = kmalloc(image_id_size, GFP_KERNEL);
 	if (!image_id)
 		return NULL;

 	p = image_id;
 	end = (char *) image_id + image_id_size;
-	ceph_encode_string(&p, end, rbd_dev->spec->image_id,
-				(u32) rbd_dev->spec->image_id_len);
+	ceph_encode_string(&p, end, rbd_dev->spec->image_id, (u32) len);

 	size = sizeof (__le32) + RBD_IMAGE_NAME_LEN_MAX;
 	reply_buf = kmalloc(size, GFP_KERNEL);
@@ -2633,14 +2632,12 @@ static int rbd_dev_probe_update_spec(struct
rbd_device *rbd_dev)
 	/* Fetch the image name; tolerate failure here */

 	name = rbd_dev_image_name(rbd_dev);
-	if (name) {
-		rbd_dev->spec->image_name_len = strlen(name);
+	if (name)
 		rbd_dev->spec->image_name = (char *) name;
-	} else {
+	else
 		pr_warning(RBD_DRV_NAME "%d "
 			"unable to get image name for image id %s\n",
 			rbd_dev->major, rbd_dev->spec->image_id);
-	}

 	/* Look up the snapshot name. */

@@ -3254,7 +3251,7 @@ static int rbd_add_parse_args(const char *buf,
 	if (!*spec->pool_name)
 		goto out_err;	/* Missing pool name */

-	spec->image_name = dup_token(&buf, &spec->image_name_len);
+	spec->image_name = dup_token(&buf, NULL);
 	if (!spec->image_name)
 		goto out_mem;
 	if (!*spec->image_name)
@@ -3344,7 +3341,7 @@ static int rbd_dev_image_id(struct rbd_device
*rbd_dev)
 	 * First, see if the format 2 image id file exists, and if
 	 * so, get the image's persistent id from it.
 	 */
-	size = sizeof (RBD_ID_PREFIX) + rbd_dev->spec->image_name_len;
+	size = sizeof (RBD_ID_PREFIX) + strlen(rbd_dev->spec->image_name);
 	object_name = kmalloc(size, GFP_NOIO);
 	if (!object_name)
 		return -ENOMEM;
@@ -3402,7 +3399,7 @@ static int rbd_dev_v1_probe(struct rbd_device
*rbd_dev)

 	/* Record the header object name for this rbd image. */

-	size = rbd_dev->spec->image_name_len + sizeof (RBD_SUFFIX);
+	size = strlen(rbd_dev->spec->image_name) + sizeof (RBD_SUFFIX);
 	rbd_dev->header_name = kmalloc(size, GFP_KERNEL);
 	if (!rbd_dev->header_name) {
 		ret = -ENOMEM;
-- 
1.7.9.5

