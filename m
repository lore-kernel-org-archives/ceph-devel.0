From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 34/47] block-rbd: Rename a jump label in
 rbd_img_obj_callback()
Date: Mon, 12 Sep 2016 21:23:06 +0200
Message-ID: <210ec2f6-d0e6-ac8d-5d34-c0774589c76f@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 19:51:29 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 34ccbf1..c349975 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2394,7 +2394,7 @@ static void rbd_img_obj_callback(struct rbd_obj_request *obj_request)
 
 	spin_lock_irq(&img_request->completion_lock);
 	if (which != img_request->next_completion)
-		goto out;
+		goto unlock;
 
 	for_each_obj_request_from(img_request, obj_request) {
 		rbd_assert(more);
@@ -2408,7 +2408,7 @@ static void rbd_img_obj_callback(struct rbd_obj_request *obj_request)
 
 	rbd_assert(more ^ (which == img_request->obj_request_count));
 	img_request->next_completion = which;
-out:
+ unlock:
 	spin_unlock_irq(&img_request->completion_lock);
 	rbd_img_request_put(img_request);
 
-- 
2.10.0
