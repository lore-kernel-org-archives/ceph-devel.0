From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 21/47] block-rbd: Rename jump labels in rbd_try_lock()
Date: Mon, 12 Sep 2016 21:07:16 +0200
Message-ID: <bc40bbb3-9488-fdb0-3d77-906c92635e0f@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 19:35:08 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b0b5a3b..7802351 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3478,7 +3478,7 @@ static int rbd_try_lock(struct rbd_device *rbd_dev)
 		if (ret) {
 			if (ret > 0)
 				ret = 0; /* have to request lock */
-			goto out;
+			goto free_lockers;
 		}
 
 		rbd_warn(rbd_dev, "%s%llu seems dead, breaking lock",
@@ -3489,7 +3489,7 @@ static int rbd_try_lock(struct rbd_device *rbd_dev)
 		if (ret) {
 			rbd_warn(rbd_dev, "blacklist of %s%llu failed: %d",
 				 ENTITY_NAME(lockers[0].id.name), ret);
-			goto out;
+			goto free_lockers;
 		}
 
 		ret = ceph_cls_break_lock(&client->osdc, &rbd_dev->header_oid,
@@ -3497,13 +3497,11 @@ static int rbd_try_lock(struct rbd_device *rbd_dev)
 					  lockers[0].id.cookie,
 					  &lockers[0].id.name);
 		if (ret && ret != -ENOENT)
-			goto out;
-
-again:
+			goto free_lockers;
+ again:
 		ceph_free_lockers(lockers, num_lockers);
 	}
-
-out:
+ free_lockers:
 	ceph_free_lockers(lockers, num_lockers);
 	return ret;
 }
-- 
2.10.0
