From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/9] rbd: get image features for a v2 image
Date: Fri, 07 Sep 2012 16:13:46 -0500
Message-ID: <504A638A.8030007@inktank.com>
References: <504A6273.7030807@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38161 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757201Ab2IGVNt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 17:13:49 -0400
Received: by mail-ie0-f174.google.com with SMTP id e11so40763iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 14:13:49 -0700 (PDT)
In-Reply-To: <504A6273.7030807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The features values for an rbd format 2 image are fetched from the
server using a "get_features" method.  The same method is used for
getting the features for a snapshot, so structure this addition with
a generic helper routine that can get this information for either.

The server will provide two 64-bit feature masks, one representing
the features used for this image (or snapshot) and one representing
features which cannot be used by the client when working with the
image (or snapshot).

For the time being, neither of these is really used so we keep
things simple and just record the first feature vector.  Once we
start using these feature masks, what we record and what we expose
to the user will most likely change.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 36e848a..d48f025 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2200,6 +2200,40 @@ out:
 	return ret;
 }

+static int _rbd_dev_v2_snap_features(struct rbd_device *rbd_dev, u64
snap_id,
+		u64 *snap_features)
+{
+	__le64 snapid = cpu_to_le64(snap_id);
+	struct {
+		__le64 features;
+		__le64 incompat;
+	} features_buf = { 0 };
+	int ret;
+
+	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
+				"rbd", "get_features",
+				(char *) &snapid, sizeof (snapid),
+				(char *) &features_buf, sizeof (features_buf),
+				CEPH_OSD_FLAG_READ, NULL);
+	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
+	if (ret < 0)
+		return ret;
+	*snap_features = le64_to_cpu(features_buf.features);
+
+	dout("  snap_id 0x%016llx features = 0x%016llx incompat = 0x%016llx\n",
+		(unsigned long long) snap_id,
+		(unsigned long long) *snap_features,
+		(unsigned long long) le64_to_cpu(features_buf.incompat));
+
+	return 0;
+}
+
+static int rbd_dev_v2_features(struct rbd_device *rbd_dev)
+{
+	return _rbd_dev_v2_snap_features(rbd_dev, CEPH_NOSNAP,
+						&rbd_dev->header.features);
+}
+
 /*
  * Scan the rbd device's current snapshot list and compare it to the
  * newly-received snapshot context.  Remove any existing snapshots
@@ -2733,6 +2767,12 @@ static int rbd_dev_v2_probe(struct rbd_device
*rbd_dev)
 	ret = rbd_dev_v2_object_prefix(rbd_dev);
 	if (ret < 0)
 		goto out_err;
+
+	/* Get the features for the image */
+
+	ret = rbd_dev_v2_features(rbd_dev);
+	if (ret < 0)
+		goto out_err;
 	rbd_dev->image_format = 2;

 	dout("discovered version 2 image, header name is %s\n",
-- 
1.7.9.5

