From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/6] rbd: use rbd_obj_method_sync() return value
Date: Fri, 26 Apr 2013 07:06:56 -0500
Message-ID: <517A6DE0.5080305@inktank.com>
References: <517A6D39.80000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:47942 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004Ab3DZMG5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 08:06:57 -0400
Received: by mail-ia0-f171.google.com with SMTP id r13so3511069iar.30
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 05:06:57 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id c2sm2601133igv.1.2013.04.26.05.06.55
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 05:06:56 -0700 (PDT)
In-Reply-To: <517A6D39.80000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Now that rbd_obj_method_sync() returns the number of bytes
returned by the method call, that value should be used by
callers to ensure we don't overrun the valid portion of the
buffer.

Fix the two spots that remained that weren't doing that,
rbd_dev_image_name() and rbd_dev_v2_snap_name().

Rearrange the error path slightly in rbd_dev_v2_snap_name().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2b5ba50..dcd8e58 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2614,7 +2614,8 @@ out_cancel:
 }

 /*
- * Synchronous osd object method call
+ * Synchronous osd object method call.  Returns the number of bytes
+ * returned in the outbound buffer, or a negative error code.
  */
 static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
 			     const char *object_name,
@@ -3740,7 +3741,8 @@ static char *rbd_dev_image_name(struct rbd_device
*rbd_dev)
 	if (ret < 0)
 		goto out;
 	p = reply_buf;
-	end = reply_buf + size;
+	end = reply_buf + ret;
+
 	image_name = ceph_extract_encoded_string(&p, end, &len, GFP_KERNEL);
 	if (IS_ERR(image_name))
 		image_name = NULL;
@@ -3913,26 +3915,23 @@ static char *rbd_dev_v2_snap_name(struct
rbd_device *rbd_dev, u32 which)
 				&snap_id, sizeof (snap_id),
 				reply_buf, size, NULL);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
-	if (ret < 0)
+	if (ret < 0) {
+		snap_name = ERR_PTR(ret);
 		goto out;
+	}

 	p = reply_buf;
-	end = reply_buf + size;
+	end = reply_buf + ret;
 	snap_name = ceph_extract_encoded_string(&p, end, NULL, GFP_KERNEL);
-	if (IS_ERR(snap_name)) {
-		ret = PTR_ERR(snap_name);
+	if (IS_ERR(snap_name))
 		goto out;
-	} else {
-		dout("  snap_id 0x%016llx snap_name = %s\n",
-			(unsigned long long)le64_to_cpu(snap_id), snap_name);
-	}
-	kfree(reply_buf);

-	return snap_name;
+	dout("  snap_id 0x%016llx snap_name = %s\n",
+		(unsigned long long)le64_to_cpu(snap_id), snap_name);
 out:
 	kfree(reply_buf);

-	return ERR_PTR(ret);
+	return snap_name;
 }

 static char *rbd_dev_v2_snap_info(struct rbd_device *rbd_dev, u32 which,
-- 
1.7.9.5

