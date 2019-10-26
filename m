From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 76/99] rbd: cancel lock_dwork if the wait is interrupted
Date: Sat, 26 Oct 2019 09:15:37 -0400
Message-ID: <20191026131600.2507-76-sashal@kernel.org>
References: <20191026131600.2507-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191026131600.2507-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Dongsheng Yang <dongsheng.yang@easystack.cn>, Ilya Dryomov <idryomov@gmail.com>, Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Dongsheng Yang <dongsheng.yang@easystack.cn>

[ Upstream commit 25e6be21230d3208d687dad90b6e43419013c351 ]

There is a warning message in my test with below steps:

  # rbd bench --io-type write --io-size 4K --io-threads 1 --io-pattern rand test &
  # sleep 5
  # pkill -9 rbd
  # rbd map test &
  # sleep 5
  # pkill rbd

The reason is that the rbd_add_acquire_lock() is interruptable,
that means, when we kill the waiting on ->acquire_wait, the lock_dwork
could be still running.

1. do_rbd_add()					2. lock_dwork
rbd_add_acquire_lock()
  - queue_delayed_work()
						lock_dwork queued
    - wait_for_completion_killable_timeout()  <-- kill happen
rbd_dev_image_unlock()	<-- UNLOCKED now, nothing to do.
rbd_dev_device_release()
rbd_dev_image_release()
  - ...
						lock successed here
     - cancel_delayed_work_sync(&rbd_dev->lock_dwork)

Then when we reach the rbd_dev_free(), WARN_ON is triggered because
lock_state is not RBD_LOCK_STATE_UNLOCKED.

To fix it, this commit make sure the lock_dwork was finished before
calling rbd_dev_image_unlock().

On the other hand, this would not happend in do_rbd_remove(), because
after rbd mapped, lock_dwork will only be queued for IO request, and
request will continue unless lock_dwork finished. when we call
rbd_dev_image_unlock() in do_rbd_remove(), all requests are done.
That means, lock_state should not be locked again after
rbd_dev_image_unlock().

[ Cancel lock_dwork in rbd_add_acquire_lock(), only if the wait is
  interrupted. ]

Fixes: 637cd060537d ("rbd: new exclusive lock wait/wake code")
Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/rbd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c8fb886aebd4e..e6369b9f33873 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6632,10 +6632,13 @@ static int rbd_add_acquire_lock(struct rbd_device *rbd_dev)
 	queue_delayed_work(rbd_dev->task_wq, &rbd_dev->lock_dwork, 0);
 	ret = wait_for_completion_killable_timeout(&rbd_dev->acquire_wait,
 			    ceph_timeout_jiffies(rbd_dev->opts->lock_timeout));
-	if (ret > 0)
+	if (ret > 0) {
 		ret = rbd_dev->acquire_err;
-	else if (!ret)
-		ret = -ETIMEDOUT;
+	} else {
+		cancel_delayed_work_sync(&rbd_dev->lock_dwork);
+		if (!ret)
+			ret = -ETIMEDOUT;
+	}
 
 	if (ret) {
 		rbd_warn(rbd_dev, "failed to acquire exclusive lock: %ld", ret);
-- 
2.20.1
