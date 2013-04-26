From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/4] rbd: set snapshot id in rbd_dev_probe_update_spec()
Date: Fri, 26 Apr 2013 09:53:02 -0500
Message-ID: <517A94CE.2050408@inktank.com>
References: <517A945B.9040304@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:44489 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab3DZOxE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 10:53:04 -0400
Received: by mail-ia0-f175.google.com with SMTP id i38so3774448iae.34
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 07:53:04 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id b6sm3524819igv.5.2013.04.26.07.53.03
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 07:53:03 -0700 (PDT)
In-Reply-To: <517A945B.9040304@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Set the rbd spec's snapshot id for an image getting mapped in
rbd_dev_probe_update_spec() rather than rbd_dev_set_mapping().
This is the more logical place for that to happen (even though
it means we might look up the snapshot by name twice).

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5f97137..5099f44 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -846,7 +846,6 @@ static int rbd_dev_set_mapping(struct rbd_device
*rbd_dev)
 {
 	if (!memcmp(rbd_dev->spec->snap_name, RBD_SNAP_HEAD_NAME,
 		    sizeof (RBD_SNAP_HEAD_NAME))) {
-		rbd_dev->spec->snap_id = CEPH_NOSNAP;
 		rbd_dev->mapping.size = rbd_dev->header.image_size;
 		rbd_dev->mapping.features = rbd_dev->header.features;
 	} else {
@@ -855,7 +854,6 @@ static int rbd_dev_set_mapping(struct rbd_device
*rbd_dev)
 		snap = snap_by_name(rbd_dev, rbd_dev->spec->snap_name);
 		if (!snap)
 			return -ENOENT;
-		rbd_dev->spec->snap_id = snap->id;
 		rbd_dev->mapping.size = snap->size;
 		rbd_dev->mapping.features = snap->features;
 		rbd_dev->mapping.read_only = true;
@@ -3759,6 +3757,10 @@ out:
  * rbd_dev_snaps_update() has completed because some of the
  * information (in particular, snapshot name) is not available
  * until then.
+ *
+ * When an image being mapped (not a parent) is probed, we have the
+ * pool name and pool id, image name and image id, and the snapshot
+ * name.  The only thing we're missing is the snapshot id.
  */
 static int rbd_dev_probe_update_spec(struct rbd_device *rbd_dev)
 {
@@ -3767,8 +3769,24 @@ static int rbd_dev_probe_update_spec(struct
rbd_device *rbd_dev)
 	void *reply_buf = NULL;
 	int ret;

-	if (rbd_dev->spec->pool_name)
-		return 0;	/* Already have the names */
+	/*
+	 * An image being mapped will have the pool name (etc.), but
+	 * we need to look up the snapshot id.
+	 */
+	if (rbd_dev->spec->pool_name) {
+		if (strcmp(rbd_dev->spec->snap_name, RBD_SNAP_HEAD_NAME)) {
+			struct rbd_snap *snap;
+
+			snap = snap_by_name(rbd_dev, rbd_dev->spec->snap_name);
+			if (!snap)
+				return -ENOENT;
+			rbd_dev->spec->snap_id = snap->id;
+		} else {
+			rbd_dev->spec->snap_id = CEPH_NOSNAP;
+		}
+
+		return 0;
+	}

 	/* Look up the pool name */

-- 
1.7.9.5

