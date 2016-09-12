From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 05/47] block-rbd: One function call less in rbd_dev_image_id()
 after error detection
Date: Mon, 12 Sep 2016 20:46:49 +0200
Message-ID: <532868bf-3209-9059-fc1e-5194ab99b776@users.sourceforge.net>
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
Date: Sun, 11 Sep 2016 15:05:49 +0200

The kfree() function was called in one case by the rbd_dev_image_id()
function during error handling even if the passed variable "response"
contained a null pointer.

Adjust a jump target according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c1da844..a6d9a06 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5865,7 +5865,7 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
 	response = kzalloc(sizeof(__le32) + RBD_IMAGE_ID_LEN_MAX, GFP_NOIO);
 	if (!response) {
 		ret = -ENOMEM;
-		goto out;
+		goto free_name;
 	}
 
 	/* If it doesn't exist we'll assume it's a format 1 image */
@@ -5893,8 +5893,8 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
 		rbd_dev->spec->image_id = image_id;
 		dout("image_id is %s\n", image_id);
 	}
-out:
 	kfree(response);
+ free_name:
 	kfree(object_name);
 
 	return ret;
-- 
2.10.0
