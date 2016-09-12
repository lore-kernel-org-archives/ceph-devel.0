From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 33/47] block-rbd: Adjust the position of a jump label in
 rbd_img_request_fill()
Date: Mon, 12 Sep 2016 21:22:03 +0200
Message-ID: <d6fae6f0-ba8f-bbf8-e1fc-de3504dfaa44@users.sourceforge.net>
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

From a0cfdf15bae448d9a0e2d5d6480c70cfa3f77322 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Sep 2016 19:50:43 +0200
Subject: [PATCH 33/47] block-rbd: Adjust the position of a jump label in
 rbd_img_request_fill()

Add a space character before a single jump label in this function
according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7a43711..34ccbf1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2588,8 +2588,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 	}
 
 	return 0;
-
-out_unwind:
+ out_unwind:
 	for_each_obj_request_safe(img_request, obj_request, next_obj_request)
 		rbd_img_obj_request_del(img_request, obj_request);
 
-- 
2.10.0

