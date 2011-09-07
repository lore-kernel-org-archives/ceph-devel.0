From: Sage Weil <sage@newdream.net>
Subject: [PATCH 1/3] rbd: allow client id to be specified in config string
Date: Wed,  7 Sep 2011 09:28:04 -0700
Message-ID: <1315412886-21092-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38880 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab1IGQz6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Sep 2011 12:55:58 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qemu-devel@nongnu.org, kwolf@redhat.com
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

Allow the client id to be specified in the config string via 'id=' so that
users can control who they authenticate as.  Currently they are stuck with
the default ('admin').  This is necessary for anyone using authentication
in their environment.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 block/rbd.c |   52 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index ce0f6ef..6135fc1 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -169,6 +169,34 @@ done:
     return ret;
 }
 
+static char *qemu_rbd_parse_clientname(const char *conf, char *clientname)
+{
+    const char *p = conf;
+
+    while (*p) {
+        int len;
+        const char *end = strchr(p, ':');
+
+        if (end) {
+            len = end - p;
+        } else {
+            len = strlen(p);
+        }
+
+        if (strncmp(p, "id=", 3) == 0) {
+            len -= 3;
+            strncpy(clientname, p + 3, len);
+            clientname[len] = '\0';
+            return clientname;
+        }
+        if (end == NULL) {
+            break;
+        }
+        p = end + 1;
+    }
+    return NULL;
+}
+
 static int qemu_rbd_set_conf(rados_t cluster, const char *conf)
 {
     char *p, *buf;
@@ -198,17 +226,19 @@ static int qemu_rbd_set_conf(rados_t cluster, const char *conf)
             break;
         }
 
-        if (strcmp(name, "conf")) {
-            ret = rados_conf_set(cluster, name, value);
+        if (strcmp(name, "conf") == 0) {
+            ret = rados_conf_read_file(cluster, value);
             if (ret < 0) {
-                error_report("invalid conf option %s", name);
-                ret = -EINVAL;
+                error_report("error reading conf file %s", value);
                 break;
             }
+        } else if (strcmp(name, "id") == 0) {
+            /* ignore, this is parsed by qemu_rbd_parse_clientname() */
         } else {
-            ret = rados_conf_read_file(cluster, value);
+            ret = rados_conf_set(cluster, name, value);
             if (ret < 0) {
-                error_report("error reading conf file %s", value);
+                error_report("invalid conf option %s", name);
+                ret = -EINVAL;
                 break;
             }
         }
@@ -227,6 +257,8 @@ static int qemu_rbd_create(const char *filename, QEMUOptionParameter *options)
     char name[RBD_MAX_IMAGE_NAME_SIZE];
     char snap_buf[RBD_MAX_SNAP_NAME_SIZE];
     char conf[RBD_MAX_CONF_SIZE];
+    char clientname_buf[RBD_MAX_CONF_SIZE];
+    char *clientname;
     rados_t cluster;
     rados_ioctx_t io_ctx;
     int ret;
@@ -259,7 +291,8 @@ static int qemu_rbd_create(const char *filename, QEMUOptionParameter *options)
         options++;
     }
 
-    if (rados_create(&cluster, NULL) < 0) {
+    clientname = qemu_rbd_parse_clientname(conf, clientname_buf);
+    if (rados_create(&cluster, clientname) < 0) {
         error_report("error initializing");
         return -EIO;
     }
@@ -385,6 +418,8 @@ static int qemu_rbd_open(BlockDriverState *bs, const char *filename, int flags)
     char pool[RBD_MAX_POOL_NAME_SIZE];
     char snap_buf[RBD_MAX_SNAP_NAME_SIZE];
     char conf[RBD_MAX_CONF_SIZE];
+    char clientname_buf[RBD_MAX_CONF_SIZE];
+    char *clientname;
     int r;
 
     if (qemu_rbd_parsename(filename, pool, sizeof(pool),
@@ -398,7 +433,8 @@ static int qemu_rbd_open(BlockDriverState *bs, const char *filename, int flags)
         s->snap = g_strdup(snap_buf);
     }
 
-    r = rados_create(&s->cluster, NULL);
+    clientname = qemu_rbd_parse_clientname(conf, clientname_buf);
+    r = rados_create(&s->cluster, clientname);
     if (r < 0) {
         error_report("error initializing");
         return r;
-- 
1.7.2.5

