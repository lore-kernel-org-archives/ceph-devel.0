From: Yehuda Sadeh <yehuda@hq.newdream.net>
Subject: [PATCH 2/2] qemu-img: don't skip writing small holes
Date: Wed,  7 Sep 2011 16:06:53 -0700
Message-ID: <92a5407ccc0617e43a4bf7d2a74fe1887382dd75.1315436097.git.yehuda@hq.newdream.net>
References: <cover.1315436097.git.yehuda@hq.newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51830 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535Ab1IGW6i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Sep 2011 18:58:38 -0400
In-Reply-To: <cover.1315436097.git.yehuda@hq.newdream.net>
In-Reply-To: <cover.1315436097.git.yehuda@hq.newdream.net>
References: <cover.1315436097.git.yehuda@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org
Cc: sage@newdream.net, yehudasa@gmail.com, Yehuda Sadeh <yehuda@hq.newdream.net>

When doing convert, we check that the sectors that are written
are not empty. When holes are small, and interleaved with data
it can lead to a significant performance issue.

Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>
---
 qemu-img.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 0552746..757fc3a 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -623,6 +623,7 @@ static int compare_sectors(const uint8_t *buf1, const uint8_t *buf2, int n,
 
 #define IO_BUF_SIZE (2 * 1024 * 1024)
 #define IO_WRITE_WINDOW_THRESHOLD (32 * 1024 * 1024)
+#define IO_WRITE_MIN_SIZE (128 * 1024)
 
 static int write_window = 0;
 
@@ -991,6 +992,7 @@ static int img_convert(int argc, char **argv)
                should add a specific call to have the info to go faster */
             buf1 = buf;
             while (n > 0) {
+                int is_allocated = is_allocated_sectors(buf1, n, &n1);
                 while (write_window > IO_WRITE_WINDOW_THRESHOLD / 512) {
                     qemu_aio_wait();
                 }
@@ -1001,8 +1003,8 @@ static int img_convert(int argc, char **argv)
                    If the output is to a host device, we also write out
                    sectors that are entirely 0, since whatever data was
                    already there is garbage, not 0s. */
-                if (!has_zero_init || out_baseimg ||
-                    is_allocated_sectors(buf1, n, &n1)) {
+                if (is_allocated || n != n1 || !has_zero_init || out_baseimg) {
+                    n1 = MAX(n1, MIN(n, IO_WRITE_MIN_SIZE / 512));
                     QEMUIOVector *qiov = qemu_mallocz(sizeof(QEMUIOVector));
 		    qemu_iovec_init(qiov, 1);
 		    qemu_iovec_add(qiov, (void *)buf1, n1 * 512);
-- 
1.7.5.1

