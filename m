From: Alex Elder <elder@inktank.com>
Subject: [PATCH, v2] rbd: do not allow remove of mounted-on image
Date: Mon, 19 Nov 2012 17:42:49 -0600
Message-ID: <50AAC3F9.1040809@inktank.com>
References: <50A65F15.6080807@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41779 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab2KSXmw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 18:42:52 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so7729715iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 15:42:52 -0800 (PST)
In-Reply-To: <50A65F15.6080807@inktank.com>
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
v2: added ctl_mutex locking for rbd_open() and rbd_release()

 drivers/block/rbd.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: b/drivers/block/rbd.c
===================================================================
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -255,6 +255,7 @@ struct rbd_device {

 	/* sysfs related */
 	struct device		dev;
+	unsigned long		open_count;
 };

 static DEFINE_MUTEX(ctl_mutex);	  /* Serialize open/close/setup/teardown */
@@ -356,8 +357,11 @@ static int rbd_open(struct block_device
 	if ((mode & FMODE_WRITE) && rbd_dev->mapping.read_only)
 		return -EROFS;

+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
 	rbd_get_dev(rbd_dev);
 	set_device_ro(bdev, rbd_dev->mapping.read_only);
+	rbd_dev->open_count++;
+	mutex_unlock(&ctl_mutex);

 	return 0;
 }
@@ -366,7 +370,11 @@ static int rbd_release(struct gendisk *d
 {
 	struct rbd_device *rbd_dev = disk->private_data;

+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
+	rbd_assert(rbd_dev->open_count > 0);
+	rbd_dev->open_count--;
 	rbd_put_dev(rbd_dev);
+	mutex_unlock(&ctl_mutex);

 	return 0;
 }
@@ -3764,6 +3772,11 @@ static ssize_t rbd_remove(struct bus_typ
 		goto done;
 	}

+	if (rbd_dev->open_count) {
+		ret = -EBUSY;
+		goto done;
+	}
+
 	rbd_remove_all_snaps(rbd_dev);
 	rbd_bus_del_dev(rbd_dev);

