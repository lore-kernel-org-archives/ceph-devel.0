From: Alex Elder <elder@inktank.com>
Subject: [PATCH, v2] rbd: fix cleanup in rbd_add()
Date: Thu, 16 May 2013 16:29:17 -0500
Message-ID: <51954FAD.2090206@inktank.com>
References: <519195B4.1080802@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:53377 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab3EPV3T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 May 2013 17:29:19 -0400
Received: by mail-ob0-f173.google.com with SMTP id eh20so4033879obb.32
        for <ceph-devel@vger.kernel.org>; Thu, 16 May 2013 14:29:18 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id r4sm8890004obg.3.2013.05.16.14.29.17
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 16 May 2013 14:29:18 -0700 (PDT)
In-Reply-To: <519195B4.1080802@inktank.com>
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
rbd_opts in that function, so fix that too.

Update some other comments that have also become out of date.

Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Alex Elder <elder@inktank.com>
---
v2: call to ceph_destroy_options() moved to its own patch

 drivers/block/rbd.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ade30dd..fdbcf04 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4700,8 +4700,10 @@ out:
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
@@ -4905,9 +4907,10 @@ static int rbd_dev_image_probe(struct rbd_device
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
@@ -5033,12 +5036,14 @@ static ssize_t rbd_add(struct bus_type *bus,
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
-	kfree(rbd_opts);
 	rbd_spec_put(spec);
 err_out_module:
 	module_put(THIS_MODULE);
-- 
1.7.9.5

