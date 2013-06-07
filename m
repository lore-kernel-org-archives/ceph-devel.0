From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [PATCH 3/5] rbd: don't hold ctl_mutex to get/put device
Date: Fri, 07 Jun 2013 10:44:55 -0700
Message-ID: <3f293a49-86a2-4cb3-a369-aedd767d8d26@email.android.com>
References: <51A94BC0.4080703@inktank.com> <51A94C63.8060104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:52055 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756594Ab3FGSPJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Jun 2013 14:15:09 -0400
In-Reply-To: <51A94C63.8060104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com> 

Alex Elder <elder@inktank.com> wrote:
>When an rbd device is first getting mapped, its device registration
>is protected the control mutex.  There is no need to do that though,
>because the device has already been assigned an id that's guaranteed
>to be unique.
>
>An unmap of an rbd device won't proceed if the device has a non-zero
>open count or is already being unmapped.  So there's no need to hold
>the control mutex in that case either.
>
>Finally, an rbd device can't be opened if it is being removed, and
>it won't go away if there is a non-zero open count.  So here too
>there's no need to hold the control mutex while getting or putting a
>reference to an rbd device's Linux device structure.
>
>Drop the mutex calls in these cases.
>
>Signed-off-by: Alex Elder <elder@inktank.com>
>---
> drivers/block/rbd.c |   17 ++---------------
> 1 file changed, 2 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>index 380940d..9c81a5c 100644
>--- a/drivers/block/rbd.c
>+++ b/drivers/block/rbd.c
>@@ -489,10 +489,8 @@ static int rbd_open(struct block_device *bdev,
>fmode_t mode)
> 	if (removing)
> 		return -ENOENT;
>
>-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
> 	(void) get_device(&rbd_dev->dev);
> 	set_device_ro(bdev, rbd_dev->mapping.read_only);
>-	mutex_unlock(&ctl_mutex);
>
> 	return 0;
> }
>@@ -507,9 +505,7 @@ static int rbd_release(struct gendisk *disk,
>fmode_t
>mode)
> 	spin_unlock_irq(&rbd_dev->lock);
> 	rbd_assert(open_count_before > 0);
>
>-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
> 	put_device(&rbd_dev->dev);
>-	mutex_unlock(&ctl_mutex);
>
> 	return 0;
> }
>@@ -4348,8 +4344,6 @@ static int rbd_bus_add_dev(struct rbd_device
>*rbd_dev)
> 	struct device *dev;
> 	int ret;
>
>-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
>-
> 	dev = &rbd_dev->dev;
> 	dev->bus = &rbd_bus_type;
> 	dev->type = &rbd_device_type;
>@@ -4358,8 +4352,6 @@ static int rbd_bus_add_dev(struct rbd_device
>*rbd_dev)
> 	dev_set_name(dev, "%d", rbd_dev->dev_id);
> 	ret = device_register(dev);
>
>-	mutex_unlock(&ctl_mutex);
>-
> 	return ret;
> }
>
>@@ -5165,8 +5157,6 @@ static ssize_t rbd_remove(struct bus_type *bus,
> 	if (dev_id != ul)
> 		return -EINVAL;
>
>-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
>-
> 	ret = -ENOENT;
> 	spin_lock(&rbd_dev_list_lock);
> 	list_for_each(tmp, &rbd_dev_list) {
>@@ -5187,7 +5177,7 @@ static ssize_t rbd_remove(struct bus_type *bus,
> 	}
> 	spin_unlock(&rbd_dev_list_lock);
> 	if (ret < 0 || already)
>-		goto done;
>+		return ret;
>
> 	rbd_bus_del_dev(rbd_dev);
> 	ret = rbd_dev_header_watch_sync(rbd_dev, false);
>@@ -5195,11 +5185,8 @@ static ssize_t rbd_remove(struct bus_type *bus,
> 		rbd_warn(rbd_dev, "failed to cancel watch event (%d)\n", ret);
> 	rbd_dev_image_release(rbd_dev);
> 	module_put(THIS_MODULE);
>-	ret = count;
>-done:
>-	mutex_unlock(&ctl_mutex);
>
>-	return ret;
>+	return count;
> }
>
> /*


