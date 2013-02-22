From: Alex Elder <elder@inktank.com>
Subject: [PATCH, v2] rbd: eliminate sparse warnings
Date: Fri, 22 Feb 2013 11:21:02 -0600
Message-ID: <5127A8FE.9050002@inktank.com>
References: <5127A85D.1070000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:48812 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757786Ab3BVRVF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 12:21:05 -0500
Received: by mail-ie0-f178.google.com with SMTP id c13so1013678ieb.9
        for <ceph-devel@vger.kernel.org>; Fri, 22 Feb 2013 09:21:05 -0800 (PST)
In-Reply-To: <5127A85D.1070000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org >> ceph-devel" <ceph-devel@vger.kernel.org>

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
v2: rebased

 drivers/block/rbd.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a9c86ca..c6b15d4 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1141,7 +1141,7 @@ static bool obj_request_type_valid(enum
obj_request_type type)
 	}
 }

-struct ceph_osd_req_op *rbd_osd_req_op_create(u16 opcode, ...)
+static struct ceph_osd_req_op *rbd_osd_req_op_create(u16 opcode, ...)
 {
 	struct ceph_osd_req_op *op;
 	va_list args;
@@ -1537,7 +1537,8 @@ static void rbd_obj_request_destroy(struct kref *kref)
  * that comprises the image request, and the Linux request pointer
  * (if there is one).
  */
-struct rbd_img_request *rbd_img_request_create(struct rbd_device *rbd_dev,
+static struct rbd_img_request *rbd_img_request_create(
+					struct rbd_device *rbd_dev,
 					u64 offset, u64 length,
 					bool write_request)
 {
@@ -1971,6 +1972,7 @@ out:
 }

 static void rbd_request_fn(struct request_queue *q)
+		__releases(q->queue_lock) __acquires(q->queue_lock)
 {
 	struct rbd_device *rbd_dev = q->queuedata;
 	bool read_only = rbd_dev->mapping.read_only;
@@ -2705,7 +2707,7 @@ static void rbd_spec_free(struct kref *kref)
 	kfree(spec);
 }

-struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
+static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 				struct rbd_spec *spec)
 {
 	struct rbd_device *rbd_dev;
@@ -4256,7 +4258,7 @@ static void rbd_sysfs_cleanup(void)
 	device_unregister(&rbd_root_dev);
 }

-int __init rbd_init(void)
+static int __init rbd_init(void)
 {
 	int rc;

@@ -4272,7 +4274,7 @@ int __init rbd_init(void)
 	return 0;
 }

-void __exit rbd_exit(void)
+static void __exit rbd_exit(void)
 {
 	rbd_sysfs_cleanup();
 }
-- 
1.7.9.5

