From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 27/47] block-rbd: Rename a jump label in
 rbd_img_request_submit()
Date: Mon, 12 Sep 2016 21:13:07 +0200
Message-ID: <e136c10c-64fb-2e7f-64ea-8ae44db37d35@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 19:43:35 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 23812e4..17bdc21 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3033,10 +3033,9 @@ static int rbd_img_request_submit(struct rbd_img_request *img_request)
 	for_each_obj_request_safe(img_request, obj_request, next_obj_request) {
 		ret = rbd_img_obj_request_submit(obj_request);
 		if (ret)
-			goto out_put_ireq;
+			goto put_request;
 	}
-
-out_put_ireq:
+ put_request:
 	rbd_img_request_put(img_request);
 	return ret;
 }
-- 
2.10.0
