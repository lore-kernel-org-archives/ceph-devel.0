From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 01/47] block-rbd: Use kmalloc_array() in
 rbd_header_from_disk()
Date: Mon, 12 Sep 2016 20:42:18 +0200
Message-ID: <6917f8b0-6122-3b30-0dc1-0394b28a6f61@users.sourceforge.net>
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
Date: Sun, 11 Sep 2016 12:21:25 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Delete the local variable "size" which became unnecessary with
  this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 35fc1da..e406c27 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -979,7 +979,6 @@ static int rbd_header_from_disk(struct rbd_device *rbd_dev,
 	char *snap_names = NULL;
 	u64 *snap_sizes = NULL;
 	u32 snap_count;
-	size_t size;
 	int ret = -ENOMEM;
 	u32 i;
 
@@ -1017,9 +1016,9 @@ static int rbd_header_from_disk(struct rbd_device *rbd_dev,
 			goto out_err;
 
 		/* ...as well as the array of their sizes. */
-
-		size = snap_count * sizeof (*header->snap_sizes);
-		snap_sizes = kmalloc(size, GFP_KERNEL);
+		snap_sizes = kmalloc_array(snap_count,
+					   sizeof(*header->snap_sizes),
+					   GFP_KERNEL);
 		if (!snap_sizes)
 			goto out_err;
 
-- 
2.10.0
