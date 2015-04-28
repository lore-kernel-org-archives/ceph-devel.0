From: mchristi@redhat.com
Subject: [PATCH 09/10] rbd: add rados locking
Date: Tue, 28 Apr 2015 17:05:46 -0500
Message-ID: <1430258747-12506-10-git-send-email-mchristi@redhat.com>
References: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45235 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031030AbbD1WFz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Apr 2015 18:05:55 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5tNb013408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:55 -0400
Received: from rh2.redhat.com (vpn-49-183.rdu2.redhat.com [10.10.49.183])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5mbU013102
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:55 -0400
In-Reply-To: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This patch adds support for rados lock, unlock and break lock.
This will be used to sync up scsi pr info manipulation and
TMF execution.

It also adds support for list locks and get lock info, but
that and the sysfs support is only for debugging. I do not
think that we want the sysfs interface for the final version
and will remove it in the final patchset. I just kept it in
in case people wanted to test with it. Do we want it in debugfs though?

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/block/rbd.c | 478 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 478 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index aed38c0..f4e7b0f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -32,6 +32,7 @@
 #include <linux/ceph/osd_client.h>
 #include <linux/ceph/mon_client.h>
 #include <linux/ceph/decode.h>
+#include <linux/ceph/msgr.h>
 #include <linux/parser.h>
 #include <linux/bsearch.h>
 
@@ -44,6 +45,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/workqueue.h>
+#include <linux/in6.h>
 
 #include "rbd_types.h"
 
@@ -123,6 +125,8 @@ static int atomic_dec_return_safe(atomic_t *v)
 
 #define RBD_FEATURES_SUPPORTED	(RBD_FEATURES_ALL)
 
+#define RBD_MAX_LOCK_STR_LEN	16
+
 /*
  * An RBD device name will be "rbd#", where the "rbd" comes from
  * RBD_DRV_NAME above, and # is a unique integer identifier.
@@ -443,6 +447,11 @@ static ssize_t rbd_remove_single_major(struct bus_type *bus, const char *buf,
 static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping);
 static void rbd_spec_put(struct rbd_spec *spec);
 
+typedef int (locker_iter_fn) (struct rbd_device *rbd_dev, char *name,
+			      u8 entity_type, u64 entity_num, char *cookie,
+			      struct ceph_entity_addr *addr,
+			      struct timespec *ts, char *desc);
+
 static int rbd_dev_id_to_minor(int dev_id)
 {
 	return dev_id << RBD_SINGLE_MAJOR_PART_SHIFT;
@@ -4085,6 +4094,467 @@ static ssize_t rbd_image_refresh(struct device *dev,
 	return size;
 }
 
+/**
+ * rbd_dev_lock - grab rados lock for device
+ * @rbd_dev: device to take lock for
+ * @name: the name of the lock
+ * @type: lock type (RADOS_LOCK_EXCLUSIVE or RADOS_LOCK_SHARED)
+ * @cookie: user-defined identifier for this instance of the lock
+ * @tag: if RADOS_LOCK_SHARED, tag of the lock. NULL if non shared.
+ * desc: user-defined lock description
+ * @flags: lock flags
+ */
+static int rbd_dev_lock(struct rbd_device *rbd_dev, char *name, u8 type,
+			char *cookie, char *tag, char *desc, u8 flags)
+{
+	int lock_op_buf_size;
+	int name_len = strlen(name);
+	int cookie_len = strlen(cookie);
+	int tag_len = strlen(tag);
+	int desc_len = strlen(desc);
+	void *lock_op_buf, *p, *end;
+	struct timespec mtime;
+	int ret;
+
+	lock_op_buf_size = name_len + sizeof(__le32) +
+				cookie_len + sizeof(__le32) +
+				tag_len + sizeof(__le32) +
+				desc_len + sizeof(__le32) +
+				sizeof(mtime) +
+				/* flag and type */
+				sizeof(u8) + sizeof(u8) +
+				CEPH_ENCODING_START_BLK_LEN;
+	p = lock_op_buf = kzalloc(lock_op_buf_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	end = p + lock_op_buf_size;
+
+	ceph_start_encoding(&p, 1, 1,
+			    lock_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
+	/* encode cls_lock_lock_op struct */
+	ceph_encode_string(&p, end, name, name_len);
+	ceph_encode_8(&p, type);
+	ceph_encode_string(&p, end, cookie, cookie_len);
+	ceph_encode_string(&p, end, tag, tag_len);
+	ceph_encode_string(&p, end, desc, desc_len);
+	/* only support infinite duration */
+	memset(&mtime, 0, sizeof(mtime));
+	ceph_encode_timespec(p, &mtime);
+	p += sizeof(struct ceph_timespec);
+	ceph_encode_8(&p, flags);
+
+	dout("%s: %s %d %s %s %s %d\n", __func__,
+	     name, type, cookie, tag, desc, flags);
+
+	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
+				  "lock", "lock", lock_op_buf,
+				  lock_op_buf_size, NULL, 0);
+	dout("%s: status %d\n", __func__, ret);
+	kfree(lock_op_buf);
+	return ret;
+}
+
+/**
+ * rbd_dev_unlock - release rados lock for device
+ * @rbd_dev: device to take lock for
+ * @name: the name of the lock
+ * @cookie: user-defined identifier for this instance of the lock
+ */
+static int rbd_dev_unlock(struct rbd_device *rbd_dev, char *name, char *cookie)
+{
+	int unlock_op_buf_size;
+	int name_len = strlen(name);
+	int cookie_len = strlen(cookie);
+	void *unlock_op_buf, *p, *end;
+	int ret;
+
+	unlock_op_buf_size = name_len + sizeof(__le32) +
+				cookie_len + sizeof(__le32) +
+				CEPH_ENCODING_START_BLK_LEN;
+	p = unlock_op_buf = kzalloc(unlock_op_buf_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	end = p + unlock_op_buf_size;
+
+	ceph_start_encoding(&p, 1, 1,
+			    unlock_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
+	/* encode cls_lock_unlock_op struct */
+	ceph_encode_string(&p, end, name, name_len);
+	ceph_encode_string(&p, end, cookie, cookie_len);
+
+	dout("%s: %s %s\n", __func__, name, cookie);
+	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
+				  "lock", "unlock", unlock_op_buf,
+				  unlock_op_buf_size, NULL, 0);
+	dout("%s: status %d\n", __func__, ret);
+	kfree(unlock_op_buf);
+	return ret;
+}
+
+/* decode a cls_lock_get_info_reply */
+static int rbd_dev_parse_lockers(struct rbd_device *rbd_dev, char *name,
+				void *p, void *end, locker_iter_fn *iter_fn)
+{
+	int i, ret;
+	struct ceph_entity_addr addr;
+	struct timespec ts;
+	struct ceph_timespec ceph_ts;
+	char *cookie, *desc;
+	size_t str_len;
+	u32 num_lockers, len;
+	u64 num;
+	u8 type;
+
+	ret = ceph_start_decoding_compat(&p, end, 1, 1, 1, &len);
+	if (ret)
+		return ret;
+	ceph_decode_32_safe(&p, end, num_lockers, einval);
+
+	dout("got %u lockers in struct len %u\n", num_lockers, len);
+	for (i = 0; i < num_lockers; i++) {
+		/* decode locker_id_t */
+		ret = ceph_start_decoding_compat(&p, end, 1, 1, 1, &len);
+		if (ret)
+			break;
+
+		ceph_decode_8_safe(&p, end, type, einval);
+		ceph_decode_64_safe(&p, end, num, einval);
+
+		cookie = ceph_extract_encoded_string(&p, end, &str_len,
+						     GFP_KERNEL);
+		if (IS_ERR(cookie)) {
+			ret = PTR_ERR(cookie);
+			goto fail;
+		}
+		/* decode locker_info_t */
+		ret = ceph_start_decoding_compat(&p, end, 1, 1, 1, &len);
+		if (ret)
+			goto free_cookie;
+
+		ceph_decode_copy_safe(&p, end, &ceph_ts, sizeof(ceph_ts),
+				      free_cookie);
+		ceph_decode_timespec(&ts, &ceph_ts);
+
+		ceph_decode_copy_safe(&p, end, &addr, sizeof(addr), free_cookie);
+		ceph_decode_addr(&addr);
+
+		desc = ceph_extract_encoded_string(&p, end, &str_len,
+						   GFP_KERNEL);
+		if (IS_ERR(desc)) {
+			ret = PTR_ERR(desc);
+			goto free_cookie;
+		}
+
+		iter_fn(rbd_dev, name, type, num, cookie, &addr, &ts, desc);
+		kfree(cookie);
+		kfree(desc);
+	}
+
+	return 0;
+
+free_cookie:
+	kfree(cookie);
+einval:
+	if (!ret)
+		ret = -EINVAL;
+fail:
+	rbd_warn(rbd_dev, "Could not decode lockers for %s\n", name);
+	return ret;
+}
+
+static int rbd_dev_lock_for_each_locker(struct rbd_device *rbd_dev, char *name,
+					locker_iter_fn *iter_fn)
+{
+	int get_info_op_buf_size;
+	int name_len = strlen(name);
+	void *get_info_op_buf, *p, *end;
+	void *get_info_reply_buf;
+	struct page *reply_pg;
+	int ret;
+
+	get_info_op_buf_size = name_len + sizeof(__le32) +
+				CEPH_ENCODING_START_BLK_LEN;
+	p = get_info_op_buf = kzalloc(get_info_op_buf_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	reply_pg = alloc_page(GFP_KERNEL);
+	if (!reply_pg) {
+		ret = -ENOMEM;
+		goto free_info_buf;
+	}
+	get_info_reply_buf = page_address(reply_pg);
+
+	ceph_start_encoding(&p, 1, 1,
+			    get_info_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
+	/* encode cls_lock_get_info struct */
+	end = p + get_info_op_buf_size;
+	ceph_encode_string(&p, end, name, name_len);
+
+	dout("%s: lock %s\n", __func__, name);
+	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
+				  "lock", "get_info", get_info_op_buf,
+				  get_info_op_buf_size, get_info_reply_buf,
+				  PAGE_SIZE);
+	dout("%s: status %d\n", __func__, ret);
+	if (ret < 0)
+		goto free_pg;
+
+	p = get_info_reply_buf;
+	end = p + ret;
+
+	ret = rbd_dev_parse_lockers(rbd_dev, name, p, end, iter_fn);
+
+free_pg:
+	__free_page(reply_pg);
+free_info_buf:
+	kfree(get_info_op_buf);
+	return ret;
+}
+
+/**
+ * rbd_dev_print_lock_info - print lock info
+ * @rbd_dev: device to take lock for
+ * @name: the name of the lock
+ * @entity_type: ceph entity type (CEPH_ENTITY_TYPE_*)
+ * @entity_num: ceph entity id
+ * @cookie: user-defined identifier for this instance of the lock
+ * @addr: entity address
+ * @ts: lock timespec
+ * @desc: lock description
+ */
+static int rbd_dev_print_lock_info(struct rbd_device *rbd_dev, char *name,
+				   u8 type, u64 num, char *cookie,
+				   struct ceph_entity_addr *addr,
+				   struct timespec *ts, char *desc)
+{
+	struct sockaddr_in6 *sin6;
+	struct sockaddr_in *sin;
+
+	switch (addr->in_addr.ss_family) {
+	case AF_INET:
+		sin = (struct sockaddr_in *)&addr->in_addr;
+		rbd_warn(rbd_dev, "%s %s %s.%llu %s %pI4\n",
+			 name, cookie, ceph_entity_type_name(type), num, desc,
+			 &sin->sin_addr.s_addr);
+		break;
+	case AF_INET6:
+		sin6 = (struct sockaddr_in6 *)&addr->in_addr;
+		rbd_warn(rbd_dev, "%s %s %s.%llu %s %pI6\n",
+			 name, cookie, ceph_entity_type_name(type), num, desc,
+			 &sin6->sin6_addr);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * rbd_dev_print_locks - print all locks for dev
+ * @rbd_dev: device to take lock for
+ */
+static size_t rbd_dev_print_locks(struct rbd_device *rbd_dev)
+{
+	int ret, i;
+	void *p, *end;
+	char *lock;
+	size_t lock_len;
+	u32 num_locks, len;
+	struct page *pg;
+
+	pg = alloc_page(GFP_KERNEL);
+	if (!pg)
+		return -ENOMEM;
+	p = page_address(pg);
+
+	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
+				"lock", "list_locks", NULL, 0,
+				p, PAGE_SIZE);
+	if (ret < 0)
+		goto free_list_locks_pg;
+
+	end = p + ret;
+	ret = ceph_start_decoding_compat(&p, end, 1, 1, 1, &len);
+	if (ret)
+		goto free_list_locks_pg;
+
+	ceph_decode_32_safe(&p, end, num_locks, einval);
+	dout("got %u locks in struct len %u\n", num_locks, len);
+
+	for (i = 0; i < num_locks; i++) {
+		lock = ceph_extract_encoded_string(&p, end, &lock_len,
+						   GFP_KERNEL);
+		if (IS_ERR(lock)) {
+			rbd_warn(rbd_dev,
+				 "Could not print info for all locks\n");
+			ret = PTR_ERR(lock);
+			goto free_list_locks_pg;
+		}
+
+		rbd_dev_lock_for_each_locker(rbd_dev, lock,
+					     rbd_dev_print_lock_info);
+		kfree(lock);
+	}
+	ret = 0;
+	goto free_list_locks_pg;
+
+einval:
+	ret = -EINVAL;
+free_list_locks_pg:
+	__free_page(pg);
+	return ret;
+}
+
+/**
+ * rbd_dev_break_lock - release rados lock for device for specified client
+ * @rbd_dev: device to take lock for
+ * @name: the name of the lock
+ * @entity_type: ceph entity type (CEPH_ENTITY_TYPE_*)
+ * @entity_num: ceph entity id
+ * @cookie: user-defined identifier for this instance of the lock
+ * @addr: entity address
+ * @ts: lock timespec
+ * @desc: lock description
+ */
+static int rbd_dev_break_lock(struct rbd_device *rbd_dev, char *name,
+			      u8 type, u64 num, char *cookie,
+			      struct ceph_entity_addr *addr,
+			      struct timespec *ts, char *desc)
+{
+	int break_lock_op_buf_size;
+	int name_len = strlen(name);
+	int cookie_len = strlen(cookie);
+	void *break_lock_op_buf, *p, *end;
+	int ret;
+
+	break_lock_op_buf_size = name_len + sizeof(__le32) +
+				cookie_len + sizeof(__le32) +
+				sizeof(u8) + sizeof(__le64) +
+				CEPH_ENCODING_START_BLK_LEN;
+	p = break_lock_op_buf = kzalloc(break_lock_op_buf_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	end = p + break_lock_op_buf_size;
+
+	ceph_start_encoding(&p, 1, 1,
+			break_lock_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
+	/* encode cls_lock_break_op struct */
+	ceph_encode_string(&p, end, name, name_len);
+	ceph_encode_8(&p, type);
+	ceph_encode_64(&p, num);
+	ceph_encode_string(&p, end, cookie, cookie_len);
+
+	dout("%s: lock %s type %hu id %llu cookie %s desc %s\n",
+	     __func__, name, type, num, cookie, desc);
+
+	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
+				  "lock", "break_lock", break_lock_op_buf,
+				  break_lock_op_buf_size, NULL, 0);
+	dout("%s: status %d\n", __func__, ret);
+	kfree(break_lock_op_buf);
+	return ret;
+}
+
+static int rbd_dev_break_locks(struct rbd_device *rbd_dev, char *name)
+{
+	return rbd_dev_lock_for_each_locker(rbd_dev, name, rbd_dev_break_lock);
+}
+
+/*
+ * TODO: remove me or move to debugfs for final merge. I don't think we
+ * need this for upstream since there is already the userspace API
+ * to use from there. These are just for testing the kernel.
+ */
+static ssize_t rbd_lock_set(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t size)
+{
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
+	char name[RBD_MAX_LOCK_STR_LEN];
+	char cookie[RBD_MAX_LOCK_STR_LEN];
+	char desc[RBD_MAX_LOCK_STR_LEN];
+	int ret;
+
+	ret = sscanf(buf, "%15s %15s %15s\n", name, cookie, desc);
+	if (ret != 3) {
+		rbd_warn(rbd_dev, "Invalid number of params. Got %d\n", ret);
+		return -EINVAL;
+	} else if (!strlen(name) || !strlen(cookie) || !strlen(desc)) {
+		rbd_warn(rbd_dev, "missing param\n");
+		return -EINVAL;
+	}
+
+	ret = rbd_dev_lock(rbd_dev, name, 1, cookie, "", desc, 0);
+	if (ret)
+		return ret;
+	else
+		return size;
+}
+
+static ssize_t rbd_unlock_set(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t size)
+{
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
+	char name[RBD_MAX_LOCK_STR_LEN];
+	char cookie[RBD_MAX_LOCK_STR_LEN];
+	int ret;
+
+	ret = sscanf(buf, "%15s %15s\n", name, cookie);
+	if (ret != 2) {
+		rbd_warn(rbd_dev, "Invalid number of params. Got %d\n", ret);
+		return -EINVAL;
+	} else if (!strlen(name) || !strlen(cookie)) {
+		rbd_warn(rbd_dev, "missing param\n");
+		return -EINVAL;
+	}
+
+	ret = rbd_dev_unlock(rbd_dev, name, cookie);
+	if (ret)
+		return ret;
+	else
+		return size;
+}
+
+static ssize_t rbd_break_locks_set(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t size)
+{
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
+	char name[RBD_MAX_LOCK_STR_LEN];
+	int ret;
+
+	ret = sscanf(buf, "%15s\n", name);
+	if (ret != 1) {
+		rbd_warn(rbd_dev, "Invalid number of params. Got %d\n", ret);
+		return -EINVAL;
+	} else if (!strlen(name)) {
+		rbd_warn(rbd_dev, "missing param\n");
+		return -EINVAL;
+	}
+
+	ret = rbd_dev_break_locks(rbd_dev, name);
+	if (ret)
+		return ret;
+	else
+		return size;
+}
+
+static ssize_t rbd_lock_dump_info_set(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t size)
+{
+	int ret = rbd_dev_print_locks(dev_to_rbd_dev(dev));
+
+	if (ret)
+		return ret;
+	else
+		return size;
+}
+
 static DEVICE_ATTR(size, S_IRUGO, rbd_size_show, NULL);
 static DEVICE_ATTR(features, S_IRUGO, rbd_features_show, NULL);
 static DEVICE_ATTR(major, S_IRUGO, rbd_major_show, NULL);
@@ -4097,6 +4567,10 @@ static DEVICE_ATTR(image_id, S_IRUGO, rbd_image_id_show, NULL);
 static DEVICE_ATTR(refresh, S_IWUSR, NULL, rbd_image_refresh);
 static DEVICE_ATTR(current_snap, S_IRUGO, rbd_snap_show, NULL);
 static DEVICE_ATTR(parent, S_IRUGO, rbd_parent_show, NULL);
+static DEVICE_ATTR(lock, S_IWUSR, NULL, rbd_lock_set);
+static DEVICE_ATTR(unlock, S_IWUSR, NULL, rbd_unlock_set);
+static DEVICE_ATTR(break_locks, S_IWUSR, NULL, rbd_break_locks_set);
+static DEVICE_ATTR(dump_lock_info, S_IWUSR, NULL, rbd_lock_dump_info_set);
 
 static struct attribute *rbd_attrs[] = {
 	&dev_attr_size.attr,
@@ -4111,6 +4585,10 @@ static struct attribute *rbd_attrs[] = {
 	&dev_attr_current_snap.attr,
 	&dev_attr_parent.attr,
 	&dev_attr_refresh.attr,
+	&dev_attr_lock.attr,
+	&dev_attr_unlock.attr,
+	&dev_attr_break_locks.attr,
+	&dev_attr_dump_lock_info.attr,
 	NULL
 };
 
-- 
1.8.3.1

