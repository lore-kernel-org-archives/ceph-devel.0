From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 03/47] block-rbd: Adjust the position of a jump label in
 rbd_header_from_disk()
Date: Mon, 12 Sep 2016 20:44:57 +0200
Message-ID: <71b06567-1ea9-204d-d61b-2af4426d9cd1@users.sourceforge.net>
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
Date: Sun, 11 Sep 2016 13:37:34 +0200

Add a space character before a single jump label in this function
according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f4212e1..d61a066 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1064,7 +1064,7 @@ static int rbd_header_from_disk(struct rbd_device *rbd_dev,
 	header->snap_sizes = snap_sizes;
 
 	return 0;
-out_2big:
+ out_2big:
 	ret = -EIO;
 	kfree(snap_sizes);
  free_names:
-- 
2.10.0
