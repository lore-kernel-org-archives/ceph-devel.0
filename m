From: Sage Weil <sage@newdream.net>
Subject: [PATCH 2/4] rbd: allow escaping in config string
Date: Thu, 15 Sep 2011 14:11:09 -0700
Message-ID: <1316121071-7690-3-git-send-email-sage@newdream.net>
References: <1316121071-7690-1-git-send-email-sage@newdream.net>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1316121071-7690-1-git-send-email-sage@newdream.net>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>
List-Id: ceph-devel.vger.kernel.org

The config string is variously delimited by =, @, and /, depending on the
field.  Allow these characters to be escaped by preceeding them with \.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 block/rbd.c |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index f64b2e0..43f0e63 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -104,8 +104,15 @@ static int qemu_rbd_next_tok(char *dst, int dst_len,
     *p = NULL;
 
     if (delim != '\0') {
-        end = strchr(src, delim);
-        if (end) {
+        for (end = src; *end; ++end) {
+            if (*end == delim) {
+                break;
+            }
+            if (*end == '\\') {
+                end++;
+            }
+        }
+        if (*end == delim) {
             *p = end + 1;
             *end = '\0';
         }
@@ -124,6 +131,19 @@ static int qemu_rbd_next_tok(char *dst, int dst_len,
     return 0;
 }
 
+static void qemu_rbd_unescape(char *src)
+{
+    char *p;
+
+    for (p = src; *src; ++src, ++p) {
+        if (*src == '\\') {
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
@@ -148,6 +168,7 @@ static int qemu_rbd_parsename(const char *filename,
         ret = -EINVAL;
         goto done;
     }
+    qemu_rbd_unescape(pool);
 
     if (strchr(p, '@')) {
         ret = qemu_rbd_next_tok(name, name_len, p, '@', "object name", &p);
@@ -155,9 +176,11 @@ static int qemu_rbd_parsename(const char *filename,
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
@@ -213,6 +236,7 @@ static int qemu_rbd_set_conf(rados_t cluster, const char *conf)
         if (ret < 0) {
             break;
         }
+        qemu_rbd_unescape(name);
 
         if (!p) {
             error_report("conf option %s has no value", name);
@@ -225,6 +249,7 @@ static int qemu_rbd_set_conf(rados_t cluster, const char *conf)
         if (ret < 0) {
             break;
         }
+        qemu_rbd_unescape(value);
 
         if (strcmp(name, "conf") == 0) {
             ret = rados_conf_read_file(cluster, value);
-- 
1.7.2.5
