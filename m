From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 36/47] block-rbd: Rename jump labels in rbd_osd_req_create()
Date: Mon, 12 Sep 2016 21:25:03 +0200
Message-ID: <1897bc71-74c4-934d-f8ca-2f095a71b4fd@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 19:54:39 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f779ff3..8e9d30f7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1988,7 +1988,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	osd_req = ceph_osdc_alloc_request(osdc, snapc, num_ops, false,
 					  GFP_NOIO);
 	if (!osd_req)
-		goto fail;
+		goto put_request;
 
 	if (op_type == OBJ_OP_WRITE || op_type == OBJ_OP_DISCARD)
 		osd_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
@@ -2001,14 +2001,13 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	osd_req->r_base_oloc.pool = rbd_dev->layout.pool_id;
 	if (ceph_oid_aprintf(&osd_req->r_base_oid, GFP_NOIO, "%s",
 			     obj_request->object_name))
-		goto fail;
+		goto put_request;
 
 	if (ceph_osdc_alloc_messages(osd_req, GFP_NOIO))
-		goto fail;
+		goto put_request;
 
 	return osd_req;
-
-fail:
+ put_request:
 	ceph_osdc_put_request(osd_req);
 	return NULL;
 }
-- 
2.10.0
