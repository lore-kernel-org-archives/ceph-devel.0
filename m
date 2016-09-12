From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 09/47] block-rbd: Rename a jump label in rbd_spec_fill_names()
Date: Mon, 12 Sep 2016 20:50:39 +0200
Message-ID: <4629298d-71b2-7d32-7dce-1d727fb79d72@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, Alex Elder <elder@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Sep 2016 17:58:18 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 45109ff..aac51a1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5421,7 +5421,7 @@ static int rbd_spec_fill_names(struct rbd_device *rbd_dev)
 	snap_name = rbd_snap_name(rbd_dev, spec->snap_id);
 	if (IS_ERR(snap_name)) {
 		ret = PTR_ERR(snap_name);
-		goto out_err;
+		goto free_name;
 	}
 
 	spec->pool_name = pool_name;
@@ -5429,8 +5429,7 @@ static int rbd_spec_fill_names(struct rbd_device *rbd_dev)
 	spec->snap_name = snap_name;
 
 	return 0;
-
-out_err:
+ free_name:
 	kfree(image_name);
 	kfree(pool_name);
 	return ret;
-- 
2.10.0

