From: Christian Brunner <chb@muc.de>
Subject: [PATCH 1/1] qemu/rbd: fixes for kevin's comments
Date: Fri, 28 May 2010 22:37:49 +0200
Message-ID: <20100528203749.GA31070@chb-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:16082 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756766Ab0E1Uhy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 May 2010 16:37:54 -0400
Received: by fg-out-1718.google.com with SMTP id d23so586364fga.1
        for <ceph-devel@vger.kernel.org>; Fri, 28 May 2010 13:37:52 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Yehuda,

here are fixes for the comments kevin made after my posting to the qemu/kvm 
list. The only file I haven't changed yet is the rbd_types header.

Regards,
Christian

---
 Makefile    |    3 -
 block/rbd.c |  190 ++++++++++++++++++++++++++++++++---------------------------
 configure   |   10 ++-
 3 files changed, 110 insertions(+), 93 deletions(-)

diff --git a/Makefile b/Makefile
index b96743d..c6c11a5 100644
--- a/Makefile
+++ b/Makefile
@@ -27,9 +27,6 @@ configure: ;
 $(call set-vpath, $(SRC_PATH):$(SRC_PATH)/hw)
 
 LIBS+=-lz $(LIBS_TOOLS)
-ifdef CONFIG_RBD
-LIBS+=-lrados
-endif
 
 ifdef BUILD_DOCS
 DOCS=qemu-doc.html qemu-tech.html qemu.1 qemu-img.1 qemu-nbd.8
diff --git a/block/rbd.c b/block/rbd.c
index c03a930..dbefc5b 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu-common.h"
+#include "qemu-error.h"
 #include <sys/types.h>
 #include <stdbool.h>
 
@@ -66,20 +67,19 @@ typedef struct RADOSCB {
     char *buf;
 } RADOSCB;
 
-typedef struct RBDRVRBDState {
+typedef struct BDRVRBDState {
     rados_pool_t pool;
     char name[RBD_MAX_OBJ_NAME_SIZE];
-    int name_len;
     uint64_t size;
     uint64_t objsize;
-} RBDRVRBDState;
+} BDRVRBDState;
 
 typedef struct rbd_obj_header_ondisk RbdHeader1;
 
 static int rbd_parsename(const char *filename, char *pool, char *name)
 {
     const char *rbdname;
-    char *p, *n;
+    char *p;
     int l;
 
     if (!strstart(filename, "rbd:", &rbdname)) {
@@ -93,19 +93,26 @@ static int rbd_parsename(const char *filename, char *pool, char *name)
     }
 
     *p = '\0';
-    n = ++p;
-
-    l = strlen(n);
+    
+    l = strlen(pool);
+    if(l >= RBD_MAX_SEG_NAME_SIZE) {
+        error_report("pool name to long");
+        return -EINVAL;
+    } else if (l <= 0) {
+        error_report("pool name to short");
+        return -EINVAL;
+    }
 
-    if (l > RBD_MAX_OBJ_NAME_SIZE) {
-        fprintf(stderr, "object name to long\n");
+    l = strlen(++p);
+    if (l >= RBD_MAX_OBJ_NAME_SIZE) {
+        error_report("object name to long");
         return -EINVAL;
     } else if (l <= 0) {
-        fprintf(stderr, "object name to short\n");
+        error_report("object name to short");
         return -EINVAL;
     }
 
-    strcpy(name, n);
+    strcpy(name, p);
 
     return l;
 }
@@ -113,13 +120,11 @@ static int rbd_parsename(const char *filename, char *pool, char *name)
 static int create_tmap_op(uint8_t op, const char *name, char **tmap_desc)
 {
     uint32_t len = strlen(name);
-    uint32_t total_len = 1 + (sizeof(uint32_t) + len) + sizeof(uint32_t);       /* encoding op + name + empty buffer */
-    char *desc;
+    /* total_len = encoding op + name + empty buffer */
+    uint32_t total_len = 1 + (sizeof(uint32_t) + len) + sizeof(uint32_t);
+    char *desc = NULL;
 
-    desc = qemu_malloc(total_len);
-    if (!desc) {
-        return -ENOMEM;
-    }
+    qemu_malloc(total_len);
 
     *tmap_desc = desc;
 
@@ -170,10 +175,9 @@ static int rbd_create(const char *filename, QEMUOptionParameter *options)
     char name[RBD_MAX_SEG_NAME_SIZE];
     RbdHeader1 header;
     rados_pool_t p;
-    int name_len;
     int ret;
 
-    if ((name_len = rbd_parsename(filename, pool, name)) < 0) {
+    if (rbd_parsename(filename, pool, name) < 0) {
         return -EINVAL;
     }
 
@@ -186,18 +190,19 @@ static int rbd_create(const char *filename, QEMUOptionParameter *options)
         } else if (!strcmp(options->name, BLOCK_OPT_CLUSTER_SIZE)) {
             if (options->value.n) {
                 objsize = options->value.n;
-                if (!objsize || ((objsize - 1) & objsize)) {    /* not a power of 2? */
-                    fprintf(stderr, "obj size needs to be power of 2\n");
+                if ((objsize - 1) & objsize) {    /* not a power of 2? */
+                    error_report("obj size needs to be power of 2");
                     return -EINVAL;
                 }
                 if (objsize < 4096) {
-                    fprintf(stderr, "obj size too small\n");
+                    error_report("obj size too small");
                     return -EINVAL;
                 }
 
                 for (obj_order = 0; obj_order < 64; obj_order++) {
-                    if (objsize == 1)
+                    if (objsize == 1) {
                         break;
+                    }
                     objsize >>= 1;
                 }
             }
@@ -219,12 +224,13 @@ static int rbd_create(const char *filename, QEMUOptionParameter *options)
     cpu_to_le32s(&header.snap_count);
 
     if (rados_initialize(0, NULL) < 0) {
-        fprintf(stderr, "error initializing\n");
+        error_report("error initializing");
         return -EIO;
     }
 
     if (rados_open_pool(pool, &p)) {
-        fprintf(stderr, "error opening pool %s\n", pool);
+        error_report("error opening pool %s", pool);
+        rados_deinitialize();
         return -EIO;
     }
 
@@ -251,53 +257,63 @@ done:
 
 static int rbd_open(BlockDriverState *bs, const char *filename, int flags)
 {
-    RBDRVRBDState *s = bs->opaque;
+    BDRVRBDState *s = bs->opaque;
     char pool[RBD_MAX_SEG_NAME_SIZE];
     char n[RBD_MAX_SEG_NAME_SIZE];
     char hbuf[4096];
+    int r;
 
-    if ((s->name_len = rbd_parsename(filename, pool, s->name)) < 0) {
+    if (rbd_parsename(filename, pool, s->name) < 0) {
         return -EINVAL;
     }
     snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", s->name, RBD_SUFFIX);
 
-    if (rados_initialize(0, NULL) < 0) {
-        fprintf(stderr, "error initializing\n");
-        return -EIO;
+    if ((r = rados_initialize(0, NULL)) < 0) {
+        error_report("error initializing");
+        return r;
     }
 
-    if (rados_open_pool(pool, &s->pool)) {
-        fprintf(stderr, "error opening pool %s\n", pool);
-        return -EIO;
+    if ((r = rados_open_pool(pool, &s->pool))) {
+        error_report("error opening pool %s", pool);
+        rados_deinitialize();
+        return r;
     }
 
-    if (rados_read(s->pool, n, 0, hbuf, 4096) < 0) {
-        fprintf(stderr, "error reading header from %s\n", s->name);
-        return -EIO;
+    if ((r = rados_read(s->pool, n, 0, hbuf, 4096)) < 0) {
+        error_report("error reading header from %s", s->name);
+        goto failed;
     }
-    if (!strncmp(hbuf + 64, rbd_signature, 4)) {
-        if (!strncmp(hbuf + 68, rbd_version, 8)) {
-            RbdHeader1 *header;
-
-            header = (RbdHeader1 *) hbuf;
-            le64_to_cpus((uint64_t *) & header->image_size);
-            s->size = header->image_size;
-            s->objsize = 1 << header->options.order;
-        } else {
-            fprintf(stderr, "Unknown image version %s\n", hbuf + 68);
-            return -EIO;
-        }
-    } else {
-        fprintf(stderr, "Invalid header signature %s\n", hbuf + 64);
-        return -EIO;
+
+    if (strncmp(hbuf + 64, rbd_signature, 4)) {
+        error_report("Invalid header signature %s", hbuf + 64);
+        r = -EMEDIUMTYPE;
+        goto failed;
+    }
+
+    if (strncmp(hbuf + 68, rbd_version, 8)) {
+        error_report("Unknown image version %s", hbuf + 68);
+        r = -EMEDIUMTYPE;
+        goto failed;
     }
 
+    RbdHeader1 *header;
+
+    header = (RbdHeader1 *) hbuf;
+    le64_to_cpus((uint64_t *) & header->image_size);
+    s->size = header->image_size;
+    s->objsize = 1 << header->options.order;
+
     return 0;
+
+failed:
+    rados_close_pool(s->pool);
+    rados_deinitialize();
+    return r;
 }
 
 static void rbd_close(BlockDriverState *bs)
 {
-    RBDRVRBDState *s = bs->opaque;
+    BDRVRBDState *s = bs->opaque;
 
     rados_close_pool(s->pool);
     rados_deinitialize();
@@ -306,25 +322,24 @@ static void rbd_close(BlockDriverState *bs)
 static int rbd_rw(BlockDriverState *bs, int64_t sector_num,
                   uint8_t *buf, int nb_sectors, int write)
 {
-    RBDRVRBDState *s = bs->opaque;
+    BDRVRBDState *s = bs->opaque;
     char n[RBD_MAX_SEG_NAME_SIZE];
 
     int64_t segnr, segoffs, segsize, r;
     int64_t off, size;
 
-    off = sector_num * 512;
-    size = nb_sectors * 512;
-    segnr = (int64_t) (off / s->objsize);
-    segoffs = (int64_t) (off % s->objsize);
-    segsize = (int64_t) (s->objsize - segoffs);
+    off = sector_num * BDRV_SECTOR_SIZE;
+    size = nb_sectors * BDRV_SECTOR_SIZE;
+    segnr = off / s->objsize;
+    segoffs = off % s->objsize;
+    segsize = s->objsize - segoffs;
 
     while (size > 0) {
         if (size < segsize) {
             segsize = size;
         }
 
-        snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012llx", s->name,
-                 (long long unsigned int)segnr);
+        snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012" PRIx64, s->name, segnr);
 
         if (write) {
             if ((r = rados_write(s->pool, n, segoffs, (const char *)buf,
@@ -336,11 +351,10 @@ static int rbd_rw(BlockDriverState *bs, int64_t sector_num,
             if (r == -ENOENT) {
                 memset(buf, 0, segsize);
             } else if (r < 0) {
-                return(r);
+                return r;
             } else if (r < segsize) {
                 memset(buf + r, 0, segsize - r);
             }
-            r = segsize;
         }
 
         buf += segsize;
@@ -350,7 +364,7 @@ static int rbd_rw(BlockDriverState *bs, int64_t sector_num,
         segnr++;
     }
 
-    return (0);
+    return 0;
 }
 
 static int rbd_read(BlockDriverState *bs, int64_t sector_num,
@@ -450,7 +464,7 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState *bs,
     int64_t off, size;
     char *buf;
 
-    RBDRVRBDState *s = bs->opaque;
+    BDRVRBDState *s = bs->opaque;
 
     acb = qemu_aio_get(&rbd_aio_pool, bs, cb, opaque);
     acb->write = write;
@@ -470,11 +484,11 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState *bs,
 
     buf = acb->bounce;
 
-    off = sector_num * 512;
-    size = nb_sectors * 512;
-    segnr = (int64_t) (off / s->objsize);
-    segoffs = (int64_t) (off % s->objsize);
-    segsize = (int64_t) (s->objsize - segoffs);
+    off = sector_num * BDRV_SECTOR_SIZE;
+    size = nb_sectors * BDRV_SECTOR_SIZE;
+    segnr = off / s->objsize;
+    segoffs = off % s->objsize;
+    segsize = s->objsize - segoffs;
 
     last_segnr = ((off + size - 1) / s->objsize);
     acb->aiocnt = (last_segnr - segnr) + 1;
@@ -495,10 +509,12 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState *bs,
 
         if (write) {
             rados_aio_create_completion(rcb, NULL,
-                                        (rados_callback_t) rbd_finish_aiocb, &c);
+                                        (rados_callback_t) rbd_finish_aiocb,
+                                        &c);
             rados_aio_write(s->pool, n, segoffs, buf, segsize, c);
         } else {
-            rados_aio_create_completion(rcb, (rados_callback_t) rbd_finish_aiocb,
+            rados_aio_create_completion(rcb, 
+                                        (rados_callback_t) rbd_finish_aiocb,
                                         NULL, &c);
             rados_aio_read(s->pool, n, segoffs, buf, segsize, c);
         }
@@ -533,14 +549,14 @@ static BlockDriverAIOCB *rbd_aio_writev(BlockDriverState * bs,
 
 static int rbd_getinfo(BlockDriverState * bs, BlockDriverInfo * bdi)
 {
-    RBDRVRBDState *s = bs->opaque;
+    BDRVRBDState *s = bs->opaque;
     bdi->cluster_size = s->objsize;
     return 0;
 }
 
 static int64_t rbd_getlength(BlockDriverState * bs)
 {
-    RBDRVRBDState *s = bs->opaque;
+    BDRVRBDState *s = bs->opaque;
 
     return s->size;
 }
@@ -560,20 +576,20 @@ static QEMUOptionParameter rbd_create_options[] = {
 };
 
 static BlockDriver bdrv_rbd = {
-    .format_name = "rbd",
-    .instance_size = sizeof(RBDRVRBDState),
-    .bdrv_open = rbd_open,
-    .bdrv_read = rbd_read,
-    .bdrv_write = rbd_write,
-    .bdrv_close = rbd_close,
-    .bdrv_create = rbd_create,
-    .bdrv_get_info = rbd_getinfo,
-    .create_options = rbd_create_options,
-    .bdrv_getlength = rbd_getlength,
-    .protocol_name = "rbd",
-
-    .bdrv_aio_readv = rbd_aio_readv,
-    .bdrv_aio_writev = rbd_aio_writev,
+    .format_name        = "rbd",
+    .instance_size      = sizeof(BDRVRBDState),
+    .bdrv_open          = rbd_open,
+    .bdrv_read          = rbd_read,
+    .bdrv_write         = rbd_write,
+    .bdrv_close         = rbd_close,
+    .bdrv_create        = rbd_create,
+    .bdrv_get_info      = rbd_getinfo,
+    .create_options     = rbd_create_options,
+    .bdrv_getlength     = rbd_getlength,
+    .protocol_name      = "rbd",
+
+    .bdrv_aio_readv     = rbd_aio_readv,
+    .bdrv_aio_writev    = rbd_aio_writev,
 };
 
 static void bdrv_rbd_init(void)
diff --git a/configure b/configure
index 29e75d2..b437680 100755
--- a/configure
+++ b/configure
@@ -314,7 +314,7 @@ kvm_kmod="no"
 check_utests="no"
 user_pie="no"
 zero_malloc=""
-rbd="no"
+rbd=""
 
 # OS specific
 if check_define __linux__ ; then
@@ -695,6 +695,8 @@ for opt do
   ;;
   --enable-vhost-net) vhost_net="yes"
   ;;
+  --disable-rbd) rbd="no"
+  ;;
   --enable-rbd) rbd="yes"
   ;;
   *) echo "ERROR: unknown option $opt"; show_help="yes"
@@ -1703,9 +1705,11 @@ if test "$rbd" != "no" ; then
 #include <rados/librados.h>
 int main(void) { rados_initialize(0, NULL); return 0; }
 EOF
-  if compile_prog "" "-lrados -lcrypto" ; then
+  rbd_libs="-lrados -lcrypto"
+  if compile_prog "" "$rbd_libs" ; then
     rbd=yes
-    LIBS="$LIBS -lrados -lcrypto"
+    libs_tools="$rbd_libs $libs_tools"
+    libs_softmmu="$rbd_libs $libs_softmmu"
   else
     if test "$rbd" = "yes" ; then
       feature_not_found "rados block device"
-- 
1.7.0.4

