From: Sage Weil <sage@newdream.net>
Subject: [PATCH] rbd: allow escaping in config string
Date: Mon, 19 Sep 2011 13:35:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109191334080.7703@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60881 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777Ab1ISU3W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2011 16:29:22 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qemu-devel@nongnu.org, kwolf@redhat.com
Cc: ceph-devel@vger.kernel.org

The config string is variously delimited by =, @, and /, depending on the
field.  Allow these characters to be escaped by preceeding them with \.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 block/rbd.c |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 98efd2c..3068c82 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -102,8 +102,15 @@ static int qemu_rbd_next_tok(char *dst, int dst_len,
     *p = NULL;
 
     if (delim != '\0') {
-        end = strchr(src, delim);
-        if (end) {
+        for (end = src; *end; ++end) {
+            if (*end == delim) {
+                break;
+            }
+            if (*end == '\\' && end[1] != '\0') {
+                end++;
+            }
+        }
+        if (*end == delim) {
             *p = end + 1;
             *end = '\0';
         }
@@ -122,6 +129,19 @@ static int qemu_rbd_next_tok(char *dst, int dst_len,
     return 0;
 }
 
+static void qemu_rbd_unescape(char *src)
+{
+    char *p;
+
+    for (p = src; *src; ++src, ++p) {
+        if (*src == '\\' && src[1] != '\0') {
+            src++;
+        }
+        *p = *src;
+    }
+    *p = '\0';
+}
+
 static int qemu_rbd_parsename(const char *filename,
                               char *pool, int pool_len,
                               char *snap, int snap_len,
@@ -146,6 +166,7 @@ static int qemu_rbd_parsename(const char *filename,
         ret = -EINVAL;
         goto done;
     }
+    qemu_rbd_unescape(pool);
 
     if (strchr(p, '@')) {
         ret = qemu_rbd_next_tok(name, name_len, p, '@', "object name", &p);
@@ -153,9 +174,11 @@ static int qemu_rbd_parsename(const char *filename,
             goto done;
         }
         ret = qemu_rbd_next_tok(snap, snap_len, p, ':', "snap name", &p);
+        qemu_rbd_unescape(snap);
     } else {
         ret = qemu_rbd_next_tok(name, name_len, p, ':', "object name", &p);
     }
+    qemu_rbd_unescape(name);
     if (ret < 0 || !p) {
         goto done;
     }
@@ -211,6 +234,7 @@ static int qemu_rbd_set_conf(rados_t cluster, const char *conf)
         if (ret < 0) {
             break;
         }
+        qemu_rbd_unescape(name);
 
         if (!p) {
             error_report("conf option %s has no value", name);
@@ -223,6 +247,7 @@ static int qemu_rbd_set_conf(rados_t cluster, const char *conf)
         if (ret < 0) {
             break;
         }
+        qemu_rbd_unescape(value);
 
         if (strcmp(name, "conf") == 0) {
             ret = rados_conf_read_file(cluster, value);
-- 
1.7.4.1

