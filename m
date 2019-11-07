From: Colin King <colin.king@canonical.com>
Subject: [PATCH] rdb: fix spelling mistake "requeueing" -> "requeuing"
Date: Thu,  7 Nov 2019 22:36:46 +0000
Message-ID: <20191107223646.416986-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a debug message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 39136675dae5..8e1595d09138 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4230,7 +4230,7 @@ static void rbd_acquire_lock(struct work_struct *work)
 		 * lock owner acked, but resend if we don't see them
 		 * release the lock
 		 */
-		dout("%s rbd_dev %p requeueing lock_dwork\n", __func__,
+		dout("%s rbd_dev %p requeuing lock_dwork\n", __func__,
 		     rbd_dev);
 		mod_delayed_work(rbd_dev->task_wq, &rbd_dev->lock_dwork,
 		    msecs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT * MSEC_PER_SEC));
-- 
2.20.1
