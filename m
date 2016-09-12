From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 26/47] block-rbd: Rename a jump label in
 rbd_img_parent_read_callback()
Date: Mon, 12 Sep 2016 21:12:18 +0200
Message-ID: <73d111a3-5d8c-ea4e-fd2c-a22bc8c62c31@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 19:40:45 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6777464..23812e4 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3077,7 +3077,7 @@ static void rbd_img_parent_read_callback(struct rbd_img_request *img_request)
 
 	obj_request->result = img_result;
 	if (obj_request->result)
-		goto out;
+		goto callback;
 
 	/*
 	 * We need to zero anything beyond the parent overlap
@@ -3099,7 +3099,7 @@ static void rbd_img_parent_read_callback(struct rbd_img_request *img_request)
 	} else {
 		obj_request->xferred = img_xferred;
 	}
-out:
+ callback:
 	rbd_img_obj_request_read_callback(obj_request);
 	rbd_obj_request_complete(obj_request);
 }
-- 
2.10.0
