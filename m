From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 43/47] block-rbd: Rename jump labels in do_rbd_add()
Date: Mon, 12 Sep 2016 21:32:05 +0200
Message-ID: <01943784-1031-d517-0d97-0a61e12e730f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, Alex Elder <elder@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Sep 2016 20:03:34 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index eec41ed..7df0b90 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6195,12 +6195,12 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	/* parse add command */
 	rc = rbd_add_parse_args(buf, &ceph_opts, &rbd_opts, &spec);
 	if (rc < 0)
-		goto out;
+		goto put_module;
 
 	rbdc = rbd_get_client(ceph_opts);
 	if (IS_ERR(rbdc)) {
 		rc = PTR_ERR(rbdc);
-		goto err_out_args;
+		goto put_spec;
 	}
 
 	/* pick the pool */
@@ -6208,14 +6208,14 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	if (rc < 0) {
 		if (rc == -ENOENT)
 			pr_info("pool %s does not exist\n", spec->pool_name);
-		goto err_out_client;
+		goto put_client;
 	}
 	spec->pool_id = (u64)rc;
 
 	rbd_dev = rbd_dev_create(rbdc, spec, rbd_opts);
 	if (!rbd_dev) {
 		rc = -ENOMEM;
-		goto err_out_client;
+		goto put_client;
 	}
 	rbdc = NULL;		/* rbd_dev now owns this */
 	spec = NULL;		/* rbd_dev now owns this */
@@ -6224,14 +6224,14 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	rbd_dev->config_info = kstrdup(buf, GFP_KERNEL);
 	if (!rbd_dev->config_info) {
 		rc = -ENOMEM;
-		goto err_out_rbd_dev;
+		goto destroy_device;
 	}
 
 	down_write(&rbd_dev->header_rwsem);
 	rc = rbd_dev_image_probe(rbd_dev, 0);
 	if (rc < 0) {
 		up_write(&rbd_dev->header_rwsem);
-		goto err_out_rbd_dev;
+		goto destroy_device;
 	}
 
 	/* If we are mapping a snapshot it must be marked read-only */
@@ -6250,22 +6250,21 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 		 */
 		rbd_unregister_watch(rbd_dev);
 		rbd_dev_image_release(rbd_dev);
-		goto out;
+		goto put_module;
 	}
 
 	rc = count;
-out:
+ put_module:
 	module_put(THIS_MODULE);
 	return rc;
-
-err_out_rbd_dev:
+ destroy_device:
 	rbd_dev_destroy(rbd_dev);
-err_out_client:
+ put_client:
 	rbd_put_client(rbdc);
-err_out_args:
+ put_spec:
 	rbd_spec_put(spec);
 	kfree(rbd_opts);
-	goto out;
+	goto put_module;
 }
 
 static ssize_t rbd_add(struct bus_type *bus,
-- 
2.10.0
