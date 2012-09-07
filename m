From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/5] rbd: kill create_snap sysfs entry
Date: Fri, 07 Sep 2012 13:19:45 -0500
Message-ID: <504A3AC1.6090308@inktank.com>
References: <504A39E0.1040107@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35579 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755751Ab2IGSTs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 14:19:48 -0400
Received: by mail-ie0-f174.google.com with SMTP id e11so5532930iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 11:19:47 -0700 (PDT)
In-Reply-To: <504A39E0.1040107@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Josh proposed the following change, and I don't think I could
explain it any better than he did:

    From: Josh Durgin <josh.durgin@inktank.com>
    Date: Tue, 24 Jul 2012 14:22:11 -0700
    To: ceph-devel <ceph-devel@vger.kernel.org>
    Message-ID: <500F1203.9050605@inktank.com>

    Right now the kernel still has one piece of rbd management
    duplicated from the rbd command line tool: snapshot creation.
    There's nothing special about snapshot creation that makes it
    advantageous to do from the kernel, so I'd like to remove the
    create_snap sysfs interface.  That is,
	/sys/bus/rbd/devices/<id>/create_snap
    would be removed.

    Does anyone rely on the sysfs interface for creating rbd
    snapshots?  If so, how hard would it be to replace with:

	rbd snap create pool/image@snap

    Is there any benefit to the sysfs interface that I'm missing?

    Josh

This patch implements this proposal, removing the code that
implements the "snap_create" sysfs interface for rbd images.
As a result, quite a lot of other supporting code goes away.

Suggested-by: Josh Durgin <josh.durgin@inktank.com>
Signed-off-by: Alex Elder <elder@inktank.com>
---
 Documentation/ABI/testing/sysfs-bus-rbd |    6 --
 drivers/block/rbd.c                     |  158
-------------------------------
 2 files changed, 164 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-rbd
b/Documentation/ABI/testing/sysfs-bus-rbd
index 7cbbe34..6fe4224 100644
--- a/Documentation/ABI/testing/sysfs-bus-rbd
+++ b/Documentation/ABI/testing/sysfs-bus-rbd
@@ -62,12 +62,6 @@ current_snap

 	The current snapshot for which the device is mapped.

-create_snap
-
-	Create a snapshot:
-
-	 $ echo <snap-name> > /sys/bus/rbd/devices/<dev-id>/snap_create
-
 snap_*

 	A directory per each snapshot
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5a3132e..d73edb1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -212,10 +212,6 @@ static int rbd_dev_snaps_update(struct rbd_device
*rbd_dev);
 static int rbd_dev_snaps_register(struct rbd_device *rbd_dev);

 static void rbd_dev_release(struct device *dev);
-static ssize_t rbd_snap_add(struct device *dev,
-			    struct device_attribute *attr,
-			    const char *buf,
-			    size_t count);
 static void __rbd_remove_snap_dev(struct rbd_snap *snap);

 static ssize_t rbd_add(struct bus_type *bus, const char *buf,
@@ -1375,71 +1371,6 @@ static int rbd_req_sync_unwatch(struct rbd_device
*rbd_dev)
 	return ret;
 }

-struct rbd_notify_info {
-	struct rbd_device *rbd_dev;
-};
-
-static void rbd_notify_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
-{
-	struct rbd_device *rbd_dev = (struct rbd_device *)data;
-	if (!rbd_dev)
-		return;
-
-	dout("rbd_notify_cb %s notify_id=%llu opcode=%u\n",
-			rbd_dev->header_name, (unsigned long long) notify_id,
-			(unsigned int) opcode);
-}
-
-/*
- * Request sync osd notify
- */
-static int rbd_req_sync_notify(struct rbd_device *rbd_dev)
-{
-	struct ceph_osd_req_op *ops;
-	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
-	struct ceph_osd_event *event;
-	struct rbd_notify_info info;
-	int payload_len = sizeof(u32) + sizeof(u32);
-	int ret;
-
-	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_NOTIFY, payload_len);
-	if (!ops)
-		return -ENOMEM;
-
-	info.rbd_dev = rbd_dev;
-
-	ret = ceph_osdc_create_event(osdc, rbd_notify_cb, 1,
-				     (void *)&info, &event);
-	if (ret < 0)
-		goto fail;
-
-	ops[0].watch.ver = 1;
-	ops[0].watch.flag = 1;
-	ops[0].watch.cookie = event->cookie;
-	ops[0].watch.prot_ver = RADOS_NOTIFY_VER;
-	ops[0].watch.timeout = 12;
-
-	ret = rbd_req_sync_op(rbd_dev, NULL,
-			       CEPH_NOSNAP,
-			       CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
-			       ops,
-			       rbd_dev->header_name,
-			       0, 0, NULL, NULL, NULL);
-	if (ret < 0)
-		goto fail_event;
-
-	ret = ceph_osdc_wait_event(event, CEPH_OSD_TIMEOUT_DEFAULT);
-	dout("ceph_osdc_wait_event returned %d\n", ret);
-	rbd_destroy_ops(ops);
-	return 0;
-
-fail_event:
-	ceph_osdc_cancel_event(event);
-fail:
-	rbd_destroy_ops(ops);
-	return ret;
-}
-
 /*
  * Synchronous osd object method call
  */
@@ -1761,52 +1692,6 @@ static int rbd_read_header(struct rbd_device
*rbd_dev,
 	return ret;
 }

-/*
- * create a snapshot
- */
-static int rbd_header_add_snap(struct rbd_device *rbd_dev,
-			       const char *snap_name,
-			       gfp_t gfp_flags)
-{
-	int name_len = strlen(snap_name);
-	u64 new_snapid;
-	int ret;
-	void *data, *p, *e;
-	struct ceph_mon_client *monc;
-
-	/* we should create a snapshot only if we're pointing at the head */
-	if (rbd_dev->mapping.snap_id != CEPH_NOSNAP)
-		return -EINVAL;
-
-	monc = &rbd_dev->rbd_client->client->monc;
-	ret = ceph_monc_create_snapid(monc, rbd_dev->pool_id, &new_snapid);
-	dout("created snapid=%llu\n", (unsigned long long) new_snapid);
-	if (ret < 0)
-		return ret;
-
-	data = kmalloc(name_len + 16, gfp_flags);
-	if (!data)
-		return -ENOMEM;
-
-	p = data;
-	e = data + name_len + 16;
-
-	ceph_encode_string_safe(&p, e, snap_name, name_len, bad);
-	ceph_encode_64_safe(&p, e, new_snapid, bad);
-
-	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
-				"rbd", "snap_add",
-				data, (size_t) (p - data), NULL, 0,
-				CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
-				NULL);
-
-	kfree(data);
-
-	return ret < 0 ? ret : 0;
-bad:
-	return -ERANGE;
-}
-
 static void __rbd_remove_all_snaps(struct rbd_device *rbd_dev)
 {
 	struct rbd_snap *snap;
@@ -2030,7 +1915,6 @@ static DEVICE_ATTR(name, S_IRUGO, rbd_name_show,
NULL);
 static DEVICE_ATTR(image_id, S_IRUGO, rbd_image_id_show, NULL);
 static DEVICE_ATTR(refresh, S_IWUSR, NULL, rbd_image_refresh);
 static DEVICE_ATTR(current_snap, S_IRUGO, rbd_snap_show, NULL);
-static DEVICE_ATTR(create_snap, S_IWUSR, NULL, rbd_snap_add);

 static struct attribute *rbd_attrs[] = {
 	&dev_attr_size.attr,
@@ -2042,7 +1926,6 @@ static struct attribute *rbd_attrs[] = {
 	&dev_attr_image_id.attr,
 	&dev_attr_current_snap.attr,
 	&dev_attr_refresh.attr,
-	&dev_attr_create_snap.attr,
 	NULL
 };

@@ -2888,47 +2771,6 @@ done:
 	return ret;
 }

-static ssize_t rbd_snap_add(struct device *dev,
-			    struct device_attribute *attr,
-			    const char *buf,
-			    size_t count)
-{
-	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
-	int ret;
-	char *name = kmalloc(count + 1, GFP_KERNEL);
-	if (!name)
-		return -ENOMEM;
-
-	snprintf(name, count, "%s", buf);
-
-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
-
-	ret = rbd_header_add_snap(rbd_dev,
-				  name, GFP_KERNEL);
-	if (ret < 0)
-		goto err_unlock;
-
-	ret = __rbd_refresh_header(rbd_dev, NULL);
-	if (ret < 0)
-		goto err_unlock;
-
-	/* shouldn't hold ctl_mutex when notifying.. notify might
-	   trigger a watch callback that would need to get that mutex */
-	mutex_unlock(&ctl_mutex);
-
-	/* make a best effort, don't error if failed */
-	rbd_req_sync_notify(rbd_dev);
-
-	ret = count;
-	kfree(name);
-	return ret;
-
-err_unlock:
-	mutex_unlock(&ctl_mutex);
-	kfree(name);
-	return ret;
-}
-
 /*
  * create control files in sysfs
  * /sys/bus/rbd/...
-- 
1.7.9.5

