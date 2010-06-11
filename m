From: Simone Gotti <simone.gotti@gmail.com>
Subject: Re: [PATCH] ceph/rbd block driver for qemu-kvm (v3)
Date: Fri, 11 Jun 2010 21:51:19 +0200
Message-ID: <4C1293B7.1060307@gmail.com>
References: <20100531193140.GA13993@chb-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:42806 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324Ab0FKTvY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jun 2010 15:51:24 -0400
In-Reply-To: <20100531193140.GA13993@chb-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: Kevin Wolf <kwolf@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

Hi Christian,

thanks for you patch. I tried it a little and it worked quite well but
during some live migration tests I noticed a problem.


The problem is related to live migration with high I/O using the AIO
calls (I triggered it with a simple "dd").

If you launch a live migration and the guest is stopped and started on
the new qemu process while some AIO was in flight the guest on the new
qemu will wait undefinitely for data this will never come. With ata
emulation an ata reset is sent after some seconds but with virtio this
won't happen.

I'm not a qemu expert but from what I understand qemu in
savevm.c:do_savevm calls qemu_aio_flush to wait that all the asyncronous
aio returned (the callback si called). But the rbd block driver doesn't
use the qemu aio model but the rados one so that function will never
know of the rados aio.

So a solution will be to glue the block driver with the qemu aio model.
I tried to do this to test if this will work in the attached patch. I
only tested with one rbd block device but the live migration tests
worked (in the patch I removed all the debug prints I adedd to see if
all AIO requets really returned.

This is an RFC just to know what you think about this possible solution.
As qemu's aio model is event based and it needs a file descriptor for
event communication i used eventfd to do this.
Let me know if you need a detailed description of the patch!


I've also got a question: as librados is multithreaded the callbacks are
called in another thread. Is there the need to protect some critical
sections with a lock (for example in rbd_aio_rw_vector and in
rbd_finish_aiocb)?


Thanks!

Bye!


From: Simone Gotti <simone.gotti@gmail.com>
Date: Fri, 11 Jun 2010 21:19:39 +0200
Subject: [PATCH] block/rbd: Added glue to qemu aio model to fix live
migration with outstanding aio

Signed-off-by: Simone Gotti <simone.gotti@gmail.com>


---
 block/rbd.c |   63
+++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 4d22069..83b7898 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -25,6 +25,8 @@
 
 #include <signal.h>
 
+#include <sys/eventfd.h>
+
 /*
  * When specifying the image filename use:
  *
@@ -47,6 +49,15 @@
 
 #define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
 
+typedef struct BDRVRBDState {
+    int efd;
+    rados_pool_t pool;
+    char name[RBD_MAX_OBJ_NAME_SIZE];
+    uint64_t size;
+    uint64_t objsize;
+    int qemu_aio_count;
+} BDRVRBDState;
+
 typedef struct RBDAIOCB {
     BlockDriverAIOCB common;
     QEMUBH *bh;
@@ -57,6 +68,7 @@ typedef struct RBDAIOCB {
     int64_t sector_num;
     int aiocnt;
     int error;
+    BDRVRBDState *s;
 } RBDAIOCB;
 
 typedef struct RADOSCB {
@@ -67,12 +79,6 @@ typedef struct RADOSCB {
     char *buf;
 } RADOSCB;
 
-typedef struct BDRVRBDState {
-    rados_pool_t pool;
-    char name[RBD_MAX_OBJ_NAME_SIZE];
-    uint64_t size;
-    uint64_t objsize;
-} BDRVRBDState;
 
 typedef struct rbd_obj_header_ondisk RbdHeader1;
 
@@ -255,6 +261,31 @@ done:
     return ret;
 }
 
+static void rbd_aio_completion_cb(void *opaque)
+{
+    BDRVRBDState *s = opaque;
+
+    uint64_t val;
+    ssize_t ret;
+
+    do {
+        if ((ret = read(s->efd, &val, sizeof(val))) > 0) {
+            s->qemu_aio_count -= val;
+       }
+    } while (ret == -1 && errno == EINTR);
+
+    return;
+}
+
+static int rbd_aio_flush_cb(void *opaque)
+{
+    BDRVRBDState *s = opaque;
+
+    return (s->qemu_aio_count > 0) ? 1 : 0;
+}
+
+
+
 static int rbd_open(BlockDriverState *bs, const char *filename, int flags)
 {
     BDRVRBDState *s = bs->opaque;
@@ -303,6 +334,15 @@ static int rbd_open(BlockDriverState *bs, const
char *filename, int flags)
     s->size = header->image_size;
     s->objsize = 1 << header->options.order;
 
+    s->efd = eventfd(0, 0);
+    if (s->efd == -1) {
+        error_report("error opening eventfd");
+        goto failed;
+    }
+    fcntl(s->efd, F_SETFL, O_NONBLOCK);
+    qemu_aio_set_fd_handler(s->efd, rbd_aio_completion_cb, NULL,
+        rbd_aio_flush_cb, NULL, s);
+
     return 0;
 
 failed:
@@ -393,6 +433,7 @@ static AIOPool rbd_aio_pool = {
 };
 
 /* This is the callback function for rados_aio_read and _write */
+
 static void rbd_finish_aiocb(rados_completion_t c, RADOSCB *rcb)
 {
     RBDAIOCB *acb = rcb->acb;
@@ -427,6 +468,8 @@ static void rbd_finish_aiocb(rados_completion_t c,
RADOSCB *rcb)
             acb->ret += r;
         }
     }
+    uint64_t buf = 1;
+    write(acb->s->efd, &buf, sizeof(buf));
     qemu_free(rcb);
     i = 0;
     if (!acb->aiocnt && acb->bh) {
@@ -435,6 +478,7 @@ static void rbd_finish_aiocb(rados_completion_t c,
RADOSCB *rcb)
 }
 
 /* Callback when all queued rados_aio requests are complete */
+
 static void rbd_aio_bh_cb(void *opaque)
 {
     RBDAIOCB *acb = opaque;
@@ -446,6 +490,10 @@ static void rbd_aio_bh_cb(void *opaque)
     acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->ret));
     qemu_bh_delete(acb->bh);
     acb->bh = NULL;
+
+    uint64_t buf = 1;
+    write(acb->s->efd, &buf, sizeof(buf));
+
     qemu_aio_release(acb);
 }
 
@@ -473,6 +521,7 @@ static BlockDriverAIOCB
*rbd_aio_rw_vector(BlockDriverState *bs,
     acb->aiocnt = 0;
     acb->ret = 0;
     acb->error = 0;
+    acb->s = s;
 
     if (!acb->bh) {
         acb->bh = qemu_bh_new(rbd_aio_bh_cb, acb);
@@ -493,6 +542,8 @@ static BlockDriverAIOCB
*rbd_aio_rw_vector(BlockDriverState *bs,
     last_segnr = ((off + size - 1) / s->objsize);
     acb->aiocnt = (last_segnr - segnr) + 1;
 
+    s->qemu_aio_count+=acb->aiocnt + 1; /* All the RADOSCB and the
related RBDAIOCB */
+
     while (size > 0) {
         if (size < segsize) {
             segsize = size;
-- 
1.7.0.1




 

On 05/31/2010 09:31 PM, Christian Brunner wrote:
> Hi Kevin,
>
> here is an updated patch for the ceph/rbd driver. I hope that everything 
> is fine now.
>
> Regards,
> Christian
>
>
> This is a block driver for the distributed file system Ceph
> (http://ceph.newdream.net/). This driver uses librados (which
> is part of the Ceph server) for direct access to the Ceph object
> store and is running entirely in userspace. Therefore it is
> called "rbd" - rados block device.
>
> To compile the driver a recent version of ceph (unstable/testing git
> head or 0.20.3 once it is released) is needed.
>
> Additional information is available on the Ceph-Wiki:
>
> http://ceph.newdream.net/wiki/Kvm-rbd
>
> The patch is based on git://repo.or.cz/qemu/kevin.git block
>
>
> Signed-off-by: Christian Brunner <chb@muc.de>
> ---
>  Makefile.objs     |    1 +
>  block/rbd.c       |  600 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  block/rbd_types.h |   64 ++++++
>  configure         |   31 +++
>  4 files changed, 696 insertions(+), 0 deletions(-)
>  create mode 100644 block/rbd.c
>  create mode 100644 block/rbd_types.h
>
> diff --git a/Makefile.objs b/Makefile.objs
> index 1a942e5..08dc11f 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -18,6 +18,7 @@ block-nested-y += parallels.o nbd.o blkdebug.o
>  block-nested-$(CONFIG_WIN32) += raw-win32.o
>  block-nested-$(CONFIG_POSIX) += raw-posix.o
>  block-nested-$(CONFIG_CURL) += curl.o
> +block-nested-$(CONFIG_RBD) += rbd.o
>  
>  block-obj-y +=  $(addprefix block/, $(block-nested-y))
>  
> diff --git a/block/rbd.c b/block/rbd.c
> new file mode 100644
> index 0000000..4a60dda
> --- /dev/null
> +++ b/block/rbd.c
> @@ -0,0 +1,600 @@
> +/*
> + * QEMU Block driver for RADOS (Ceph)
> + *
> + * Copyright (C) 2010 Christian Brunner <chb@muc.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu-common.h"
> +#include "qemu-error.h"
> +#include <sys/types.h>
> +#include <stdbool.h>
> +
> +#include <qemu-common.h>
> +
> +#include "rbd_types.h"
> +#include "module.h"
> +#include "block_int.h"
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <rados/librados.h>
> +
> +#include <signal.h>
> +
> +/*
> + * When specifying the image filename use:
> + *
> + * rbd:poolname/devicename
> + *
> + * poolname must be the name of an existing rados pool
> + *
> + * devicename is the basename for all objects used to
> + * emulate the raw device.
> + *
> + * Metadata information (image size, ...) is stored in an
> + * object with the name "devicename.rbd".
> + *
> + * The raw device is split into 4MB sized objects by default.
> + * The sequencenumber is encoded in a 12 byte long hex-string,
> + * and is attached to the devicename, separated by a dot.
> + * e.g. "devicename.1234567890ab"
> + *
> + */
> +
> +#define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
> +
> +typedef struct RBDAIOCB {
> +    BlockDriverAIOCB common;
> +    QEMUBH *bh;
> +    int ret;
> +    QEMUIOVector *qiov;
> +    char *bounce;
> +    int write;
> +    int64_t sector_num;
> +    int aiocnt;
> +    int error;
> +} RBDAIOCB;
> +
> +typedef struct RADOSCB {
> +    int rcbid;
> +    RBDAIOCB *acb;
> +    int done;
> +    int64_t segsize;
> +    char *buf;
> +} RADOSCB;
> +
> +typedef struct BDRVRBDState {
> +    rados_pool_t pool;
> +    char name[RBD_MAX_OBJ_NAME_SIZE];
> +    uint64_t size;
> +    uint64_t objsize;
> +} BDRVRBDState;
> +
> +typedef struct rbd_obj_header_ondisk RbdHeader1;
> +
> +static int rbd_parsename(const char *filename, char *pool, char *name)
> +{
> +    const char *rbdname;
> +    char *p;
> +    int l;
> +
> +    if (!strstart(filename, "rbd:", &rbdname)) {
> +        return -EINVAL;
> +    }
> +
> +    pstrcpy(pool, 2 * RBD_MAX_SEG_NAME_SIZE, rbdname);
> +    p = strchr(pool, '/');
> +    if (p == NULL) {
> +        return -EINVAL;
> +    }
> +
> +    *p = '\0';
> +
> +    l = strlen(pool);
> +    if(l >= RBD_MAX_SEG_NAME_SIZE) {
> +        error_report("pool name to long");
> +        return -EINVAL;
> +    } else if (l <= 0) {
> +        error_report("pool name to short");
> +        return -EINVAL;
> +    }
> +
> +    l = strlen(++p);
> +    if (l >= RBD_MAX_OBJ_NAME_SIZE) {
> +        error_report("object name to long");
> +        return -EINVAL;
> +    } else if (l <= 0) {
> +        error_report("object name to short");
> +        return -EINVAL;
> +    }
> +
> +    strcpy(name, p);
> +
> +    return l;
> +}
> +
> +static int create_tmap_op(uint8_t op, const char *name, char **tmap_desc)
> +{
> +    uint32_t len = strlen(name);
> +    /* total_len = encoding op + name + empty buffer */
> +    uint32_t total_len = 1 + (sizeof(uint32_t) + len) + sizeof(uint32_t);
> +    char *desc = NULL;
> +
> +    qemu_malloc(total_len);
> +
> +    *tmap_desc = desc;
> +
> +    *desc = op;
> +    desc++;
> +    memcpy(desc, &len, sizeof(len));
> +    desc += sizeof(len);
> +    memcpy(desc, name, len);
> +    desc += len;
> +    len = 0;
> +    memcpy(desc, &len, sizeof(len));
> +    desc += sizeof(len);
> +
> +    return desc - *tmap_desc;
> +}
> +
> +static void free_tmap_op(char *tmap_desc)
> +{
> +    qemu_free(tmap_desc);
> +}
> +
> +static int rbd_register_image(rados_pool_t pool, const char *name)
> +{
> +    char *tmap_desc;
> +    const char *dir = RBD_DIRECTORY;
> +    int ret;
> +
> +    ret = create_tmap_op(CEPH_OSD_TMAP_SET, name, &tmap_desc);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret = rados_tmap_update(pool, dir, tmap_desc, ret);
> +    free_tmap_op(tmap_desc);
> +
> +    return ret;
> +}
> +
> +static int rbd_create(const char *filename, QEMUOptionParameter *options)
> +{
> +    int64_t bytes = 0;
> +    int64_t objsize;
> +    uint64_t size;
> +    time_t mtime;
> +    uint8_t obj_order = RBD_DEFAULT_OBJ_ORDER;
> +    char pool[RBD_MAX_SEG_NAME_SIZE];
> +    char n[RBD_MAX_SEG_NAME_SIZE];
> +    char name[RBD_MAX_SEG_NAME_SIZE];
> +    RbdHeader1 header;
> +    rados_pool_t p;
> +    int ret;
> +
> +    if (rbd_parsename(filename, pool, name) < 0) {
> +        return -EINVAL;
> +    }
> +
> +    snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", name, RBD_SUFFIX);
> +
> +    /* Read out options */
> +    while (options && options->name) {
> +        if (!strcmp(options->name, BLOCK_OPT_SIZE)) {
> +            bytes = options->value.n;
> +        } else if (!strcmp(options->name, BLOCK_OPT_CLUSTER_SIZE)) {
> +            if (options->value.n) {
> +                objsize = options->value.n;
> +                if ((objsize - 1) & objsize) {    /* not a power of 2? */
> +                    error_report("obj size needs to be power of 2");
> +                    return -EINVAL;
> +                }
> +                if (objsize < 4096) {
> +                    error_report("obj size too small");
> +                    return -EINVAL;
> +                }
> +
> +                for (obj_order = 0; obj_order < 64; obj_order++) {
> +                    if (objsize == 1) {
> +                        break;
> +                    }
> +                    objsize >>= 1;
> +                }
> +            }
> +        }
> +        options++;
> +    }
> +
> +    memset(&header, 0, sizeof(header));
> +    pstrcpy(header.text, sizeof(header.text), RBD_HEADER_TEXT);
> +    pstrcpy(header.signature, sizeof(header.signature), RBD_HEADER_SIGNATURE);
> +    pstrcpy(header.version, sizeof(header.version), RBD_HEADER_VERSION);
> +    header.image_size = bytes;
> +    cpu_to_le64s((uint64_t *) & header.image_size);
> +    header.options.order = obj_order;
> +    header.options.crypt_type = RBD_CRYPT_NONE;
> +    header.options.comp_type = RBD_COMP_NONE;
> +    header.snap_seq = 0;
> +    header.snap_count = 0;
> +    cpu_to_le32s(&header.snap_count);
> +
> +    if (rados_initialize(0, NULL) < 0) {
> +        error_report("error initializing");
> +        return -EIO;
> +    }
> +
> +    if (rados_open_pool(pool, &p)) {
> +        error_report("error opening pool %s", pool);
> +        rados_deinitialize();
> +        return -EIO;
> +    }
> +
> +    /* check for existing rbd header file */
> +    ret = rados_stat(p, n, &size, &mtime);
> +    if (ret == 0) {
> +        ret=-EEXIST;
> +        goto done;
> +    }
> +
> +    /* create header file */
> +    ret = rados_write(p, n, 0, (const char *)&header, sizeof(header));
> +    if (ret < 0) {
> +        goto done;
> +    }
> +
> +    ret = rbd_register_image(p, name);
> +done:
> +    rados_close_pool(p);
> +    rados_deinitialize();
> +
> +    return ret;
> +}
> +
> +static int rbd_open(BlockDriverState *bs, const char *filename, int flags)
> +{
> +    BDRVRBDState *s = bs->opaque;
> +    char pool[RBD_MAX_SEG_NAME_SIZE];
> +    char n[RBD_MAX_SEG_NAME_SIZE];
> +    char hbuf[4096];
> +    int r;
> +
> +    if (rbd_parsename(filename, pool, s->name) < 0) {
> +        return -EINVAL;
> +    }
> +    snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", s->name, RBD_SUFFIX);
> +
> +    if ((r = rados_initialize(0, NULL)) < 0) {
> +        error_report("error initializing");
> +        return r;
> +    }
> +
> +    if ((r = rados_open_pool(pool, &s->pool))) {
> +        error_report("error opening pool %s", pool);
> +        rados_deinitialize();
> +        return r;
> +    }
> +
> +    if ((r = rados_read(s->pool, n, 0, hbuf, 4096)) < 0) {
> +        error_report("error reading header from %s", s->name);
> +        goto failed;
> +    }
> +
> +    if (strncmp(hbuf + 64, RBD_HEADER_SIGNATURE, 4)) {
> +        error_report("Invalid header signature %s", hbuf + 64);
> +        r = -EMEDIUMTYPE;
> +        goto failed;
> +    }
> +
> +    if (strncmp(hbuf + 68, RBD_HEADER_VERSION, 8)) {
> +        error_report("Unknown image version %s", hbuf + 68);
> +        r = -EMEDIUMTYPE;
> +        goto failed;
> +    }
> +
> +    RbdHeader1 *header;
> +
> +    header = (RbdHeader1 *) hbuf;
> +    le64_to_cpus((uint64_t *) & header->image_size);
> +    s->size = header->image_size;
> +    s->objsize = 1 << header->options.order;
> +
> +    return 0;
> +
> +failed:
> +    rados_close_pool(s->pool);
> +    rados_deinitialize();
> +    return r;
> +}
> +
> +static void rbd_close(BlockDriverState *bs)
> +{
> +    BDRVRBDState *s = bs->opaque;
> +
> +    rados_close_pool(s->pool);
> +    rados_deinitialize();
> +}
> +
> +static int rbd_rw(BlockDriverState *bs, int64_t sector_num,
> +                  uint8_t *buf, int nb_sectors, int write)
> +{
> +    BDRVRBDState *s = bs->opaque;
> +    char n[RBD_MAX_SEG_NAME_SIZE];
> +
> +    int64_t segnr, segoffs, segsize, r;
> +    int64_t off, size;
> +
> +    off = sector_num * BDRV_SECTOR_SIZE;
> +    size = nb_sectors * BDRV_SECTOR_SIZE;
> +    segnr = off / s->objsize;
> +    segoffs = off % s->objsize;
> +    segsize = s->objsize - segoffs;
> +
> +    while (size > 0) {
> +        if (size < segsize) {
> +            segsize = size;
> +        }
> +
> +        snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012" PRIx64, s->name, segnr);
> +
> +        if (write) {
> +            if ((r = rados_write(s->pool, n, segoffs, (const char *)buf,
> +                segsize)) < 0) {
> +                return r;
> +            }
> +        } else {
> +            r = rados_read(s->pool, n, segoffs, (char *)buf, segsize);
> +            if (r == -ENOENT) {
> +                memset(buf, 0, segsize);
> +            } else if (r < 0) {
> +                return r;
> +            } else if (r < segsize) {
> +                memset(buf + r, 0, segsize - r);
> +            }
> +        }
> +
> +        buf += segsize;
> +        size -= segsize;
> +        segoffs = 0;
> +        segsize = s->objsize;
> +        segnr++;
> +    }
> +
> +    return 0;
> +}
> +
> +static int rbd_read(BlockDriverState *bs, int64_t sector_num,
> +                    uint8_t *buf, int nb_sectors)
> +{
> +    return rbd_rw(bs, sector_num, buf, nb_sectors, 0);
> +}
> +
> +static int rbd_write(BlockDriverState *bs, int64_t sector_num,
> +                     const uint8_t *buf, int nb_sectors)
> +{
> +    return rbd_rw(bs, sector_num, (uint8_t *) buf, nb_sectors, 1);
> +}
> +
> +static void rbd_aio_cancel(BlockDriverAIOCB *blockacb)
> +{
> +    RBDAIOCB *acb = (RBDAIOCB *) blockacb;
> +    qemu_bh_delete(acb->bh);
> +    acb->bh = NULL;
> +    qemu_aio_release(acb);
> +}
> +
> +static AIOPool rbd_aio_pool = {
> +    .aiocb_size = sizeof(RBDAIOCB),
> +    .cancel = rbd_aio_cancel,
> +};
> +
> +/* This is the callback function for rados_aio_read and _write */
> +static void rbd_finish_aiocb(rados_completion_t c, RADOSCB *rcb)
> +{
> +    RBDAIOCB *acb = rcb->acb;
> +    int64_t r;
> +    int i;
> +
> +    acb->aiocnt--;
> +    r = rados_aio_get_return_value(c);
> +    rados_aio_release(c);
> +    if (acb->write) {
> +        if (r < 0) {
> +            acb->ret = r;
> +            acb->error = 1;
> +        } else if (!acb->error) {
> +            acb->ret += rcb->segsize;
> +        }
> +    } else {
> +        if (r == -ENOENT) {
> +            memset(rcb->buf, 0, rcb->segsize);
> +            if (!acb->error) {
> +                acb->ret += rcb->segsize;
> +            }
> +        } else if (r < 0) {
> +            acb->ret = r;
> +            acb->error = 1;
> +        } else if (r < rcb->segsize) {
> +            memset(rcb->buf + r, 0, rcb->segsize - r);
> +            if (!acb->error) {
> +                acb->ret += rcb->segsize;
> +            }
> +        } else if (!acb->error) {
> +            acb->ret += r;
> +        }
> +    }
> +    qemu_free(rcb);
> +    i = 0;
> +    if (!acb->aiocnt && acb->bh) {
> +        qemu_bh_schedule(acb->bh);
> +    }
> +}
> +
> +/* Callback when all queued rados_aio requests are complete */
> +static void rbd_aio_bh_cb(void *opaque)
> +{
> +    RBDAIOCB *acb = opaque;
> +
> +    if (!acb->write) {
> +        qemu_iovec_from_buffer(acb->qiov, acb->bounce, acb->qiov->size);
> +    }
> +    qemu_vfree(acb->bounce);
> +    acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->ret));
> +    qemu_bh_delete(acb->bh);
> +    acb->bh = NULL;
> +    qemu_aio_release(acb);
> +}
> +
> +static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState *bs,
> +                                           int64_t sector_num,
> +                                           QEMUIOVector *qiov,
> +                                           int nb_sectors,
> +                                           BlockDriverCompletionFunc *cb,
> +                                           void *opaque, int write)
> +{
> +    RBDAIOCB *acb;
> +    RADOSCB *rcb;
> +    rados_completion_t c;
> +    char n[RBD_MAX_SEG_NAME_SIZE];
> +    int64_t segnr, segoffs, segsize, last_segnr;
> +    int64_t off, size;
> +    char *buf;
> +
> +    BDRVRBDState *s = bs->opaque;
> +
> +    acb = qemu_aio_get(&rbd_aio_pool, bs, cb, opaque);
> +    acb->write = write;
> +    acb->qiov = qiov;
> +    acb->bounce = qemu_blockalign(bs, qiov->size);
> +    acb->aiocnt = 0;
> +    acb->ret = 0;
> +    acb->error = 0;
> +
> +    if (!acb->bh) {
> +        acb->bh = qemu_bh_new(rbd_aio_bh_cb, acb);
> +    }
> +
> +    if (write) {
> +        qemu_iovec_to_buffer(acb->qiov, acb->bounce);
> +    }
> +
> +    buf = acb->bounce;
> +
> +    off = sector_num * BDRV_SECTOR_SIZE;
> +    size = nb_sectors * BDRV_SECTOR_SIZE;
> +    segnr = off / s->objsize;
> +    segoffs = off % s->objsize;
> +    segsize = s->objsize - segoffs;
> +
> +    last_segnr = ((off + size - 1) / s->objsize);
> +    acb->aiocnt = (last_segnr - segnr) + 1;
> +
> +    while (size > 0) {
> +        if (size < segsize) {
> +            segsize = size;
> +        }
> +
> +        snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012llx", s->name,
> +                 (long long unsigned int)segnr);
> +
> +        rcb = qemu_malloc(sizeof(RADOSCB));
> +        rcb->done = 0;
> +        rcb->acb = acb;
> +        rcb->segsize = segsize;
> +        rcb->buf = buf;
> +
> +        if (write) {
> +            rados_aio_create_completion(rcb, NULL,
> +                                        (rados_callback_t) rbd_finish_aiocb,
> +                                        &c);
> +            rados_aio_write(s->pool, n, segoffs, buf, segsize, c);
> +        } else {
> +            rados_aio_create_completion(rcb,
> +                                        (rados_callback_t) rbd_finish_aiocb,
> +                                        NULL, &c);
> +            rados_aio_read(s->pool, n, segoffs, buf, segsize, c);
> +        }
> +
> +        buf += segsize;
> +        size -= segsize;
> +        segoffs = 0;
> +        segsize = s->objsize;
> +        segnr++;
> +    }
> +
> +    return &acb->common;
> +}
> +
> +static BlockDriverAIOCB *rbd_aio_readv(BlockDriverState * bs,
> +                                       int64_t sector_num, QEMUIOVector * qiov,
> +                                       int nb_sectors,
> +                                       BlockDriverCompletionFunc * cb,
> +                                       void *opaque)
> +{
> +    return rbd_aio_rw_vector(bs, sector_num, qiov, nb_sectors, cb, opaque, 0);
> +}
> +
> +static BlockDriverAIOCB *rbd_aio_writev(BlockDriverState * bs,
> +                                        int64_t sector_num, QEMUIOVector * qiov,
> +                                        int nb_sectors,
> +                                        BlockDriverCompletionFunc * cb,
> +                                        void *opaque)
> +{
> +    return rbd_aio_rw_vector(bs, sector_num, qiov, nb_sectors, cb, opaque, 1);
> +}
> +
> +static int rbd_getinfo(BlockDriverState * bs, BlockDriverInfo * bdi)
> +{
> +    BDRVRBDState *s = bs->opaque;
> +    bdi->cluster_size = s->objsize;
> +    return 0;
> +}
> +
> +static int64_t rbd_getlength(BlockDriverState * bs)
> +{
> +    BDRVRBDState *s = bs->opaque;
> +
> +    return s->size;
> +}
> +
> +static QEMUOptionParameter rbd_create_options[] = {
> +    {
> +     .name = BLOCK_OPT_SIZE,
> +     .type = OPT_SIZE,
> +     .help = "Virtual disk size"
> +    },
> +    {
> +     .name = BLOCK_OPT_CLUSTER_SIZE,
> +     .type = OPT_SIZE,
> +     .help = "RBD object size"
> +    },
> +    {NULL}
> +};
> +
> +static BlockDriver bdrv_rbd = {
> +    .format_name        = "rbd",
> +    .instance_size      = sizeof(BDRVRBDState),
> +    .bdrv_file_open     = rbd_open,
> +    .bdrv_read          = rbd_read,
> +    .bdrv_write         = rbd_write,
> +    .bdrv_close         = rbd_close,
> +    .bdrv_create        = rbd_create,
> +    .bdrv_get_info      = rbd_getinfo,
> +    .create_options     = rbd_create_options,
> +    .bdrv_getlength     = rbd_getlength,
> +    .protocol_name      = "rbd",
> +
> +    .bdrv_aio_readv     = rbd_aio_readv,
> +    .bdrv_aio_writev    = rbd_aio_writev,
> +};
> +
> +static void bdrv_rbd_init(void)
> +{
> +    bdrv_register(&bdrv_rbd);
> +}
> +
> +block_init(bdrv_rbd_init);
> diff --git a/block/rbd_types.h b/block/rbd_types.h
> new file mode 100644
> index 0000000..91ac4f9
> --- /dev/null
> +++ b/block/rbd_types.h
> @@ -0,0 +1,64 @@
> +/*
> + * Ceph - scalable distributed file system
> + *
> + * Copyright (C) 2004-2010 Sage Weil <sage@newdream.net>
> + *
> + * This is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License version 2.1, as published by the Free Software
> + * Foundation.  See file COPYING.
> + *
> + */
> +
> +#ifndef QEMU_BLOCK_RBD_TYPES_H
> +#define QEMU_BLOCK_RBD_TYPES_H
> +
> +
> +/*
> + * rbd image 'foo' consists of objects
> + *   foo.rbd      - image metadata
> + *   foo.00000000
> + *   foo.00000001
> + *   ...          - data
> + */
> +
> +#define RBD_SUFFIX              ".rbd"
> +#define RBD_DIRECTORY           "rbd_directory"
> +
> +#define RBD_DEFAULT_OBJ_ORDER   22   /* 4MB */
> +
> +#define RBD_MAX_OBJ_NAME_SIZE   96
> +#define RBD_MAX_SEG_NAME_SIZE   128
> +
> +#define RBD_COMP_NONE           0
> +#define RBD_CRYPT_NONE          0
> +
> +#define RBD_HEADER_TEXT         "<<< Rados Block Device Image >>>\n"
> +#define RBD_HEADER_SIGNATURE    "RBD"
> +#define RBD_HEADER_VERSION      "001.004"
> +
> +struct rbd_obj_snap_ondisk {
> +    uint64_t id;
> +    uint64_t image_size;
> +} __attribute__((packed));
> +
> +struct rbd_obj_header_ondisk {
> +    char text[64];
> +    char signature[4];
> +    char version[8];
> +    struct {
> +        uint8_t order;
> +        uint8_t crypt_type;
> +        uint8_t comp_type;
> +        uint8_t unused;
> +    } __attribute__((packed)) options;
> +    uint64_t image_size;
> +    uint64_t snap_seq;
> +    uint32_t snap_count;
> +    uint32_t reserved;
> +    uint64_t snap_names_len;
> +    struct rbd_obj_snap_ondisk snaps[0];
> +} __attribute__((packed));
> +
> +
> +#endif
> diff --git a/configure b/configure
> index 3cd2c5f..3f5c8ce 100755
> --- a/configure
> +++ b/configure
> @@ -299,6 +299,7 @@ pkgversion=""
>  check_utests="no"
>  user_pie="no"
>  zero_malloc=""
> +rbd=""
>  
>  # OS specific
>  if check_define __linux__ ; then
> @@ -660,6 +661,10 @@ for opt do
>    ;;
>    --enable-vhost-net) vhost_net="yes"
>    ;;
> +  --disable-rbd) rbd="no"
> +  ;;
> +  --enable-rbd) rbd="yes"
> +  ;;
>    *) echo "ERROR: unknown option $opt"; show_help="yes"
>    ;;
>    esac
> @@ -826,6 +831,7 @@ echo "  --enable-docs            enable documentation build"
>  echo "  --disable-docs           disable documentation build"
>  echo "  --disable-vhost-net      disable vhost-net acceleration support"
>  echo "  --enable-vhost-net       enable vhost-net acceleration support"
> +echo "  --enable-rbd		 enable building the rados block device (rbd)"
>  echo ""
>  echo "NOTE: The object files are built at the place where configure is launched"
>  exit 1
> @@ -1579,6 +1585,27 @@ if test "$mingw32" != yes -a "$pthread" = no; then
>  fi
>  
>  ##########################################
> +# rbd probe
> +if test "$rbd" != "no" ; then
> +  cat > $TMPC <<EOF
> +#include <stdio.h>
> +#include <rados/librados.h>
> +int main(void) { rados_initialize(0, NULL); return 0; }
> +EOF
> +  rbd_libs="-lrados -lcrypto"
> +  if compile_prog "" "$rbd_libs" ; then
> +    rbd=yes
> +    libs_tools="$rbd_libs $libs_tools"
> +    libs_softmmu="$rbd_libs $libs_softmmu"
> +  else
> +    if test "$rbd" = "yes" ; then
> +      feature_not_found "rados block device"
> +    fi
> +    rbd=no
> +  fi
> +fi
> +
> +##########################################
>  # linux-aio probe
>  
>  if test "$linux_aio" != "no" ; then
> @@ -2041,6 +2068,7 @@ echo "preadv support    $preadv"
>  echo "fdatasync         $fdatasync"
>  echo "uuid support      $uuid"
>  echo "vhost-net support $vhost_net"
> +echo "rbd support       $rbd"
>  
>  if test $sdl_too_old = "yes"; then
>  echo "-> Your SDL version is too old - please upgrade to have SDL support"
> @@ -2270,6 +2298,9 @@ echo "CONFIG_UNAME_RELEASE=\"$uname_release\"" >> $config_host_mak
>  if test "$zero_malloc" = "yes" ; then
>    echo "CONFIG_ZERO_MALLOC=y" >> $config_host_mak
>  fi
> +if test "$rbd" = "yes" ; then
> +  echo "CONFIG_RBD=y" >> $config_host_mak
> +fi
>  
>  # USB host support
>  case "$usb" in
>   

