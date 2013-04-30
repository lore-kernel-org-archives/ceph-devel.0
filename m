From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4] rbd: look up snapshot name in names buffer
Date: Tue, 30 Apr 2013 07:42:33 -0500
Message-ID: <517FBC39.9040702@inktank.com>
References: <517FBBF0.9020904@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:50253 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760555Ab3D3Mmf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 08:42:35 -0400
Received: by mail-ie0-f182.google.com with SMTP id bn7so498712ieb.41
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 05:42:34 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id w8sm7695849igl.9.2013.04.30.05.42.33
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 05:42:33 -0700 (PDT)
In-Reply-To: <517FBBF0.9020904@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Rather than scanning the list of snapshot structures for it, scan
the snapshot context buffer containing snapshot names in order to
determine for a format 1 image the name associated with a given
snapshot id.

Pull out the part of rbd_dev_v1_snap_info() that does this scan into
a new function, _rbd_dev_v1_snap_name().  Have that function return
a dynamically-allocated copy of the name, and don't duplicate it in
rbd_dev_v1_snap_info().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 15e84d8..98033e7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -66,6 +66,8 @@

 #define RBD_SNAP_HEAD_NAME	"-"

+#define	BAD_SNAP_INDEX	U32_MAX		/* invalid index into snap array */
+
 /* This allows a single page to hold an image name sent by OSD */
 #define RBD_IMAGE_NAME_LEN_MAX	(PAGE_SIZE - sizeof (__le32) - 1)
 #define RBD_IMAGE_ID_LEN_MAX	64
@@ -809,6 +811,33 @@ out_err:
 	return -ENOMEM;
 }

+static const char *_rbd_dev_v1_snap_name(struct rbd_device *rbd_dev,
u32 which)
+{
+	const char *snap_name;
+
+	rbd_assert(which < rbd_dev->header.snapc->num_snaps);
+
+	/* Skip over names until we find the one we are looking for */
+
+	snap_name = rbd_dev->header.snap_names;
+	while (which--)
+		snap_name += strlen(snap_name) + 1;
+
+	return kstrdup(snap_name, GFP_KERNEL);
+}
+
+static u32 rbd_dev_snap_index(struct rbd_device *rbd_dev, u64 snap_id)
+{
+	struct ceph_snap_context *snapc = rbd_dev->header.snapc;
+	u32 which;
+
+	for (which = 0; which < snapc->num_snaps; which++)
+		if (snapc->snaps[which] == snap_id)
+			return which;
+
+	return BAD_SNAP_INDEX;
+}
+
 static const char *rbd_snap_name(struct rbd_device *rbd_dev, u64 snap_id)
 {
 	struct rbd_snap *snap;
@@ -3421,17 +3450,8 @@ static const char *rbd_dev_v1_snap_info(struct
rbd_device *rbd_dev, u32 which,
 		u64 *snap_size, u64 *snap_features)
 {
 	const char *snap_name;
-	int i;
-
-	rbd_assert(which < rbd_dev->header.snapc->num_snaps);
-
-	/* Skip over names until we find the one we are looking for */

-	snap_name = rbd_dev->header.snap_names;
-	for (i = 0; i < which; i++)
-		snap_name += strlen(snap_name) + 1;
-
-	snap_name = kstrdup(snap_name, GFP_KERNEL);
+	snap_name = _rbd_dev_v1_snap_name(rbd_dev, which);
 	if (!snap_name)
 		return ERR_PTR(-ENOMEM);

-- 
1.7.9.5

