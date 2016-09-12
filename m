From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 12/47] block-rbd: One function call less in
 rbd_dev_v2_parent_info() after error detection
Date: Mon, 12 Sep 2016 20:57:10 +0200
Message-ID: <3b1883b8-790c-156b-6e8d-f2bcf8848903@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 18:05:00 +0200

The kfree() function was called in one case by the rbd_dev_v2_parent_info()
function during error handling even if the passed variable "reply_buf"
contained a null pointer.

Adjust jump targets according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 90797aa..946e3ca 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5105,7 +5105,7 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 	reply_buf = kmalloc(size, GFP_KERNEL);
 	if (!reply_buf) {
 		ret = -ENOMEM;
-		goto out_err;
+		goto put_spec;
 	}
 
 	snapid = cpu_to_le64(rbd_dev->spec->snap_id);
@@ -5115,12 +5115,12 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 				reply_buf, size);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
-		goto out_err;
+		goto free_buffer;
 
 	p = reply_buf;
 	end = reply_buf + ret;
 	ret = -ERANGE;
-	ceph_decode_64_safe(&p, end, pool_id, out_err);
+	ceph_decode_64_safe(&p, end, pool_id, free_buffer);
 	if (pool_id == CEPH_NOPOOL) {
 		/*
 		 * Either the parent never existed, or we have
@@ -5138,7 +5138,7 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 				rbd_dev->disk->disk_name);
 		}
 
-		goto out;	/* No parent?  No problem. */
+		goto success_indication;	/* No parent?  No problem. */
 	}
 
 	/* The ceph file layout needs to fit pool id in 32 bits */
@@ -5147,16 +5147,16 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 	if (pool_id > (u64)U32_MAX) {
 		rbd_warn(NULL, "parent pool id too large (%llu > %u)",
 			(unsigned long long)pool_id, U32_MAX);
-		goto out_err;
+		goto free_buffer;
 	}
 
 	image_id = ceph_extract_encoded_string(&p, end, NULL, GFP_KERNEL);
 	if (IS_ERR(image_id)) {
 		ret = PTR_ERR(image_id);
-		goto out_err;
+		goto free_buffer;
 	}
-	ceph_decode_64_safe(&p, end, snap_id, out_err);
-	ceph_decode_64_safe(&p, end, overlap, out_err);
+	ceph_decode_64_safe(&p, end, snap_id, free_buffer);
+	ceph_decode_64_safe(&p, end, overlap, free_buffer);
 
 	/*
 	 * The parent won't change (except when the clone is
@@ -5189,11 +5189,11 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 		}
 	}
 	rbd_dev->parent_overlap = overlap;
-
-out:
+ success_indication:
 	ret = 0;
-out_err:
+ free_buffer:
 	kfree(reply_buf);
+ put_spec:
 	rbd_spec_put(parent_spec);
 
 	return ret;
-- 
2.10.0
