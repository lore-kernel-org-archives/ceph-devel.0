From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 42/47] block-rbd: Rename jump labels in rbd_dev_image_probe()
Date: Mon, 12 Sep 2016 21:31:03 +0200
Message-ID: <c41e7df3-db58-2e37-c77b-072c55f99e1f@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 20:02:16 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 80983f6..eec41ed 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6108,7 +6108,7 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
 
 	ret = rbd_dev_header_name(rbd_dev);
 	if (ret)
-		goto err_out_format;
+		goto status_indication;
 
 	if (!depth) {
 		ret = rbd_register_watch(rbd_dev);
@@ -6117,13 +6117,13 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
 				pr_info("image %s/%s does not exist\n",
 					rbd_dev->spec->pool_name,
 					rbd_dev->spec->image_name);
-			goto err_out_format;
+			goto status_indication;
 		}
 	}
 
 	ret = rbd_dev_header_info(rbd_dev);
 	if (ret)
-		goto err_out_watch;
+		goto check_input;
 
 	/*
 	 * If this image is the one being mapped, we have pool name and
@@ -6141,13 +6141,13 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
 				rbd_dev->spec->pool_name,
 				rbd_dev->spec->image_name,
 				rbd_dev->spec->snap_name);
-		goto err_out_probe;
+		goto unprobe_device;
 	}
 
 	if (rbd_dev->header.features & RBD_FEATURE_LAYERING) {
 		ret = rbd_dev_v2_parent_info(rbd_dev);
 		if (ret)
-			goto err_out_probe;
+			goto unprobe_device;
 
 		/*
 		 * Need to warn users if this image is the one being
@@ -6160,18 +6160,17 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
 
 	ret = rbd_dev_probe_parent(rbd_dev, depth);
 	if (ret)
-		goto err_out_probe;
+		goto unprobe_device;
 
 	dout("discovered format %u image, header name is %s\n",
 		rbd_dev->image_format, rbd_dev->header_oid.name);
 	return 0;
-
-err_out_probe:
+ unprobe_device:
 	rbd_dev_unprobe(rbd_dev);
-err_out_watch:
+ check_input:
 	if (!depth)
 		rbd_unregister_watch(rbd_dev);
-err_out_format:
+ status_indication:
 	rbd_dev->image_format = 0;
 	kfree(rbd_dev->spec->image_id);
 	rbd_dev->spec->image_id = NULL;
-- 
2.10.0
