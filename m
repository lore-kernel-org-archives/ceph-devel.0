From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/6] rbd: probe the parent of an image if present
Date: Tue, 30 Oct 2012 20:50:08 -0500
Message-ID: <509083D0.1060003@inktank.com>
References: <509081C4.3050402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:33350 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421Ab2JaBuL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 21:50:11 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so677769iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 18:50:10 -0700 (PDT)
In-Reply-To: <509081C4.3050402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Call the probe function for the parent device.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   79
+++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 04062c1..8ef13f72 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -222,6 +222,7 @@ struct rbd_device {

 	struct rbd_spec		*parent_spec;
 	u64			parent_overlap;
+	struct rbd_device	*parent;

 	/* protects updating the header */
 	struct rw_semaphore     header_rwsem;
@@ -255,6 +256,7 @@ static ssize_t rbd_add(struct bus_type *bus, const
char *buf,
 		       size_t count);
 static ssize_t rbd_remove(struct bus_type *bus, const char *buf,
 			  size_t count);
+static int rbd_dev_probe(struct rbd_device *rbd_dev);

 static struct bus_attribute rbd_bus_attrs[] = {
 	__ATTR(add, S_IWUSR, NULL, rbd_add),
@@ -378,6 +380,13 @@ out_opt:
 	return ERR_PTR(ret);
 }

+static struct rbd_client *__rbd_get_client(struct rbd_client *rbdc)
+{
+	kref_get(&rbdc->kref);
+
+	return rbdc;
+}
+
 /*
  * Find a ceph client with specific addr and configuration.  If
  * found, bump its reference count.
@@ -393,7 +402,8 @@ static struct rbd_client *rbd_client_find(struct
ceph_options *ceph_opts)
 	spin_lock(&rbd_client_list_lock);
 	list_for_each_entry(client_node, &rbd_client_list, node) {
 		if (!ceph_compare_options(ceph_opts, client_node->client)) {
-			kref_get(&client_node->kref);
+			__rbd_get_client(client_node);
+
 			found = true;
 			break;
 		}
@@ -3311,6 +3321,11 @@ static int rbd_dev_image_id(struct rbd_device
*rbd_dev)
 	void *response;
 	void *p;

+	/* If we already have it we don't need to look it up */
+
+	if (rbd_dev->spec->image_id)
+		return 0;
+
 	/*
 	 * When probing a parent image, the image id is already
 	 * known (and the image name likely is not).  There's no
@@ -3492,6 +3507,9 @@ out_err:

 static int rbd_dev_probe_finish(struct rbd_device *rbd_dev)
 {
+	struct rbd_device *parent = NULL;
+	struct rbd_spec *parent_spec = NULL;
+	struct rbd_client *rbdc = NULL;
 	int ret;

 	/* no need to lock here, as rbd_dev is not registered yet */
@@ -3536,6 +3554,31 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)
 	 * At this point cleanup in the event of an error is the job
 	 * of the sysfs code (initiated by rbd_bus_del_dev()).
 	 */
+	/* Probe the parent if there is one */
+
+	if (rbd_dev->parent_spec) {
+		/*
+		 * We need to pass a reference to the client and the
+		 * parent spec when creating the parent rbd_dev.
+		 * Images related by parent/child relationships
+		 * always share both.
+		 */
+		parent_spec = rbd_spec_get(rbd_dev->parent_spec);
+		rbdc = __rbd_get_client(rbd_dev->rbd_client);
+
+		parent = rbd_dev_create(rbdc, parent_spec);
+		if (!parent) {
+			ret = -ENOMEM;
+			goto err_out_spec;
+		}
+		rbdc = NULL;		/* parent now owns reference */
+		parent_spec = NULL;	/* parent now owns reference */
+		ret = rbd_dev_probe(parent);
+		if (ret < 0)
+			goto err_out_parent;
+		rbd_dev->parent = parent;
+	}
+
 	down_write(&rbd_dev->header_rwsem);
 	ret = rbd_dev_snaps_register(rbd_dev);
 	up_write(&rbd_dev->header_rwsem);
@@ -3554,6 +3597,12 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)
 		(unsigned long long) rbd_dev->mapping.size);

 	return ret;
+
+err_out_parent:
+	rbd_dev_destroy(parent);
+err_out_spec:
+	rbd_spec_put(parent_spec);
+	rbd_put_client(rbdc);
 err_out_bus:
 	/* this will also clean up rest of rbd_dev stuff */

@@ -3717,6 +3766,12 @@ static void rbd_dev_release(struct device *dev)
 	module_put(THIS_MODULE);
 }

+static void __rbd_remove(struct rbd_device *rbd_dev)
+{
+	rbd_remove_all_snaps(rbd_dev);
+	rbd_bus_del_dev(rbd_dev);
+}
+
 static ssize_t rbd_remove(struct bus_type *bus,
 			  const char *buf,
 			  size_t count)
@@ -3743,8 +3798,26 @@ static ssize_t rbd_remove(struct bus_type *bus,
 		goto done;
 	}

-	rbd_remove_all_snaps(rbd_dev);
-	rbd_bus_del_dev(rbd_dev);
+	while (rbd_dev->parent_spec) {
+		struct rbd_device *first = rbd_dev;
+		struct rbd_device *second = first->parent;
+		struct rbd_device *third;
+
+		/*
+		 * Follow to the parent with no grandparent and
+		 * remove it.
+		 */
+		while (second && (third = second->parent)) {
+			first = second;
+			second = third;
+		}
+		__rbd_remove(second);
+		rbd_spec_put(first->parent_spec);
+		first->parent_spec = NULL;
+		first->parent_overlap = 0;
+		first->parent = NULL;
+	}
+	__rbd_remove(rbd_dev);

 done:
 	mutex_unlock(&ctl_mutex);
-- 
1.7.9.5

