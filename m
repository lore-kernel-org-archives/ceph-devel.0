From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4] rbd: define and use rbd_warn()
Date: Thu, 01 Nov 2012 10:26:12 -0500
Message-ID: <50929494.7060009@inktank.com>
References: <50929419.6020302@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52102 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761049Ab2KAP0P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 11:26:15 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3724548iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 08:26:15 -0700 (PDT)
In-Reply-To: <50929419.6020302@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Define a new function rbd_warn() that produces a boilerplate warning
message, identifying in the resulting message the affected rbd
device in the best way available.  Use it in a few places that now
use pr_warning().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 503ee7f..85a5164 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -293,6 +293,33 @@ static struct device rbd_root_dev = {
 	.release =      rbd_root_dev_release,
 };

+static __printf(2, 3)
+void rbd_warn(struct rbd_device *rbd_dev, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	if (!rbd_dev)
+		printk(KERN_WARNING "%s: %pV\n", RBD_DRV_NAME, &vaf);
+	else if (rbd_dev->disk)
+		printk(KERN_WARNING "%s: %s: %pV\n",
+			RBD_DRV_NAME, rbd_dev->disk->disk_name, &vaf);
+	else if (rbd_dev->spec && rbd_dev->spec->image_name)
+		printk(KERN_WARNING "%s: image %s: %pV\n",
+			RBD_DRV_NAME, rbd_dev->spec->image_name, &vaf);
+	else if (rbd_dev->spec && rbd_dev->spec->image_id)
+		printk(KERN_WARNING "%s: id %s: %pV\n",
+			RBD_DRV_NAME, rbd_dev->spec->image_id, &vaf);
+	else	/* punt */
+		printk(KERN_WARNING "%s: rbd_dev %p: %pV\n",
+			RBD_DRV_NAME, rbd_dev, &vaf);
+	va_end(args);
+}
+
 #ifdef RBD_DEBUG
 #define rbd_assert(expr)						\
 		if (unlikely(!(expr))) {				\
@@ -1405,8 +1432,8 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
 		(unsigned int) opcode);
 	rc = rbd_dev_refresh(rbd_dev, &hver);
 	if (rc)
-		pr_warning(RBD_DRV_NAME "%d got notification but failed to "
-			   " update snaps: %d\n", rbd_dev->major, rc);
+		rbd_warn(rbd_dev, "got notification but failed to "
+			   " update snaps: %d\n", rc);

 	rbd_req_sync_notify_ack(rbd_dev, hver, notify_id);
 }
@@ -1769,15 +1796,13 @@ rbd_dev_v1_header_read(struct rbd_device
*rbd_dev, u64 *version)
 			goto out_err;
 		if (WARN_ON((size_t) ret < size)) {
 			ret = -ENXIO;
-			pr_warning("short header read for image %s"
-					" (want %zd got %d)\n",
-				rbd_dev->spec->image_name, size, ret);
+			rbd_warn(rbd_dev, "short header read (want %zd got %d)",
+				size, ret);
 			goto out_err;
 		}
 		if (!rbd_dev_ondisk_valid(ondisk)) {
 			ret = -ENXIO;
-			pr_warning("invalid header for image %s\n",
-				rbd_dev->spec->image_name);
+			rbd_warn(rbd_dev, "invalid header");
 			goto out_err;
 		}

@@ -2632,9 +2657,7 @@ static int rbd_dev_probe_update_spec(struct
rbd_device *rbd_dev)
 	if (name)
 		rbd_dev->spec->image_name = (char *) name;
 	else
-		pr_warning(RBD_DRV_NAME "%d "
-			"unable to get image name for image id %s\n",
-			rbd_dev->major, rbd_dev->spec->image_id);
+		rbd_warn(rbd_dev, "unable to get image name");

 	/* Look up the snapshot name. */

-- 
1.7.9.5

