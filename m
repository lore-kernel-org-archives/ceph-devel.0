From: Yehuda Sadeh <yehuda@hq.newdream.net>
Subject: [PATCH 1/1] qemu-img: async write to block device when converting image
Date: Mon, 12 Sep 2011 07:26:45 -0700
Message-ID: <ea3984c0f16e44c14f8b9352375f6299d8e1b647.1315836010.git.yehuda@hq.newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47306 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616Ab1ILORK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Sep 2011 10:17:10 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, kwolf@redhat.com
Cc: sage@newdream.net, yehudasa@gmail.com, Yehuda Sadeh <yehuda@hq.newdream.net>

In order to improve image conversion process, instead of synchronously
writing the destingation image, we keep a window of async writes.

Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>
---
 qemu-img.c |   47 +++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 6a39731..a45f5f2 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -646,6 +646,29 @@ static int compare_sectors(const uint8_t *buf1, const uint8_t *buf2, int n,
 }
 
 #define IO_BUF_SIZE (2 * 1024 * 1024)
+#define IO_WRITE_WINDOW_THRESHOLD (32 * 1024 * 1024)
+
+static int write_window = 0;
+static int write_ret = 0;
+
+struct write_info {
+    int64_t sector;
+    QEMUIOVector qiov;
+};
+
+static void img_write_cb(void *opaque, int ret)
+{
+    struct write_info *wr = (struct write_info *)opaque;
+    QEMUIOVector *qiov = &wr->qiov;
+    if (ret < 0) {
+        error_report("error while writing sector %" PRId64
+                     ": %s", wr->sector, strerror(-ret));
+        write_ret = ret;
+    }
+    write_window -=  qiov->iov->iov_len / 512;
+    qemu_iovec_destroy(qiov);
+    g_free(wr);
+}
 
 static int img_convert(int argc, char **argv)
 {
@@ -1019,6 +1042,9 @@ static int img_convert(int argc, char **argv)
                should add a specific call to have the info to go faster */
             buf1 = buf;
             while (n > 0) {
+                while (write_window > IO_WRITE_WINDOW_THRESHOLD / 512) {
+                    qemu_aio_wait();
+                }
                 /* If the output image is being created as a copy on write image,
                    copy all sectors even the ones containing only NUL bytes,
                    because they may differ from the sectors in the base image.
@@ -1028,12 +1054,21 @@ static int img_convert(int argc, char **argv)
                    already there is garbage, not 0s. */
                 if (!has_zero_init || out_baseimg ||
                     is_allocated_sectors_min(buf1, n, &n1, min_sparse)) {
-                    ret = bdrv_write(out_bs, sector_num, buf1, n1);
-                    if (ret < 0) {
-                        error_report("error while writing sector %" PRId64
-                                     ": %s", sector_num, strerror(-ret));
+                    QEMUIOVector *qiov;
+                    struct write_info *wr;
+                    BlockDriverAIOCB *acb;
+                    wr = g_malloc0(sizeof(struct write_info));
+                    qiov = &wr->qiov;
+                    qemu_iovec_init(qiov, 1);
+                    qemu_iovec_add(qiov, (void *)buf1, n1 * 512);
+                    wr->sector = sector_num;
+                    acb = bdrv_aio_writev(out_bs, sector_num, qiov, n1, img_write_cb, wr);
+                    if (!acb) {
+                        g_free(wr);
+                        error_report("I/O error while writing sector %" PRId64, sector_num);
                         goto out;
                     }
+                    write_window += n1;
                 }
                 sector_num += n1;
                 n -= n1;
@@ -1041,6 +1076,9 @@ static int img_convert(int argc, char **argv)
             }
             qemu_progress_print(local_progress, 100);
         }
+        while (write_window > 0) {
+            qemu_aio_wait();
+        }
     }
 out:
     qemu_progress_end();
@@ -1048,6 +1086,7 @@ out:
     free_option_parameters(param);
     qemu_vfree(buf);
     if (out_bs) {
+        bdrv_flush(out_bs);
         bdrv_delete(out_bs);
     }
     if (bs) {
-- 
1.7.5.1

