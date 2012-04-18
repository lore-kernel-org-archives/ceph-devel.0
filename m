From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 4/6] rbd: fix snapshot size type
Date: Wed, 18 Apr 2012 09:41:09 -0500
Message-ID: <4F8ED285.7060005@dreamhost.com>
References: <4F8ED154.6050500@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39338 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab2DROlK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 10:41:10 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id CCD922444A
	for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 07:44:12 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 7F6622449D
	for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 07:44:12 -0700 (PDT)
In-Reply-To: <4F8ED154.6050500@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Snapshot sizes should be the same type as regular image sizes. This
only affects their displayed size in sysfs, not the reported size of
an actual block device sizes.

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
Reviewed-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |    6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

Index: b/drivers/block/rbd.c
===================================================================
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -141,7 +141,7 @@
  struct rbd_snap {
  	struct	device		dev;
  	const char		*name;
-	size_t			size;
+	u64			size;
  	struct list_head	node;
  	u64			id;
  };
@@ -1936,7 +1936,7 @@
  {
  	struct rbd_snap *snap = container_of(dev, struct rbd_snap, dev);

-	return sprintf(buf, "%zd\n", snap->size);
+	return sprintf(buf, "%llu\n", (unsigned long long)snap->size);
  }

  static ssize_t rbd_snap_id_show(struct device *dev,
@@ -1945,7 +1945,7 @@
  {
  	struct rbd_snap *snap = container_of(dev, struct rbd_snap, dev);

-	return sprintf(buf, "%llu\n", (unsigned long long) snap->id);
+	return sprintf(buf, "%llu\n", (unsigned long long)snap->id);
  }

  static DEVICE_ATTR(snap_size, S_IRUGO, rbd_snap_size_show, NULL);
