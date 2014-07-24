From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 1/8] rbd: show the entire chain of parent images
Date: Thu, 24 Jul 2014 12:42:42 +0400
Message-ID: <1406191369-6746-2-git-send-email-ilya.dryomov@inktank.com>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:48466 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934448AbaGXIm4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 04:42:56 -0400
Received: by mail-lb0-f180.google.com with SMTP id v6so2034342lbi.11
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 01:42:55 -0700 (PDT)
Received: from localhost ([109.110.66.237])
        by mx.google.com with ESMTPSA id ll11sm3871203lac.48.2014.07.24.01.42.53
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 01:42:54 -0700 (PDT)
In-Reply-To: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Make /sys/bus/rbd/devices/<id>/parent show the entire chain of parent
images.  While at it, kernel sprintf() doesn't return negative values,
casting to unsigned long long is no longer necessary and there is no
good reason to split into multiple sprintf() calls.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 Documentation/ABI/testing/sysfs-bus-rbd |    4 +--
 drivers/block/rbd.c                     |   56 +++++++++++++------------------
 2 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-rbd b/Documentation/ABI/testing/sysfs-bus-rbd
index 501adc2a9ec7..2ddd680929d8 100644
--- a/Documentation/ABI/testing/sysfs-bus-rbd
+++ b/Documentation/ABI/testing/sysfs-bus-rbd
@@ -94,5 +94,5 @@ current_snap
 
 parent
 
-	Information identifying the pool, image, and snapshot id for
-	the parent image in a layered rbd image (format 2 only).
+	Information identifying the chain of parent images in a layered rbd
+	image.  Entries are separated by empty lines.
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 703b728e05fa..7847fbb949ff 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3685,46 +3685,36 @@ static ssize_t rbd_snap_show(struct device *dev,
 }
 
 /*
- * For an rbd v2 image, shows the pool id, image id, and snapshot id
- * for the parent image.  If there is no parent, simply shows
- * "(no parent image)".
+ * For a v2 image, shows the chain of parent images, separated by empty
+ * lines.  For v1 images or if there is no parent, shows "(no parent
+ * image)".
  */
 static ssize_t rbd_parent_show(struct device *dev,
-			     struct device_attribute *attr,
-			     char *buf)
+			       struct device_attribute *attr,
+			       char *buf)
 {
 	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
-	struct rbd_spec *spec = rbd_dev->parent_spec;
-	int count;
-	char *bufp = buf;
+	ssize_t count = 0;
 
-	if (!spec)
+	if (!rbd_dev->parent)
 		return sprintf(buf, "(no parent image)\n");
 
-	count = sprintf(bufp, "pool_id %llu\npool_name %s\n",
-			(unsigned long long) spec->pool_id, spec->pool_name);
-	if (count < 0)
-		return count;
-	bufp += count;
-
-	count = sprintf(bufp, "image_id %s\nimage_name %s\n", spec->image_id,
-			spec->image_name ? spec->image_name : "(unknown)");
-	if (count < 0)
-		return count;
-	bufp += count;
-
-	count = sprintf(bufp, "snap_id %llu\nsnap_name %s\n",
-			(unsigned long long) spec->snap_id, spec->snap_name);
-	if (count < 0)
-		return count;
-	bufp += count;
-
-	count = sprintf(bufp, "overlap %llu\n", rbd_dev->parent_overlap);
-	if (count < 0)
-		return count;
-	bufp += count;
-
-	return (ssize_t) (bufp - buf);
+	for ( ; rbd_dev->parent; rbd_dev = rbd_dev->parent) {
+		struct rbd_spec *spec = rbd_dev->parent_spec;
+
+		count += sprintf(&buf[count], "%s"
+			    "pool_id %llu\npool_name %s\n"
+			    "image_id %s\nimage_name %s\n"
+			    "snap_id %llu\nsnap_name %s\n"
+			    "overlap %llu\n",
+			    !count ? "" : "\n", /* first? */
+			    spec->pool_id, spec->pool_name,
+			    spec->image_id, spec->image_name ?: "(unknown)",
+			    spec->snap_id, spec->snap_name,
+			    rbd_dev->parent_overlap);
+	}
+
+	return count;
 }
 
 static ssize_t rbd_image_refresh(struct device *dev,
-- 
1.7.10.4

