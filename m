From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 10/47] block-rbd: One function call less in
 rbd_dev_image_name() after error detection
Date: Mon, 12 Sep 2016 20:51:45 +0200
Message-ID: <e3852062-0872-1cea-ec0d-a03d4c77ddd9@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 18:00:18 +0200

The kfree() function was called in one case by the rbd_dev_image_name()
function during error handling even if the passed variable "reply_buf"
contained a null pointer.

Adjust jump targets according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index aac51a1..145bbcc 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5276,14 +5276,14 @@ static char *rbd_dev_image_name(struct rbd_device *rbd_dev)
 	size = sizeof (__le32) + RBD_IMAGE_NAME_LEN_MAX;
 	reply_buf = kmalloc(size, GFP_KERNEL);
 	if (!reply_buf)
-		goto out;
+		goto free_id;
 
 	ret = rbd_obj_method_sync(rbd_dev, RBD_DIRECTORY,
 				"rbd", "dir_get_name",
 				image_id, image_id_size,
 				reply_buf, size);
 	if (ret < 0)
-		goto out;
+		goto free_buffer;
 	p = reply_buf;
 	end = reply_buf + ret;
 
@@ -5292,8 +5292,9 @@ static char *rbd_dev_image_name(struct rbd_device *rbd_dev)
 		image_name = NULL;
 	else
 		dout("%s: name is %s len is %zd\n", __func__, image_name, len);
-out:
+ free_buffer:
 	kfree(reply_buf);
+ free_id:
 	kfree(image_id);
 
 	return image_name;
-- 
2.10.0
