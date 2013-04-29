From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/5] rbd: don't destroy rbd_dev in device release function
Date: Mon, 29 Apr 2013 13:00:34 -0500
Message-ID: <517EB542.9030000@inktank.com>
References: <517EB4F0.1070607@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:38201 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757824Ab3D2SAh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 14:00:37 -0400
Received: by mail-yh0-f43.google.com with SMTP id a41so594015yho.2
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 11:00:36 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id l70sm33206690yha.1.2013.04.29.11.00.35
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 11:00:35 -0700 (PDT)
In-Reply-To: <517EB4F0.1070607@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Rename rbd_dev_probe_finish() to be rbd_dev_device_setup().  Its
purpose is to set up the Linux side of an rbd device mapping.
Rename rbd_dev_release() to be rbd_dev_device_release(), making
it more obvious it serves as the inverse of the setup function
(or it will).

Encapsulate some of what was done in rbd_dev_release() into a new
function rbd_dev_image_release(), which serves as the inverse of
setting up the ceph side of the mapped rbd image.

Define a new helper rbd_dev_clear_mapping() to simply zero out the
fields of a mapping structure--the inverse of rbd_dev_set_mapping().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5904819..feaa2e9 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -358,7 +358,7 @@ static int rbd_img_request_submit(struct
rbd_img_request *img_request);

 static int rbd_dev_snaps_update(struct rbd_device *rbd_dev);

-static void rbd_dev_release(struct device *dev);
+static void rbd_dev_device_release(struct device *dev);
 static void rbd_snap_destroy(struct rbd_snap *snap);

 static ssize_t rbd_add(struct bus_type *bus, const char *buf,
@@ -893,6 +893,13 @@ static void rbd_dev_mapping_clear(struct rbd_device
*rbd_dev)
 	rbd_dev->mapping.read_only = true;
 }

+static void rbd_dev_clear_mapping(struct rbd_device *rbd_dev)
+{
+	rbd_dev->mapping.size = 0;
+	rbd_dev->mapping.features = 0;
+	rbd_dev->mapping.read_only = true;
+}
+
 static void rbd_header_free(struct rbd_image_header *header)
 {
 	kfree(header->object_prefix);
@@ -4182,7 +4189,7 @@ static int rbd_bus_add_dev(struct rbd_device *rbd_dev)
 	dev->bus = &rbd_bus_type;
 	dev->type = &rbd_device_type;
 	dev->parent = &rbd_root_dev;
-	dev->release = rbd_dev_release;
+	dev->release = rbd_dev_device_release;
 	dev_set_name(dev, "%d", rbd_dev->dev_id);
 	ret = device_register(dev);

@@ -4718,7 +4725,7 @@ out_err:
 	return ret;
 }

-static int rbd_dev_probe_finish(struct rbd_device *rbd_dev)
+static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 {
 	int ret;

@@ -4800,6 +4807,15 @@ static int rbd_dev_header_name(struct rbd_device
*rbd_dev)
 	return 0;
 }

+static void rbd_dev_image_release(struct rbd_device *rbd_dev)
+{
+	rbd_header_free(&rbd_dev->header);
+	rbd_assert(rbd_dev->rbd_client != NULL);
+	rbd_spec_put(rbd_dev->parent_spec);
+	kfree(rbd_dev->header_name);
+	rbd_dev_destroy(rbd_dev);
+}
+
 /*
  * Probe for the existence of the header object for the given rbd
  * device.  For format 2 images this includes determining the image
@@ -4848,7 +4864,7 @@ static int rbd_dev_image_probe(struct rbd_device
*rbd_dev)
 	if (ret)
 		goto err_out_snaps;

-	ret = rbd_dev_probe_finish(rbd_dev);
+	ret = rbd_dev_device_setup(rbd_dev);
 	if (ret)
 		goto err_out_parent;

@@ -4968,24 +4984,19 @@ static struct rbd_device *__rbd_get_dev(unsigned
long dev_id)
 	return NULL;
 }

-static void rbd_dev_release(struct device *dev)
+static void rbd_dev_device_release(struct device *dev)
 {
 	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);

-	/* clean up and free blkdev */
 	rbd_free_disk(rbd_dev);
+	clear_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
+	rbd_dev_clear_mapping(rbd_dev);
 	unregister_blkdev(rbd_dev->major, rbd_dev->name);
-
-	/* release allocated disk header fields */
-	rbd_header_free(&rbd_dev->header);
-
-	/* done with the id, and with the rbd_dev */
+	rbd_dev->major = 0;
 	rbd_dev_id_put(rbd_dev);
 	rbd_dev_mapping_clear(rbd_dev);
-	rbd_assert(rbd_dev->rbd_client != NULL);
-	rbd_spec_put(rbd_dev->parent_spec);
-	kfree(rbd_dev->header_name);
-	rbd_dev_destroy(rbd_dev);
+
+	rbd_dev_image_release(rbd_dev);
 }

 static void rbd_dev_remove_parent(struct rbd_device *rbd_dev)
-- 
1.7.9.5

