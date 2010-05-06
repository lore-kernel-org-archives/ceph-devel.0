From: Christian Brunner <chb@muc.de>
Subject: [PATCH 2/2] qemu-kvm/rbd: avoid code duplication
Date: Thu, 6 May 2010 22:54:39 +0200
Message-ID: <20100506205439.GA57863@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncolin.muc.de ([193.149.48.11]:53065 "EHLO ncolin.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456Ab0EFUyl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 May 2010 16:54:41 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Combine rbd_write and rbd_read into rbd_rw to make the driver even
smaller. - No functional changes.

Christian
---
 block/rbd.c |   68 ++++++++++++++++++++--------------------------------------
 1 files changed, 24 insertions(+), 44 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index dfd2eca..3ebf285 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -294,14 +294,13 @@ static void rbd_close(BlockDriverState * bs)
     rados_deinitialize();
 }
 
-static int
-rbd_write(BlockDriverState * bs, int64_t sector_num,
-          const uint8_t * buf, int nb_sectors)
+static int rbd_rw(BlockDriverState *bs, int64_t sector_num,
+                  uint8_t *buf, int nb_sectors, int write)
 {
     RBDRVRBDState *s = bs->opaque;
     char n[RBD_MAX_SEG_NAME_SIZE];
 
-    int64_t segnr, segoffs, segsize;
+    int64_t segnr, segoffs, segsize, r;
     int64_t off, size;
 
     off = sector_num * 512;
@@ -318,9 +317,19 @@ rbd_write(BlockDriverState * bs, int64_t sector_num,
         snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012llx", s->name,
                  (long long unsigned int)segnr);
 
-        if (rados_write(s->pool, n, segoffs, (const char *)buf, segsize)
-            < 0) {
-            return -errno;
+        if (write) {
+            if (rados_write(s->pool, n, segoffs, (const char *)buf, 
+                segsize) < 0) {
+                return -errno;
+            }
+        } else {
+            r = rados_read(s->pool, n, segoffs, (char *)buf, segsize);
+            if (r < 0) {
+                memset(buf, 0, segsize);
+            } else if (r < segsize) {
+                memset(buf + r, 0, segsize - r);
+            }
+            r = segsize;
         }
 
         buf += segsize;
@@ -333,45 +342,16 @@ rbd_write(BlockDriverState * bs, int64_t sector_num,
     return (0);
 }
 
-static int
-rbd_read(BlockDriverState * bs, int64_t sector_num,
-         uint8_t * buf, int nb_sectors)
+static int rbd_read(BlockDriverState *bs, int64_t sector_num,
+                    uint8_t * buf, int nb_sectors)
 {
-    RBDRVRBDState *s = bs->opaque;
-    char n[RBD_MAX_SEG_NAME_SIZE];
-
-    int64_t segnr, segoffs, segsize, r;
-    int64_t off, size;
-
-    off = sector_num * 512;
-    size = nb_sectors * 512;
-    segnr = (int64_t) (off / s->objsize);
-    segoffs = (int64_t) (off % s->objsize);
-    segsize = (int64_t) (s->objsize - segoffs);
-
-    while (size > 0) {
-        if (size < segsize) {
-            segsize = size;
-        }
-
-        snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012llx", s->name,
-                 (long long unsigned int)segnr);
-
-        r = rados_read(s->pool, n, segoffs, (char *)buf, segsize);
-        if (r < 0) {
-            memset(buf, 0, segsize);
-        } else if (r < segsize) {
-            memset(buf + r, 0, segsize - r);
-        }
-
-        buf += segsize;
-        size -= segsize;
-        segoffs = 0;
-        segsize = s->objsize;
-        segnr++;
-    }
+    return rbd_rw(bs, sector_num, buf, nb_sectors, 0);
+}
 
-    return (0);
+static int rbd_write(BlockDriverState *bs, int64_t sector_num,
+                     const uint8_t *buf, int nb_sectors)
+{
+    return rbd_rw(bs, sector_num, (uint8_t *) buf, nb_sectors, 1);
 }
 
 static void rbd_aio_cancel(BlockDriverAIOCB * blockacb)
-- 
1.6.6.1


-- 
Christian Brunner                              MUC.DE e.V.
                                               Joseph-Dollinger-Bogen 14
                                               D-80807 Muenchen
