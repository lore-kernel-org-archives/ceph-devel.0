From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2 2/3] rbd: Use refcount_t for refcount
Date: Tue, 13 Aug 2019 14:16:41 +0800
Message-ID: <20190813061641.5428-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
List-Id: ceph-devel.vger.kernel.org

Reference counters are preferred to use refcount_t instead of
atomic_t.
This is because the implementation of refcount_t can prevent
overflows and detect possible use-after-free.
So convert atomic_t ref counters to refcount_t.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/block/rbd.c | 57 ++++++++-------------------------------------
 1 file changed, 10 insertions(+), 47 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 3327192bb71f..74d2dddbe108 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -46,44 +46,12 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/workqueue.h>
+#include <linux/refcount.h>
 
 #include "rbd_types.h"
 
 #define RBD_DEBUG	/* Activate rbd_assert() calls */
 
-/*
- * Increment the given counter and return its updated value.
- * If the counter is already 0 it will not be incremented.
- * If the counter is already at its maximum value returns
- * -EINVAL without updating it.
- */
-static int atomic_inc_return_safe(atomic_t *v)
-{
-	unsigned int counter;
-
-	counter = (unsigned int)atomic_fetch_add_unless(v, 1, 0);
-	if (counter <= (unsigned int)INT_MAX)
-		return (int)counter;
-
-	atomic_dec(v);
-
-	return -EINVAL;
-}
-
-/* Decrement the counter.  Return the resulting value, or -EINVAL */
-static int atomic_dec_return_safe(atomic_t *v)
-{
-	int counter;
-
-	counter = atomic_dec_return(v);
-	if (counter >= 0)
-		return counter;
-
-	atomic_inc(v);
-
-	return -EINVAL;
-}
-
 #define RBD_DRV_NAME "rbd"
 
 #define RBD_MINORS_PER_MAJOR		256
@@ -438,7 +406,7 @@ struct rbd_device {
 
 	struct rbd_spec		*parent_spec;
 	u64			parent_overlap;
-	atomic_t		parent_ref;
+	refcount_t		parent_ref;
 	struct rbd_device	*parent;
 
 	/* Block layer tags. */
@@ -1680,21 +1648,19 @@ static void rbd_dev_unparent(struct rbd_device *rbd_dev)
  */
 static void rbd_dev_parent_put(struct rbd_device *rbd_dev)
 {
-	int counter;
+	bool is_dec_to_zero;
 
 	if (!rbd_dev->parent_spec)
 		return;
 
-	counter = atomic_dec_return_safe(&rbd_dev->parent_ref);
-	if (counter > 0)
+	is_dec_to_zero = refcount_dec_and_test_checked(&rbd_dev->parent_ref);
+	if (!is_dec_to_zero)
 		return;
 
 	/* Last reference; clean up parent data structures */
 
-	if (!counter)
+	if (is_dec_to_zero)
 		rbd_dev_unparent(rbd_dev);
-	else
-		rbd_warn(rbd_dev, "parent reference underflow");
 }
 
 /*
@@ -1707,20 +1673,17 @@ static void rbd_dev_parent_put(struct rbd_device *rbd_dev)
  */
 static bool rbd_dev_parent_get(struct rbd_device *rbd_dev)
 {
-	int counter = 0;
+	bool is_inc_suc = false;
 
 	if (!rbd_dev->parent_spec)
 		return false;
 
 	down_read(&rbd_dev->header_rwsem);
 	if (rbd_dev->parent_overlap)
-		counter = atomic_inc_return_safe(&rbd_dev->parent_ref);
+		is_inc_suc = refcount_inc_not_zero_checked(&rbd_dev->parent_ref);
 	up_read(&rbd_dev->header_rwsem);
 
-	if (counter < 0)
-		rbd_warn(rbd_dev, "parent reference overflow");
-
-	return counter > 0;
+	return is_inc_suc;
 }
 
 /*
@@ -6823,7 +6786,7 @@ static int rbd_dev_probe_parent(struct rbd_device *rbd_dev, int depth)
 		goto out_err;
 
 	rbd_dev->parent = parent;
-	atomic_set(&rbd_dev->parent_ref, 1);
+	refcount_set(&rbd_dev->parent_ref, 1);
 	return 0;
 
 out_err:
-- 
2.20.1
