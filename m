From: Christian Brunner <chb@muc.de>
Subject: [PATCH] qemu-kvm/rbd: add queueing delay based on queuesize (using
 use qemu_mutex_* and qemu_cond_*)
Date: Wed, 14 Jul 2010 15:35:46 +0200
Message-ID: <20100714133545.GA21617@bambus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56370 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab0GNNfy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jul 2010 09:35:54 -0400
Received: by bwz1 with SMTP id 1so925911bwz.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jul 2010 06:35:52 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Yehuda,

this is an updated version of the patch I've sent yesterday. It is now based on the
current rbd branch and it is using qemu_cond_* and qemu_mutex_*.

Regards,
Christian

---
 Makefile.objs |    1 +
 block/rbd.c   |   33 ++++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 56a13c1..e1b8513 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -12,6 +12,7 @@ block-obj-y += nbd.o block.o aio.o aes.o osdep.o qemu-config.o
 block-obj-$(CONFIG_POSIX) += posix-aio-compat.o
 block-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
 block-obj-$(CONFIG_POSIX) += compatfd.o
+block-obj-$(CONFIG_RBD) += qemu-thread.o
 
 block-nested-y += raw.o cow.o qcow.o vdi.o vmdk.o cloop.o dmg.o bochs.o vpc.o vvfat.o
 block-nested-y += qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-snapshot.o
diff --git a/block/rbd.c b/block/rbd.c
index e7d4083..01786da 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -24,7 +24,7 @@
 #include <rados/librados.h>
 
 #include <signal.h>
-
+#include <qemu-thread.h>
 
 int eventfd(unsigned int initval, int flags);
 
@@ -50,6 +50,7 @@ int eventfd(unsigned int initval, int flags);
  */
 
 #define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
+#define MAX_QUEUE_SIZE 33554432 // 32MB
 
 typedef struct RBDAIOCB {
     BlockDriverAIOCB common;
@@ -82,6 +83,9 @@ typedef struct BDRVRBDState {
     uint64_t objsize;
     int qemu_aio_count;
     int read_only;
+    uint64_t queuesize;
+    QemuMutex *queue_mutex;
+    QemuCond *queue_threshold;
 } BDRVRBDState;
 
 typedef struct rbd_obj_header_ondisk RbdHeader1;
@@ -487,6 +491,13 @@ static int rbd_open(BlockDriverState *bs, const char *filename, int flags)
 
     s->read_only = (snap != NULL);
 
+    s->queuesize = 0;
+
+    s->queue_mutex = qemu_malloc(sizeof(QemuMutex));
+    qemu_mutex_init(s->queue_mutex);
+    s->queue_threshold = qemu_malloc(sizeof(QemuCond));
+    qemu_cond_init(s->queue_threshold);
+
     s->efd = eventfd(0, 0);
     if (s->efd < 0) {
         error_report("error opening eventfd");
@@ -523,6 +534,12 @@ static void rbd_close(BlockDriverState *bs)
 {
     BDRVRBDState *s = bs->opaque;
 
+    // The following do not exist in qemu:
+    // qemu_cond_destroy(s->queue_threshold);
+    // qemu_mutex_destroy(s->queue_mutex);
+    qemu_free(s->queue_threshold);
+    qemu_free(s->queue_mutex);
+
     rados_close_pool(s->header_pool);
     rados_close_pool(s->pool);
     rados_deinitialize();
@@ -613,6 +630,12 @@ static void rbd_finish_aiocb(rados_completion_t c, RADOSCB *rcb)
     int i;
 
     acb->aiocnt--;
+    acb->s->queuesize -= rcb->segsize;
+    if (acb->s->queuesize+rcb->segsize > MAX_QUEUE_SIZE && acb->s->queuesize <= MAX_QUEUE_SIZE) {
+        qemu_mutex_lock(acb->s->queue_mutex);
+        qemu_cond_signal(acb->s->queue_threshold);
+        qemu_mutex_unlock(acb->s->queue_mutex);
+    }
     r = rados_aio_get_return_value(c);
     rados_aio_release(c);
     if (acb->write) {
@@ -735,6 +758,14 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState *bs,
         rcb->segsize = segsize;
         rcb->buf = buf;
 
+        while  (s->queuesize > MAX_QUEUE_SIZE) {
+            qemu_mutex_lock(s->queue_mutex);
+            qemu_cond_wait(s->queue_threshold, s->queue_mutex);
+            qemu_mutex_unlock(s->queue_mutex);
+        }
+
+        s->queuesize += segsize;
+
         if (write) {
             rados_aio_create_completion(rcb, NULL,
                                         (rados_callback_t) rbd_finish_aiocb,
-- 
1.6.5.2

