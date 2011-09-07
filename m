From: Yehuda Sadeh <yehuda@hq.newdream.net>
Subject: [PATCH 1/2] qemu-img: async write to block device when converting image
Date: Wed,  7 Sep 2011 16:06:52 -0700
Message-ID: <7c1ad306663bcacc60312d4d51ee6d266e075687.1315436097.git.yehuda@hq.newdream.net>
References: <cover.1315436097.git.yehuda@hq.newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51827 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528Ab1IGW6i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Sep 2011 18:58:38 -0400
In-Reply-To: <cover.1315436097.git.yehuda@hq.newdream.net>
In-Reply-To: <cover.1315436097.git.yehuda@hq.newdream.net>
References: <cover.1315436097.git.yehuda@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org
Cc: sage@newdream.net, yehudasa@gmail.com, Yehuda Sadeh <yehuda@hq.newdream.net>

In order to improve image conversion process, instead of synchronously
writing the destingation image, we keep a window of async writes.

Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>
---
 qemu-img.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b205e98..0552746 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -622,6 +622,17 @@ static int compare_sectors(const uint8_t *buf1, const uint8_t *buf2, int n,
 }
 
 #define IO_BUF_SIZE (2 * 1024 * 1024)
+#define IO_WRITE_WINDOW_THRESHOLD (32 * 1024 * 1024)
+
+static int write_window = 0;
+
+static void img_write_cb(void *opaque, int ret)
+{
+    QEMUIOVector *qiov = (QEMUIOVector *)opaque;
+    write_window -=  qiov->iov->iov_len / 512;
+    qemu_iovec_destroy(qiov);    
+    qemu_free(qiov);
+}
 
 static int img_convert(int argc, char **argv)
 {
@@ -980,6 +991,9 @@ static int img_convert(int argc, char **argv)
                should add a specific call to have the info to go faster */
             buf1 = buf;
             while (n > 0) {
+                while (write_window > IO_WRITE_WINDOW_THRESHOLD / 512) {
+                    qemu_aio_wait();
+                }
                 /* If the output image is being created as a copy on write image,
                    copy all sectors even the ones containing only NUL bytes,
                    because they may differ from the sectors in the base image.
@@ -989,11 +1003,11 @@ static int img_convert(int argc, char **argv)
                    already there is garbage, not 0s. */
                 if (!has_zero_init || out_baseimg ||
                     is_allocated_sectors(buf1, n, &n1)) {
-                    ret = bdrv_write(out_bs, sector_num, buf1, n1);
-                    if (ret < 0) {
-                        error_report("error while writing");
-                        goto out;
-                    }
+                    QEMUIOVector *qiov = qemu_mallocz(sizeof(QEMUIOVector));
+		    qemu_iovec_init(qiov, 1);
+		    qemu_iovec_add(qiov, (void *)buf1, n1 * 512);
+                    bdrv_aio_writev(out_bs, sector_num, qiov, n1, img_write_cb, qiov);
+                    write_window += n1;
                 }
                 sector_num += n1;
                 n -= n1;
@@ -1001,11 +1015,15 @@ static int img_convert(int argc, char **argv)
             }
             qemu_progress_print(local_progress, 100);
         }
+        while (write_window > 0) {
+            qemu_aio_wait();
+        }
     }
 out:
     qemu_progress_end();
     free_option_parameters(create_options);
     free_option_parameters(param);
+    bdrv_flush(out_bs);
     qemu_free(buf);
     if (out_bs) {
         bdrv_delete(out_bs);
-- 
1.7.5.1

