From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 24/47] block-rbd: Rename jump labels in rbd_request_lock()
Date: Mon, 12 Sep 2016 21:10:34 +0200
Message-ID: <e5bdbae6-c9d0-8c0d-9ba7-95826cf726b4@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 19:38:52 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e175d21..09a0ed3 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3297,7 +3297,7 @@ static int rbd_request_lock(struct rbd_device *rbd_dev)
 				   &reply_pages, &reply_len);
 	if (ret && ret != -ETIMEDOUT) {
 		rbd_warn(rbd_dev, "failed to request lock: %d", ret);
-		goto out;
+		goto release_page_vector;
 	}
 
 	if (reply_len > 0 && reply_len <= PAGE_SIZE) {
@@ -3321,7 +3321,7 @@ static int rbd_request_lock(struct rbd_device *rbd_dev)
 				rbd_warn(rbd_dev,
 					 "duplicate lock owners detected");
 				ret = -EIO;
-				goto out;
+				goto release_page_vector;
 			}
 
 			lock_owner_responded = true;
@@ -3342,14 +3342,12 @@ static int rbd_request_lock(struct rbd_device *rbd_dev)
 		rbd_warn(rbd_dev, "no lock owners detected");
 		ret = -ETIMEDOUT;
 	}
-
-out:
+ release_page_vector:
 	ceph_release_page_vector(reply_pages, calc_pages_for(0, reply_len));
 	return ret;
-
-e_inval:
+ e_inval:
 	ret = -EINVAL;
-	goto out;
+	goto release_page_vector;
 }
 
 static void wake_requests(struct rbd_device *rbd_dev, bool wake_all)
-- 
2.10.0
