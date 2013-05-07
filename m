From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/7] rbd: set the mapping size and features later
Date: Mon, 06 May 2013 20:52:32 -0500
Message-ID: <51885E60.2010902@inktank.com>
References: <51885E06.8020201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:45762 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759546Ab3EGBwe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 21:52:34 -0400
Received: by mail-ve0-f174.google.com with SMTP id pb11so41923veb.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 18:52:34 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id q5sm19483918vdj.5.2013.05.06.18.52.32
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 May 2013 18:52:33 -0700 (PDT)
In-Reply-To: <51885E06.8020201@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Defer setting the size and features fields of a mapped image until
after the Linux disk structure is set up.  Set the capacity of the
disk after that.

Rearrange the definition of rbd_image_header, separating the fields
that are set only once from those that can be updated.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0c72643..357a11f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -100,21 +100,20 @@
  * block device image metadata (in-memory version)
  */
 struct rbd_image_header {
-	/* These four fields never change for a given rbd image */
+	/* These six fields never change for a given rbd image */
 	char *object_prefix;
-	u64 features;
 	__u8 obj_order;
 	__u8 crypt_type;
 	__u8 comp_type;
+	u64 stripe_unit;
+	u64 stripe_count;
+	u64 features;		/* Might be changeable someday? */

 	/* The remaining fields need to be updated occasionally */
 	u64 image_size;
 	struct ceph_snap_context *snapc;
-	char *snap_names;
-	u64 *snap_sizes;
-
-	u64 stripe_unit;
-	u64 stripe_count;
+	char *snap_names;	/* format 1 only */
+	u64 *snap_sizes;	/* format 1 only */
 };

 /*
@@ -4637,10 +4636,6 @@ static int rbd_dev_device_setup(struct rbd_device
*rbd_dev)
 {
 	int ret;

-	ret = rbd_dev_mapping_set(rbd_dev);
-	if (ret)
-		return ret;
-
 	/* generate unique id: find highest unique id, add one */
 	rbd_dev_id_get(rbd_dev);

@@ -4662,13 +4657,17 @@ static int rbd_dev_device_setup(struct
rbd_device *rbd_dev)
 	if (ret)
 		goto err_out_blkdev;

-	ret = rbd_bus_add_dev(rbd_dev);
+	ret = rbd_dev_mapping_set(rbd_dev);
 	if (ret)
 		goto err_out_disk;
+	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
+
+	ret = rbd_bus_add_dev(rbd_dev);
+	if (ret)
+		goto err_out_mapping;

 	/* Everything's ready.  Announce the disk to the world. */

-	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
 	set_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
 	add_disk(rbd_dev->disk);

@@ -4677,6 +4676,8 @@ static int rbd_dev_device_setup(struct rbd_device
*rbd_dev)

 	return ret;

+err_out_mapping:
+	rbd_dev_mapping_clear(rbd_dev);
 err_out_disk:
 	rbd_free_disk(rbd_dev);
 err_out_blkdev:
-- 
1.7.9.5

