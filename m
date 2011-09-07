From: Sage Weil <sage@newdream.net>
Subject: [PATCH 3/3] rbd: fix leak in qemu_rbd_open failure paths
Date: Wed,  7 Sep 2011 09:28:06 -0700
Message-ID: <1315412886-21092-3-git-send-email-sage@newdream.net>
References: <1315412886-21092-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38879 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab1IGQz4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Sep 2011 12:55:56 -0400
In-Reply-To: <1315412886-21092-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qemu-devel@nongnu.org, kwolf@redhat.com
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

Fix leak of s->snap in failure path.  Simplify error paths for the whole
function.

Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Sage Weil <sage@newdream.net>
---
 block/rbd.c |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 2763092..1b78d51 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -427,10 +427,6 @@ static int qemu_rbd_open(BlockDriverState *bs, const char *filename, int flags)
                            conf, sizeof(conf)) < 0) {
         return -EINVAL;
     }
-    s->snap = NULL;
-    if (snap_buf[0] != '\0') {
-        s->snap = g_strdup(snap_buf);
-    }
 
     clientname = qemu_rbd_parse_clientname(conf, clientname_buf);
     r = rados_create(&s->cluster, clientname);
@@ -439,12 +435,16 @@ static int qemu_rbd_open(BlockDriverState *bs, const char *filename, int flags)
         return r;
     }
 
+    s->snap = NULL;
+    if (snap_buf[0] != '\0') {
+        s->snap = g_strdup(snap_buf);
+    }
+
     if (strstr(conf, "conf=") == NULL) {
         r = rados_conf_read_file(s->cluster, NULL);
         if (r < 0) {
             error_report("error reading config file");
-            rados_shutdown(s->cluster);
-            return r;
+            goto failed_shutdown;
         }
     }
 
@@ -452,31 +452,26 @@ static int qemu_rbd_open(BlockDriverState *bs, const char *filename, int flags)
         r = qemu_rbd_set_conf(s->cluster, conf);
         if (r < 0) {
             error_report("error setting config options");
-            rados_shutdown(s->cluster);
-            return r;
+            goto failed_shutdown;
         }
     }
 
     r = rados_connect(s->cluster);
     if (r < 0) {
         error_report("error connecting");
-        rados_shutdown(s->cluster);
-        return r;
+        goto failed_shutdown;
     }
 
     r = rados_ioctx_create(s->cluster, pool, &s->io_ctx);
     if (r < 0) {
         error_report("error opening pool %s", pool);
-        rados_shutdown(s->cluster);
-        return r;
+        goto failed_shutdown;
     }
 
     r = rbd_open(s->io_ctx, s->name, &s->image, s->snap);
     if (r < 0) {
         error_report("error reading header from %s", s->name);
-        rados_ioctx_destroy(s->io_ctx);
-        rados_shutdown(s->cluster);
-        return r;
+        goto failed_open;
     }
 
     bs->read_only = (s->snap != NULL);
@@ -497,8 +492,11 @@ static int qemu_rbd_open(BlockDriverState *bs, const char *filename, int flags)
 
 failed:
     rbd_close(s->image);
+failed_open:
     rados_ioctx_destroy(s->io_ctx);
+failed_shutdown:
     rados_shutdown(s->cluster);
+    g_free(s->snap);
     return r;
 }
 
-- 
1.7.2.5

