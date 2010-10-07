From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [PATCH] ceph/rbd block driver for qemu-kvm (v4)
Date: Thu, 07 Oct 2010 09:12:55 -0500
Message-ID: <4CADD567.9010606@codemonkey.ws>
References: <20100802194631.GA4923@chb-desktop> <alpine.LNX.2.00.1008030033550.2664@linmac> <20100803201407.GD1475@chb-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59823 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295Ab0JGOMv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Oct 2010 10:12:51 -0400
In-Reply-To: <20100803201407.GD1475@chb-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: malc <av1474@comtv.ru>, kvm@vger.kernel.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, ceph-devel@vger.kernel.org

On 08/03/2010 03:14 PM, Christian Brunner wrote:
> On Tue, Aug 03, 2010 at 12:37:18AM +0400, malc wrote:
>    
>> Thare are whitespace issues in this patch.
>>      
> Thanks for looking at the patch. Here is an updated patch, that
> should fix the whitespace issues:
>
> This is a block driver for the distributed file system Ceph
> (http://ceph.newdream.net/). This driver uses librados (which
> is part of the Ceph server) for direct access to the Ceph object
> store and is running entirely in userspace.
>
> It now has (read only) snapshot support and passes all relevant
> qemu-iotests.
>
> To compile the driver you need at least ceph 0.21.
>
> Additional information is available on the Ceph-Wiki:
>
> http://ceph.newdream.net/wiki/Kvm-rbd
>
> The patch is based on git://repo.or.cz/qemu/kevin.git block
>
> Signed-off-by: Christian Brunner<chb@muc.de>
>
> ---
>   Makefile.objs     |    1 +
>   block/rbd.c       |  907 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   block/rbd_types.h |   71 +++++
>   configure         |   31 ++
>   4 files changed, 1010 insertions(+), 0 deletions(-)
>   create mode 100644 block/rbd.c
>   create mode 100644 block/rbd_types.h
>
> diff --git a/Makefile.objs b/Makefile.objs
> index 4a1eaa1..bf45142 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -18,6 +18,7 @@ block-nested-y += parallels.o nbd.o blkdebug.o sheepdog.o
>   block-nested-$(CONFIG_WIN32) += raw-win32.o
>   block-nested-$(CONFIG_POSIX) += raw-posix.o
>   block-nested-$(CONFIG_CURL) += curl.o
> +block-nested-$(CONFIG_RBD) += rbd.o
>
>   block-obj-y +=  $(addprefix block/, $(block-nested-y))
>
> diff --git a/block/rbd.c b/block/rbd.c
> new file mode 100644
> index 0000000..0e6b2a5
> --- /dev/null
> +++ b/block/rbd.c
> @@ -0,0 +1,907 @@
> +/*
> + * QEMU Block driver for RADOS (Ceph)
> + *
> + * Copyright (C) 2010 Christian Brunner<chb@muc.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu-common.h"
> +#include "qemu-error.h"
> +#include<sys/types.h>
> +#include<stdbool.h>
> +
> +#include<qemu-common.h>
>    

This looks to be unnecessary.  Generally, system includes shouldn't be 
required so all of these should go away except rado/librados.h

> +
> +#include "rbd_types.h"
> +#include "module.h"
> +#include "block_int.h"
> +
> +#include<stdio.h>
> +#include<stdlib.h>
> +#include<rados/librados.h>
> +
> +#include<signal.h>
> +
> +
> +int eventfd(unsigned int initval, int flags);
>    

This is not quite right.  Depending on eventfd is curious but in the 
very least, you need to detect the presence of eventfd in configure and 
provide a wrapper that redefines it as necessary.

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
> +#define OBJ_MAX_SIZE (1UL<<  OBJ_DEFAULT_OBJ_ORDER)
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
> +    struct BDRVRBDState *s;
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
> +    int efd;
> +    rados_pool_t pool;
> +    rados_pool_t header_pool;
> +    char name[RBD_MAX_OBJ_NAME_SIZE];
> +    char block_name[RBD_MAX_BLOCK_NAME_SIZE];
> +    uint64_t size;
> +    uint64_t objsize;
> +    int qemu_aio_count;
> +    int read_only;
> +} BDRVRBDState;
> +
> +typedef struct rbd_obj_header_ondisk RbdHeader1;
> +
> +static int rbd_parsename(const char *filename, char *pool, char **snap,
> +                         char *name)
> +{
> +    const char *rbdname;
> +    char *p;
> +    int l;
> +
> +    if (!strstart(filename, "rbd:",&rbdname)) {
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
> +    if(l>= RBD_MAX_SEG_NAME_SIZE) {
> +        error_report("pool name to long");
> +        return -EINVAL;
> +    } else if (l<= 0) {
> +        error_report("pool name to short");
> +        return -EINVAL;
> +    }
> +
> +    l = strlen(++p);
> +    if (l>= RBD_MAX_OBJ_NAME_SIZE) {
> +        error_report("object name to long");
> +        return -EINVAL;
> +    } else if (l<= 0) {
> +        error_report("object name to short");
> +        return -EINVAL;
> +    }
> +
> +    strcpy(name, p);
> +
> +    *snap = strchr(name, '@');
> +    if (*snap) {
> +        *(*snap) = '\0';
> +        (*snap)++;
> +        if (!*snap) *snap = NULL;
> +    }
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
>    

char is the wrong type to use here as it may be signed or unsigned.  
That can have weird effects with binary data when you're directly 
manipulating it.

> +
> +    desc = qemu_malloc(total_len);
> +
> +    *tmap_desc = desc;
> +
> +    *desc = op;
> +    desc++;
> +    memcpy(desc,&len, sizeof(len));
> +    desc += sizeof(len);
> +    memcpy(desc, name, len);
> +    desc += len;
> +    len = 0;
> +    memcpy(desc,&len, sizeof(len));
> +    desc += sizeof(len);
>    

Shouldn't endianness be a concern?

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
> +    ret = create_tmap_op(CEPH_OSD_TMAP_SET, name,&tmap_desc);
> +    if (ret<  0) {
> +        return ret;
> +    }
> +
> +    ret = rados_tmap_update(pool, dir, tmap_desc, ret);
> +    free_tmap_op(tmap_desc);
> +
> +    return ret;
> +}
>    

This ops are all synchronous?  IOW, rados_tmap_update() call blocks 
until the operation is completed?

> +static int touch_rbd_info(rados_pool_t pool, const char *info_oid)
> +{
> +    int r = rados_write(pool, info_oid, 0, NULL, 0);
> +    if (r<  0) {
> +        return r;
> +    }
> +    return 0;
> +}
> +
> +static int rbd_assign_bid(rados_pool_t pool, uint64_t *id)
> +{
> +    uint64_t out[1];
> +    const char *info_oid = RBD_INFO;
> +
> +    *id = 0;
> +
> +    int r = touch_rbd_info(pool, info_oid);
> +    if (r<  0) {
> +        return r;
> +    }
> +
> +    r = rados_exec(pool, info_oid, "rbd", "assign_bid", NULL,
> +                   0, (char *)out, sizeof(out));
> +    if (r<  0) {
> +        return r;
> +    }
> +
> +    *id = out[0];
> +    le64_to_cpus(out);
> +
> +    return 0;
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
> +    char *snap;
> +    RbdHeader1 header;
> +    rados_pool_t p;
> +    uint64_t bid;
> +    uint32_t hi, lo;
> +    int ret;
> +
> +    if (rbd_parsename(filename, pool,&snap, name)<  0) {
> +        return -EINVAL;
> +    }
> +
> +    snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", name, RBD_SUFFIX);
> +
> +    /* Read out options */
> +    while (options&&  options->name) {
> +        if (!strcmp(options->name, BLOCK_OPT_SIZE)) {
> +            bytes = options->value.n;
> +        } else if (!strcmp(options->name, BLOCK_OPT_CLUSTER_SIZE)) {
> +            if (options->value.n) {
> +                objsize = options->value.n;
> +                if ((objsize - 1)&  objsize) {    /* not a power of 2? */
> +                    error_report("obj size needs to be power of 2");
> +                    return -EINVAL;
> +                }
> +                if (objsize<  4096) {
> +                    error_report("obj size too small");
> +                    return -EINVAL;
> +                }
> +
> +                for (obj_order = 0; obj_order<  64; obj_order++) {
> +                    if (objsize == 1) {
> +                        break;
> +                    }
> +                    objsize>>= 1;
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
> +    cpu_to_le64s((uint64_t *)&  header.image_size);
> +    header.options.order = obj_order;
> +    header.options.crypt_type = RBD_CRYPT_NONE;
> +    header.options.comp_type = RBD_COMP_NONE;
> +    header.snap_seq = 0;
> +    header.snap_count = 0;
> +    cpu_to_le32s(&header.snap_count);
> +
> +    if (rados_initialize(0, NULL)<  0) {
> +        error_report("error initializing");
> +        return -EIO;
> +    }
> +
> +    if (rados_open_pool(pool,&p)) {
> +        error_report("error opening pool %s", pool);
> +        rados_deinitialize();
> +        return -EIO;
> +    }
> +
> +    /* check for existing rbd header file */
> +    ret = rados_stat(p, n,&size,&mtime);
> +    if (ret == 0) {
> +        ret=-EEXIST;
> +        goto done;
> +    }
> +
> +    ret = rbd_assign_bid(p,&bid);
> +    if (ret<  0) {
> +        error_report("failed assigning block id");
> +        rados_deinitialize();
> +        return -EIO;
> +    }
> +    hi = bid>>  32;
> +    lo = bid&  0xFFFFFFFF;
> +    snprintf(header.block_name, sizeof(header.block_name), "rb.%x.%x", hi, lo);
> +
> +    /* create header file */
> +    ret = rados_write(p, n, 0, (const char *)&header, sizeof(header));
> +    if (ret<  0) {
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
> +static void rbd_aio_completion_cb(void *opaque)
> +{
> +    BDRVRBDState *s = opaque;
> +
> +    uint64_t val;
> +    ssize_t ret;
> +
> +    do {
> +        if ((ret = read(s->efd,&val, sizeof(val)))>  0) {
> +            s->qemu_aio_count -= val;
> +        }
> +    } while (ret<  0&&  errno == EINTR);
> +
> +    return;
> +}
> +
> +static int rbd_aio_flush_cb(void *opaque)
> +{
> +    BDRVRBDState *s = opaque;
> +
> +    return (s->qemu_aio_count>  0);
> +}
> +
> +
> +static int rbd_set_snapc(rados_pool_t pool, const char *snap, RbdHeader1 *header)
> +{
> +    uint32_t snap_count = header->snap_count;
> +    rados_snap_t *snaps = NULL;
> +    rados_snap_t seq;
> +    uint32_t i;
> +    uint64_t snap_names_len = header->snap_names_len;
> +    int r;
> +    rados_snap_t snapid = 0;
> +
> +    cpu_to_le32s(&snap_count);
> +    cpu_to_le64s(&snap_names_len);
> +    if (snap_count) {
> +        const char *header_snap = (const char *)&header->snaps[snap_count];
> +        const char *end = header_snap + snap_names_len;
> +        snaps = qemu_malloc(sizeof(rados_snap_t) * header->snap_count);
> +
> +        for (i=0; i<  snap_count; i++) {
> +            snaps[i] = (uint64_t)header->snaps[i].id;
> +            cpu_to_le64s(&snaps[i]);
> +
> +            if (snap&&  strcmp(snap, header_snap) == 0) {
> +                snapid = snaps[i];
> +            }
> +
> +            header_snap += strlen(header_snap) + 1;
> +            if (header_snap>  end)
> +                error_report("bad header, snapshot list broken");
>    

Missing curly braces here.

> +        }
> +    }
> +
> +    if (snap&&  !snapid) {
> +        error_report("snapshot not found");
> +        return -ENOENT;
> +    }
> +    seq = header->snap_seq;
> +    cpu_to_le32s((uint32_t *)&seq);
> +
> +    r = rados_set_snap_context(pool, seq, snaps, snap_count);
> +
> +    rados_set_snap(pool, snapid);
> +
> +    qemu_free(snaps);
> +
> +    return r;
> +}
> +
> +#define BUF_READ_START_LEN    4096
> +
> +static int rbd_read_header(BDRVRBDState *s, char **hbuf)
> +{
> +    char *buf = NULL;
> +    char n[RBD_MAX_SEG_NAME_SIZE];
> +    uint64_t len = BUF_READ_START_LEN;
> +    int r;
> +
> +    snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", s->name, RBD_SUFFIX);
> +
> +    buf = qemu_malloc(len);
> +
> +    r = rados_read(s->header_pool, n, 0, buf, len);
> +    if (r<  0)
> +        goto failed;
> +
> +    if (r<  len)
> +        goto done;
> +
> +    qemu_free(buf);
> +    buf = qemu_malloc(len);
> +
> +    r = rados_stat(s->header_pool, n,&len, NULL);
> +    if (r<  0)
> +        goto failed;
> +
> +    r = rados_read(s->header_pool, n, 0, buf, len);
> +    if (r<  0)
> +        goto failed;
> +
> +done:
> +    *hbuf = buf;
> +    return 0;
> +
> +failed:
> +    qemu_free(buf);
> +    return r;
> +}
> +
> +static int rbd_open(BlockDriverState *bs, const char *filename, int flags)
> +{
> +    BDRVRBDState *s = bs->opaque;
> +    char pool[RBD_MAX_SEG_NAME_SIZE];
> +    char *snap;
> +    char *hbuf = NULL;
> +    int r;
> +
> +    if (rbd_parsename(filename, pool,&snap, s->name)<  0) {
> +        return -EINVAL;
> +    }
> +
> +    if ((r = rados_initialize(0, NULL))<  0) {
> +        error_report("error initializing");
> +        return r;
> +    }
> +
> +    if ((r = rados_open_pool(pool,&s->pool))) {
> +        error_report("error opening pool %s", pool);
> +        rados_deinitialize();
> +        return r;
> +    }
> +
> +    if ((r = rados_open_pool(pool,&s->header_pool))) {
> +        error_report("error opening pool %s", pool);
> +        rados_deinitialize();
> +        return r;
> +    }
> +
> +   if ((r = rbd_read_header(s,&hbuf))<  0) {
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
>
>    

Don't mix variable definitions with code.

> +    header = (RbdHeader1 *) hbuf;
> +    le64_to_cpus((uint64_t *)&  header->image_size);
> +    s->size = header->image_size;
> +    s->objsize = 1<<  header->options.order;
> +    memcpy(s->block_name, header->block_name, sizeof(header->block_name));
> +
> +    r = rbd_set_snapc(s->pool, snap, header);
> +    if (r<  0) {
> +        error_report("failed setting snap context: %s", strerror(-r));
> +        goto failed;
> +    }
> +
> +    s->read_only = (snap != NULL);
> +
> +    s->efd = eventfd(0, 0);
> +    if (s->efd<  0) {
> +        error_report("error opening eventfd");
> +        goto failed;
> +    }
> +    fcntl(s->efd, F_SETFL, O_NONBLOCK);
> +    qemu_aio_set_fd_handler(s->efd, rbd_aio_completion_cb, NULL,
> +        rbd_aio_flush_cb, NULL, s);
>    

It looks like you just use the eventfd to signal aio completion 
callbacks.  A better way to do this would be to schedule a bottom half.  
eventfds are Linux specific and specific to recent kernels.

I think you need to try to split this up into multiple patches.  Maybe 
start a driver with just open support and then add rw incrementally.

> +    qemu_free(hbuf);
> +
> +    return 0;
> +
> +failed:
> +    if (hbuf)
> +        qemu_free(hbuf);
> +
> +    rados_close_pool(s->header_pool);
> +    rados_close_pool(s->pool);
> +    rados_deinitialize();
> +    return r;
> +}
> +
> +static void rbd_close(BlockDriverState *bs)
> +{
> +    BDRVRBDState *s = bs->opaque;
> +
> +    close(s->efd);
> +    qemu_aio_set_fd_handler(s->efd, NULL , NULL, NULL, NULL, NULL);
> +
> +    rados_close_pool(s->header_pool);
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
> +    while (size>  0) {
> +        if (size<  segsize) {
> +            segsize = size;
> +        }
> +
> +        snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012" PRIx64, s->block_name, segnr);
> +
> +        if (write) {
> +            if (s->read_only)
> +                return -EROFS;
> +            if ((r = rados_write(s->pool, n, segoffs, (const char *)buf,
> +                segsize))<  0) {
> +                return r;
> +            }
> +        } else {
> +            r = rados_read(s->pool, n, segoffs, (char *)buf, segsize);
> +            if (r == -ENOENT) {
> +                memset(buf, 0, segsize);
> +            } else if (r<  0) {
> +                return r;
> +            } else if (r<  segsize) {
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
>    

You don't need to implement synchronous functions as long as you have 
the async interfaces implemented.

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
> +
> +static void rbd_finish_aiocb(rados_completion_t c, RADOSCB *rcb)
> +{
> +    RBDAIOCB *acb = rcb->acb;
> +    int64_t r;
> +    uint64_t buf = 1;
> +    int i;
> +
> +    acb->aiocnt--;
> +    r = rados_aio_get_return_value(c);
> +    rados_aio_release(c);
> +    if (acb->write) {
> +        if (r<  0) {
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
> +        } else if (r<  0) {
> +            acb->ret = r;
> +            acb->error = 1;
> +        } else if (r<  rcb->segsize) {
> +            memset(rcb->buf + r, 0, rcb->segsize - r);
> +            if (!acb->error) {
> +                acb->ret += rcb->segsize;
> +            }
> +        } else if (!acb->error) {
> +            acb->ret += r;
> +        }
> +    }
> +    if (write(acb->s->efd,&buf, sizeof(buf))<  0)
> +        error_report("failed writing to acb->s->efd\n");
> +    qemu_free(rcb);
> +    i = 0;
> +    if (!acb->aiocnt&&  acb->bh) {
> +        qemu_bh_schedule(acb->bh);
> +    }
> +}
> +
> +/* Callback when all queued rados_aio requests are complete */
> +
> +static void rbd_aio_bh_cb(void *opaque)
> +{
> +    RBDAIOCB *acb = opaque;
> +    uint64_t buf = 1;
> +
> +    if (!acb->write) {
> +        qemu_iovec_from_buffer(acb->qiov, acb->bounce, acb->qiov->size);
> +    }
> +    qemu_vfree(acb->bounce);
> +    acb->common.cb(acb->common.opaque, (acb->ret>  0 ? 0 : acb->ret));
> +    qemu_bh_delete(acb->bh);
> +    acb->bh = NULL;
> +
> +    if (write(acb->s->efd,&buf, sizeof(buf))<  0)
> +        error_report("failed writing to acb->s->efd\n");
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
> +    acb->s = s;
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
> +    s->qemu_aio_count+=acb->aiocnt + 1; /* All the RADOSCB and the related RBDAIOCB */
> +
> +    if (write&&  s->read_only) {
> +        acb->ret = -EROFS;
> +        return NULL;
> +    }
> +
> +    while (size>  0) {
> +        if (size<  segsize) {
> +            segsize = size;
> +        }
> +
> +        snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012" PRIx64, s->block_name,
> +                 segnr);
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
> +&c);
> +            rados_aio_write(s->pool, n, segoffs, buf, segsize, c);
> +        } else {
> +            rados_aio_create_completion(rcb,
> +                                        (rados_callback_t) rbd_finish_aiocb,
> +                                        NULL,&c);
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
> +    return&acb->common;
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
> +static int rbd_snap_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)
> +{
> +    BDRVRBDState *s = bs->opaque;
> +    char inbuf[512], outbuf[128];
> +    uint64_t snap_id;
> +    int r;
> +    char *p = inbuf;
> +    char *end = inbuf + sizeof(inbuf);
> +    char n[RBD_MAX_SEG_NAME_SIZE];
> +    char *hbuf = NULL;
> +
> +    if (sn_info->name[0] == '\0')
> +        return -EINVAL; /* we need a name for rbd snapshots */
> +
> +    /*
> +     * rbd snapshots are using the name as the user controlled unique identifier
> +     * we can't use the rbd snapid for that purpose, as it can't be set
> +     */
> +    if (sn_info->id_str[0] != '\0'&&
> +        strcmp(sn_info->id_str, sn_info->name) != 0)
> +        return -EINVAL;
>    

I don't fully understand.  Does this mean that snapshots are stored in a 
shared namespace?  IOW, if a user root creates a snapshot of in one VM, 
the other VM running as root sees it too?

Regards,

Anthony Liguori
