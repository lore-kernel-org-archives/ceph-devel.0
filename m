From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/9] rbd: do not allow remove of mounted-on image
Date: Thu, 13 Dec 2012 11:01:08 -0600
Message-ID: <50CA09D4.9070902@inktank.com>
References: <50CA0915.1090801@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:41493 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702Ab2LMRBM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 12:01:12 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so2162297iay.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 09:01:11 -0800 (PST)
In-Reply-To: <50CA0915.1090801@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is no check in rbd_remove() to see if anybody holds open the
image being removed.  That's not cool.

Add a simple open count that goes up and down with opens and closes
(releases) of the device, and don't allow an rbd image to be removed
if the count is non-zero.

Protect the updates of the open count value with ctl_mutex to ensure
the underlying rbd device doesn't get removed while concurrently
being opened.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 842caf4..c7bf961 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -235,6 +235,7 @@ struct rbd_device {

 	/* sysfs related */
 	struct device		dev;
+	unsigned long		open_count;
 };

 static DEFINE_MUTEX(ctl_mutex);	  /* Serialize open/close/setup/teardown */
@@ -309,8 +310,11 @@ static int rbd_open(struct block_device *bdev,
fmode_t mode)
 	if ((mode & FMODE_WRITE) && rbd_dev->mapping.read_only)
 		return -EROFS;

+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
 	rbd_get_dev(rbd_dev);
 	set_device_ro(bdev, rbd_dev->mapping.read_only);
+	rbd_dev->open_count++;
+	mutex_unlock(&ctl_mutex);

 	return 0;
 }
@@ -319,7 +323,11 @@ static int rbd_release(struct gendisk *disk,
fmode_t mode)
 {
 	struct rbd_device *rbd_dev = disk->private_data;

+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
+	rbd_assert(rbd_dev->open_count > 0);
+	rbd_dev->open_count--;
 	rbd_put_dev(rbd_dev);
+	mutex_unlock(&ctl_mutex);

 	return 0;
 }
@@ -3745,6 +3753,11 @@ static ssize_t rbd_remove(struct bus_type *bus,
 		goto done;
 	}

+	if (rbd_dev->open_count) {
+		ret = -EBUSY;
+		goto done;
+	}
+
 	rbd_remove_all_snaps(rbd_dev);
 	rbd_bus_del_dev(rbd_dev);

-- 
1.7.9.5

