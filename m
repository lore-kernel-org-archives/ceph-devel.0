From: Sage Weil <sage@newdream.net>
Subject: [PATCH 1/4] rbd: ignore failures when reading from
	default conf location
Date: Thu, 15 Sep 2011 14:11:08 -0700
Message-ID: <1316121071-7690-2-git-send-email-sage@newdream.net>
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

If we are reading from the default config location, ignore any failures.
It is perfectly legal for the user to specify exactly the options they need
and to not rely on any config file.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 block/rbd.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 1b78d51..f64b2e0 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -298,11 +298,8 @@ static int qemu_rbd_create(const char *filename, QEMUOptionParameter *options)
     }
 
     if (strstr(conf, "conf=") == NULL) {
-        if (rados_conf_read_file(cluster, NULL) < 0) {
-            error_report("error reading config file");
-            rados_shutdown(cluster);
-            return -EIO;
-        }
+        /* try default location, but ignore failure */
+        rados_conf_read_file(cluster, NULL);
     }
 
     if (conf[0] != '\0' &&
@@ -441,11 +438,8 @@ static int qemu_rbd_open(BlockDriverState *bs, const char *filename, int flags)
     }
 
     if (strstr(conf, "conf=") == NULL) {
-        r = rados_conf_read_file(s->cluster, NULL);
-        if (r < 0) {
-            error_report("error reading config file");
-            goto failed_shutdown;
-        }
+        /* try default location, but ignore failure */
+        rados_conf_read_file(s->cluster, NULL);
     }
 
     if (conf[0] != '\0') {
-- 
1.7.2.5
