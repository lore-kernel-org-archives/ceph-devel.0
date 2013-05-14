From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: fix cleanup in rbd_add()
Date: Mon, 13 May 2013 20:39:00 -0500
Message-ID: <519195B4.1080802@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:38196 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab3ENBjC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 May 2013 21:39:02 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so8437715oag.17
        for <ceph-devel@vger.kernel.org>; Mon, 13 May 2013 18:39:02 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id dt3sm19317884obb.12.2013.05.13.18.39.00
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 May 2013 18:39:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Bjorn Helgaas pointed out that a recent commit introduced a
use-after-free condition in an error path for rbd_add().
He correctly stated:

    I think b536f69a3a5 "rbd: set up devices only for mapped images"
    introduced a use-after-free error in rbd_add():
	...
    If rbd_dev_device_setup() returns an error, we call
    rbd_dev_image_release(), which ultimately kfrees rbd_dev.
    Then we call rbd_dev_destroy(), which references fields in
    the already-freed rbd_dev struct before kfreeing it again.

The simple fix is to return the error code after the call to
rbd_dev_image_release().

Closer examination revealed that there's no need to clean up
ceph_opts or rbd_opts in that function, so fix that too.

Update some other comments that have also become out of date.

Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e8d4693..632dd35 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4699,8 +4699,10 @@ out:
 	return ret;
 }

-/* Undo whatever state changes are made by v1 or v2 image probe */
-
+/*
+ * Undo whatever state changes are made by v1 or v2 header info
+ * call.
+ */
 static void rbd_dev_unprobe(struct rbd_device *rbd_dev)
 {
 	struct rbd_image_header	*header;
@@ -4904,9 +4906,10 @@ static int rbd_dev_image_probe(struct rbd_device
*rbd_dev, bool mapping)
 	int tmp;

 	/*
-	 * Get the id from the image id object.  If it's not a
-	 * format 2 image, we'll get ENOENT back, and we'll assume
-	 * it's a format 1 image.
+	 * Get the id from the image id object.  Unless there's an
+	 * error, rbd_dev->spec->image_id will be filled in with
+	 * a dynamically-allocated string, and rbd_dev->image_format
+	 * will be set to either 1 or 2.
 	 */
 	ret = rbd_dev_image_id(rbd_dev);
 	if (ret)
@@ -4994,7 +4997,7 @@ static ssize_t rbd_add(struct bus_type *bus,
 		rc = PTR_ERR(rbdc);
 		goto err_out_args;
 	}
-	ceph_opts = NULL;	/* rbd_dev client now owns this */
+	ceph_opts = NULL;	/* rbd_get_client() consumes this */

 	/* pick the pool */
 	osdc = &rbdc->client->osdc;
@@ -5033,14 +5036,14 @@ static ssize_t rbd_add(struct bus_type *bus,
 		return count;

 	rbd_dev_image_release(rbd_dev);
+
+	return rc;
+
 err_out_rbd_dev:
 	rbd_dev_destroy(rbd_dev);
 err_out_client:
 	rbd_put_client(rbdc);
 err_out_args:
-	if (ceph_opts)
-		ceph_destroy_options(ceph_opts);
-	kfree(rbd_opts);
 	rbd_spec_put(spec);
 err_out_module:
 	module_put(THIS_MODULE);
-- 
1.7.9.5

