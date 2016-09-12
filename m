From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 45/47] block-rbd: Rename a jump label in rbd_slab_init()
Date: Mon, 12 Sep 2016 21:34:14 +0200
Message-ID: <c0f88ee7-fb42-081f-6660-3f8a264df0cb@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 20:05:42 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b106c68..8802a06 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6454,14 +6454,14 @@ static int rbd_slab_init(void)
 	rbd_assert(!rbd_obj_request_cache);
 	rbd_obj_request_cache = KMEM_CACHE(rbd_obj_request, 0);
 	if (!rbd_obj_request_cache)
-		goto out_err;
+		goto destroy_cache;
 
 	rbd_assert(!rbd_segment_name_cache);
 	rbd_segment_name_cache = kmem_cache_create("rbd_segment_name",
 					CEPH_MAX_OID_NAME_LEN + 1, 1, 0, NULL);
 	if (rbd_segment_name_cache)
 		return 0;
-out_err:
+ destroy_cache:
 	kmem_cache_destroy(rbd_obj_request_cache);
 	rbd_obj_request_cache = NULL;
 
-- 
2.10.0
