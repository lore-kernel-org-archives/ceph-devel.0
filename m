From: mchristi@redhat.com
Subject: [PATCH 10/10] rbd: distribute scsi pr info through rbd class calls
Date: Tue, 28 Apr 2015 17:05:47 -0500
Message-ID: <1430258747-12506-11-git-send-email-mchristi@redhat.com>
References: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35636 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031032AbbD1WF4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Apr 2015 18:05:56 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 2C9D8AC7A9
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 22:05:56 +0000 (UTC)
Received: from rh2.redhat.com (vpn-49-183.rdu2.redhat.com [10.10.49.183])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5mbV013102
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:55 -0400
In-Reply-To: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This stores the LIO PR info in the rbd header. Other
clients (LIO nodes) are notified when the data changes,
so they can update their info.

I added a sysfs file to test it here temporarily. I will
remove it in the final version. The final patches will
have a LIO callout call the rados locking and these
functions instead.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/block/rbd.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f4e7b0f..1fa4fd0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4465,6 +4465,72 @@ static int rbd_dev_break_locks(struct rbd_device *rbd_dev, char *name)
 	return rbd_dev_lock_for_each_locker(rbd_dev, name, rbd_dev_break_lock);
 }
 
+static size_t rbd_dev_set_scsi_pr_info(struct rbd_device *rbd_dev,
+				       const char *info)
+{
+	int info_len = strlen(info);
+	int info_buf_len = info_len + sizeof(__le32);
+	int ret;
+	void *info_buf, *p, *end;
+
+	dout("%s: set scsi pr info %s\n", __func__, info);
+
+	p = info_buf = kzalloc(info_buf_len, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	end = p + info_buf_len;
+	ceph_encode_string(&p, end, info, info_len);
+
+	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
+				  "rbd", "set_scsi_pr_info", info_buf,
+				  info_buf_len, NULL, 0);
+	if (!ret)
+		rbd_obj_notify_scsi_event_sync(rbd_dev,
+					       RBD_NOTIFY_OP_SCSI_PR_UPDATE, 5);
+	dout("%s: status %d\n", __func__, ret);
+	kfree(info_buf);
+	return ret;
+}
+
+static size_t rbd_dev_get_scsi_pr_info(struct rbd_device *rbd_dev,
+				       char *buf, int buf_len)
+{
+	__le64 snapid;
+	int ret;
+	void *info_buf, *p;
+
+	info_buf = p = kzalloc(buf_len, GFP_KERNEL);
+	if (!info_buf)
+		return -ENOMEM;
+
+	snapid = cpu_to_le64(rbd_dev->spec->snap_id);
+	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name, "rbd",
+				  "get_scsi_pr_info", &snapid, sizeof(snapid),
+				  info_buf, buf_len);
+	if (ret > sizeof(__le32)) {
+		char *ret_buf;
+		size_t ret_buf_len;
+
+		ret_buf = ceph_extract_encoded_string(&p, p + buf_len,
+						      &ret_buf_len, GFP_KERNEL);
+		if (IS_ERR(ret_buf)) {
+			ret = PTR_ERR(ret_buf);
+			goto free_info_buf;
+		}
+		ret = strlcpy(buf, ret_buf, buf_len);
+		kfree(ret_buf);
+	} else if (ret > 0) {
+		ret = -EINVAL;
+		buf[0] = '\0';
+	}
+
+free_info_buf:
+	kfree(info_buf);
+	dout("%s: returned %d\n", __func__, ret);
+	return ret;
+}
+
 /*
  * TODO: remove me or move to debugfs for final merge. I don't think we
  * need this for upstream since there is already the userspace API
@@ -4555,6 +4621,24 @@ static ssize_t rbd_lock_dump_info_set(struct device *dev,
 		return size;
 }
 
+static ssize_t rbd_scsi_pr_info_set(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t size)
+{
+	int ret = rbd_dev_set_scsi_pr_info(dev_to_rbd_dev(dev), buf);
+
+	if (ret)
+		return ret;
+	else
+		return size;
+}
+
+static ssize_t rbd_scsi_pr_info_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	return rbd_dev_get_scsi_pr_info(dev_to_rbd_dev(dev), buf, PAGE_SIZE);
+}
+
 static DEVICE_ATTR(size, S_IRUGO, rbd_size_show, NULL);
 static DEVICE_ATTR(features, S_IRUGO, rbd_features_show, NULL);
 static DEVICE_ATTR(major, S_IRUGO, rbd_major_show, NULL);
@@ -4571,6 +4655,8 @@ static DEVICE_ATTR(lock, S_IWUSR, NULL, rbd_lock_set);
 static DEVICE_ATTR(unlock, S_IWUSR, NULL, rbd_unlock_set);
 static DEVICE_ATTR(break_locks, S_IWUSR, NULL, rbd_break_locks_set);
 static DEVICE_ATTR(dump_lock_info, S_IWUSR, NULL, rbd_lock_dump_info_set);
+static DEVICE_ATTR(scsi_pr_info, S_IWUSR | S_IRUGO, rbd_scsi_pr_info_show,
+		   rbd_scsi_pr_info_set);
 
 static struct attribute *rbd_attrs[] = {
 	&dev_attr_size.attr,
@@ -4589,6 +4675,7 @@ static struct attribute *rbd_attrs[] = {
 	&dev_attr_unlock.attr,
 	&dev_attr_break_locks.attr,
 	&dev_attr_dump_lock_info.attr,
+	&dev_attr_scsi_pr_info.attr,
 	NULL
 };
 
-- 
1.8.3.1

