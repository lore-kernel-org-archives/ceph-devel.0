From: Christian Brunner <chb@muc.de>
Subject: Re: [Qemu-devel] [PATCH v4 1/4] rbd: use the higher level librbd
 instead of just librados
Date: Wed, 25 May 2011 21:18:46 +0200
Message-ID: <BANLkTi=wf9BKHgGxFMq6uLFdp1SQdXrigA@mail.gmail.com>
References: <1306263078-18089-1-git-send-email-josh.durgin@dreamhost.com>
	<1306263078-18089-2-git-send-email-josh.durgin@dreamhost.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44262 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab1EYTSr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 15:18:47 -0400
In-Reply-To: <1306263078-18089-2-git-send-email-josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, ceph-devel@vger.kernel.org

Apart from two cosmetic issues (see below), I think this patch is
ready to replace the old rbd driver. You can add:

Reviewed-by: Christian Brunner <chb@muc.de>

Regards
Christian

2011/5/24 Josh Durgin <josh.durgin@dreamhost.com>:
> librbd stacks on top of librados to provide access
> to rbd images.
>
> Using librbd simplifies the qemu code, and allows
> qemu to use new versions of the rbd format
> with few (if any) changes.
>
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>
> ---
> =A0block/rbd.c =A0 =A0 =A0 | =A0790 +++++++++++++++------------------=
--------------------
> =A0block/rbd_types.h | =A0 71 -----
> =A0configure =A0 =A0 =A0 =A0 | =A0 33 +--
> =A03 files changed, 224 insertions(+), 670 deletions(-)
> =A0delete mode 100644 block/rbd_types.h
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 249a590..1c8e7c7 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -1,20 +1,22 @@
> =A0/*
> =A0* QEMU Block driver for RADOS (Ceph)
> =A0*
> - * Copyright (C) 2010 Christian Brunner <chb@muc.de>
> + * Copyright (C) 2010-2011 Christian Brunner <chb@muc.de>,
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Josh Durgin <josh=
=2Edurgin@dreamhost.com>
> =A0*
> =A0* This work is licensed under the terms of the GNU GPL, version 2.=
 =A0See
> =A0* the COPYING file in the top-level directory.
> =A0*
> =A0*/
>
> +#include <inttypes.h>
> +
> =A0#include "qemu-common.h"
> =A0#include "qemu-error.h"
>
> -#include "rbd_types.h"
> =A0#include "block_int.h"
>
> -#include <rados/librados.h>
> +#include <rbd/librbd.h>
>
>
>
> @@ -40,6 +42,12 @@
>
> =A0#define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
>
> +#define RBD_MAX_CONF_NAME_SIZE 128
> +#define RBD_MAX_CONF_VAL_SIZE 512
> +#define RBD_MAX_CONF_SIZE 1024
> +#define RBD_MAX_POOL_NAME_SIZE 128
> +#define RBD_MAX_SNAP_NAME_SIZE 128
> +
> =A0typedef struct RBDAIOCB {
> =A0 =A0 BlockDriverAIOCB common;
> =A0 =A0 QEMUBH *bh;
> @@ -48,7 +56,6 @@ typedef struct RBDAIOCB {
> =A0 =A0 char *bounce;
> =A0 =A0 int write;
> =A0 =A0 int64_t sector_num;
> - =A0 =A0int aiocnt;
> =A0 =A0 int error;
> =A0 =A0 struct BDRVRBDState *s;
> =A0 =A0 int cancelled;
> @@ -59,7 +66,7 @@ typedef struct RADOSCB {
> =A0 =A0 RBDAIOCB *acb;
> =A0 =A0 struct BDRVRBDState *s;
> =A0 =A0 int done;
> - =A0 =A0int64_t segsize;
> + =A0 =A0int64_t size;
> =A0 =A0 char *buf;
> =A0 =A0 int ret;
> =A0} RADOSCB;
> @@ -69,25 +76,22 @@ typedef struct RADOSCB {
>
> =A0typedef struct BDRVRBDState {
> =A0 =A0 int fds[2];
> - =A0 =A0rados_pool_t pool;
> - =A0 =A0rados_pool_t header_pool;
> - =A0 =A0char name[RBD_MAX_OBJ_NAME_SIZE];
> - =A0 =A0char block_name[RBD_MAX_BLOCK_NAME_SIZE];
> - =A0 =A0uint64_t size;
> - =A0 =A0uint64_t objsize;
> + =A0 =A0rados_t cluster;
> + =A0 =A0rados_ioctx_t io_ctx;
> + =A0 =A0rbd_image_t image;
> + =A0 =A0char name[RBD_MAX_IMAGE_NAME_SIZE];
> =A0 =A0 int qemu_aio_count;
> + =A0 =A0char *snap;
> =A0 =A0 int event_reader_pos;
> =A0 =A0 RADOSCB *event_rcb;
> =A0} BDRVRBDState;
>
> -typedef struct rbd_obj_header_ondisk RbdHeader1;
> -
> =A0static void rbd_aio_bh_cb(void *opaque);
>
> -static int rbd_next_tok(char *dst, int dst_len,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *src, char deli=
m,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *name,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char **p)
> +static int qemu_rbd_next_tok(char *dst, int dst_len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *src, =
char delim,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char =
*name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char **p)
> =A0{
> =A0 =A0 int l;
> =A0 =A0 char *end;
> @@ -115,10 +119,10 @@ static int rbd_next_tok(char *dst, int dst_len,
> =A0 =A0 return 0;
> =A0}
>
> -static int rbd_parsename(const char *filename,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *pool, int poo=
l_len,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *snap, int sna=
p_len,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *name, int nam=
e_len)
> +static int qemu_rbd_parsename(const char *filename,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *po=
ol, int pool_len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *sn=
ap, int snap_len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *na=
me, int name_len)
> =A0{
> =A0 =A0 const char *start;
> =A0 =A0 char *p, *buf;
> @@ -131,12 +135,12 @@ static int rbd_parsename(const char *filename,
> =A0 =A0 buf =3D qemu_strdup(start);
> =A0 =A0 p =3D buf;
>
> - =A0 =A0ret =3D rbd_next_tok(pool, pool_len, p, '/', "pool name", &p=
);
> + =A0 =A0ret =3D qemu_rbd_next_tok(pool, pool_len, p, '/', "pool name=
", &p);
> =A0 =A0 if (ret < 0 || !p) {
> =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> =A0 =A0 =A0 =A0 goto done;
> =A0 =A0 }
> - =A0 =A0ret =3D rbd_next_tok(name, name_len, p, '@', "object name", =
&p);
> + =A0 =A0ret =3D qemu_rbd_next_tok(name, name_len, p, '@', "object na=
me", &p);
> =A0 =A0 if (ret < 0) {
> =A0 =A0 =A0 =A0 goto done;
> =A0 =A0 }
> @@ -145,123 +149,35 @@ static int rbd_parsename(const char *filename,
> =A0 =A0 =A0 =A0 goto done;
> =A0 =A0 }
>
> - =A0 =A0ret =3D rbd_next_tok(snap, snap_len, p, '\0', "snap name", &=
p);
> + =A0 =A0ret =3D qemu_rbd_next_tok(snap, snap_len, p, '\0', "snap nam=
e", &p);
>
> =A0done:
> =A0 =A0 qemu_free(buf);
> =A0 =A0 return ret;
> =A0}
>
> -static int create_tmap_op(uint8_t op, const char *name, char **tmap_=
desc)
> -{
> - =A0 =A0uint32_t len =3D strlen(name);
> - =A0 =A0uint32_t len_le =3D cpu_to_le32(len);
> - =A0 =A0/* total_len =3D encoding op + name + empty buffer */
> - =A0 =A0uint32_t total_len =3D 1 + (sizeof(uint32_t) + len) + sizeof=
(uint32_t);
> - =A0 =A0uint8_t *desc =3D NULL;
> -
> - =A0 =A0desc =3D qemu_malloc(total_len);
> -
> - =A0 =A0*tmap_desc =3D (char *)desc;
> -
> - =A0 =A0*desc =3D op;
> - =A0 =A0desc++;
> - =A0 =A0memcpy(desc, &len_le, sizeof(len_le));
> - =A0 =A0desc +=3D sizeof(len_le);
> - =A0 =A0memcpy(desc, name, len);
> - =A0 =A0desc +=3D len;
> - =A0 =A0len =3D 0; /* no need for endian conversion for 0 */
> - =A0 =A0memcpy(desc, &len, sizeof(len));
> - =A0 =A0desc +=3D sizeof(len);
> -
> - =A0 =A0return (char *)desc - *tmap_desc;
> -}
> -
> -static void free_tmap_op(char *tmap_desc)
> -{
> - =A0 =A0qemu_free(tmap_desc);
> -}
> -
> -static int rbd_register_image(rados_pool_t pool, const char *name)
> -{
> - =A0 =A0char *tmap_desc;
> - =A0 =A0const char *dir =3D RBD_DIRECTORY;
> - =A0 =A0int ret;
> -
> - =A0 =A0ret =3D create_tmap_op(CEPH_OSD_TMAP_SET, name, &tmap_desc);
> - =A0 =A0if (ret < 0) {
> - =A0 =A0 =A0 =A0return ret;
> - =A0 =A0}
> -
> - =A0 =A0ret =3D rados_tmap_update(pool, dir, tmap_desc, ret);
> - =A0 =A0free_tmap_op(tmap_desc);
> -
> - =A0 =A0return ret;
> -}
> -
> -static int touch_rbd_info(rados_pool_t pool, const char *info_oid)
> -{
> - =A0 =A0int r =3D rados_write(pool, info_oid, 0, NULL, 0);
> - =A0 =A0if (r < 0) {
> - =A0 =A0 =A0 =A0return r;
> - =A0 =A0}
> - =A0 =A0return 0;
> -}
> -
> -static int rbd_assign_bid(rados_pool_t pool, uint64_t *id)
> -{
> - =A0 =A0uint64_t out[1];
> - =A0 =A0const char *info_oid =3D RBD_INFO;
> -
> - =A0 =A0*id =3D 0;
> -
> - =A0 =A0int r =3D touch_rbd_info(pool, info_oid);
> - =A0 =A0if (r < 0) {
> - =A0 =A0 =A0 =A0return r;
> - =A0 =A0}
> -
> - =A0 =A0r =3D rados_exec(pool, info_oid, "rbd", "assign_bid", NULL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, (char *)out, sizeof(out));
> - =A0 =A0if (r < 0) {
> - =A0 =A0 =A0 =A0return r;
> - =A0 =A0}
> -
> - =A0 =A0le64_to_cpus(out);
> - =A0 =A0*id =3D out[0];
> -
> - =A0 =A0return 0;
> -}
> -
> -static int rbd_create(const char *filename, QEMUOptionParameter *opt=
ions)
> +static int qemu_rbd_create(const char *filename, QEMUOptionParameter=
 *options)
> =A0{
> =A0 =A0 int64_t bytes =3D 0;
> =A0 =A0 int64_t objsize;
> - =A0 =A0uint64_t size;
> - =A0 =A0time_t mtime;
> - =A0 =A0uint8_t obj_order =3D RBD_DEFAULT_OBJ_ORDER;
> - =A0 =A0char pool[RBD_MAX_SEG_NAME_SIZE];
> - =A0 =A0char n[RBD_MAX_SEG_NAME_SIZE];
> - =A0 =A0char name[RBD_MAX_OBJ_NAME_SIZE];
> - =A0 =A0char snap_buf[RBD_MAX_SEG_NAME_SIZE];
> + =A0 =A0int obj_order =3D 0;
> + =A0 =A0char pool[RBD_MAX_POOL_NAME_SIZE];
> + =A0 =A0char name[RBD_MAX_IMAGE_NAME_SIZE];
> + =A0 =A0char snap_buf[RBD_MAX_SNAP_NAME_SIZE];
> =A0 =A0 char *snap =3D NULL;
> - =A0 =A0RbdHeader1 header;
> - =A0 =A0rados_pool_t p;
> - =A0 =A0uint64_t bid;
> - =A0 =A0uint32_t hi, lo;
> + =A0 =A0rados_t cluster;
> + =A0 =A0rados_ioctx_t io_ctx;
> =A0 =A0 int ret;
>
> - =A0 =A0if (rbd_parsename(filename,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pool, sizeof(pool),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snap_buf, sizeof(snap_bu=
f),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name, sizeof(name)) < 0)=
 {
> + =A0 =A0if (qemu_rbd_parsename(filename, pool, sizeof(pool),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snap_buf, sizeo=
f(snap_buf),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name, sizeof(na=
me)) < 0) {
> =A0 =A0 =A0 =A0 return -EINVAL;
> =A0 =A0 }
> =A0 =A0 if (snap_buf[0] !=3D '\0') {
> =A0 =A0 =A0 =A0 snap =3D snap_buf;
> =A0 =A0 }
>
> - =A0 =A0snprintf(n, sizeof(n), "%s%s", name, RBD_SUFFIX);
> -
> =A0 =A0 /* Read out options */
> =A0 =A0 while (options && options->name) {
> =A0 =A0 =A0 =A0 if (!strcmp(options->name, BLOCK_OPT_SIZE)) {
> @@ -277,82 +193,55 @@ static int rbd_create(const char *filename, QEM=
UOptionParameter *options)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error_report("obj size too sm=
all");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 obj_order =3D ffs(objsize) - 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0obj_order =3D ffs(objsize) - 1;
> =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 options++;
> =A0 =A0 }
>
> - =A0 =A0memset(&header, 0, sizeof(header));
> - =A0 =A0pstrcpy(header.text, sizeof(header.text), RBD_HEADER_TEXT);
> - =A0 =A0pstrcpy(header.signature, sizeof(header.signature), RBD_HEAD=
ER_SIGNATURE);
> - =A0 =A0pstrcpy(header.version, sizeof(header.version), RBD_HEADER_V=
ERSION);
> - =A0 =A0header.image_size =3D cpu_to_le64(bytes);
> - =A0 =A0header.options.order =3D obj_order;
> - =A0 =A0header.options.crypt_type =3D RBD_CRYPT_NONE;
> - =A0 =A0header.options.comp_type =3D RBD_COMP_NONE;
> - =A0 =A0header.snap_seq =3D 0;
> - =A0 =A0header.snap_count =3D 0;
> -
> - =A0 =A0if (rados_initialize(0, NULL) < 0) {
> + =A0 =A0if (rados_create(&cluster, NULL) < 0) {
> =A0 =A0 =A0 =A0 error_report("error initializing");
> =A0 =A0 =A0 =A0 return -EIO;
> =A0 =A0 }
>
> - =A0 =A0if (rados_open_pool(pool, &p)) {
> - =A0 =A0 =A0 =A0error_report("error opening pool %s", pool);
> - =A0 =A0 =A0 =A0rados_deinitialize();
> + =A0 =A0if (rados_conf_read_file(cluster, NULL) < 0) {
> + =A0 =A0 =A0 =A0error_report("error reading config file");
> + =A0 =A0 =A0 =A0rados_shutdown(cluster);
> =A0 =A0 =A0 =A0 return -EIO;
> =A0 =A0 }
>
> - =A0 =A0/* check for existing rbd header file */
> - =A0 =A0ret =3D rados_stat(p, n, &size, &mtime);
> - =A0 =A0if (ret =3D=3D 0) {
> - =A0 =A0 =A0 =A0ret=3D-EEXIST;
> - =A0 =A0 =A0 =A0goto done;
> - =A0 =A0}
> -
> - =A0 =A0ret =3D rbd_assign_bid(p, &bid);
> - =A0 =A0if (ret < 0) {
> - =A0 =A0 =A0 =A0error_report("failed assigning block id");
> - =A0 =A0 =A0 =A0rados_deinitialize();
> + =A0 =A0if (rados_connect(cluster) < 0) {
> + =A0 =A0 =A0 =A0error_report("error connecting");
> + =A0 =A0 =A0 =A0rados_shutdown(cluster);
> =A0 =A0 =A0 =A0 return -EIO;
> =A0 =A0 }
> - =A0 =A0hi =3D bid >> 32;
> - =A0 =A0lo =3D bid & 0xFFFFFFFF;
> - =A0 =A0snprintf(header.block_name, sizeof(header.block_name), "rb.%=
x.%x", hi, lo);
>
> - =A0 =A0/* create header file */
> - =A0 =A0ret =3D rados_write(p, n, 0, (const char *)&header, sizeof(h=
eader));
> - =A0 =A0if (ret < 0) {
> - =A0 =A0 =A0 =A0goto done;
> + =A0 =A0if (rados_ioctx_create(cluster, pool, &io_ctx) < 0) {
> + =A0 =A0 =A0 =A0error_report("error opening pool %s", pool);
> + =A0 =A0 =A0 =A0rados_shutdown(cluster);
> + =A0 =A0 =A0 =A0return -EIO;
> =A0 =A0 }
>
> - =A0 =A0ret =3D rbd_register_image(p, name);
> -done:
> - =A0 =A0rados_close_pool(p);
> - =A0 =A0rados_deinitialize();
> + =A0 =A0ret =3D rbd_create(io_ctx, name, bytes, &obj_order);
> + =A0 =A0rados_ioctx_destroy(io_ctx);
> + =A0 =A0rados_shutdown(cluster);
>
> =A0 =A0 return ret;
> =A0}
>
> =A0/*
> - * This aio completion is being called from rbd_aio_event_reader() a=
nd
> - * runs in qemu context. It schedules a bh, but just in case the aio
> + * This aio completion is being called from qemu_rbd_aio_event_reade=
r()
> + * and runs in qemu context. It schedules a bh, but just in case the=
 aio
> =A0* was not cancelled before.
> =A0*/
> -static void rbd_complete_aio(RADOSCB *rcb)
> +static void qemu_rbd_complete_aio(RADOSCB *rcb)
> =A0{
> =A0 =A0 RBDAIOCB *acb =3D rcb->acb;
> =A0 =A0 int64_t r;
>
> - =A0 =A0acb->aiocnt--;
> -
> =A0 =A0 if (acb->cancelled) {
> - =A0 =A0 =A0 =A0if (!acb->aiocnt) {
> - =A0 =A0 =A0 =A0 =A0 =A0qemu_vfree(acb->bounce);
> - =A0 =A0 =A0 =A0 =A0 =A0qemu_aio_release(acb);
> - =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0qemu_vfree(acb->bounce);
> + =A0 =A0 =A0 =A0qemu_aio_release(acb);
> =A0 =A0 =A0 =A0 goto done;
> =A0 =A0 }
>
> @@ -363,32 +252,25 @@ static void rbd_complete_aio(RADOSCB *rcb)
> =A0 =A0 =A0 =A0 =A0 =A0 acb->ret =3D r;
> =A0 =A0 =A0 =A0 =A0 =A0 acb->error =3D 1;
> =A0 =A0 =A0 =A0 } else if (!acb->error) {
> - =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D rcb->segsize;
> + =A0 =A0 =A0 =A0 =A0 =A0acb->ret =3D rcb->size;
> =A0 =A0 =A0 =A0 }
> =A0 =A0 } else {
> - =A0 =A0 =A0 =A0if (r =3D=3D -ENOENT) {
> - =A0 =A0 =A0 =A0 =A0 =A0memset(rcb->buf, 0, rcb->segsize);
> - =A0 =A0 =A0 =A0 =A0 =A0if (!acb->error) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D rcb->segsize;
> - =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0} else if (r < 0) {
> - =A0 =A0 =A0 =A0 =A0 memset(rcb->buf, 0, rcb->segsize);
> + =A0 =A0 =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0memset(rcb->buf, 0, rcb->size);
> =A0 =A0 =A0 =A0 =A0 =A0 acb->ret =3D r;
> =A0 =A0 =A0 =A0 =A0 =A0 acb->error =3D 1;
> - =A0 =A0 =A0 =A0} else if (r < rcb->segsize) {
> - =A0 =A0 =A0 =A0 =A0 =A0memset(rcb->buf + r, 0, rcb->segsize - r);
> + =A0 =A0 =A0 =A0} else if (r < rcb->size) {
> + =A0 =A0 =A0 =A0 =A0 =A0memset(rcb->buf + r, 0, rcb->size - r);
> =A0 =A0 =A0 =A0 =A0 =A0 if (!acb->error) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D rcb->segsize;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acb->ret =3D rcb->size;
> =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 } else if (!acb->error) {
> - =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D r;
> + =A0 =A0 =A0 =A0 =A0 =A0acb->ret =3D r;
> =A0 =A0 =A0 =A0 }
> =A0 =A0 }
> =A0 =A0 /* Note that acb->bh can be NULL in case where the aio was ca=
ncelled */
> - =A0 =A0if (!acb->aiocnt) {
> - =A0 =A0 =A0 =A0acb->bh =3D qemu_bh_new(rbd_aio_bh_cb, acb);
> - =A0 =A0 =A0 =A0qemu_bh_schedule(acb->bh);
> - =A0 =A0}
> + =A0 =A0acb->bh =3D qemu_bh_new(rbd_aio_bh_cb, acb);
> + =A0 =A0qemu_bh_schedule(acb->bh);
> =A0done:
> =A0 =A0 qemu_free(rcb);
> =A0}
> @@ -397,7 +279,7 @@ done:
> =A0* aio fd read handler. It runs in the qemu context and calls the
> =A0* completion handling of completed rados aio operations.
> =A0*/
> -static void rbd_aio_event_reader(void *opaque)
> +static void qemu_rbd_aio_event_reader(void *opaque)
> =A0{
> =A0 =A0 BDRVRBDState *s =3D opaque;
>
> @@ -413,176 +295,74 @@ static void rbd_aio_event_reader(void *opaque)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->event_reader_pos +=3D ret;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s->event_reader_pos =3D=3D sizeof=
(s->event_rcb)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->event_reader_pos =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rbd_complete_aio(s->event_rc=
b);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->qemu_aio_count --;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0qemu_rbd_complete_aio(s->eve=
nt_rcb);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->qemu_aio_count--;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 }
> =A0 =A0 } while (ret < 0 && errno =3D=3D EINTR);
> =A0}
>
> -static int rbd_aio_flush_cb(void *opaque)
> +static int qemu_rbd_aio_flush_cb(void *opaque)
> =A0{
> =A0 =A0 BDRVRBDState *s =3D opaque;
>
> =A0 =A0 return (s->qemu_aio_count > 0);
> =A0}
>
> -
> -static int rbd_set_snapc(rados_pool_t pool, const char *snap, RbdHea=
der1 *header)
> -{
> - =A0 =A0uint32_t snap_count =3D le32_to_cpu(header->snap_count);
> - =A0 =A0rados_snap_t *snaps =3D NULL;
> - =A0 =A0rados_snap_t seq;
> - =A0 =A0uint32_t i;
> - =A0 =A0uint64_t snap_names_len =3D le64_to_cpu(header->snap_names_l=
en);
> - =A0 =A0int r;
> - =A0 =A0rados_snap_t snapid =3D 0;
> -
> - =A0 =A0if (snap_count) {
> - =A0 =A0 =A0 =A0const char *header_snap =3D (const char *)&header->s=
naps[snap_count];
> - =A0 =A0 =A0 =A0const char *end =3D header_snap + snap_names_len;
> - =A0 =A0 =A0 =A0snaps =3D qemu_malloc(sizeof(rados_snap_t) * header-=
>snap_count);
> -
> - =A0 =A0 =A0 =A0for (i=3D0; i < snap_count; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0snaps[i] =3D le64_to_cpu(header->snaps[i].id=
);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0if (snap && strcmp(snap, header_snap) =3D=3D=
 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snapid =3D snaps[i];
> - =A0 =A0 =A0 =A0 =A0 =A0}
> -
> - =A0 =A0 =A0 =A0 =A0 =A0header_snap +=3D strlen(header_snap) + 1;
> - =A0 =A0 =A0 =A0 =A0 =A0if (header_snap > end) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error_report("bad header, snapshot l=
ist broken");
> - =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0}
> - =A0 =A0}
> -
> - =A0 =A0if (snap && !snapid) {
> - =A0 =A0 =A0 =A0error_report("snapshot not found");
> - =A0 =A0 =A0 =A0qemu_free(snaps);
> - =A0 =A0 =A0 =A0return -ENOENT;
> - =A0 =A0}
> - =A0 =A0seq =3D le32_to_cpu(header->snap_seq);
> -
> - =A0 =A0r =3D rados_set_snap_context(pool, seq, snaps, snap_count);
> -
> - =A0 =A0rados_set_snap(pool, snapid);
> -
> - =A0 =A0qemu_free(snaps);
> -
> - =A0 =A0return r;
> -}
> -
> -#define BUF_READ_START_LEN =A0 =A04096
> -
> -static int rbd_read_header(BDRVRBDState *s, char **hbuf)
> -{
> - =A0 =A0char *buf =3D NULL;
> - =A0 =A0char n[RBD_MAX_SEG_NAME_SIZE];
> - =A0 =A0uint64_t len =3D BUF_READ_START_LEN;
> - =A0 =A0int r;
> -
> - =A0 =A0snprintf(n, sizeof(n), "%s%s", s->name, RBD_SUFFIX);
> -
> - =A0 =A0buf =3D qemu_malloc(len);
> -
> - =A0 =A0r =3D rados_read(s->header_pool, n, 0, buf, len);
> - =A0 =A0if (r < 0) {
> - =A0 =A0 =A0 =A0goto failed;
> - =A0 =A0}
> -
> - =A0 =A0if (r < len) {
> - =A0 =A0 =A0 =A0goto done;
> - =A0 =A0}
> -
> - =A0 =A0qemu_free(buf);
> - =A0 =A0buf =3D qemu_malloc(len);
> -
> - =A0 =A0r =3D rados_stat(s->header_pool, n, &len, NULL);
> - =A0 =A0if (r < 0) {
> - =A0 =A0 =A0 =A0goto failed;
> - =A0 =A0}
> -
> - =A0 =A0r =3D rados_read(s->header_pool, n, 0, buf, len);
> - =A0 =A0if (r < 0) {
> - =A0 =A0 =A0 =A0goto failed;
> - =A0 =A0}
> -
> -done:
> - =A0 =A0*hbuf =3D buf;
> - =A0 =A0return 0;
> -
> -failed:
> - =A0 =A0qemu_free(buf);
> - =A0 =A0return r;
> -}
> -
> -static int rbd_open(BlockDriverState *bs, const char *filename, int =
flags)
> +static int qemu_rbd_open(BlockDriverState *bs, const char *filename,=
 int flags)
> =A0{
> =A0 =A0 BDRVRBDState *s =3D bs->opaque;
> - =A0 =A0RbdHeader1 *header;
> - =A0 =A0char pool[RBD_MAX_SEG_NAME_SIZE];
> - =A0 =A0char snap_buf[RBD_MAX_SEG_NAME_SIZE];
> - =A0 =A0char *snap =3D NULL;
> - =A0 =A0char *hbuf =3D NULL;
> + =A0 =A0char pool[RBD_MAX_POOL_NAME_SIZE];
> + =A0 =A0char snap_buf[RBD_MAX_SNAP_NAME_SIZE];
> =A0 =A0 int r;
>
> - =A0 =A0if (rbd_parsename(filename, pool, sizeof(pool),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snap_buf, sizeof(snap_bu=
f),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->name, sizeof(s->name)=
) < 0) {
> + =A0 =A0if (qemu_rbd_parsename(filename, pool, sizeof(pool),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snap_buf, sizeo=
f(snap_buf),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->name, sizeof=
(s->name)) < 0) {
> =A0 =A0 =A0 =A0 return -EINVAL;
> =A0 =A0 }
> + =A0 =A0s->snap =3D NULL;
> =A0 =A0 if (snap_buf[0] !=3D '\0') {
> - =A0 =A0 =A0 =A0snap =3D snap_buf;
> + =A0 =A0 =A0 =A0s->snap =3D qemu_strdup(snap_buf);
> =A0 =A0 }
>
> - =A0 =A0if ((r =3D rados_initialize(0, NULL)) < 0) {
> + =A0 =A0r =3D rados_create(&s->cluster, NULL);
> + =A0 =A0if (r < 0) {
> =A0 =A0 =A0 =A0 error_report("error initializing");
> =A0 =A0 =A0 =A0 return r;
> =A0 =A0 }
>
> - =A0 =A0if ((r =3D rados_open_pool(pool, &s->pool))) {
> - =A0 =A0 =A0 =A0error_report("error opening pool %s", pool);
> - =A0 =A0 =A0 =A0rados_deinitialize();
> + =A0 =A0r =3D rados_conf_read_file(s->cluster, NULL);
> + =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0error_report("error reading config file");
> + =A0 =A0 =A0 =A0rados_shutdown(s->cluster);
> =A0 =A0 =A0 =A0 return r;
> =A0 =A0 }
>
> - =A0 =A0if ((r =3D rados_open_pool(pool, &s->header_pool))) {
> - =A0 =A0 =A0 =A0error_report("error opening pool %s", pool);
> - =A0 =A0 =A0 =A0rados_deinitialize();
> + =A0 =A0r =3D rados_connect(s->cluster);
> + =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0error_report("error connecting");
> + =A0 =A0 =A0 =A0rados_shutdown(s->cluster);
> =A0 =A0 =A0 =A0 return r;
> =A0 =A0 }
>
> - =A0 =A0if ((r =3D rbd_read_header(s, &hbuf)) < 0) {
> - =A0 =A0 =A0 =A0error_report("error reading header from %s", s->name=
);
> - =A0 =A0 =A0 =A0goto failed;
> - =A0 =A0}
> -
> - =A0 =A0if (memcmp(hbuf + 64, RBD_HEADER_SIGNATURE, 4)) {
> - =A0 =A0 =A0 =A0error_report("Invalid header signature");
> - =A0 =A0 =A0 =A0r =3D -EMEDIUMTYPE;
> - =A0 =A0 =A0 =A0goto failed;
> - =A0 =A0}
> -
> - =A0 =A0if (memcmp(hbuf + 68, RBD_HEADER_VERSION, 8)) {
> - =A0 =A0 =A0 =A0error_report("Unknown image version");
> - =A0 =A0 =A0 =A0r =3D -EMEDIUMTYPE;
> - =A0 =A0 =A0 =A0goto failed;
> + =A0 =A0r =3D rados_ioctx_create(s->cluster, pool, &s->io_ctx);
> + =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0error_report("error opening pool %s", pool);
> + =A0 =A0 =A0 =A0rados_shutdown(s->cluster);
> + =A0 =A0 =A0 =A0return r;
> =A0 =A0 }
>
> - =A0 =A0header =3D (RbdHeader1 *) hbuf;
> - =A0 =A0s->size =3D le64_to_cpu(header->image_size);
> - =A0 =A0s->objsize =3D 1ULL << header->options.order;
> - =A0 =A0memcpy(s->block_name, header->block_name, sizeof(header->blo=
ck_name));
> -
> - =A0 =A0r =3D rbd_set_snapc(s->pool, snap, header);
> + =A0 =A0r =3D rbd_open(s->io_ctx, s->name, &s->image, s->snap);
> =A0 =A0 if (r < 0) {
> - =A0 =A0 =A0 =A0error_report("failed setting snap context: %s", stre=
rror(-r));
> - =A0 =A0 =A0 =A0goto failed;
> + =A0 =A0 =A0 =A0error_report("error reading header from %s", s->name=
);
> + =A0 =A0 =A0 =A0rados_ioctx_destroy(s->io_ctx);
> + =A0 =A0 =A0 =A0rados_shutdown(s->cluster);
> + =A0 =A0 =A0 =A0return r;
> =A0 =A0 }
>
> - =A0 =A0bs->read_only =3D (snap !=3D NULL);
> + =A0 =A0bs->read_only =3D (s->snap !=3D NULL);
>
> =A0 =A0 s->event_reader_pos =3D 0;
> =A0 =A0 r =3D qemu_pipe(s->fds);
> @@ -592,23 +372,20 @@ static int rbd_open(BlockDriverState *bs, const=
 char *filename, int flags)
> =A0 =A0 }
> =A0 =A0 fcntl(s->fds[0], F_SETFL, O_NONBLOCK);
> =A0 =A0 fcntl(s->fds[1], F_SETFL, O_NONBLOCK);
> - =A0 =A0qemu_aio_set_fd_handler(s->fds[RBD_FD_READ], rbd_aio_event_r=
eader, NULL,
> - =A0 =A0 =A0 =A0rbd_aio_flush_cb, NULL, s);
> + =A0 =A0qemu_aio_set_fd_handler(s->fds[RBD_FD_READ], qemu_rbd_aio_ev=
ent_reader,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL, qemu_r=
bd_aio_flush_cb, NULL, s);
>
> - =A0 =A0qemu_free(hbuf);
>
> =A0 =A0 return 0;
>
> =A0failed:
> - =A0 =A0qemu_free(hbuf);
> -
> - =A0 =A0rados_close_pool(s->header_pool);
> - =A0 =A0rados_close_pool(s->pool);
> - =A0 =A0rados_deinitialize();
> + =A0 =A0rbd_close(s->image);
> + =A0 =A0rados_ioctx_destroy(s->io_ctx);
> + =A0 =A0rados_shutdown(s->cluster);
> =A0 =A0 return r;
> =A0}
>
> -static void rbd_close(BlockDriverState *bs)
> +static void qemu_rbd_close(BlockDriverState *bs)
> =A0{
> =A0 =A0 BDRVRBDState *s =3D bs->opaque;
>
> @@ -617,16 +394,17 @@ static void rbd_close(BlockDriverState *bs)
> =A0 =A0 qemu_aio_set_fd_handler(s->fds[RBD_FD_READ], NULL , NULL, NUL=
L, NULL,
> =A0 =A0 =A0 =A0 NULL);
>
> - =A0 =A0rados_close_pool(s->header_pool);
> - =A0 =A0rados_close_pool(s->pool);
> - =A0 =A0rados_deinitialize();
> + =A0 =A0rbd_close(s->image);
> + =A0 =A0rados_ioctx_destroy(s->io_ctx);
> + =A0 =A0qemu_free(s->snap);
> + =A0 =A0rados_shutdown(s->cluster);
> =A0}
>
> =A0/*
> =A0* Cancel aio. Since we don't reference acb in a non qemu threads,
> =A0* it is safe to access it here.
> =A0*/
> -static void rbd_aio_cancel(BlockDriverAIOCB *blockacb)
> +static void qemu_rbd_aio_cancel(BlockDriverAIOCB *blockacb)
> =A0{
> =A0 =A0 RBDAIOCB *acb =3D (RBDAIOCB *) blockacb;
> =A0 =A0 acb->cancelled =3D 1;
> @@ -634,39 +412,28 @@ static void rbd_aio_cancel(BlockDriverAIOCB *bl=
ockacb)
>
> =A0static AIOPool rbd_aio_pool =3D {
> =A0 =A0 .aiocb_size =3D sizeof(RBDAIOCB),
> - =A0 =A0.cancel =3D rbd_aio_cancel,
> + =A0 =A0.cancel =3D qemu_rbd_aio_cancel,
> =A0};
>
> -/*
> - * This is the callback function for rados_aio_read and _write
> - *
> - * Note: this function is being called from a non qemu thread so
> - * we need to be careful about what we do here. Generally we only
> - * write to the block notification pipe, and do the rest of the
> - * io completion handling from rbd_aio_event_reader() which
> - * runs in a qemu context.
> - */
> -static void rbd_finish_aiocb(rados_completion_t c, RADOSCB *rcb)
> +static int qemu_rbd_send_pipe(BDRVRBDState *s, RADOSCB *rcb)
> =A0{
> - =A0 =A0int ret;
> - =A0 =A0rcb->ret =3D rados_aio_get_return_value(c);
> - =A0 =A0rados_aio_release(c);
> + =A0 =A0int ret =3D 0;
> =A0 =A0 while (1) {
> =A0 =A0 =A0 =A0 fd_set wfd;
> - =A0 =A0 =A0 =A0int fd =3D rcb->s->fds[RBD_FD_WRITE];
> + =A0 =A0 =A0 =A0int fd =3D s->fds[RBD_FD_WRITE];
>
> - =A0 =A0 =A0 =A0/* send the rcb pointer to the qemu thread that is r=
esponsible
> - =A0 =A0 =A0 =A0 =A0 for the aio completion. Must do it in a qemu th=
read context */
> + =A0 =A0 =A0 =A0/* send the op pointer to the qemu thread that is re=
sponsible
> + =A0 =A0 =A0 =A0 =A0 for the aio/op completion. Must do it in a qemu=
 thread context */
> =A0 =A0 =A0 =A0 ret =3D write(fd, (void *)&rcb, sizeof(rcb));
> =A0 =A0 =A0 =A0 if (ret >=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 if (errno =3D=3D EINTR) {
> =A0 =A0 =A0 =A0 =A0 =A0 continue;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 if (errno !=3D EAGAIN) {
> =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 FD_ZERO(&wfd);
> =A0 =A0 =A0 =A0 FD_SET(fd, &wfd);
> @@ -675,13 +442,31 @@ static void rbd_finish_aiocb(rados_completion_t=
 c, RADOSCB *rcb)
> =A0 =A0 =A0 =A0 } while (ret < 0 && errno =3D=3D EINTR);
> =A0 =A0 }
>
> + =A0 =A0return ret;
> +}
> +
> +/*
> + * This is the callback function for rbd_aio_read and _write
> + *
> + * Note: this function is being called from a non qemu thread so
> + * we need to be careful about what we do here. Generally we only
> + * write to the block notification pipe, and do the rest of the
> + * io completion handling from qemu_rbd_aio_event_reader() which
> + * runs in a qemu context.
> + */
> +static void rbd_finish_aiocb(rbd_completion_t c, RADOSCB *rcb)
> +{
> + =A0 =A0int ret;
> + =A0 =A0rcb->ret =3D rbd_aio_get_return_value(c);
> + =A0 =A0rbd_aio_release(c);
> + =A0 =A0ret =3D qemu_rbd_send_pipe(rcb->s, rcb);
> =A0 =A0 if (ret < 0) {
> - =A0 =A0 =A0 =A0error_report("failed writing to acb->s->fds\n");
> + =A0 =A0 =A0 =A0error_report("failed writing to acb->s->fds");
> =A0 =A0 =A0 =A0 qemu_free(rcb);
> =A0 =A0 }
> =A0}
>
> -/* Callback when all queued rados_aio requests are complete */
> +/* Callback when all queued rbd_aio requests are complete */
>
> =A0static void rbd_aio_bh_cb(void *opaque)
> =A0{
> @@ -707,9 +492,7 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(BlockD=
riverState *bs,
> =A0{
> =A0 =A0 RBDAIOCB *acb;
> =A0 =A0 RADOSCB *rcb;
> - =A0 =A0rados_completion_t c;
> - =A0 =A0char n[RBD_MAX_SEG_NAME_SIZE];
> - =A0 =A0int64_t segnr, segoffs, segsize, last_segnr;
> + =A0 =A0rbd_completion_t c;
> =A0 =A0 int64_t off, size;
> =A0 =A0 char *buf;
>
> @@ -719,7 +502,6 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(BlockD=
riverState *bs,
> =A0 =A0 acb->write =3D write;
> =A0 =A0 acb->qiov =3D qiov;
> =A0 =A0 acb->bounce =3D qemu_blockalign(bs, qiov->size);
> - =A0 =A0acb->aiocnt =3D 0;
> =A0 =A0 acb->ret =3D 0;
> =A0 =A0 acb->error =3D 0;
> =A0 =A0 acb->s =3D s;
> @@ -734,95 +516,81 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(Bloc=
kDriverState *bs,
>
> =A0 =A0 off =3D sector_num * BDRV_SECTOR_SIZE;
> =A0 =A0 size =3D nb_sectors * BDRV_SECTOR_SIZE;
> - =A0 =A0segnr =3D off / s->objsize;
> - =A0 =A0segoffs =3D off % s->objsize;
> - =A0 =A0segsize =3D s->objsize - segoffs;
> -
> - =A0 =A0last_segnr =3D ((off + size - 1) / s->objsize);
> - =A0 =A0acb->aiocnt =3D (last_segnr - segnr) + 1;
>
> - =A0 =A0s->qemu_aio_count +=3D acb->aiocnt; /* All the RADOSCB */
> + =A0 =A0s->qemu_aio_count++; /* All the RADOSCB */
>
> - =A0 =A0while (size > 0) {
> - =A0 =A0 =A0 =A0if (size < segsize) {
> - =A0 =A0 =A0 =A0 =A0 =A0segsize =3D size;
> - =A0 =A0 =A0 =A0}
> -
> - =A0 =A0 =A0 =A0snprintf(n, sizeof(n), "%s.%012" PRIx64, s->block_na=
me,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 segnr);
> -
> - =A0 =A0 =A0 =A0rcb =3D qemu_malloc(sizeof(RADOSCB));
> - =A0 =A0 =A0 =A0rcb->done =3D 0;
> - =A0 =A0 =A0 =A0rcb->acb =3D acb;
> - =A0 =A0 =A0 =A0rcb->segsize =3D segsize;
> - =A0 =A0 =A0 =A0rcb->buf =3D buf;
> - =A0 =A0 =A0 =A0rcb->s =3D acb->s;
> -
> - =A0 =A0 =A0 =A0if (write) {
> - =A0 =A0 =A0 =A0 =A0 =A0rados_aio_create_completion(rcb, NULL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(rados_callback_t) rbd_finish_aiocb,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0&c);
> - =A0 =A0 =A0 =A0 =A0 =A0rados_aio_write(s->pool, n, segoffs, buf, se=
gsize, c);
> - =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0rados_aio_create_completion(rcb,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(rados_callback_t) rbd_finish_aiocb,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0NULL, &c);
> - =A0 =A0 =A0 =A0 =A0 =A0rados_aio_read(s->pool, n, segoffs, buf, seg=
size, c);
> - =A0 =A0 =A0 =A0}
> + =A0 =A0rcb =3D qemu_malloc(sizeof(RADOSCB));
> + =A0 =A0rcb->done =3D 0;
> + =A0 =A0rcb->acb =3D acb;
> + =A0 =A0rcb->buf =3D buf;
> + =A0 =A0rcb->s =3D acb->s;
> + =A0 =A0rcb->size =3D size;
>
> - =A0 =A0 =A0 =A0buf +=3D segsize;
> - =A0 =A0 =A0 =A0size -=3D segsize;
> - =A0 =A0 =A0 =A0segoffs =3D 0;
> - =A0 =A0 =A0 =A0segsize =3D s->objsize;
> - =A0 =A0 =A0 =A0segnr++;
> + =A0 =A0if (write) {
> + =A0 =A0 =A0 =A0rbd_aio_create_completion(rcb, (rbd_callback_t) rbd_=
finish_aiocb, &c);
> + =A0 =A0 =A0 =A0rbd_aio_write(s->image, off, size, buf, c);
> + =A0 =A0} else {
> + =A0 =A0 =A0 =A0rbd_aio_create_completion(rcb, (rbd_callback_t) rbd_=
finish_aiocb, &c);
> + =A0 =A0 =A0 =A0rbd_aio_read(s->image, off, size, buf, c);
> =A0 =A0 }
>
> =A0 =A0 return &acb->common;
> =A0}
>
> -static BlockDriverAIOCB *rbd_aio_readv(BlockDriverState * bs,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 int64_t sector_num, QEMUIOVector * qiov,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 int nb_sectors,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 BlockDriverCompletionFunc * cb,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 void *opaque)
> +static BlockDriverAIOCB *qemu_rbd_aio_readv(BlockDriverState *bs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0int64_t sector_num,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0QEMUIOVector *qiov,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0int nb_sectors,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0BlockDriverCompletionFunc *cb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0void *opaque)
> =A0{
> =A0 =A0 return rbd_aio_rw_vector(bs, sector_num, qiov, nb_sectors, cb=
, opaque, 0);
> =A0}
>
> -static BlockDriverAIOCB *rbd_aio_writev(BlockDriverState * bs,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0int64_t sector_num, QEMUIOVector * qiov,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0int nb_sectors,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0BlockDriverCompletionFunc * cb,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0void *opaque)
> +static BlockDriverAIOCB *qemu_rbd_aio_writev(BlockDriverState *bs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 int64_t sector_num,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 QEMUIOVector *qiov,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 int nb_sectors,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 BlockDriverCompletionFunc *cb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 void *opaque)
> =A0{
> =A0 =A0 return rbd_aio_rw_vector(bs, sector_num, qiov, nb_sectors, cb=
, opaque, 1);
> =A0}
>
> -static int rbd_getinfo(BlockDriverState * bs, BlockDriverInfo * bdi)
> +static int qemu_rbd_getinfo(BlockDriverState *bs, BlockDriverInfo *b=
di)
> =A0{
> =A0 =A0 BDRVRBDState *s =3D bs->opaque;
> - =A0 =A0bdi->cluster_size =3D s->objsize;
> + =A0 =A0rbd_image_info_t info;
> + =A0 =A0int r;
> +
> + =A0 =A0r =3D rbd_stat(s->image, &info, sizeof(info));
> + =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0return r;
> + =A0 =A0}
> +
> + =A0 =A0bdi->cluster_size =3D info.obj_size;
> =A0 =A0 return 0;
> =A0}
>
> -static int64_t rbd_getlength(BlockDriverState * bs)
> +static int64_t qemu_rbd_getlength(BlockDriverState *bs)
> =A0{
> =A0 =A0 BDRVRBDState *s =3D bs->opaque;
> + =A0 =A0rbd_image_info_t info;
> + =A0 =A0int r;
>
> - =A0 =A0return s->size;
> + =A0 =A0r =3D rbd_stat(s->image, &info, sizeof(info));
> + =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0return r;
> + =A0 =A0}
> +
> + =A0 =A0return info.size;
> =A0}
>
> -static int rbd_snap_create(BlockDriverState *bs, QEMUSnapshotInfo *s=
n_info)
> +static int qemu_rbd_snap_create(BlockDriverState *bs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0QEMU=
SnapshotInfo *sn_info)
> =A0{
> =A0 =A0 BDRVRBDState *s =3D bs->opaque;
> - =A0 =A0char inbuf[512], outbuf[128];
> - =A0 =A0uint64_t snap_id;
> =A0 =A0 int r;
> - =A0 =A0char *p =3D inbuf;
> - =A0 =A0char *end =3D inbuf + sizeof(inbuf);
> - =A0 =A0char n[RBD_MAX_SEG_NAME_SIZE];
> - =A0 =A0char *hbuf =3D NULL;
> - =A0 =A0RbdHeader1 *header;
>
> =A0 =A0 if (sn_info->name[0] =3D=3D '\0') {
> =A0 =A0 =A0 =A0 return -EINVAL; /* we need a name for rbd snapshots *=
/
> @@ -841,185 +609,59 @@ static int rbd_snap_create(BlockDriverState *b=
s, QEMUSnapshotInfo *sn_info)
> =A0 =A0 =A0 =A0 return -ERANGE;
> =A0 =A0 }
>
> - =A0 =A0r =3D rados_selfmanaged_snap_create(s->header_pool, &snap_id=
);
> + =A0 =A0r =3D rbd_snap_create(s->image, sn_info->name);
> =A0 =A0 if (r < 0) {
> - =A0 =A0 =A0 =A0error_report("failed to create snap id: %s", strerro=
r(-r));
> + =A0 =A0 =A0 =A0error_report("failed to create snap: %s", strerror(-=
r));
> =A0 =A0 =A0 =A0 return r;
> =A0 =A0 }
>
> - =A0 =A0*(uint32_t *)p =3D strlen(sn_info->name);
> - =A0 =A0cpu_to_le32s((uint32_t *)p);
> - =A0 =A0p +=3D sizeof(uint32_t);
> - =A0 =A0strncpy(p, sn_info->name, end - p);
> - =A0 =A0p +=3D strlen(p);
> - =A0 =A0if (p + sizeof(snap_id) > end) {
> - =A0 =A0 =A0 =A0error_report("invalid input parameter");
> - =A0 =A0 =A0 =A0return -EINVAL;
> - =A0 =A0}
> -
> - =A0 =A0*(uint64_t *)p =3D snap_id;
> - =A0 =A0cpu_to_le64s((uint64_t *)p);
> -
> - =A0 =A0snprintf(n, sizeof(n), "%s%s", s->name, RBD_SUFFIX);
> -
> - =A0 =A0r =3D rados_exec(s->header_pool, n, "rbd", "snap_add", inbuf=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(inbuf), outbuf, sizeof(o=
utbuf));
> - =A0 =A0if (r < 0) {
> - =A0 =A0 =A0 =A0error_report("rbd.snap_add execution failed failed: =
%s", strerror(-r));
> - =A0 =A0 =A0 =A0return r;
> - =A0 =A0}
> -
> - =A0 =A0sprintf(sn_info->id_str, "%s", sn_info->name);
> -
> - =A0 =A0r =3D rbd_read_header(s, &hbuf);
> - =A0 =A0if (r < 0) {
> - =A0 =A0 =A0 =A0error_report("failed reading header: %s", strerror(-=
r));
> - =A0 =A0 =A0 =A0return r;
> - =A0 =A0}
> -
> - =A0 =A0header =3D (RbdHeader1 *) hbuf;
> - =A0 =A0r =3D rbd_set_snapc(s->pool, sn_info->name, header);
> - =A0 =A0if (r < 0) {
> - =A0 =A0 =A0 =A0error_report("failed setting snap context: %s", stre=
rror(-r));
> - =A0 =A0 =A0 =A0goto failed;
> - =A0 =A0}
> -
> - =A0 =A0return 0;
> -
> -failed:
> - =A0 =A0qemu_free(header);
> - =A0 =A0return r;
> -}
> -
> -static int decode32(char **p, const char *end, uint32_t *v)
> -{
> - =A0 =A0if (*p + 4 > end) {
> - =A0 =A0 =A0 return -ERANGE;
> - =A0 =A0}
> -
> - =A0 =A0*v =3D *(uint32_t *)(*p);
> - =A0 =A0le32_to_cpus(v);
> - =A0 =A0*p +=3D 4;
> =A0 =A0 return 0;
> =A0}
>
> -static int decode64(char **p, const char *end, uint64_t *v)
> -{
> - =A0 =A0if (*p + 8 > end) {
> - =A0 =A0 =A0 =A0return -ERANGE;
> - =A0 =A0}
> -
> - =A0 =A0*v =3D *(uint64_t *)(*p);
> - =A0 =A0le64_to_cpus(v);
> - =A0 =A0*p +=3D 8;
> - =A0 =A0return 0;
> -}
> -
> -static int decode_str(char **p, const char *end, char **s)
> -{
> - =A0 =A0uint32_t len;
> - =A0 =A0int r;
> -
> - =A0 =A0if ((r =3D decode32(p, end, &len)) < 0) {
> - =A0 =A0 =A0 =A0return r;
> - =A0 =A0}
> -
> - =A0 =A0*s =3D qemu_malloc(len + 1);
> - =A0 =A0memcpy(*s, *p, len);
> - =A0 =A0*p +=3D len;
> - =A0 =A0(*s)[len] =3D '\0';
> -
> - =A0 =A0return len;
> -}
> -
> -static int rbd_snap_list(BlockDriverState *bs, QEMUSnapshotInfo **ps=
n_tab)
> +static int qemu_rbd_snap_list(BlockDriverState *bs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0QEMUSnap=
shotInfo **psn_tab)
> =A0{
> =A0 =A0 BDRVRBDState *s =3D bs->opaque;
> - =A0 =A0char n[RBD_MAX_SEG_NAME_SIZE];
> =A0 =A0 QEMUSnapshotInfo *sn_info, *sn_tab =3D NULL;
> - =A0 =A0RbdHeader1 *header;
> - =A0 =A0char *hbuf =3D NULL;
> - =A0 =A0char *outbuf =3D NULL, *end, *buf;
> - =A0 =A0uint64_t len;
> - =A0 =A0uint64_t snap_seq;
> - =A0 =A0uint32_t snap_count;
> =A0 =A0 int r, i;
> + =A0 =A0rbd_snap_info_t *snaps;
> + =A0 =A0int max_snaps =3D 100, snap_count;

I think it would be nicer to have this defined at the beginning (e.g.
RBD_MAX_SNAPS).

>
> - =A0 =A0/* read header to estimate how much space we need to read th=
e snap
> - =A0 =A0 * list */
> - =A0 =A0if ((r =3D rbd_read_header(s, &hbuf)) < 0) {
> - =A0 =A0 =A0 =A0goto done_err;
> - =A0 =A0}
> - =A0 =A0header =3D (RbdHeader1 *)hbuf;
> - =A0 =A0len =3D le64_to_cpu(header->snap_names_len);
> - =A0 =A0len +=3D 1024; /* should have already been enough, but new s=
napshots might
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0already been created since w=
e read the header. just allocate
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0a bit more, so that in most =
cases it'll suffice anyway */
> - =A0 =A0qemu_free(hbuf);
> -
> - =A0 =A0snprintf(n, sizeof(n), "%s%s", s->name, RBD_SUFFIX);
> - =A0 =A0while (1) {
> - =A0 =A0 =A0 =A0qemu_free(outbuf);
> - =A0 =A0 =A0 =A0outbuf =3D qemu_malloc(len);
> -
> - =A0 =A0 =A0 =A0r =3D rados_exec(s->header_pool, n, "rbd", "snap_lis=
t", NULL, 0,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outbuf, len);
> + =A0 =A0do {
> + =A0 =A0 =A0 =A0snaps =3D qemu_malloc(sizeof(*snaps) * max_snaps);
> + =A0 =A0 =A0 =A0r =3D rbd_snap_list(s->image, snaps, &max_snaps);
> =A0 =A0 =A0 =A0 if (r < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0error_report("rbd.snap_list execution failed=
 failed: %s", strerror(-r));
> - =A0 =A0 =A0 =A0 =A0 =A0goto done_err;
> + =A0 =A0 =A0 =A0 =A0 =A0qemu_free(snaps);
> =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0if (r !=3D len) {
> - =A0 =A0 =A0 =A0 =A0 =A0break;
> - =A0 =A0 =A0 }
> + =A0 =A0} while (r =3D=3D -ERANGE);
>
> - =A0 =A0 =A0 =A0/* if we're here, we probably raced with some snaps =
creation */
> - =A0 =A0 =A0 =A0len *=3D 2;
> + =A0 =A0if (r <=3D 0) {
> + =A0 =A0 =A0 =A0return r;
> =A0 =A0 }
> - =A0 =A0buf =3D outbuf;
> - =A0 =A0end =3D buf + len;
>
> - =A0 =A0if ((r =3D decode64(&buf, end, &snap_seq)) < 0) {
> - =A0 =A0 =A0 =A0goto done_err;
> - =A0 =A0}
> - =A0 =A0if ((r =3D decode32(&buf, end, &snap_count)) < 0) {
> - =A0 =A0 =A0 =A0goto done_err;
> - =A0 =A0}
> + =A0 =A0snap_count =3D r;

This isn't really necessary. We could just use snap_count above (or r b=
elow).

>
> =A0 =A0 sn_tab =3D qemu_mallocz(snap_count * sizeof(QEMUSnapshotInfo)=
);
> - =A0 =A0for (i =3D 0; i < snap_count; i++) {
> - =A0 =A0 =A0 =A0uint64_t id, image_size;
> - =A0 =A0 =A0 =A0char *snap_name;
>
> - =A0 =A0 =A0 =A0if ((r =3D decode64(&buf, end, &id)) < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0goto done_err;
> - =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0if ((r =3D decode64(&buf, end, &image_size)) < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0goto done_err;
> - =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0if ((r =3D decode_str(&buf, end, &snap_name)) < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0goto done_err;
> - =A0 =A0 =A0 =A0}
> + =A0 =A0for (i =3D 0; i < snap_count; i++) {
> + =A0 =A0 =A0 =A0const char *snap_name =3D snaps[i].name;
>
> =A0 =A0 =A0 =A0 sn_info =3D sn_tab + i;
> =A0 =A0 =A0 =A0 pstrcpy(sn_info->id_str, sizeof(sn_info->id_str), sna=
p_name);
> =A0 =A0 =A0 =A0 pstrcpy(sn_info->name, sizeof(sn_info->name), snap_na=
me);
> - =A0 =A0 =A0 =A0qemu_free(snap_name);
>
> - =A0 =A0 =A0 =A0sn_info->vm_state_size =3D image_size;
> + =A0 =A0 =A0 =A0sn_info->vm_state_size =3D snaps[i].size;
> =A0 =A0 =A0 =A0 sn_info->date_sec =3D 0;
> =A0 =A0 =A0 =A0 sn_info->date_nsec =3D 0;
> =A0 =A0 =A0 =A0 sn_info->vm_clock_nsec =3D 0;
> =A0 =A0 }
> + =A0 =A0rbd_snap_list_end(snaps);
> +
> =A0 =A0 *psn_tab =3D sn_tab;
> - =A0 =A0qemu_free(outbuf);
> =A0 =A0 return snap_count;
> -done_err:
> - =A0 =A0qemu_free(sn_tab);
> - =A0 =A0qemu_free(outbuf);
> - =A0 =A0return r;
> =A0}
>
> -static QEMUOptionParameter rbd_create_options[] =3D {
> +static QEMUOptionParameter qemu_rbd_create_options[] =3D {
> =A0 =A0 {
> =A0 =A0 =A0.name =3D BLOCK_OPT_SIZE,
> =A0 =A0 =A0.type =3D OPT_SIZE,
> @@ -1036,19 +678,19 @@ static QEMUOptionParameter rbd_create_options[=
] =3D {
> =A0static BlockDriver bdrv_rbd =3D {
> =A0 =A0 .format_name =A0 =A0 =A0 =A0=3D "rbd",
> =A0 =A0 .instance_size =A0 =A0 =A0=3D sizeof(BDRVRBDState),
> - =A0 =A0.bdrv_file_open =A0 =A0 =3D rbd_open,
> - =A0 =A0.bdrv_close =A0 =A0 =A0 =A0 =3D rbd_close,
> - =A0 =A0.bdrv_create =A0 =A0 =A0 =A0=3D rbd_create,
> - =A0 =A0.bdrv_get_info =A0 =A0 =A0=3D rbd_getinfo,
> - =A0 =A0.create_options =A0 =A0 =3D rbd_create_options,
> - =A0 =A0.bdrv_getlength =A0 =A0 =3D rbd_getlength,
> + =A0 =A0.bdrv_file_open =A0 =A0 =3D qemu_rbd_open,
> + =A0 =A0.bdrv_close =A0 =A0 =A0 =A0 =3D qemu_rbd_close,
> + =A0 =A0.bdrv_create =A0 =A0 =A0 =A0=3D qemu_rbd_create,
> + =A0 =A0.bdrv_get_info =A0 =A0 =A0=3D qemu_rbd_getinfo,
> + =A0 =A0.create_options =A0 =A0 =3D qemu_rbd_create_options,
> + =A0 =A0.bdrv_getlength =A0 =A0 =3D qemu_rbd_getlength,
> =A0 =A0 .protocol_name =A0 =A0 =A0=3D "rbd",
>
> - =A0 =A0.bdrv_aio_readv =A0 =A0 =3D rbd_aio_readv,
> - =A0 =A0.bdrv_aio_writev =A0 =A0=3D rbd_aio_writev,
> + =A0 =A0.bdrv_aio_readv =A0 =A0 =3D qemu_rbd_aio_readv,
> + =A0 =A0.bdrv_aio_writev =A0 =A0=3D qemu_rbd_aio_writev,
>
> - =A0 =A0.bdrv_snapshot_create =3D rbd_snap_create,
> - =A0 =A0.bdrv_snapshot_list =3D rbd_snap_list,
> + =A0 =A0.bdrv_snapshot_create =3D qemu_rbd_snap_create,
> + =A0 =A0.bdrv_snapshot_list =3D qemu_rbd_snap_list,
> =A0};
>
> =A0static void bdrv_rbd_init(void)
> diff --git a/block/rbd_types.h b/block/rbd_types.h
> deleted file mode 100644
> index f4cca99..0000000
> --- a/block/rbd_types.h
> +++ /dev/null
> @@ -1,71 +0,0 @@
> -/*
> - * Ceph - scalable distributed file system
> - *
> - * Copyright (C) 2004-2010 Sage Weil <sage@newdream.net>
> - *
> - * This is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License version 2.1, as published by the Free Software
> - * Foundation. =A0See file COPYING.LIB.
> - *
> - */
> -
> -#ifndef CEPH_RBD_TYPES_H
> -#define CEPH_RBD_TYPES_H
> -
> -
> -/*
> - * rbd image 'foo' consists of objects
> - * =A0 foo.rbd =A0 =A0 =A0- image metadata
> - * =A0 foo.00000000
> - * =A0 foo.00000001
> - * =A0 ... =A0 =A0 =A0 =A0 =A0- data
> - */
> -
> -#define RBD_SUFFIX =A0 =A0 =A0 =A0 =A0 =A0 =A0".rbd"
> -#define RBD_DIRECTORY =A0 =A0 =A0 =A0 =A0 "rbd_directory"
> -#define RBD_INFO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"rbd_info"
> -
> -#define RBD_DEFAULT_OBJ_ORDER =A0 22 =A0 /* 4MB */
> -
> -#define RBD_MAX_OBJ_NAME_SIZE =A0 96
> -#define RBD_MAX_BLOCK_NAME_SIZE 24
> -#define RBD_MAX_SEG_NAME_SIZE =A0 128
> -
> -#define RBD_COMP_NONE =A0 =A0 =A0 =A0 =A0 0
> -#define RBD_CRYPT_NONE =A0 =A0 =A0 =A0 =A00
> -
> -#define RBD_HEADER_TEXT =A0 =A0 =A0 =A0 "<<< Rados Block Device Imag=
e >>>\n"
> -#define RBD_HEADER_SIGNATURE =A0 =A0"RBD"
> -#define RBD_HEADER_VERSION =A0 =A0 =A0"001.005"
> -
> -struct rbd_info {
> - =A0 =A0uint64_t max_id;
> -} __attribute__ ((packed));
> -
> -struct rbd_obj_snap_ondisk {
> - =A0 =A0uint64_t id;
> - =A0 =A0uint64_t image_size;
> -} __attribute__((packed));
> -
> -struct rbd_obj_header_ondisk {
> - =A0 =A0char text[40];
> - =A0 =A0char block_name[RBD_MAX_BLOCK_NAME_SIZE];
> - =A0 =A0char signature[4];
> - =A0 =A0char version[8];
> - =A0 =A0struct {
> - =A0 =A0 =A0 =A0uint8_t order;
> - =A0 =A0 =A0 =A0uint8_t crypt_type;
> - =A0 =A0 =A0 =A0uint8_t comp_type;
> - =A0 =A0 =A0 =A0uint8_t unused;
> - =A0 =A0} __attribute__((packed)) options;
> - =A0 =A0uint64_t image_size;
> - =A0 =A0uint64_t snap_seq;
> - =A0 =A0uint32_t snap_count;
> - =A0 =A0uint32_t reserved;
> - =A0 =A0uint64_t snap_names_len;
> - =A0 =A0struct rbd_obj_snap_ondisk snaps[0];
> -} __attribute__((packed));
> -
> -
> -#endif
> diff --git a/configure b/configure
> index a318d37..378c238 100755
> --- a/configure
> +++ b/configure
> @@ -1917,41 +1917,24 @@ fi
> =A0if test "$rbd" !=3D "no" ; then
> =A0 cat > $TMPC <<EOF
> =A0#include <stdio.h>
> -#include <rados/librados.h>
> -int main(void) { rados_initialize(0, NULL); return 0; }
> -EOF
> - =A0rbd_libs=3D"-lrados"
> - =A0if compile_prog "" "$rbd_libs" ; then
> - =A0 =A0librados_too_old=3Dno
> - =A0 =A0cat > $TMPC <<EOF
> -#include <stdio.h>
> -#include <rados/librados.h>
> -#ifndef CEPH_OSD_TMAP_SET
> -#error missing CEPH_OSD_TMAP_SET
> -#endif
> +#include <rbd/librbd.h>
> =A0int main(void) {
> - =A0 =A0int (*func)(const rados_pool_t pool, uint64_t *snapid) =3D r=
ados_selfmanaged_snap_create;
> - =A0 =A0rados_initialize(0, NULL);
> + =A0 =A0rados_t cluster;
> + =A0 =A0rados_create(&cluster, NULL);
> =A0 =A0 return 0;
> =A0}
> =A0EOF
> - =A0 =A0if compile_prog "" "$rbd_libs" ; then
> - =A0 =A0 =A0rbd=3Dyes
> - =A0 =A0 =A0libs_tools=3D"$rbd_libs $libs_tools"
> - =A0 =A0 =A0libs_softmmu=3D"$rbd_libs $libs_softmmu"
> - =A0 =A0else
> - =A0 =A0 =A0rbd=3Dno
> - =A0 =A0 =A0librados_too_old=3Dyes
> - =A0 =A0fi
> + =A0rbd_libs=3D"-lrbd -lrados"
> + =A0if compile_prog "" "$rbd_libs" ; then
> + =A0 =A0rbd=3Dyes
> + =A0 =A0libs_tools=3D"$rbd_libs $libs_tools"
> + =A0 =A0libs_softmmu=3D"$rbd_libs $libs_softmmu"
> =A0 else
> =A0 =A0 if test "$rbd" =3D "yes" ; then
> =A0 =A0 =A0 feature_not_found "rados block device"
> =A0 =A0 fi
> =A0 =A0 rbd=3Dno
> =A0 fi
> - =A0if test "$librados_too_old" =3D "yes" ; then
> - =A0 =A0echo "-> Your librados version is too old - upgrade needed t=
o have rbd support"
> - =A0fi
> =A0fi
>
> =A0##########################################
> --
> 1.7.2.3
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
