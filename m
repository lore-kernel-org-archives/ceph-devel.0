From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 5/6] rbd: rename __rbd_update_snaps to __rbd_refresh_header
Date: Wed, 18 Apr 2012 09:41:12 -0500
Message-ID: <4F8ED288.9010807@dreamhost.com>
References: <4F8ED154.6050500@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39342 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab2DROlN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 10:41:13 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 0FAD62449D
	for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 07:44:16 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id D86922444A
	for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 07:44:15 -0700 (PDT)
In-Reply-To: <4F8ED154.6050500@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This function rereads the entire header and handles any changes in
it, not just changes in snapshots.

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
Reviewed-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)

Index: b/drivers/block/rbd.c
===================================================================
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -240,7 +240,7 @@
  	put_device(&rbd_dev->dev);
  }

-static int __rbd_update_snaps(struct rbd_device *rbd_dev);
+static int __rbd_refresh_header(struct rbd_device *rbd_dev);

  static int rbd_open(struct block_device *bdev, fmode_t mode)
  {
@@ -1223,7 +1223,7 @@
  	dout("rbd_watch_cb %s notify_id=%lld opcode=%d\n", dev->obj_md_name,
  		notify_id, (int)opcode);
  	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
-	rc = __rbd_update_snaps(dev);
+	rc = __rbd_refresh_header(dev);
  	mutex_unlock(&ctl_mutex);
  	if (rc)
  		pr_warning(RBD_DRV_NAME "%d got notification but failed to "
@@ -1690,7 +1690,7 @@
  /*
   * only read the first part of the ondisk header, without the snaps info
   */
-static int __rbd_update_snaps(struct rbd_device *rbd_dev)
+static int __rbd_refresh_header(struct rbd_device *rbd_dev)
  {
  	int ret;
  	struct rbd_image_header h;
@@ -1877,7 +1877,7 @@

  	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);

-	rc = __rbd_update_snaps(rbd_dev);
+	rc = __rbd_refresh_header(rbd_dev);
  	if (rc < 0)
  		ret = rc;

@@ -2160,7 +2160,7 @@
  					 rbd_dev->header.obj_version);
  		if (ret == -ERANGE) {
  			mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
-			rc = __rbd_update_snaps(rbd_dev);
+			rc = __rbd_refresh_header(rbd_dev);
  			mutex_unlock(&ctl_mutex);
  			if (rc < 0)
  				return rc;
@@ -2545,7 +2545,7 @@
  	if (ret < 0)
  		goto err_unlock;

-	ret = __rbd_update_snaps(rbd_dev);
+	ret = __rbd_refresh_header(rbd_dev);
  	if (ret < 0)
  		goto err_unlock;

