From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 14/47] block-rbd: Rename a jump label in
 rbd_dev_v2_object_prefix()
Date: Mon, 12 Sep 2016 20:59:34 +0200
Message-ID: <7378c5de-9568-2736-fba6-7fc9a31bd1df@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 18:10:02 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index aff8c4e..6acddc53 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5017,7 +5017,7 @@ static int rbd_dev_v2_object_prefix(struct rbd_device *rbd_dev)
 				reply_buf, RBD_OBJ_PREFIX_LEN_MAX);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
-		goto out;
+		goto free_buffer;
 
 	p = reply_buf;
 	rbd_dev->header.object_prefix = ceph_extract_encoded_string(&p,
@@ -5030,7 +5030,7 @@ static int rbd_dev_v2_object_prefix(struct rbd_device *rbd_dev)
 	} else {
 		dout("  object_prefix = %s\n", rbd_dev->header.object_prefix);
 	}
-out:
+ free_buffer:
 	kfree(reply_buf);
 
 	return ret;
-- 
2.10.0
