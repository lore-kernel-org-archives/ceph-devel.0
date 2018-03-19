From: KAMEI Hitoshi <hitoshi.kamei.xm@hitachi.com>
Subject: [PATCH 1/2] rbd: RBD_DEV_FLAG_THICK rbd_dev_flags bit
Date: Mon, 19 Mar 2018 21:01:06 +0900
Message-ID: <5AAFA682.2080901@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: idryomov@gmail.com, sage@redhat.com, elder@kernel.org, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

This patch adds a user interface to prevent from issuing discard
requests onto the specified rbd device. This is needed for
thick-provisioned images. To avoid discarding allocated blocks on
thick-provision image, users can specify this flag bit via sysfs
(/sys/bus/rbd/devices/<dev-id>/thick).

When users write "1" to the file, rbd doesn't issue discard
operation; meanwhile, if users write "0" to the file then rbd
issues discard operation.

Signed-off-by: Hitoshi Kamei <hitoshi.kamei.xm@hitachi.com>
Cc: Mitsuo Hayasaka <mitsuo.hayasaka.hu@hitachi.com>
---
 drivers/block/rbd.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8e40da093766..dba60ef43a47 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -427,6 +427,7 @@ enum rbd_dev_flags {
 	RBD_DEV_FLAG_EXISTS,	/* mapped snapshot has not been deleted */
 	RBD_DEV_FLAG_REMOVING,	/* this mapping is being removed */
 	RBD_DEV_FLAG_BLACKLISTED, /* our ceph_client is blacklisted */
+	RBD_DEV_FLAG_THICK,	/* image is thick-provisioned */
 };

 static DEFINE_MUTEX(client_mutex);	/* Serialize client creation */
@@ -4011,6 +4012,15 @@ static void rbd_queue_workfn(struct work_struct *work)
 		goto err;
 	}

+	/* Ignore/skip discard requests for thick-provision image */
+
+	if (op_type == OBJ_OP_DISCARD &&
+	    test_bit(RBD_DEV_FLAG_THICK, &rbd_dev->flags)) {
+		dout("%s: Ignored a discard request\n", __func__);
+		result = 0;
+		goto err_rq;
+	}
+
 	/* Ignore/skip any zero-length requests */

 	if (!length) {
@@ -4600,6 +4610,32 @@ static ssize_t rbd_image_refresh(struct device *dev,
 	return size;
 }

+static ssize_t rbd_thick_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t size)
+{
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
+
+	spin_lock_irq(&rbd_dev->lock);
+	if (!strncmp(buf, "1", size))
+		set_bit(RBD_DEV_FLAG_THICK, &rbd_dev->flags);
+	else if (!strncmp(buf, "0", size))
+		clear_bit(RBD_DEV_FLAG_THICK, &rbd_dev->flags);
+	spin_unlock_irq(&rbd_dev->lock);
+
+	return size;
+}
+
+static ssize_t rbd_thick_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
+	int is_thick = test_bit(RBD_DEV_FLAG_THICK, &rbd_dev->flags) ? 1 : 0;
+
+	return sprintf(buf, "%d\n", is_thick);
+}
+
 static DEVICE_ATTR(size, S_IRUGO, rbd_size_show, NULL);
 static DEVICE_ATTR(features, S_IRUGO, rbd_features_show, NULL);
 static DEVICE_ATTR(major, S_IRUGO, rbd_major_show, NULL);
@@ -4616,6 +4652,7 @@ static DEVICE_ATTR(refresh, S_IWUSR, NULL, rbd_image_refresh);
 static DEVICE_ATTR(current_snap, S_IRUGO, rbd_snap_show, NULL);
 static DEVICE_ATTR(snap_id, S_IRUGO, rbd_snap_id_show, NULL);
 static DEVICE_ATTR(parent, S_IRUGO, rbd_parent_show, NULL);
+static DEVICE_ATTR(thick, 0644, rbd_thick_show, rbd_thick_store);

 static struct attribute *rbd_attrs[] = {
 	&dev_attr_size.attr,
@@ -4634,6 +4671,7 @@ static struct attribute *rbd_attrs[] = {
 	&dev_attr_snap_id.attr,
 	&dev_attr_parent.attr,
 	&dev_attr_refresh.attr,
+	&dev_attr_thick.attr,
 	NULL
 };

-- 
2.15.1
