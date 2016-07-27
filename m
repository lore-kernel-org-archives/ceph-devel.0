From: Alexandre Derumier <aderumier@odiso.com>
Subject: [PATCH] rbd : disable
 rbd_cache_writethrough_until_flush for cache=unsafe
Date: Wed, 27 Jul 2016 14:26:42 +0200
Message-ID: <1469622402-8634-1-git-send-email-aderumier@odiso.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: "Qemu-devel" <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
To: qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, ceph-devel@vger.kernel.org, Alexandre Derumier <aderumier@odiso.com>
List-Id: ceph-devel.vger.kernel.org

ceph force writethrough until a flush is detected.
With cache=unsafe, we never send flush.
So we need to tell to ceph
to set rbd_cache_writethrough_until_flush=false in this case.

This speedup a lot qemu-img convert which use cache=unsafe by default

Signed-off-by: Alexandre Derumier <aderumier@odiso.com>
---
 block/rbd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/rbd.c b/block/rbd.c
index 0106fea..f3af6c8 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -552,6 +552,10 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         rados_conf_set(s->cluster, "rbd_cache", "true");
     }
 
+    if (flags & BDRV_O_NO_FLUSH) {
+        rados_conf_set(s->cluster, "rbd_cache_writethrough_until_flush", "false");
+    }
+
     r = rados_connect(s->cluster);
     if (r < 0) {
         error_setg_errno(errp, -r, "error connecting");
-- 
2.1.4
