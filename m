From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/6] rbd: rename rbd_device->id
Date: Thu, 26 Jul 2012 13:45:18 -0500
Message-ID: <5011903E.6030504@inktank.com>
References: <50118F33.7080502@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:59777 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416Ab2GZSpV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 14:45:21 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so2311502ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 11:45:20 -0700 (PDT)
In-Reply-To: <50118F33.7080502@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The "id" field of an rbd device structure represents the unique
client-local device id mapped to the underlying rbd image.  Each rbd
image will have another id--the image id--and each snapshot has its
own id as well.  The simple name "id" no longer conveys the
information one might like to have.

Rename the device "id" field in struct rbd_dev to be "dev_id" to
make it a little more obvious what we're dealing with without having
to think more about context.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d95d563..0fda2ed 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -147,7 +147,7 @@ struct rbd_snap {
  * a single device
  */
 struct rbd_device {
-	int			id;		/* blkdev unique id */
+	int			dev_id;		/* blkdev unique id */

 	int			major;		/* blkdev assigned major */
 	struct gendisk		*disk;		/* blkdev's gendisk and rq */
@@ -1778,7 +1778,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 		goto out;

 	snprintf(disk->disk_name, sizeof(disk->disk_name), RBD_DRV_NAME "%d",
-		 rbd_dev->id);
+		 rbd_dev->dev_id);
 	disk->major = rbd_dev->major;
 	disk->first_minor = 0;
 	disk->fops = &rbd_bd_ops;
@@ -2167,7 +2167,7 @@ static int rbd_bus_add_dev(struct rbd_device *rbd_dev)
 	dev->type = &rbd_device_type;
 	dev->parent = &rbd_root_dev;
 	dev->release = rbd_dev_release;
-	dev_set_name(dev, "%d", rbd_dev->id);
+	dev_set_name(dev, "%d", rbd_dev->dev_id);
 	ret = device_register(dev);
 	if (ret < 0)
 		goto out;
@@ -2215,7 +2215,7 @@ static atomic64_t rbd_id_max = ATOMIC64_INIT(0);
  */
 static void rbd_id_get(struct rbd_device *rbd_dev)
 {
-	rbd_dev->id = atomic64_inc_return(&rbd_id_max);
+	rbd_dev->dev_id = atomic64_inc_return(&rbd_id_max);

 	spin_lock(&rbd_dev_list_lock);
 	list_add_tail(&rbd_dev->node, &rbd_dev_list);
@@ -2229,7 +2229,7 @@ static void rbd_id_get(struct rbd_device *rbd_dev)
 static void rbd_id_put(struct rbd_device *rbd_dev)
 {
 	struct list_head *tmp;
-	int rbd_id = rbd_dev->id;
+	int rbd_id = rbd_dev->dev_id;
 	int max_id;

 	BUG_ON(rbd_id < 1);
@@ -2468,7 +2468,7 @@ static ssize_t rbd_add(struct bus_type *bus,
 	/* Fill in the device name, now that we have its id. */
 	BUILD_BUG_ON(DEV_NAME_LEN
 			< sizeof (RBD_DRV_NAME) + MAX_INT_FORMAT_WIDTH);
-	sprintf(rbd_dev->name, "%s%d", RBD_DRV_NAME, rbd_dev->id);
+	sprintf(rbd_dev->name, "%s%d", RBD_DRV_NAME, rbd_dev->dev_id);

 	/* parse add command */
 	rc = rbd_add_parse_args(rbd_dev, buf, &mon_addrs, &mon_addrs_size,
@@ -2545,7 +2545,7 @@ err_nomem:
 	return (ssize_t) rc;
 }

-static struct rbd_device *__rbd_get_dev(unsigned long id)
+static struct rbd_device *__rbd_get_dev(unsigned long dev_id)
 {
 	struct list_head *tmp;
 	struct rbd_device *rbd_dev;
@@ -2553,7 +2553,7 @@ static struct rbd_device *__rbd_get_dev(unsigned
long id)
 	spin_lock(&rbd_dev_list_lock);
 	list_for_each(tmp, &rbd_dev_list) {
 		rbd_dev = list_entry(tmp, struct rbd_device, node);
-		if (rbd_dev->id == id) {
+		if (rbd_dev->dev_id == dev_id) {
 			spin_unlock(&rbd_dev_list_lock);
 			return rbd_dev;
 		}
-- 
1.7.9.5

