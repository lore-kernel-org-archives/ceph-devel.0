From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 16/47] block-rbd: Rename jump labels in
 rbd_dev_v1_header_info()
Date: Mon, 12 Sep 2016 21:01:42 +0200
Message-ID: <ff082acc-cdcc-2738-6242-d8ef35c42999@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 18:15:44 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 262805a..0b6f0f9 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4352,17 +4352,17 @@ static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev)
 		ret = rbd_obj_read_sync(rbd_dev, rbd_dev->header_oid.name,
 				       0, size, ondisk);
 		if (ret < 0)
-			goto out;
+			goto free_header;
 		if ((size_t)ret < size) {
 			ret = -ENXIO;
 			rbd_warn(rbd_dev, "short header read (want %zd got %d)",
 				size, ret);
-			goto out;
+			goto free_header;
 		}
 		if (!rbd_dev_ondisk_valid(ondisk)) {
 			ret = -ENXIO;
 			rbd_warn(rbd_dev, "invalid header");
-			goto out;
+			goto free_header;
 		}
 
 		names_size = le64_to_cpu(ondisk->snap_names_len);
@@ -4371,7 +4371,7 @@ static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev)
 	} while (snap_count != want_count);
 
 	ret = rbd_header_from_disk(rbd_dev, ondisk);
-out:
+ free_header:
 	kfree(ondisk);
 
 	return ret;
-- 
2.10.0
