From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [PATCH v5 2/4] rbd: allow configuration of rados from the rbd filename
Date: Wed, 25 May 2011 13:34:45 -0700
Message-ID: <1306355687-4647-3-git-send-email-josh.durgin@dreamhost.com>
References: <1306355687-4647-1-git-send-email-josh.durgin@dreamhost.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48229 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755477Ab1EYUjR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 16:39:17 -0400
In-Reply-To: <1306355687-4647-1-git-send-email-josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kvm@vger.kernel.org, qemu-devel@nongnu.orgkvm@vger.kernel.orgqemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>, Christian Brunner <chb@muc.de>

The new format is rbd:pool/image[@snapshot][:option1=value1[:option2=value2...]]
Each option is used to configure rados, and may be any Ceph option, or "conf".
The "conf" option specifies a Ceph configuration file to read.

This allows rbd volumes from more than one Ceph cluster to be used by
specifying different monitor addresses, as well as having different
logging levels or locations for different volumes.

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
---
 block/rbd.c |  119 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 102 insertions(+), 17 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 2cee70d..d346a21 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -23,13 +23,17 @@
 /*
  * When specifying the image filename use:
  *
- * rbd:poolname/devicename
+ * rbd:poolname/devicename[@snapshotname][:option1=value1[:option2=value2...]]
  *
  * poolname must be the name of an existing rados pool
  *
  * devicename is the basename for all objects used to
  * emulate the raw device.
  *
+ * Each option given is used to configure rados, and may be
+ * any Ceph option, or "conf". The "conf" option specifies
+ * a Ceph configuration file to read.
+ *
  * Metadata information (image size, ...) is stored in an
  * object with the name "devicename.rbd".
  *
@@ -123,7 +127,8 @@ static int qemu_rbd_next_tok(char *dst, int dst_len,
 static int qemu_rbd_parsename(const char *filename,
                               char *pool, int pool_len,
                               char *snap, int snap_len,
-                              char *name, int name_len)
+                              char *name, int name_len,
+                              char *conf, int conf_len)
 {
     const char *start;
     char *p, *buf;
@@ -135,28 +140,84 @@ static int qemu_rbd_parsename(const char *filename,
 
     buf = qemu_strdup(start);
     p = buf;
+    *snap = '\0';
+    *conf = '\0';
 
     ret = qemu_rbd_next_tok(pool, pool_len, p, '/', "pool name", &p);
     if (ret < 0 || !p) {
         ret = -EINVAL;
         goto done;
     }
-    ret = qemu_rbd_next_tok(name, name_len, p, '@', "object name", &p);
-    if (ret < 0) {
-        goto done;
+
+    if (strchr(p, '@')) {
+        ret = qemu_rbd_next_tok(name, name_len, p, '@', "object name", &p);
+        if (ret < 0) {
+            goto done;
+        }
+        ret = qemu_rbd_next_tok(snap, snap_len, p, ':', "snap name", &p);
+    } else {
+        ret = qemu_rbd_next_tok(name, name_len, p, ':', "object name", &p);
     }
-    if (!p) {
-        *snap = '\0';
+    if (ret < 0 || !p) {
         goto done;
     }
 
-    ret = qemu_rbd_next_tok(snap, snap_len, p, '\0', "snap name", &p);
+    ret = qemu_rbd_next_tok(conf, conf_len, p, '\0', "configuration", &p);
 
 done:
     qemu_free(buf);
     return ret;
 }
 
+static int qemu_rbd_set_conf(rados_t cluster, const char *conf)
+{
+    char *p, *buf;
+    char name[RBD_MAX_CONF_NAME_SIZE];
+    char value[RBD_MAX_CONF_VAL_SIZE];
+    int ret = 0;
+
+    buf = qemu_strdup(conf);
+    p = buf;
+
+    while (p) {
+        ret = qemu_rbd_next_tok(name, sizeof(name), p,
+                                '=', "conf option name", &p);
+        if (ret < 0) {
+            break;
+        }
+
+        if (!p) {
+            error_report("conf option %s has no value", name);
+            ret = -EINVAL;
+            break;
+        }
+
+        ret = qemu_rbd_next_tok(value, sizeof(value), p,
+                                ':', "conf option value", &p);
+        if (ret < 0) {
+            break;
+        }
+
+        if (strncmp(name, "conf", strlen("conf"))) {
+            ret = rados_conf_set(cluster, name, value);
+            if (ret < 0) {
+                error_report("invalid conf option %s", name);
+                ret = -EINVAL;
+                break;
+            }
+        } else {
+            ret = rados_conf_read_file(cluster, value);
+            if (ret < 0) {
+                error_report("error reading conf file %s", value);
+                break;
+            }
+        }
+    }
+
+    qemu_free(buf);
+    return ret;
+}
+
 static int qemu_rbd_create(const char *filename, QEMUOptionParameter *options)
 {
     int64_t bytes = 0;
@@ -165,6 +226,7 @@ static int qemu_rbd_create(const char *filename, QEMUOptionParameter *options)
     char pool[RBD_MAX_POOL_NAME_SIZE];
     char name[RBD_MAX_IMAGE_NAME_SIZE];
     char snap_buf[RBD_MAX_SNAP_NAME_SIZE];
+    char conf[RBD_MAX_CONF_SIZE];
     char *snap = NULL;
     rados_t cluster;
     rados_ioctx_t io_ctx;
@@ -172,7 +234,8 @@ static int qemu_rbd_create(const char *filename, QEMUOptionParameter *options)
 
     if (qemu_rbd_parsename(filename, pool, sizeof(pool),
                            snap_buf, sizeof(snap_buf),
-                           name, sizeof(name)) < 0) {
+                           name, sizeof(name),
+                           conf, sizeof(conf)) < 0) {
         return -EINVAL;
     }
     if (snap_buf[0] != '\0') {
@@ -205,8 +268,17 @@ static int qemu_rbd_create(const char *filename, QEMUOptionParameter *options)
         return -EIO;
     }
 
-    if (rados_conf_read_file(cluster, NULL) < 0) {
-        error_report("error reading config file");
+    if (strstr(conf, "conf=") == NULL) {
+        if (rados_conf_read_file(cluster, NULL) < 0) {
+            error_report("error reading config file");
+            rados_shutdown(cluster);
+            return -EIO;
+        }
+    }
+
+    if (conf[0] != '\0' &&
+        qemu_rbd_set_conf(cluster, conf) < 0) {
+        error_report("error setting config options");
         rados_shutdown(cluster);
         return -EIO;
     }
@@ -316,11 +388,13 @@ static int qemu_rbd_open(BlockDriverState *bs, const char *filename, int flags)
     BDRVRBDState *s = bs->opaque;
     char pool[RBD_MAX_POOL_NAME_SIZE];
     char snap_buf[RBD_MAX_SNAP_NAME_SIZE];
+    char conf[RBD_MAX_CONF_SIZE];
     int r;
 
     if (qemu_rbd_parsename(filename, pool, sizeof(pool),
                            snap_buf, sizeof(snap_buf),
-                           s->name, sizeof(s->name)) < 0) {
+                           s->name, sizeof(s->name),
+                           conf, sizeof(conf)) < 0) {
         return -EINVAL;
     }
     s->snap = NULL;
@@ -334,11 +408,22 @@ static int qemu_rbd_open(BlockDriverState *bs, const char *filename, int flags)
         return r;
     }
 
-    r = rados_conf_read_file(s->cluster, NULL);
-    if (r < 0) {
-        error_report("error reading config file");
-        rados_shutdown(s->cluster);
-        return r;
+    if (strstr(conf, "conf=") == NULL) {
+        r = rados_conf_read_file(s->cluster, NULL);
+        if (r < 0) {
+            error_report("error reading config file");
+            rados_shutdown(s->cluster);
+            return r;
+        }
+    }
+
+    if (conf[0] != '\0') {
+        r = qemu_rbd_set_conf(s->cluster, conf);
+        if (r < 0) {
+            error_report("error setting config options");
+            rados_shutdown(s->cluster);
+            return r;
+        }
     }
 
     r = rados_connect(s->cluster);
-- 
1.7.2.3

