From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 31/47] block-rbd: Fix three jump targets in
 rbd_img_obj_parent_read_full()
Date: Mon, 12 Sep 2016 21:18:54 +0200
Message-ID: <974443eb-d84c-a1e6-833b-675bf8d041ba@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 19:48:46 +0200

* Adjust jump targets according to the current Linux coding
  style convention.

* Delete two duplicate checks then at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

I find that this function implementation needs another close look.
It seems that four lines can not be executed according to the shown
control flow at the moment.
How do you think about to avoid "dead" source code there anyhow?

 drivers/block/rbd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7d5f7b9..1b8a8c5 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2789,18 +2789,18 @@ static int rbd_img_obj_parent_read_full(struct rbd_obj_request *obj_request)
 	if (IS_ERR(pages)) {
 		result = PTR_ERR(pages);
 		pages = NULL;
-		goto out_err;
+		goto status_indication;
 	}
 
 	result = -ENOMEM;
 	parent_request = rbd_parent_request_create(obj_request,
 						img_offset, length);
 	if (!parent_request)
-		goto out_err;
+		goto release_page_vector;
 
 	result = rbd_img_request_fill(parent_request, OBJ_REQUEST_PAGES, pages);
 	if (result)
-		goto out_err;
+		goto put_request;
 	parent_request->copyup_pages = pages;
 	parent_request->copyup_page_count = page_count;
 
@@ -2813,11 +2813,11 @@ static int rbd_img_obj_parent_read_full(struct rbd_obj_request *obj_request)
 	parent_request->copyup_page_count = 0;
 	parent_request->obj_request = NULL;
 	rbd_obj_request_put(obj_request);
-out_err:
-	if (pages)
-		ceph_release_page_vector(pages, page_count);
-	if (parent_request)
-		rbd_img_request_put(parent_request);
+ put_request:
+	rbd_img_request_put(parent_request);
+ release_page_vector:
+	ceph_release_page_vector(pages, page_count);
+ status_indication:
 	obj_request->result = result;
 	obj_request->xferred = 0;
 	obj_request_done_set(obj_request);
-- 
2.10.0
