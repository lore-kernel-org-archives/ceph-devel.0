From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/5] rbd: set mapping read-only flag in rbd_add()
Date: Wed, 08 May 2013 17:08:16 -0500
Message-ID: <518ACCD0.90603@inktank.com>
References: <518ACC55.7090100@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:39005 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454Ab3EHWIR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 May 2013 18:08:17 -0400
Received: by mail-oa0-f41.google.com with SMTP id k1so2661062oag.28
        for <ceph-devel@vger.kernel.org>; Wed, 08 May 2013 15:08:16 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id r4sm332107obg.3.2013.05.08.15.08.15
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 08 May 2013 15:08:15 -0700 (PDT)
In-Reply-To: <518ACC55.7090100@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The rbd_dev->mapping field for a parent image is not meaningful.
Since rbd_image_probe() is used both for images being mapped and
their parents, it doesn't make sense to set that flag in that
function.

So move the setting of the mapping.read_only flag out of
rbd_dev_image_probe() and into rbd_add() instead.

This resolves:
    http://tracker.ceph.com/issues/4940

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2a0e9b8..dbfc44a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -358,7 +358,7 @@ static ssize_t rbd_add(struct bus_type *bus, const
char *buf,
 		       size_t count);
 static ssize_t rbd_remove(struct bus_type *bus, const char *buf,
 			  size_t count);
-static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool read_only);
+static int rbd_dev_image_probe(struct rbd_device *rbd_dev);

 static struct bus_attribute rbd_bus_attrs[] = {
 	__ATTR(add, S_IWUSR, NULL, rbd_add),
@@ -4549,7 +4549,7 @@ static int rbd_dev_probe_parent(struct rbd_device
*rbd_dev)
 	if (!parent)
 		goto out_err;

-	ret = rbd_dev_image_probe(parent, true);
+	ret = rbd_dev_image_probe(parent);
 	if (ret < 0)
 		goto out_err;
 	rbd_dev->parent = parent;
@@ -4671,10 +4671,9 @@ static void rbd_dev_image_release(struct
rbd_device *rbd_dev)

 /*
  * Probe for the existence of the header object for the given rbd
- * device.  For format 2 images this includes determining the image
- * id.
+ * device.
  */
-static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool read_only)
+static int rbd_dev_image_probe(struct rbd_device *rbd_dev)
 {
 	int ret;
 	int tmp;
@@ -4709,12 +4708,6 @@ static int rbd_dev_image_probe(struct rbd_device
*rbd_dev, bool read_only)
 	if (ret)
 		goto err_out_probe;

-	/* If we are mapping a snapshot it must be marked read-only */
-
-	if (rbd_dev->spec->snap_id != CEPH_NOSNAP)
-		read_only = true;
-	rbd_dev->mapping.read_only = read_only;
-
 	ret = rbd_dev_probe_parent(rbd_dev);
 	if (ret)
 		goto err_out_probe;
@@ -4795,10 +4788,16 @@ static ssize_t rbd_add(struct bus_type *bus,
 	rbdc = NULL;		/* rbd_dev now owns this */
 	spec = NULL;		/* rbd_dev now owns this */

-	rc = rbd_dev_image_probe(rbd_dev, read_only);
+	rc = rbd_dev_image_probe(rbd_dev);
 	if (rc < 0)
 		goto err_out_rbd_dev;

+	/* If we are mapping a snapshot it must be marked read-only */
+
+	if (rbd_dev->spec->snap_id != CEPH_NOSNAP)
+		read_only = true;
+	rbd_dev->mapping.read_only = read_only;
+
 	rc = rbd_dev_device_setup(rbd_dev);
 	if (!rc)
 		return count;
-- 
1.7.9.5

