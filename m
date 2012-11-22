From: Stefan Priebe <s.priebe@profihost.ag>
Subject: [PATCH] overflow of int ret: use ssize_t for ret
Date: Thu, 22 Nov 2012 10:07:55 +0100
Message-ID: <1353575275-1343-1-git-send-email-s.priebe@profihost.ag>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Priebe <s.priebe@profihost.ag>, stefanha@gmail.com, sw@weilnetz.de, josh.durgin@inktank.com, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

When acb->cmd is WRITE or DISCARD block/rbd stores rcb->size into acb->ret

Look here:
   if (acb->cmd == RBD_AIO_WRITE ||
        acb->cmd == RBD_AIO_DISCARD) {
        if (r < 0) {
            acb->ret = r;
            acb->error = 1;
        } else if (!acb->error) {
            acb->ret = rcb->size;
        }

right now acb->ret is just an int and we might get an overflow if size is too big.
For discards rcb->size holds the size of the discard - this might be some TB if you
discard a whole device.

The steps to reproduce are:
mkfs.xfs -f a whole device bigger than int in bytes. mkfs.xfs sends a discard. Important is that you use scsi-hd and set discard_granularity=512. Otherwise rbd disabled discard support.
---
 block/rbd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 5a0f79f..0384c6c 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -69,7 +69,7 @@ typedef enum {
 typedef struct RBDAIOCB {
     BlockDriverAIOCB common;
     QEMUBH *bh;
-    int ret;
+    ssize_t ret;
     QEMUIOVector *qiov;
     char *bounce;
     RBDAIOCmd cmd;
@@ -86,7 +86,7 @@ typedef struct RADOSCB {
     int done;
     int64_t size;
     char *buf;
-    int ret;
+    ssize_t ret;
 } RADOSCB;
 
 #define RBD_FD_READ 0
-- 
1.7.10.4
