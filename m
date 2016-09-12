From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 29/47] block-rbd: Delete an unnecessary initialisation in
 rbd_img_obj_exists_submit()
Date: Mon, 12 Sep 2016 21:15:05 +0200
Message-ID: <79f27292-3a81-f64f-2a9d-8982859ffac5@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 19:45:29 +0200

The local variable "pages" will be set to an appropriate pointer
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 66801ec..f3f2919 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2897,7 +2897,7 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
 	struct rbd_obj_request *stat_request;
 	struct rbd_device *rbd_dev;
 	struct ceph_osd_client *osdc;
-	struct page **pages = NULL;
+	struct page **pages;
 	u32 page_count;
 	size_t size;
 	int ret;
-- 
2.10.0
