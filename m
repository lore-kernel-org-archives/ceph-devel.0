From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: eliminate sparse warnings
Date: Tue, 19 Feb 2013 18:45:15 -0600
Message-ID: <51241C9B.209@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:62125 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932691Ab3BTApS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 19:45:18 -0500
Received: by mail-ie0-f170.google.com with SMTP id c11so9465631ieb.29
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 16:45:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Fengguang Wu reminded me that there were outstanding sparse reports
in the ceph and rbd code.  This patch fixes these problems in rbd
that lead to those reports:
    - Convert functions that are never referenced externally to have
      static scope.
    - Add a lockdep annotation to rbd_request_fn(), because it
      releases a lock before acquiring it again.

This partially resolves:
    http://tracker.ceph.com/issues/4184

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b0eea3e..ff5476c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1127,7 +1127,7 @@ static bool obj_request_type_valid(enum
obj_request_type type)
 	}
 }

-struct ceph_osd_req_op *rbd_osd_req_op_create(u16 opcode, ...)
+static struct ceph_osd_req_op *rbd_osd_req_op_create(u16 opcode, ...)
 {
 	struct ceph_osd_req_op *op;
 	va_list args;
@@ -1482,7 +1482,8 @@ static void rbd_obj_request_destroy(struct kref *kref)
  * that comprises the image request, and the Linux request pointer
  * (if there is one).
  */
-struct rbd_img_request *rbd_img_request_create(struct rbd_device *rbd_dev,
+static struct rbd_img_request *rbd_img_request_create(
+					struct rbd_device *rbd_dev,
 					u64 offset, u64 length,
 					bool write_request)
 {
@@ -1903,6 +1904,7 @@ out:
 }

 static void rbd_request_fn(struct request_queue *q)
+		__releases(q->queue_lock) __acquires(q->queue_lock)
 {
 	struct rbd_device *rbd_dev = q->queuedata;
 	bool read_only = rbd_dev->mapping.read_only;
@@ -2627,7 +2629,7 @@ static void rbd_spec_free(struct kref *kref)
 	kfree(spec);
 }

-struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
+static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 				struct rbd_spec *spec)
 {
 	struct rbd_device *rbd_dev;
@@ -4178,7 +4180,7 @@ static void rbd_sysfs_cleanup(void)
 	device_unregister(&rbd_root_dev);
 }

-int __init rbd_init(void)
+static int __init rbd_init(void)
 {
 	int rc;

@@ -4194,7 +4196,7 @@ int __init rbd_init(void)
 	return 0;
 }

-void __exit rbd_exit(void)
+static void __exit rbd_exit(void)
 {
 	rbd_sysfs_cleanup();
 }
-- 
1.7.9.5

