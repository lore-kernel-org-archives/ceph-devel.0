From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 19/47] block-rbd: Rename a jump label in
 rbd_reregister_watch()
Date: Mon, 12 Sep 2016 21:05:21 +0200
Message-ID: <83afc929-81ff-db63-4f08-a9c72eb8dde6@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 19:31:04 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2b5f76e..97dbc1a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3950,7 +3950,7 @@ static void rbd_reregister_watch(struct work_struct *work)
 
 	mutex_lock(&rbd_dev->watch_mutex);
 	if (rbd_dev->watch_state != RBD_WATCH_STATE_ERROR)
-		goto fail_unlock;
+		goto unlock;
 
 	ret = __rbd_register_watch(rbd_dev);
 	if (ret) {
@@ -3959,7 +3959,7 @@ static void rbd_reregister_watch(struct work_struct *work)
 			queue_delayed_work(rbd_dev->task_wq,
 					   &rbd_dev->watch_dwork,
 					   RBD_RETRY_DELAY);
-		goto fail_unlock;
+		goto unlock;
 	}
 
 	rbd_dev->watch_state = RBD_WATCH_STATE_REGISTERED;
@@ -3980,8 +3980,7 @@ static void rbd_reregister_watch(struct work_struct *work)
 	up_write(&rbd_dev->lock_rwsem);
 	wake_requests(rbd_dev, true);
 	return;
-
-fail_unlock:
+ unlock:
 	mutex_unlock(&rbd_dev->watch_mutex);
 	up_write(&rbd_dev->lock_rwsem);
 }
-- 
2.10.0
