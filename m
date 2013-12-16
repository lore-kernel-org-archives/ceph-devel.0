From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] rbd: enable extended devt in single-major mode
Date: Mon, 16 Dec 2013 19:33:47 +0200
Message-ID: <1387215227-19332-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:39391 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550Ab3LPRef (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 12:34:35 -0500
Received: by mail-ee0-f54.google.com with SMTP id e51so2028380eek.13
        for <ceph-devel@vger.kernel.org>; Mon, 16 Dec 2013 09:34:34 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

If single-major device number allocation scheme is turned on, instead
of reserving 256 minors per device, which imposes a limit of 4096
images mapped at once, reserve 16 minors per device and enable extended
devt feature.  This results in a theoretical limit of 65536 images
mapped at once, and still allows to have more than 15 partititions:
partitions starting with 16th are mapped under major 259 (Block
Extended Major):

$ rbd showmapped
id pool image snap device
0  rbd  b5    -    /dev/rbd0    # no partitions
1  rbd  b2    -    /dev/rbd1    # 40 partitions
2  rbd  b3    -    /dev/rbd2    #  2 partitions

$ cat /proc/partitions
 251        0       1024 rbd0
 251       16       1024 rbd1
 251       17          0 rbd1p1
 251       18          0 rbd1p2
 ...
 251       30          0 rbd1p14
 251       31          0 rbd1p15
 259        0          0 rbd1p16
 259        1          0 rbd1p17
 ...
 259       23          0 rbd1p39
 259       24          0 rbd1p40
 251       32       1024 rbd2
 251       33          0 rbd2p1
 251       34          0 rbd2p2

(major 251 was assigned dynamically at module load time)

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
---
[ Josh has already reviewed this and it is ready to be merged into
testing branch of ceph-client.git, but it wasn't posted on any mailing
list.  Correcting this oversight now. ]

 drivers/block/rbd.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e5ddcb58e9a2..11ae4c1238a6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -91,7 +91,8 @@ static int atomic_dec_return_safe(atomic_t *v)
 
 #define RBD_DRV_NAME "rbd"
 
-#define RBD_PART_SHIFT	8
+#define RBD_MINORS_PER_MAJOR		256
+#define RBD_SINGLE_MAJOR_PART_SHIFT	4
 
 #define RBD_SNAP_DEV_NAME_PREFIX	"snap_"
 #define RBD_MAX_SNAP_NAME_LEN	\
@@ -415,12 +416,12 @@ static void rbd_spec_put(struct rbd_spec *spec);
 
 static int rbd_dev_id_to_minor(int dev_id)
 {
-	return dev_id << RBD_PART_SHIFT;
+	return dev_id << RBD_SINGLE_MAJOR_PART_SHIFT;
 }
 
 static int minor_to_rbd_dev_id(int minor)
 {
-	return minor >> RBD_PART_SHIFT;
+	return minor >> RBD_SINGLE_MAJOR_PART_SHIFT;
 }
 
 static BUS_ATTR(add, S_IWUSR, NULL, rbd_add);
@@ -3434,7 +3435,9 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	u64 segment_size;
 
 	/* create gendisk info */
-	disk = alloc_disk(1 << RBD_PART_SHIFT);
+	disk = alloc_disk(single_major ?
+			  (1 << RBD_SINGLE_MAJOR_PART_SHIFT) :
+			  RBD_MINORS_PER_MAJOR);
 	if (!disk)
 		return -ENOMEM;
 
@@ -3442,6 +3445,8 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 		 rbd_dev->dev_id);
 	disk->major = rbd_dev->major;
 	disk->first_minor = rbd_dev->minor;
+	if (single_major)
+		disk->flags |= GENHD_FL_EXT_DEVT;
 	disk->fops = &rbd_bd_ops;
 	disk->private_data = rbd_dev;
 
-- 
1.7.10.4

