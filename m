From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [RFC 2/2] rbd: implement bdrv_set_key
Date: Wed,  9 Nov 2011 16:20:56 -0800
Message-ID: <c3704b44309e60da89fec86420ca8ff1b0ebf960.1320884066.git.josh.durgin@dreamhost.com>
References: <cover.1320884065.git.josh.durgin@dreamhost.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47234 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816Ab1KJAVk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 19:21:40 -0500
In-Reply-To: <cover.1320884065.git.josh.durgin@dreamhost.com>
In-Reply-To: <cover.1320884065.git.josh.durgin@dreamhost.com>
References: <cover.1320884065.git.josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org, kwolf@redhat.com

We can't connect to the cluster before the key is set, so this step is
moved to qemu_rbd_open_finish. Each bdrv function will fail before the
key is set.

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
---
 block/rbd.c |  160 +++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 113 insertions(+), 47 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index c684e0c..005222a 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -83,6 +83,8 @@ typedef struct BDRVRBDState {
     rados_ioctx_t io_ctx;
     rbd_image_t image;
     char name[RBD_MAX_IMAGE_NAME_SIZE];
+    char pool[RBD_MAX_POOL_NAME_SIZE];
+    char conf[RBD_MAX_CONF_SIZE];
     int qemu_aio_count;
     char *snap;
     int event_reader_pos;
@@ -271,6 +273,17 @@ static int qemu_rbd_set_conf(rados_t cluster, const char *conf)
     return ret;
 }
 
+static int qemu_rbd_connect(rados_t cluster,
+                            const char *pool,
+                            rados_ioctx_t *io_ctx)
+{
+    int ret = rados_connect(cluster);
+    if (ret < 0) {
+        return ret;
+    }
+    return rados_ioctx_create(cluster, pool, io_ctx);
+}
+
 static int qemu_rbd_create(const char *filename, QEMUOptionParameter *options)
 {
     int64_t bytes = 0;
@@ -332,16 +345,15 @@ static int qemu_rbd_create(const char *filename, QEMUOptionParameter *options)
         return -EIO;
     }
 
-    if (rados_connect(cluster) < 0) {
-        error_report("error connecting");
-        rados_shutdown(cluster);
-        return -EIO;
-    }
-
-    if (rados_ioctx_create(cluster, pool, &io_ctx) < 0) {
-        error_report("error opening pool %s", pool);
+    ret = qemu_rbd_connect(cluster, pool, &io_ctx);
+    if (ret < 0) {
+        error_report("error connecting: %s", strerror(-ret));
         rados_shutdown(cluster);
-        return -EIO;
+        if (ret == -EPERM || ret == -ENOTSUP) {
+            return -EPERM;
+        } else {
+            return -EIO;
+        }
     }
 
     ret = rbd_create(io_ctx, name, bytes, &obj_order);
@@ -431,57 +443,46 @@ static int qemu_rbd_aio_flush_cb(void *opaque)
     return (s->qemu_aio_count > 0);
 }
 
-static int qemu_rbd_open(BlockDriverState *bs, const char *filename, int flags)
+
+static int qemu_rbd_finish_open(BDRVRBDState *s, const char *key)
 {
-    BDRVRBDState *s = bs->opaque;
-    char pool[RBD_MAX_POOL_NAME_SIZE];
-    char snap_buf[RBD_MAX_SNAP_NAME_SIZE];
-    char conf[RBD_MAX_CONF_SIZE];
     char clientname_buf[RBD_MAX_CONF_SIZE];
     char *clientname;
     int r;
 
-    if (qemu_rbd_parsename(filename, pool, sizeof(pool),
-                           snap_buf, sizeof(snap_buf),
-                           s->name, sizeof(s->name),
-                           conf, sizeof(conf)) < 0) {
-        return -EINVAL;
-    }
-
-    clientname = qemu_rbd_parse_clientname(conf, clientname_buf);
+    clientname = qemu_rbd_parse_clientname(s->conf, clientname_buf);
     r = rados_create(&s->cluster, clientname);
     if (r < 0) {
         error_report("error initializing");
         return r;
     }
 
-    s->snap = NULL;
-    if (snap_buf[0] != '\0') {
-        s->snap = g_strdup(snap_buf);
-    }
-
-    if (strstr(conf, "conf=") == NULL) {
+    if (strstr(s->conf, "conf=") == NULL) {
         /* try default location, but ignore failure */
         rados_conf_read_file(s->cluster, NULL);
     }
 
-    if (conf[0] != '\0') {
-        r = qemu_rbd_set_conf(s->cluster, conf);
+    if (s->conf[0] != '\0') {
+        r = qemu_rbd_set_conf(s->cluster, s->conf);
         if (r < 0) {
             error_report("error setting config options");
             goto failed_shutdown;
         }
     }
 
-    r = rados_connect(s->cluster);
-    if (r < 0) {
-        error_report("error connecting");
-        goto failed_shutdown;
+    if (key) {
+        r = rados_conf_set(s->cluster, "key", key);
+        if (r < 0) {
+            error_report("error setting key");
+            goto failed_shutdown;
+        }
     }
 
-    r = rados_ioctx_create(s->cluster, pool, &s->io_ctx);
-    if (r < 0) {
-        error_report("error opening pool %s", pool);
+    r = qemu_rbd_connect(s->cluster, s->pool, &s->io_ctx);
+    if (r == -EPERM || r == -ENOTSUP) {
+        return -EPERM;
+    } else if (r < 0) {
+        error_report("error connecting: %s", strerror(-r));
         goto failed_shutdown;
     }
 
@@ -491,8 +492,6 @@ static int qemu_rbd_open(BlockDriverState *bs, const char *filename, int flags)
         goto failed_open;
     }
 
-    bs->read_only = (s->snap != NULL);
-
     s->event_reader_pos = 0;
     r = qemu_pipe(s->fds);
     if (r < 0) {
@@ -513,23 +512,55 @@ failed_open:
     rados_ioctx_destroy(s->io_ctx);
 failed_shutdown:
     rados_shutdown(s->cluster);
-    g_free(s->snap);
     return r;
 }
 
+static int qemu_rbd_open(BlockDriverState *bs, const char *filename, int flags)
+{
+    BDRVRBDState *s = bs->opaque;
+    char snap_buf[RBD_MAX_SNAP_NAME_SIZE];
+    int r;
+
+    if (qemu_rbd_parsename(filename, s->pool, sizeof(s->pool),
+                           snap_buf, sizeof(snap_buf),
+                           s->name, sizeof(s->name),
+                           s->conf, sizeof(s->conf)) < 0) {
+        return -EINVAL;
+    }
+
+    s->snap = NULL;
+    if (snap_buf[0] != '\0') {
+        s->snap = g_strdup(snap_buf);
+    }
+
+    bs->read_only = (s->snap != NULL);
+
+    r = qemu_rbd_finish_open(s, NULL);
+    if (r == -EPERM) {
+        bs->needs_auth = 1;
+    } else if (r < 0) {
+        g_free(s->snap);
+        return r;
+    }
+
+    return 0;
+}
+
 static void qemu_rbd_close(BlockDriverState *bs)
 {
     BDRVRBDState *s = bs->opaque;
 
-    close(s->fds[0]);
-    close(s->fds[1]);
-    qemu_aio_set_fd_handler(s->fds[RBD_FD_READ], NULL , NULL, NULL, NULL,
-        NULL);
+    if (!bdrv_key_required(bs)) {
+        close(s->fds[0]);
+        close(s->fds[1]);
+        qemu_aio_set_fd_handler(s->fds[RBD_FD_READ], NULL , NULL, NULL, NULL,
+                                NULL);
 
-    rbd_close(s->image);
-    rados_ioctx_destroy(s->io_ctx);
+        rbd_close(s->image);
+        rados_ioctx_destroy(s->io_ctx);
+        rados_shutdown(s->cluster);
+    }
     g_free(s->snap);
-    rados_shutdown(s->cluster);
 }
 
 /*
@@ -692,6 +723,9 @@ static BlockDriverAIOCB *qemu_rbd_aio_readv(BlockDriverState *bs,
                                             BlockDriverCompletionFunc *cb,
                                             void *opaque)
 {
+    if (bdrv_key_required(bs)) {
+        return NULL;
+    }
     return rbd_aio_rw_vector(bs, sector_num, qiov, nb_sectors, cb, opaque, 0);
 }
 
@@ -702,11 +736,18 @@ static BlockDriverAIOCB *qemu_rbd_aio_writev(BlockDriverState *bs,
                                              BlockDriverCompletionFunc *cb,
                                              void *opaque)
 {
+    if (bdrv_key_required(bs)) {
+        return NULL;
+    }
     return rbd_aio_rw_vector(bs, sector_num, qiov, nb_sectors, cb, opaque, 1);
 }
 
 static int qemu_rbd_co_flush(BlockDriverState *bs)
 {
+    if (bdrv_key_required(bs)) {
+        return -EPERM;
+    }
+
 #if LIBRBD_VERSION_CODE >= LIBRBD_VERSION(0, 1, 1)
     /* rbd_flush added in 0.1.1 */
     BDRVRBDState *s = bs->opaque;
@@ -721,6 +762,9 @@ static int qemu_rbd_getinfo(BlockDriverState *bs, BlockDriverInfo *bdi)
     BDRVRBDState *s = bs->opaque;
     rbd_image_info_t info;
     int r;
+    if (bdrv_key_required(bs)) {
+        return -EPERM;
+    }
 
     r = rbd_stat(s->image, &info, sizeof(info));
     if (r < 0) {
@@ -736,6 +780,9 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
     BDRVRBDState *s = bs->opaque;
     rbd_image_info_t info;
     int r;
+    if (bdrv_key_required(bs)) {
+        return -EPERM;
+    }
 
     r = rbd_stat(s->image, &info, sizeof(info));
     if (r < 0) {
@@ -749,6 +796,9 @@ static int qemu_rbd_truncate(BlockDriverState *bs, int64_t offset)
 {
     BDRVRBDState *s = bs->opaque;
     int r;
+    if (bdrv_key_required(bs)) {
+        return -EPERM;
+    }
 
     r = rbd_resize(s->image, offset);
     if (r < 0) {
@@ -758,11 +808,22 @@ static int qemu_rbd_truncate(BlockDriverState *bs, int64_t offset)
     return 0;
 }
 
+static int qemu_rbd_set_key(BlockDriverState *bs, const char *key)
+{
+    if (bs->valid_key) {
+        return 0;
+    }
+    return qemu_rbd_finish_open(bs->opaque, key);
+}
+
 static int qemu_rbd_snap_create(BlockDriverState *bs,
                                 QEMUSnapshotInfo *sn_info)
 {
     BDRVRBDState *s = bs->opaque;
     int r;
+    if (bdrv_key_required(bs)) {
+        return -EPERM;
+    }
 
     if (sn_info->name[0] == '\0') {
         return -EINVAL; /* we need a name for rbd snapshots */
@@ -799,6 +860,10 @@ static int qemu_rbd_snap_list(BlockDriverState *bs,
     rbd_snap_info_t *snaps;
     int max_snaps = RBD_MAX_SNAPS;
 
+    if (bdrv_key_required(bs)) {
+        return -EPERM;
+    }
+
     do {
         snaps = g_malloc(sizeof(*snaps) * max_snaps);
         snap_count = rbd_snap_list(s->image, snaps, &max_snaps);
@@ -856,6 +921,7 @@ static BlockDriver bdrv_rbd = {
     .create_options     = qemu_rbd_create_options,
     .bdrv_getlength     = qemu_rbd_getlength,
     .bdrv_truncate      = qemu_rbd_truncate,
+    .bdrv_set_key       = qemu_rbd_set_key,
     .protocol_name      = "rbd",
 
     .bdrv_aio_readv     = qemu_rbd_aio_readv,
-- 
1.7.1

