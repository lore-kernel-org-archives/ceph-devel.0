From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] ceph/rbd block driver for qemu-kvm (v7)
Date: Thu, 11 Nov 2010 21:09:48 +0000
Message-ID: <AANLkTikE3UX8AxmfiwwVgR7_NxL=p=1CCD+6wwomwBkQ@mail.gmail.com>
References: <20101015195424.GA4094@dell.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36451 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756914Ab0KKVJw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Nov 2010 16:09:52 -0500
In-Reply-To: <20101015195424.GA4094@dell.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, kwolf@redhat.com

On Fri, Oct 15, 2010 at 8:54 PM, Christian Brunner <chb@muc.de> wrote:
> Hi,
>
> once again, Yehuda committed fixes for all the suggestions made on the
> list (and more). Here is the next update for the ceph/rbd block driver.
>
> Please let us know if there are any pending issues.
>
> For those who didn't follow the previous postings:
>
> This is an block driver for the distributed file system Ceph
> (http://ceph.newdream.net/). This driver uses librados (which
> is part of the Ceph server) for direct access to the Ceph object
> store and is running entirely in userspace (Yehuda also
> wrote a driver for the linux kernel, that can be used to access
> rbd volumes as a block device).
>
> Kind Regards,
> Christian
>
> Signed-off-by: Christian Brunner <chb@muc.de>
> Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>
> ---
>  Makefile.objs     |    1 +
>  block/rbd.c       | 1059 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  block/rbd_types.h |   71 ++++
>  configure         |   31 ++
>  4 files changed, 1162 insertions(+), 0 deletions(-)
>  create mode 100644 block/rbd.c
>  create mode 100644 block/rbd_types.h

This patch is close now.  Just some minor issues below.

>
> diff --git a/Makefile.objs b/Makefile.objs
> index 6ee077c..56a13c1 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -19,6 +19,7 @@ block-nested-y += parallels.o nbd.o blkdebug.o
>  block-nested-$(CONFIG_WIN32) += raw-win32.o
>  block-nested-$(CONFIG_POSIX) += raw-posix.o
>  block-nested-$(CONFIG_CURL) += curl.o
> +block-nested-$(CONFIG_RBD) += rbd.o
>
>  block-obj-y +=  $(addprefix block/, $(block-nested-y))
>
> diff --git a/block/rbd.c b/block/rbd.c
> new file mode 100644
> index 0000000..fbfb93e
> --- /dev/null
> +++ b/block/rbd.c
> @@ -0,0 +1,1059 @@
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
> +
> +#include "rbd_types.h"
> +#include "block_int.h"
> +
> +#include <rados/librados.h>
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
> +    int event_reader_pos;
> +    RADOSCB *event_rcb;
> +} BDRVRBDState;
> +
> +typedef struct rbd_obj_header_ondisk RbdHeader1;
> +
> +static int rbd_next_tok(char *dst, int dst_len,
> +                        char *src, char delim,
> +                        const char *name,
> +                        char **p)
> +{
> +    int l;
> +    char *end;
> +
> +    *p = NULL;
> +
> +    if (delim != '\0') {
> +        end = strchr(src, delim);
> +        if (end) {
> +            *p = end + 1;
> +            *end = '\0';
> +        }
> +    }
> +    l = strlen(src);
> +    if (l >= dst_len) {
> +        error_report("%s too long", name);
> +        return -EINVAL;
> +    } else if (l == 0) {
> +        error_report("%s too short", name);
> +        return -EINVAL;
> +    }
> +
> +    pstrcpy(dst, dst_len, src);
> +
> +    return 0;
> +}
> +
> +static int rbd_parsename(const char *filename,
> +                         char *pool, int pool_len,
> +                         char *snap, int snap_len,
> +                         char *name, int name_len)
> +{
> +    const char *start;
> +    char *p, *buf;
> +    int ret;
> +
> +    if (!strstart(filename, "rbd:", &start)) {
> +        return -EINVAL;
> +    }
> +
> +    buf = qemu_strdup(start);
> +    p = buf;
> +
> +    ret = rbd_next_tok(pool, pool_len, p, '/', "pool name", &p);
> +    if (ret < 0 || !p) {
> +        ret = -EINVAL;
> +        goto done;
> +    }
> +    ret = rbd_next_tok(name, name_len, p, '@', "object name", &p);
> +    if (ret < 0) {
> +        goto done;
> +    }
> +    if (!p) {
> +        *snap = '\0';
> +        goto done;
> +    }
> +
> +    ret = rbd_next_tok(snap, snap_len, p, '\0', "snap name", &p);
> +
> +done:
> +    qemu_free(buf);
> +    return ret;
> +}
> +
> +static int create_tmap_op(uint8_t op, const char *name, char **tmap_desc)
> +{
> +    uint32_t len = strlen(name);
> +    uint32_t len_le = cpu_to_le32(len);
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
> +    memcpy(desc, &len_le, sizeof(len_le));
> +    desc += sizeof(len_le);
> +    memcpy(desc, name, len);
> +    desc += len;
> +    len = 0; /* no need for endian conversion for 0 */
> +    memcpy(desc, &len, sizeof(len));
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
> +static int touch_rbd_info(rados_pool_t pool, const char *info_oid)
> +{
> +    int r = rados_write(pool, info_oid, 0, NULL, 0);
> +    if (r < 0) {
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
> +    if (r < 0) {
> +        return r;
> +    }
> +
> +    r = rados_exec(pool, info_oid, "rbd", "assign_bid", NULL,
> +                   0, (char *)out, sizeof(out));
> +    if (r < 0) {
> +        return r;
> +    }
> +
> +    le64_to_cpus(out);
> +    *id = out[0];
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
> +    char name[RBD_MAX_OBJ_NAME_SIZE];
> +    char snap_buf[RBD_MAX_SEG_NAME_SIZE];
> +    char *snap = NULL;
> +    RbdHeader1 header;
> +    rados_pool_t p;
> +    uint64_t bid;
> +    uint32_t hi, lo;
> +    int ret;
> +
> +    if (rbd_parsename(filename,
> +                      pool, sizeof(pool),
> +                      snap_buf, sizeof(snap_buf),
> +                      name, sizeof(name)) < 0) {
> +        return -EINVAL;
> +    }
> +    if (snap_buf[0] != '\0') {
> +        snap = snap_buf;
> +    }
> +
> +    snprintf(n, sizeof(n), "%s%s", name, RBD_SUFFIX);
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

You can replace the loop with:

obj_order = ffs(objsize) - 1;

> +            }
> +        }
> +        options++;
> +    }
> +
> +    memset(&header, 0, sizeof(header));
> +    pstrcpy(header.text, sizeof(header.text), RBD_HEADER_TEXT);
> +    pstrcpy(header.signature, sizeof(header.signature), RBD_HEADER_SIGNATURE);
> +    pstrcpy(header.version, sizeof(header.version), RBD_HEADER_VERSION);
> +    header.image_size = cpu_to_le64(bytes);
> +    header.options.order = obj_order;
> +    header.options.crypt_type = RBD_CRYPT_NONE;
> +    header.options.comp_type = RBD_COMP_NONE;
> +    header.snap_seq = 0;
> +    header.snap_count = 0;
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
> +    ret = rbd_assign_bid(p, &bid);
> +    if (ret < 0) {
> +        error_report("failed assigning block id");
> +        rados_deinitialize();
> +        return -EIO;
> +    }
> +    hi = bid >> 32;
> +    lo = bid & 0xFFFFFFFF;
> +    snprintf(header.block_name, sizeof(header.block_name), "rb.%x.%x", hi, lo);
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

What about acb->bh?  It's easiest to keep acb->bh NULL most of the time and
only allocate it before scheduling and deleting it in the bh function.

> +        }
> +        goto done;
> +    }
> +
> +    r = rcb->ret;
> +
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

Should we memset(rcb->buf + r, 0, rcb->segsize) here to avoid copying
uninitialized heap data into the guest later?

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
> +    /* Note that acb->bh can be NULL in case where the aio was cancelled */
> +    if (!acb->aiocnt && acb->bh) {
> +        qemu_bh_schedule(acb->bh);
> +    }
> +done:
> +    qemu_free(rcb);
> +    i = 0;

i isn't used.

> +}
> +
> +/*
> + * aio fd read handler. It runs in the qemu context and calls the
> + * completion handling of completed rados aio operations.
> + */
> +static void rbd_aio_event_reader(void *opaque)
> +{
> +    BDRVRBDState *s = opaque;
> +
> +    ssize_t ret;
> +
> +    do {
> +        char *p = (char *)&s->event_rcb;
> +
> +        /* now read the rcb pointer that was sent from a non qemu thread */
> +        if ((ret = read(s->fds[RBD_FD_READ], p + s->event_reader_pos,
> +                        sizeof(s->event_rcb) - s->event_reader_pos)) > 0) {
> +            if (ret > 0) {
> +                s->event_reader_pos += ret;
> +                if (s->event_reader_pos == sizeof(s->event_rcb)) {
> +                    s->event_reader_pos = 0;
> +                    rbd_complete_aio(s->event_rcb);
> +                    s->qemu_aio_count --;
> +                }
> +            }
> +        }
> +    } while (ret < 0 && errno == EINTR);
> +}
> +
> +static int rbd_aio_flush_cb(void *opaque)
> +{
> +    BDRVRBDState *s = opaque;
> +
> +    return (s->qemu_aio_count > 0);
> +}
> +
> +
> +static int rbd_set_snapc(rados_pool_t pool, const char *snap, RbdHeader1 *header)
> +{
> +    uint32_t snap_count = le32_to_cpu(header->snap_count);
> +    rados_snap_t *snaps = NULL;
> +    rados_snap_t seq;
> +    uint32_t i;
> +    uint64_t snap_names_len = le64_to_cpu(header->snap_names_len);
> +    int r;
> +    rados_snap_t snapid = 0;
> +
> +    if (snap_count) {
> +        const char *header_snap = (const char *)&header->snaps[snap_count];
> +        const char *end = header_snap + snap_names_len;
> +        snaps = qemu_malloc(sizeof(rados_snap_t) * header->snap_count);
> +
> +        for (i=0; i < snap_count; i++) {
> +            snaps[i] = le64_to_cpu(header->snaps[i].id);
> +
> +            if (snap && strcmp(snap, header_snap) == 0) {
> +                snapid = snaps[i];
> +            }
> +
> +            header_snap += strlen(header_snap) + 1;
> +            if (header_snap > end) {
> +                error_report("bad header, snapshot list broken");
> +            }
> +        }
> +    }
> +
> +    if (snap && !snapid) {
> +        error_report("snapshot not found");
> +        qemu_free(snaps);
> +        return -ENOENT;
> +    }
> +    seq = le32_to_cpu(header->snap_seq);
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
> +    snprintf(n, sizeof(n), "%s%s", s->name, RBD_SUFFIX);
> +
> +    buf = qemu_malloc(len);
> +
> +    r = rados_read(s->header_pool, n, 0, buf, len);
> +    if (r < 0) {
> +        goto failed;
> +    }
> +
> +    if (r < len)
> +        goto done;

QEMU coding style always uses curly brackets, even when the if statement body
is only one line.  There are other occurrences further down, please fix them.

> +
> +    qemu_free(buf);
> +    buf = qemu_malloc(len);
> +
> +    r = rados_stat(s->header_pool, n, &len, NULL);
> +    if (r < 0) {
> +        goto failed;
> +    }
> +
> +    r = rados_read(s->header_pool, n, 0, buf, len);
> +    if (r < 0) {
> +        goto failed;
> +    }
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
> +    char snap_buf[RBD_MAX_SEG_NAME_SIZE];
> +    char *snap = NULL;
> +    char *hbuf = NULL;
> +    int r;
> +
> +    if (rbd_parsename(filename, pool, sizeof(pool),
> +                      snap_buf, sizeof(snap_buf),
> +                      s->name, sizeof(s->name)) < 0) {
> +        return -EINVAL;
> +    }
> +    if (snap_buf[0] != '\0') {
> +        snap = snap_buf;
> +    }
> +
> +    if ((r = rados_initialize(0, NULL)) < 0) {
> +        error_report("error initializing");
> +        return r;
> +    }

Does rados_initialize() work when called multiple times?  This would happen if
the VM has several rbd devices attached.

> +
> +    if ((r = rados_open_pool(pool, &s->pool))) {
> +        error_report("error opening pool %s", pool);
> +        rados_deinitialize();
> +        return r;
> +    }
> +
> +    if ((r = rados_open_pool(pool, &s->header_pool))) {
> +        error_report("error opening pool %s", pool);
> +        rados_deinitialize();
> +        return r;
> +    }
> +
> +   if ((r = rbd_read_header(s, &hbuf)) < 0) {

3 space indentation.

> +        error_report("error reading header from %s", s->name);
> +        goto failed;
> +    }
> +
> +    if (memcmp(hbuf + 64, RBD_HEADER_SIGNATURE, 4)) {
> +        error_report("Invalid header signature %s", hbuf + 64);

If it is invalid then printing it as a string is dangerous.  A whole bunch of
binary junk may be printed.

> +        r = -EMEDIUMTYPE;
> +        goto failed;
> +    }
> +
> +    if (memcmp(hbuf + 68, RBD_HEADER_VERSION, 8)) {
> +        error_report("Unknown image version %s", hbuf + 68);

Same comment about printing invalid binary data as a string.

> +        r = -EMEDIUMTYPE;
> +        goto failed;
> +    }
> +
> +    header = (RbdHeader1 *) hbuf;
> +    s->size = le64_to_cpu(header->image_size);
> +    s->objsize = 1 << header->options.order;

I think you need the following for the full 64-bit range:

s->objsize = 1ULL << header->options.order;

> +    memcpy(s->block_name, header->block_name, sizeof(header->block_name));
> +
> +    r = rbd_set_snapc(s->pool, snap, header);
> +    if (r < 0) {
> +        error_report("failed setting snap context: %s", strerror(-r));
> +        goto failed;
> +    }
> +
> +    s->read_only = (snap != NULL);

read_only is unused.  You can remove the field from BDRVRBDState and use:

bs->read_only = (snap != NULL);

> +
> +    s->event_reader_pos = 0;
> +    r = qemu_pipe(s->fds);
> +    if (r < 0) {
> +        error_report("error opening eventfd");
> +        goto failed;
> +    }
> +    fcntl(s->fds[0], F_SETFL, O_NONBLOCK);
> +    fcntl(s->fds[1], F_SETFL, O_NONBLOCK);
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

qemu_free(NULL) is a nop, no need to check that hbuf != NULL.  The same code is
repeated further down in this patch.

> +
> +    rados_close_pool(s->header_pool);
> +    rados_close_pool(s->pool);
> +    rados_deinitialize();

What if two rbd images are currently open, is it safe to call
rados_deinitialize()?  The same applies to rbd_close().

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
> +    int ret;
> +    rcb->ret = rados_aio_get_return_value(c);
> +    rados_aio_release(c);
> +    while (1) {
> +        fd_set wfd;
> +        int fd = rcb->s->fds[RBD_FD_WRITE];
> +
> +        /* send the rcb pointer to the qemu thread that is responsible
> +           for the aio completion. Must do it in a qemu thread context */
> +        ret = write(fd, (void *)&rcb, sizeof(rcb));
> +        if (ret >= 0)
> +            break;
> +        if (errno == EINTR)
> +            continue;
> +        if (errno != EAGAIN)
> +            break;
> +
> +        FD_ZERO(&wfd);
> +        FD_SET(fd, &wfd);
> +        do {
> +            ret = select(fd + 1, NULL, &wfd, NULL, NULL);
> +        } while (ret < 0 && errno == EINTR);
> +    }
> +
> +    if (ret < 0) {
> +        error_report("failed writing to acb->s->fds\n");
> +        qemu_free(rcb);
> +    }
> +}
> +
> +/* Callback when all queued rados_aio requests are complete */
> +
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
> +
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
> +    acb->cancelled = 0;
> +    acb->bh = qemu_bh_new(rbd_aio_bh_cb, acb);
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
> +    s->qemu_aio_count += acb->aiocnt; /* All the RADOSCB */
> +
> +    while (size > 0) {
> +        if (size < segsize) {
> +            segsize = size;
> +        }
> +
> +        snprintf(n, sizeof(n), "%s.%012" PRIx64, s->block_name,
> +                 segnr);
> +
> +        rcb = qemu_malloc(sizeof(RADOSCB));
> +        rcb->done = 0;
> +        rcb->acb = acb;
> +        rcb->segsize = segsize;
> +        rcb->buf = buf;
> +        rcb->s = acb->s;
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
> +    RbdHeader1 *header;
> +
> +    if (sn_info->name[0] == '\0')
> +        return -EINVAL; /* we need a name for rbd snapshots */
> +
> +    /*
> +     * rbd snapshots are using the name as the user controlled unique identifier
> +     * we can't use the rbd snapid for that purpose, as it can't be set
> +     */
> +    if (sn_info->id_str[0] != '\0' &&
> +        strcmp(sn_info->id_str, sn_info->name) != 0)
> +        return -EINVAL;
> +
> +    if (strlen(sn_info->name) >= sizeof(sn_info->id_str))
> +        return -ERANGE;
> +
> +    r = rados_selfmanaged_snap_create(s->header_pool, &snap_id);
> +    if (r < 0) {
> +        error_report("failed to create snap id: %s", strerror(-r));
> +        return r;
> +    }
> +
> +    *(uint32_t *)p = strlen(sn_info->name);
> +    cpu_to_le32s((uint32_t *)p);
> +    p += sizeof(uint32_t);
> +    strncpy(p, sn_info->name, end - p);
> +    p += strlen(p);
> +    if (p + sizeof(snap_id) > end) {
> +        error_report("invalid input parameter");
> +        return -EINVAL;
> +    }
> +
> +    *(uint64_t *)p = snap_id;
> +    cpu_to_le64s((uint64_t *)p);
> +
> +    snprintf(n, sizeof(n), "%s%s", s->name, RBD_SUFFIX);
> +
> +    r = rados_exec(s->header_pool, n, "rbd", "snap_add", inbuf,
> +                   sizeof(inbuf), outbuf, sizeof(outbuf));
> +    if (r < 0) {
> +        error_report("rbd.snap_add execution failed failed: %s", strerror(-r));
> +        return r;
> +    }
> +
> +    sprintf(sn_info->id_str, "%s", sn_info->name);
> +
> +    r = rbd_read_header(s, &hbuf);
> +    if (r < 0) {
> +        error_report("failed reading header: %s", strerror(-r));
> +        return r;
> +    }
> +
> +    header = (RbdHeader1 *) hbuf;
> +    r = rbd_set_snapc(s->pool, sn_info->name, header);
> +    if (r < 0) {
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
> +    if (*p + 4 > end)
> +        return -ERANGE;
> +
> +    *v = *(uint32_t *)(*p);
> +    cpu_to_le32s(v);

Should this be le32_to_cpus(v)?

> +    *p += 4;
> +    return 0;
> +}
> +
> +static int decode64(char **p, const char *end, uint64_t *v)
> +{
> +    if (*p + 8 > end)
> +        return -ERANGE;
> +
> +    *v = *(uint64_t *)(*p);
> +    cpu_to_le64s(v);

Should this be le64_to_cpus(v)?

> +    *p += 8;
> +    return 0;
> +}
> +
> +static int decode_str(char **p, const char *end, char **s)
> +{
> +    uint32_t len;
> +    int r;
> +
> +    if ((r = decode32(p, end, &len)) < 0)
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
> +    RbdHeader1 *header;
> +    char *hbuf = NULL;
> +    char *outbuf = NULL, *end, *buf;
> +    uint64_t len;
> +    uint64_t snap_seq;
> +    uint32_t snap_count;
> +    int r, i;
> +
> +    if ((r = rbd_read_header(s, &hbuf)) < 0) {
> +        goto done_err;
> +    }
> +    header = (RbdHeader1 *)hbuf;
> +    len = le64_to_cpu(header->snap_names_len);
> +    len += 1024; /* should have already been enough, but new snapshots might
> +                    already been created since we read the header, just allocate
> +                    a bit more, so that in most cases it'll suffice anyway */
> +    snprintf(n, sizeof(n), "%s%s", s->name, RBD_SUFFIX);
> +    while (1) {
> +        qemu_free(outbuf);
> +        outbuf = qemu_malloc(len);
> +
> +        r = rados_exec(s->header_pool, n, "rbd", "snap_list", NULL, 0,
> +                       outbuf, len);
> +        if (r < 0) {
> +            error_report("rbd.snap_list execution failed failed: %s", strerror(-r));
> +            goto done_err;
> +        }
> +        if (r != len)
> +            break;
> +
> +        /* if we're here, we probably raced with some snaps creation */
> +        len *= 2;
> +    }
> +    buf = outbuf;
> +    end = buf + len;
> +
> +    if ((r = decode64(&buf, end, &snap_seq)) < 0) {
> +        goto done_err;
> +    }
> +    if ((r = decode32(&buf, end, &snap_count)) < 0) {
> +        goto done_err;
> +    }
> +
> +    sn_tab = qemu_mallocz(snap_count * sizeof(QEMUSnapshotInfo));
> +    for (i = 0; i < snap_count; i++) {
> +        uint64_t id, image_size;
> +        char *snap_name;
> +        int name_len;
> +
> +        if ((r = decode64(&buf, end, &id)) < 0) {
> +            goto done_err;
> +        }
> +        if ((r = decode64(&buf, end, &image_size)) < 0) {
> +            goto done_err;
> +        }
> +        if ((r = decode_str(&buf, end, &snap_name)) < 0) {
> +            goto done_err;
> +        }
> +
> +        name_len = sizeof(sn_info->id_str) - 1;
> +        if (r < name_len)
> +            name_len = r;
> +
> +        sn_info = sn_tab + i;
> +        pstrcpy(sn_info->id_str, name_len + 1, snap_name);
> +        pstrcpy(sn_info->name, name_len + 1, snap_name);
> +        qemu_free(snap_name);

Maybe I'm missing something but it looks like the following would work too and
eliminates name_len.  Also id_str and name are not the same size:

pstrcpy(sn_info->id_str, sizeof(sn_info->id_str), snap_name);
pstrcpy(sn_info->name, sizeof(sn_info->name), snap_name);

Are you truncating name on purpose?

> +
> +        sn_info->vm_state_size = image_size;
> +        sn_info->date_sec = 0;
> +        sn_info->date_nsec = 0;
> +        sn_info->vm_clock_nsec = 0;
> +    }
> +    *psn_tab = sn_tab;
> +    qemu_free(outbuf);

Looks like hbuf is leaked.  I think the safest solution is to free hbuf right
after calculating len.  Then the return/error paths don't need to remember to
free it.

> +    return snap_count;
> +done_err:
> +    qemu_free(hbuf);
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
> + * Copyright (C) 2004-2010 Sage Weil <sage@newdream.net>
> + *
> + * This is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License version 2.1, as published by the Free Software
> + * Foundation.  See file COPYING.

The LGPL license is in COPYING.LIB.

Stefan
