From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 25/47] block-rbd: Fix jump targets in rbd_img_parent_read()
Date: Mon, 12 Sep 2016 21:11:27 +0200
Message-ID: <813ced30-1914-b507-f5f8-ddc5d073c54a@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 19:39:54 +0200

* Adjust jump targets according to the current Linux coding
  style convention.

* Delete a duplicate check then at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 09a0ed3..6777464 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3120,7 +3120,7 @@ static void rbd_img_parent_read(struct rbd_obj_request *obj_request)
 						obj_request->length);
 	result = -ENOMEM;
 	if (!img_request)
-		goto out_err;
+		goto status_indication;
 
 	if (obj_request->type == OBJ_REQUEST_BIO)
 		result = rbd_img_request_fill(img_request, OBJ_REQUEST_BIO,
@@ -3129,17 +3129,17 @@ static void rbd_img_parent_read(struct rbd_obj_request *obj_request)
 		result = rbd_img_request_fill(img_request, OBJ_REQUEST_PAGES,
 						obj_request->pages);
 	if (result)
-		goto out_err;
+		goto put_request;
 
 	img_request->callback = rbd_img_parent_read_callback;
 	result = rbd_img_request_submit(img_request);
 	if (result)
-		goto out_err;
+		goto put_request;
 
 	return;
-out_err:
-	if (img_request)
-		rbd_img_request_put(img_request);
+ put_request:
+	rbd_img_request_put(img_request);
+ status_indication:
 	obj_request->result = result;
 	obj_request->xferred = 0;
 	obj_request_done_set(obj_request);
-- 
2.10.0
