From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/6] rbd: don't look up snapshot id in rbd_dev_mapping_set()
Date: Mon, 06 May 2013 20:38:04 -0500
Message-ID: <51885AFC.3050908@inktank.com>
References: <51885A97.9070005@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:49796 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759433Ab3EGBiH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 21:38:07 -0400
Received: by mail-ie0-f178.google.com with SMTP id b11so52368iee.37
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 18:38:06 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id c2sm5186687igv.1.2013.05.06.18.38.04
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 May 2013 18:38:05 -0700 (PDT)
In-Reply-To: <51885A97.9070005@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently rbd_dev_mapping_set() looks up the snapshot id for the
snapshot whose name is found in the rbd device's spec structure.

That function gets called by rbd_dev_device_setup(), which is
called by rbd_add() *after* rbd_dev_image_probe().  If the
image probe succeeds, the rbd device's spec will already have
been updated to include names and ids for all fields.

Therefore there's no need to look up the snapshot id in
rbd_dev_mapping_set().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7d93dbd..5eebf6d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -936,20 +936,11 @@ static int rbd_snap_features(struct rbd_device
*rbd_dev, u64 snap_id,

 static int rbd_dev_mapping_set(struct rbd_device *rbd_dev)
 {
-	const char *snap_name = rbd_dev->spec->snap_name;
-	u64 snap_id;
+	u64 snap_id = rbd_dev->spec->snap_id;
 	u64 size = 0;
 	u64 features = 0;
 	int ret;

-	if (strcmp(snap_name, RBD_SNAP_HEAD_NAME)) {
-		snap_id = rbd_snap_id_by_name(rbd_dev, snap_name);
-		if (snap_id == CEPH_NOSNAP)
-			return -ENOENT;
-	} else {
-		snap_id = CEPH_NOSNAP;
-	}
-
 	ret = rbd_snap_size(rbd_dev, snap_id, &size);
 	if (ret)
 		return ret;
-- 
1.7.9.5

