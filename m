From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 40/47] block-rbd: One function call less in
 rbd_dev_probe_parent() after error detection
Date: Mon, 12 Sep 2016 21:29:15 +0200
Message-ID: <41288740-f584-070d-125e-21a33d0255bf@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 20:00:08 +0200

The rbd_dev_destroy() function was called in two cases by the
rbd_dev_probe_parent() function during error handling even if
the passed variable contained a null pointer.

* Adjust jump targets according to the current Linux coding
  style convention.

* Delete an initialisation for the variable "parent" at the beginning
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e01df3c..a037a5d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5950,7 +5950,7 @@ out_err:
  */
 static int rbd_dev_probe_parent(struct rbd_device *rbd_dev, int depth)
 {
-	struct rbd_device *parent = NULL;
+	struct rbd_device *parent;
 	int ret;
 
 	if (!rbd_dev->parent_spec)
@@ -5959,13 +5959,13 @@ static int rbd_dev_probe_parent(struct rbd_device *rbd_dev, int depth)
 	if (++depth > RBD_MAX_PARENT_CHAIN_LEN) {
 		pr_info("parent chain is too long (%d)\n", depth);
 		ret = -EINVAL;
-		goto out_err;
+		goto unparent_device;
 	}
 
 	parent = __rbd_dev_create(rbd_dev->rbd_client, rbd_dev->parent_spec);
 	if (!parent) {
 		ret = -ENOMEM;
-		goto out_err;
+		goto unparent_device;
 	}
 
 	/*
@@ -5977,15 +5977,15 @@ static int rbd_dev_probe_parent(struct rbd_device *rbd_dev, int depth)
 
 	ret = rbd_dev_image_probe(parent, depth);
 	if (ret < 0)
-		goto out_err;
+		goto destroy_device;
 
 	rbd_dev->parent = parent;
 	atomic_set(&rbd_dev->parent_ref, 1);
 	return 0;
-
-out_err:
-	rbd_dev_unparent(rbd_dev);
+ destroy_device:
 	rbd_dev_destroy(parent);
+ unparent_device:
+	rbd_dev_unparent(rbd_dev);
 	return ret;
 }
 
-- 
2.10.0
