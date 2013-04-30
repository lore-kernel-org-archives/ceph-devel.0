From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/3] rbd: snap names are pointer to constant data
Date: Tue, 30 Apr 2013 07:23:42 -0500
Message-ID: <517FB7CE.9050809@inktank.com>
References: <517FB770.1070500@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:62447 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760543Ab3D3MXp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 08:23:45 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so488977iec.15
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 05:23:44 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id ua6sm22307289igb.0.2013.04.30.05.23.43
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 05:23:43 -0700 (PDT)
In-Reply-To: <517FB770.1070500@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Make explicit that snapshot names don't change by making functions
return and take parameters that that point to const qualified data.

This resolves:
    http://tracker.ceph.com/issues/4857

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index dbc61e3..ab5c901 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3435,10 +3435,10 @@ static struct rbd_snap *rbd_snap_create(struct
rbd_device *rbd_dev,
  * Returns a dynamically-allocated snapshot name if successful, or a
  * pointer-coded error otherwise.
  */
-static char *rbd_dev_v1_snap_info(struct rbd_device *rbd_dev, u32 which,
+static const char *rbd_dev_v1_snap_info(struct rbd_device *rbd_dev, u32
which,
 		u64 *snap_size, u64 *snap_features)
 {
-	char *snap_name;
+	const char *snap_name;
 	int i;

 	rbd_assert(which < rbd_dev->header.snapc->num_snaps);
@@ -3907,7 +3907,7 @@ out:
 	return ret;
 }

-static char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev, u32 which)
+static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev, u32
which)
 {
 	size_t size;
 	void *reply_buf;
@@ -3948,13 +3948,13 @@ out:
 	return snap_name;
 }

-static char *rbd_dev_v2_snap_info(struct rbd_device *rbd_dev, u32 which,
+static const char *rbd_dev_v2_snap_info(struct rbd_device *rbd_dev, u32
which,
 		u64 *snap_size, u64 *snap_features)
 {
 	u64 snap_id;
 	u64 size;
 	u64 features;
-	char *snap_name;
+	const char *snap_name;
 	int ret;

 	rbd_assert(which < rbd_dev->header.snapc->num_snaps);
@@ -3978,7 +3978,7 @@ out_err:
 	return ERR_PTR(ret);
 }

-static char *rbd_dev_snap_info(struct rbd_device *rbd_dev, u32 which,
+static const char *rbd_dev_snap_info(struct rbd_device *rbd_dev, u32 which,
 		u64 *snap_size, u64 *snap_features)
 {
 	if (rbd_dev->image_format == 1)
@@ -4045,7 +4045,7 @@ static int rbd_dev_snaps_update(struct rbd_device
*rbd_dev)
 	while (index < snap_count || links != head) {
 		u64 snap_id;
 		struct rbd_snap *snap;
-		char *snap_name;
+		const char *snap_name;
 		u64 snap_size = 0;
 		u64 snap_features = 0;

-- 
1.7.9.5

