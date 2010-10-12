From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [PATCH] ceph/rbd block driver for qemu-kvm (v6)
Date: Tue, 12 Oct 2010 17:57:07 -0500
Message-ID: <4CB4E7C3.8090908@codemonkey.ws>
References: <20101012231854.GA4535@dell.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38858 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab0JLW5L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Oct 2010 18:57:11 -0400
In-Reply-To: <20101012231854.GA4535@dell.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, kwolf@redhat.com

On 10/12/2010 06:18 PM, Christian Brunner wrote:
> Hi Anthony,
> Hi Kevin,
> Hi Stefan,
>
> here is an updated version of the ceph/rbd block driver. It includes all
> the changes Yehuda made after the discussion on the list last weekend.
> As far as I can tell all the issues discussed are fixed.
>
> Please let us know if the driver is ready for inclusion now.
>    

I think it'll need a few more rounds.  If you can split up the patch, it 
may help get feedback faster.  See comments below.

> Thanks,
> Christian
>
> Signed-off-by: Christian Brunner<chb@muc.de>
> Signed-off-by: Yehuda Sadeh<yehuda@hq.newdream.net>
> ---
>   Makefile.objs     |    1 +
>   block/rbd.c       |  982 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   block/rbd_types.h |   71 ++++
>   configure         |   31 ++
>   4 files changed, 1085 insertions(+), 0 deletions(-)
>   create mode 100644 block/rbd.c
>   create mode 100644 block/rbd_types.h
>
> diff --git a/Makefile.objs b/Makefile.objs
> index 6ee077c..56a13c1 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -19,6 +19,7 @@ block-nested-y += parallels.o nbd.o blkdebug.o
>   block-nested-$(CONFIG_WIN32) += raw-win32.o
>   block-nested-$(CONFIG_POSIX) += raw-posix.o
>   block-nested-$(CONFIG_CURL) += curl.o
> +block-nested-$(CONFIG_RBD) += rbd.o
>
>   block-obj-y +=  $(addprefix block/, $(block-nested-y))
>
> diff --git a/block/rbd.c b/block/rbd.c
> new file mode 100644
> index 0000000..575e481
> --- /dev/null
> +++ b/block/rbd.c
> @@ -0,0 +1,982 @@
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
> +
> +#include "rbd_types.h"
> +#include "block_int.h"
> +
> +#include<rados/librados.h>
> +
> +
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
> +    int cancelled;
> +} RBDAIOCB;
> +
> +typedef struct RADOSCB {
> +    int rcbid;
> +    RBDAIOCB *acb;
> +    struct BDRVRBDState *s;
> +    int done;
> +    int64_t segsize;
> +    char *buf;
> +    int ret;
> +} RADOSCB;
> +
> +#define RBD_FD_READ 0
> +#define RBD_FD_WRITE 1
> +
> +typedef struct BDRVRBDState {
> +    int fds[2];
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
>    

Passing strings that are expected to be of a certain size is usually bad 
form.  Probably better to pass in the capacity of pool as an additional 
argument.

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
>    

The limits are really weird here.   Is this a RBD limit or just an 
internal thing?

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
>    

You're assuming name is at least RBD_MAX_OBJ_NAME_SIZE but not 
validating that.

Does MAX_OBJ_NAME_SIZE == MAX_SEG_NAME_SIZE because you're assuming so 
above.

> +    *snap = strchr(name, '@');
> +    if (*snap) {
> +        *(*snap) = '\0';
> +        (*snap)++;
> +        if (!*snap) *snap = NULL;
> +    }
> +
> +    return l;
> +}
>    

So snap ends up pointing to a substring in name?  This memory allocation 
is super frail.  I'd suggest rewriting this to make it more robust such 
that all the strings had clear allocation life cycles.  I'd be amazed if 
you didn't have an overflow/leak today.

> +static int create_tmap_op(uint8_t op, const char *name, char **tmap_desc)
> +{
> +    uint32_t len = strlen(name);
> +    /* total_len = encoding op + name + empty buffer */
> +    uint32_t total_len = 1 + (sizeof(uint32_t) + len) + sizeof(uint32_t);
> +    uint8_t *desc = NULL;
> +
> +    desc = qemu_malloc(total_len);
> +
> +    *tmap_desc = (char *)desc;
> +
> +    *desc = op;
> +    desc++;
> +    cpu_to_le32s(&len);
> +    memcpy(desc,&len, sizeof(len));
> +    desc += sizeof(len);
> +    memcpy(desc, name, len);
> +    desc += len;
> +    len = 0; /* no need for endian conversion for 0 */
> +    memcpy(desc,&len, sizeof(len));
> +    desc += sizeof(len);
> +
> +    return (char *)desc - *tmap_desc;
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
> +
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
>    

You're doing the assignment of the return value before you actually do 
the endian conversion.

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
>
>    

sizeof(n) is more defensive.

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
> +/*
> + * This aio completion is being called from rbd_aio_event_reader() and
> + * runs in qemu context. It schedules a bh, but just in case the aio
> + * was not cancelled before.
> + */
> +static void rbd_complete_aio(RADOSCB *rcb)
> +{
> +    RBDAIOCB *acb = rcb->acb;
> +    int64_t r;
> +    int i;
> +
> +    acb->aiocnt--;
> +
> +    if (acb->cancelled) {
> +        if (!acb->aiocnt) {
> +            qemu_vfree(acb->bounce);
> +            qemu_aio_release(acb);
> +        }
> +        goto done;
> +    }
> +
> +    r = rcb->ret;
> +
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
> +    /* Note that acb->bh can be NULL in case where the aio was cancelled */
> +    if (!acb->aiocnt&&  acb->bh) {
> +        qemu_bh_schedule(acb->bh);
> +    }
> +done:
> +    qemu_free(rcb);
> +    i = 0;
> +}
> +
> +/*
> + * aio fd read handler. It runs in the qemu context and calls the
> + * completion handling of completed rados aio operations.
> + */
> +static void rbd_aio_event_reader(void *opaque)
> +{
> +    BDRVRBDState *s = opaque;
> +    RADOSCB *rcb;
> +
> +    ssize_t ret;
> +
> +    do {
> +        if ((ret = read(s->fds[RBD_FD_READ],&rcb, sizeof(rcb)))>  0) {
>    

This is sufficiently exotic that it needs a comment.  I think most 
people's first reaction is that the code is a bug and that it should be 
'rcb, sizeof(*rcb)'.  Passing pointers over a socket is unusual.

> +            rbd_complete_aio(rcb);
> +            s->qemu_aio_count --;
> +        }
> +    } while (ret<  0&&  errno == EINTR);
> +
> +    return;
>    

The return is unnecessary.

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
> +            if (header_snap>  end) {
> +                error_report("bad header, snapshot list broken");
> +            }
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
>    

Missing {}s here and many other places.  Please make sure you're 
following CODING_STYLE.

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
> +    RbdHeader1 *header;
> +    char pool[RBD_MAX_SEG_NAME_SIZE];
> +    char *snap;
> +    char *hbuf = NULL;
> +    int r;
> +
> +    if (rbd_parsename(filename, pool,&snap, s->name)<  0) {
> +        return -EINVAL;
> +    }
>    

In rbd_parsename() you assume pool is 2*RBD_MAX_SEG_NAME_SIZE and here 
it's only RBD_MAX_SEG_NAME_SIZE.

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
>    

Is strncmp really the right function as opposed to memcmp?

> +
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
> +    r = qemu_pipe(s->fds);
> +    if (r<  0) {
> +        error_report("error opening eventfd");
> +        goto failed;
> +    }
> +    fcntl(s->fds[0], F_SETFL, O_NONBLOCK);
> +    fcntl(s->fds[1], F_SETFL, O_NONBLOCK);
>    

You set this to be O_NONBLOCK but in rbd_aio_event_reader you're not 
gracefully handling EAGAIN and partial reads.

> +    qemu_aio_set_fd_handler(s->fds[RBD_FD_READ], rbd_aio_event_reader, NULL,
> +        rbd_aio_flush_cb, NULL, s);
> +
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
> +    close(s->fds[0]);
> +    close(s->fds[1]);
> +    qemu_aio_set_fd_handler(s->fds[RBD_FD_READ], NULL , NULL, NULL, NULL,
> +        NULL);
> +
> +    rados_close_pool(s->header_pool);
> +    rados_close_pool(s->pool);
> +    rados_deinitialize();
> +}
> +
> +/*
> + * Cancel aio. Since we don't reference acb in a non qemu threads,
> + * it is safe to access it here.
> + */
> +static void rbd_aio_cancel(BlockDriverAIOCB *blockacb)
> +{
> +    RBDAIOCB *acb = (RBDAIOCB *) blockacb;
> +    qemu_bh_delete(acb->bh);
> +    acb->bh = NULL;
> +    acb->cancelled = 1;
> +}
> +
> +static AIOPool rbd_aio_pool = {
> +    .aiocb_size = sizeof(RBDAIOCB),
> +    .cancel = rbd_aio_cancel,
> +};
> +
> +/*
> + * This is the callback function for rados_aio_read and _write
> + *
> + * Note: this function is being called from a non qemu thread so
> + * we need to be careful about what we do here. Generally we only
> + * write to the block notification pipe, and do the rest of the
> + * io completion handling from rbd_aio_event_reader() which
> + * runs in a qemu context.
> + */
> +static void rbd_finish_aiocb(rados_completion_t c, RADOSCB *rcb)
> +{
> +    rcb->ret = rados_aio_get_return_value(c);
> +    rados_aio_release(c);
> +    if (write(rcb->s->fds[RBD_FD_WRITE], (void *)&rcb, sizeof(rcb))<  0) {
> +        error_report("failed writing to acb->s->fds\n");
> +        qemu_free(rcb);
> +    }
> +}
>    

You need to handle EAGAIN here.
> +
> +    r = rbd_read_header(s,&hbuf);
> +    if (r<  0) {
> +        error_report("failed reading header: %s", strerror(-r));
> +        return r;
> +    }
> +
> +    RbdHeader1 *header;
> +
> +    header = (RbdHeader1 *) hbuf;
>    

Mixing variable definitions with code (didn't I mention this in the last 
review?).

> +    r = rbd_set_snapc(s->pool, sn_info->name, header);
> +    if (r<  0) {
> +        error_report("failed setting snap context: %s", strerror(-r));
> +        goto failed;
> +    }
> +
> +    return 0;
> +
> +failed:
> +    if (hbuf)
> +        qemu_free(header);
> +    return r;
> +}
> +
> +static int decode32(char **p, const char *end, uint32_t *v)
> +{
> +    if (*p + 4>  end)
> +        return -ERANGE;
> +
> +    *v = *(uint32_t *)(*p);
> +    cpu_to_le32s(v);
> +    *p += 4;
> +    return 0;
> +}
> +
> +static int decode64(char **p, const char *end, uint64_t *v)
> +{
> +    if (*p + 8>  end)
> +        return -ERANGE;
> +
> +    *v = *(uint64_t *)(*p);
> +    cpu_to_le64s(v);
> +    *p += 8;
> +    return 0;
> +}
> +
> +static int decode_str(char **p, const char *end, char **s)
> +{
> +    uint32_t len;
> +    int r;
> +
> +    if ((r = decode32(p, end,&len))<  0)
> +        return r;
> +
> +    *s = qemu_malloc(len + 1);
> +    memcpy(*s, *p, len);
> +    *p += len;
> +    (*s)[len] = '\0';
> +
> +    return len;
> +}
> +
> +static int rbd_snap_list(BlockDriverState *bs, QEMUSnapshotInfo **psn_tab)
> +{
> +    BDRVRBDState *s = bs->opaque;
> +    char n[RBD_MAX_SEG_NAME_SIZE];
> +    QEMUSnapshotInfo *sn_info, *sn_tab = NULL;
> +    char *outbuf = NULL, *end, *buf;
> +    uint64_t len = 1024;
> +    uint64_t snap_seq;
> +    uint32_t snap_count;
> +    int r, i;
> +
> +    snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", s->name, RBD_SUFFIX);
>    

sizeof(n)

> +    while (1) {
> +        qemu_free(outbuf);
> +        outbuf = qemu_malloc(len);
> +
> +        r = rados_exec(s->header_pool, n, "rbd", "snap_list", NULL, 0,
> +                       outbuf, len);
> +        if (r<  0) {
> +            error_report("rbd.snap_list execution failed failed: %s", strerror(-r));
> +            return r;
> +        }
> +        if (r != len)
> +            break;
> +
> +        len *= 2;
> +    }
>    

Is this really the only way to figure out how large the buffer should be??

> +    buf = outbuf;
> +    end = buf + len;
> +
> +    if ((r = decode64(&buf, end,&snap_seq))<  0)
> +        goto done_err;
> +    if ((r = decode32(&buf, end,&snap_count))<  0)
> +        goto done_err;
> +
> +    sn_tab = qemu_mallocz(snap_count * sizeof(QEMUSnapshotInfo));
> +    for (i = 0; i<  snap_count; i++) {
> +        uint64_t id, image_size;
> +        char *snap_name;
> +        int name_len;
> +
> +        if ((r = decode64(&buf, end,&id))<  0)
> +            goto done_err;
> +        if ((r = decode64(&buf, end,&image_size))<  0)
> +            goto done_err;
> +        if ((r = decode_str(&buf, end,&snap_name))<  0)
> +            goto done_err;
> +
> +        name_len = sizeof(sn_info->id_str) - 1;
> +        if (r<  name_len)
> +            name_len = r;
> +
> +        sn_info = sn_tab + i;
> +        pstrcpy(sn_info->id_str, name_len + 1, snap_name);
> +        pstrcpy(sn_info->name, name_len + 1, snap_name);
> +        qemu_free(snap_name);
> +
> +        sn_info->vm_state_size = image_size;
> +        sn_info->date_sec = 0;
> +        sn_info->date_nsec = 0;
> +        sn_info->vm_clock_nsec = 0;
> +    }
> +    *psn_tab = sn_tab;
> +    qemu_free(outbuf);
> +    return snap_count;
> +done_err:
> +    qemu_free(sn_tab);
> +    qemu_free(outbuf);
> +    return r;
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
> +    .bdrv_close         = rbd_close,
> +    .bdrv_create        = rbd_create,
> +    .bdrv_get_info      = rbd_getinfo,
> +    .create_options     = rbd_create_options,
> +    .bdrv_getlength     = rbd_getlength,
> +    .protocol_name      = "rbd",
> +
> +    .bdrv_aio_readv     = rbd_aio_readv,
> +    .bdrv_aio_writev    = rbd_aio_writev,
> +
> +    .bdrv_snapshot_create = rbd_snap_create,
> +    .bdrv_snapshot_list = rbd_snap_list,
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
> index 0000000..c35d840
> --- /dev/null
> +++ b/block/rbd_types.h
> @@ -0,0 +1,71 @@
> +/*
> + * Ceph - scalable distributed file system
> + *
> + * Copyright (C) 2004-2010 Sage Weil<sage@newdream.net>
> + *
> + * This is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License version 2.1, as published by the Free Software
> + * Foundation.  See file COPYING.
> + *
> + */
> +
> +#ifndef CEPH_RBD_TYPES_H
> +#define CEPH_RBD_TYPES_H
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
> +#define RBD_INFO                "rbd_info"
> +
> +#define RBD_DEFAULT_OBJ_ORDER   22   /* 4MB */
> +
> +#define RBD_MAX_OBJ_NAME_SIZE   96
> +#define RBD_MAX_BLOCK_NAME_SIZE 24
> +#define RBD_MAX_SEG_NAME_SIZE   128
> +
> +#define RBD_COMP_NONE           0
> +#define RBD_CRYPT_NONE          0
> +
> +#define RBD_HEADER_TEXT         "<<<  Rados Block Device Image>>>\n"
> +#define RBD_HEADER_SIGNATURE    "RBD"
> +#define RBD_HEADER_VERSION      "001.005"
> +
> +struct rbd_info {
> +    uint64_t max_id;
> +} __attribute__ ((packed));
> +
> +struct rbd_obj_snap_ondisk {
> +    uint64_t id;
> +    uint64_t image_size;
> +} __attribute__((packed));
> +
> +struct rbd_obj_header_ondisk {
> +    char text[40];
> +    char block_name[RBD_MAX_BLOCK_NAME_SIZE];
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
>    

These types don't match QEMU CODING_STYLE.

Regards,

Anthony Liguori

> diff --git a/configure b/configure
> index af50607..5d8f620 100755
> --- a/configure
> +++ b/configure
> @@ -325,6 +325,7 @@ cpu_emulation="yes"
>   check_utests="no"
>   user_pie="no"
>   zero_malloc=""
> +rbd=""
>
>   # OS specific
>   if check_define __linux__ ; then
> @@ -724,6 +725,10 @@ for opt do
>     ;;
>     --*dir)
>     ;;
> +  --disable-rbd) rbd="no"
> +  ;;
> +  --enable-rbd) rbd="yes"
> +  ;;
>     *) echo "ERROR: unknown option $opt"; show_help="yes"
>     ;;
>     esac
> @@ -909,6 +914,7 @@ echo "  --enable-docs            enable documentation build"
>   echo "  --disable-docs           disable documentation build"
>   echo "  --disable-vhost-net      disable vhost-net acceleration support"
>   echo "  --enable-vhost-net       enable vhost-net acceleration support"
> +echo "  --enable-rbd             enable building the rados block device (rbd)"
>   echo ""
>   echo "NOTE: The object files are built at the place where configure is launched"
>   exit 1
> @@ -1755,6 +1761,27 @@ if test "$mingw32" != yes -a "$pthread" = no; then
>   fi
>
>   ##########################################
> +# rbd probe
> +if test "$rbd" != "no" ; then
> +  cat>  $TMPC<<EOF
> +#include<stdio.h>
> +#include<rados/librados.h>
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
>   # linux-aio probe
>
>   if test "$linux_aio" != "no" ; then
> @@ -2256,6 +2283,7 @@ echo "preadv support    $preadv"
>   echo "fdatasync         $fdatasync"
>   echo "uuid support      $uuid"
>   echo "vhost-net support $vhost_net"
> +echo "rbd support       $rbd"
>
>   if test $sdl_too_old = "yes"; then
>   echo "->  Your SDL version is too old - please upgrade to have SDL support"
> @@ -2498,6 +2526,9 @@ echo "CONFIG_UNAME_RELEASE=\"$uname_release\"">>  $config_host_mak
>   if test "$zero_malloc" = "yes" ; then
>     echo "CONFIG_ZERO_MALLOC=y">>  $config_host_mak
>   fi
> +if test "$rbd" = "yes" ; then
> +  echo "CONFIG_RBD=y">>  $config_host_mak
> +fi
>
>   # USB host support
>   case "$usb" in
>    

