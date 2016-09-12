From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 02/47] block-rbd: Less function calls in
 rbd_header_from_disk() after error detection
Date: Mon, 12 Sep 2016 20:43:46 +0200
Message-ID: <cbebe916-a45d-f06f-0bd2-820b0c28c949@users.sourceforge.net>
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
Date: Sun, 11 Sep 2016 13:18:57 +0200

The functions "ceph_put_snap_context" and "kfree" were called in a few
cases by the function "rbd_header_from_disk" during error handling
even if the passed variables contained a null pointer.

Adjust jump targets according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e406c27..f4212e1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1001,7 +1001,7 @@ static int rbd_header_from_disk(struct rbd_device *rbd_dev,
 	snap_count = le32_to_cpu(ondisk->snap_count);
 	snapc = ceph_create_snap_context(snap_count, GFP_KERNEL);
 	if (!snapc)
-		goto out_err;
+		goto free_prefix;
 	snapc->seq = le64_to_cpu(ondisk->snap_seq);
 	if (snap_count) {
 		struct rbd_image_snap_ondisk *snaps;
@@ -1013,14 +1013,14 @@ static int rbd_header_from_disk(struct rbd_device *rbd_dev,
 			goto out_2big;
 		snap_names = kmalloc(snap_names_len, GFP_KERNEL);
 		if (!snap_names)
-			goto out_err;
+			goto put_snap_context;
 
 		/* ...as well as the array of their sizes. */
 		snap_sizes = kmalloc_array(snap_count,
 					   sizeof(*header->snap_sizes),
 					   GFP_KERNEL);
 		if (!snap_sizes)
-			goto out_err;
+			goto free_names;
 
 		/*
 		 * Copy the names, and fill in each snapshot's id
@@ -1066,10 +1066,12 @@ static int rbd_header_from_disk(struct rbd_device *rbd_dev,
 	return 0;
 out_2big:
 	ret = -EIO;
-out_err:
 	kfree(snap_sizes);
+ free_names:
 	kfree(snap_names);
+ put_snap_context:
 	ceph_put_snap_context(snapc);
+ free_prefix:
 	kfree(object_prefix);
 
 	return ret;
-- 
2.10.0
