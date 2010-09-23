From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] ceph/rbd block driver for qemu-kvm (v4)
Date: Wed, 22 Sep 2010 19:21:40 -0700
Message-ID: <AANLkTikj7D_dhOZg-98qekWdpKdYtfQaVFAMQt2q4T3j@mail.gmail.com>
References: <20100802194631.GA4923@chb-desktop>
	<alpine.LNX.2.00.1008030033550.2664@linmac>
	<20100803201407.GD1475@chb-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:46983 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab0IWCVn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Sep 2010 22:21:43 -0400
In-Reply-To: <20100803201407.GD1475@chb-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Cc: malc <av1474@comtv.ru>, kvm@vger.kernel.org, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>

=46ollowing up on this one, I'd like to know whether there is any
pending issue preventing rbd from being included upstream.

Thanks,
Yehuda

On Tue, Aug 3, 2010 at 1:14 PM, Christian Brunner <chb@muc.de> wrote:
> On Tue, Aug 03, 2010 at 12:37:18AM +0400, malc wrote:
>>
>> Thare are whitespace issues in this patch.
>
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
> Signed-off-by: Christian Brunner <chb@muc.de>
>
> ---
> =A0Makefile.objs =A0 =A0 | =A0 =A01 +
> =A0block/rbd.c =A0 =A0 =A0 | =A0907 +++++++++++++++++++++++++++++++++=
++++++++++++++++++++
> =A0block/rbd_types.h | =A0 71 +++++
> =A0configure =A0 =A0 =A0 =A0 | =A0 31 ++
> =A04 files changed, 1010 insertions(+), 0 deletions(-)
> =A0create mode 100644 block/rbd.c
> =A0create mode 100644 block/rbd_types.h
>
> diff --git a/Makefile.objs b/Makefile.objs
> index 4a1eaa1..bf45142 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -18,6 +18,7 @@ block-nested-y +=3D parallels.o nbd.o blkdebug.o sh=
eepdog.o
> =A0block-nested-$(CONFIG_WIN32) +=3D raw-win32.o
> =A0block-nested-$(CONFIG_POSIX) +=3D raw-posix.o
> =A0block-nested-$(CONFIG_CURL) +=3D curl.o
> +block-nested-$(CONFIG_RBD) +=3D rbd.o
>
> =A0block-obj-y +=3D =A0$(addprefix block/, $(block-nested-y))
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
> + * Copyright (C) 2010 Christian Brunner <chb@muc.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. =
=A0See
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
> +
> +int eventfd(unsigned int initval, int flags);
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
> + =A0 =A0BlockDriverAIOCB common;
> + =A0 =A0QEMUBH *bh;
> + =A0 =A0int ret;
> + =A0 =A0QEMUIOVector *qiov;
> + =A0 =A0char *bounce;
> + =A0 =A0int write;
> + =A0 =A0int64_t sector_num;
> + =A0 =A0int aiocnt;
> + =A0 =A0int error;
> + =A0 =A0struct BDRVRBDState *s;
> +} RBDAIOCB;
> +
> +typedef struct RADOSCB {
> + =A0 =A0int rcbid;
> + =A0 =A0RBDAIOCB *acb;
> + =A0 =A0int done;
> + =A0 =A0int64_t segsize;
> + =A0 =A0char *buf;
> +} RADOSCB;
> +
> +typedef struct BDRVRBDState {
> + =A0 =A0int efd;
> + =A0 =A0rados_pool_t pool;
> + =A0 =A0rados_pool_t header_pool;
> + =A0 =A0char name[RBD_MAX_OBJ_NAME_SIZE];
> + =A0 =A0char block_name[RBD_MAX_BLOCK_NAME_SIZE];
> + =A0 =A0uint64_t size;
> + =A0 =A0uint64_t objsize;
> + =A0 =A0int qemu_aio_count;
> + =A0 =A0int read_only;
> +} BDRVRBDState;
> +
> +typedef struct rbd_obj_header_ondisk RbdHeader1;
> +
> +static int rbd_parsename(const char *filename, char *pool, char **sn=
ap,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *name)
> +{
> + =A0 =A0const char *rbdname;
> + =A0 =A0char *p;
> + =A0 =A0int l;
> +
> + =A0 =A0if (!strstart(filename, "rbd:", &rbdname)) {
> + =A0 =A0 =A0 =A0return -EINVAL;
> + =A0 =A0}
> +
> + =A0 =A0pstrcpy(pool, 2 * RBD_MAX_SEG_NAME_SIZE, rbdname);
> + =A0 =A0p =3D strchr(pool, '/');
> + =A0 =A0if (p =3D=3D NULL) {
> + =A0 =A0 =A0 =A0return -EINVAL;
> + =A0 =A0}
> +
> + =A0 =A0*p =3D '\0';
> +
> + =A0 =A0l =3D strlen(pool);
> + =A0 =A0if(l >=3D RBD_MAX_SEG_NAME_SIZE) {
> + =A0 =A0 =A0 =A0error_report("pool name to long");
> + =A0 =A0 =A0 =A0return -EINVAL;
> + =A0 =A0} else if (l <=3D 0) {
> + =A0 =A0 =A0 =A0error_report("pool name to short");
> + =A0 =A0 =A0 =A0return -EINVAL;
> + =A0 =A0}
> +
> + =A0 =A0l =3D strlen(++p);
> + =A0 =A0if (l >=3D RBD_MAX_OBJ_NAME_SIZE) {
> + =A0 =A0 =A0 =A0error_report("object name to long");
> + =A0 =A0 =A0 =A0return -EINVAL;
> + =A0 =A0} else if (l <=3D 0) {
> + =A0 =A0 =A0 =A0error_report("object name to short");
> + =A0 =A0 =A0 =A0return -EINVAL;
> + =A0 =A0}
> +
> + =A0 =A0strcpy(name, p);
> +
> + =A0 =A0*snap =3D strchr(name, '@');
> + =A0 =A0if (*snap) {
> + =A0 =A0 =A0 =A0*(*snap) =3D '\0';
> + =A0 =A0 =A0 =A0(*snap)++;
> + =A0 =A0 =A0 =A0if (!*snap) *snap =3D NULL;
> + =A0 =A0}
> +
> + =A0 =A0return l;
> +}
> +
> +static int create_tmap_op(uint8_t op, const char *name, char **tmap_=
desc)
> +{
> + =A0 =A0uint32_t len =3D strlen(name);
> + =A0 =A0/* total_len =3D encoding op + name + empty buffer */
> + =A0 =A0uint32_t total_len =3D 1 + (sizeof(uint32_t) + len) + sizeof=
(uint32_t);
> + =A0 =A0char *desc =3D NULL;
> +
> + =A0 =A0desc =3D qemu_malloc(total_len);
> +
> + =A0 =A0*tmap_desc =3D desc;
> +
> + =A0 =A0*desc =3D op;
> + =A0 =A0desc++;
> + =A0 =A0memcpy(desc, &len, sizeof(len));
> + =A0 =A0desc +=3D sizeof(len);
> + =A0 =A0memcpy(desc, name, len);
> + =A0 =A0desc +=3D len;
> + =A0 =A0len =3D 0;
> + =A0 =A0memcpy(desc, &len, sizeof(len));
> + =A0 =A0desc +=3D sizeof(len);
> +
> + =A0 =A0return desc - *tmap_desc;
> +}
> +
> +static void free_tmap_op(char *tmap_desc)
> +{
> + =A0 =A0qemu_free(tmap_desc);
> +}
> +
> +static int rbd_register_image(rados_pool_t pool, const char *name)
> +{
> + =A0 =A0char *tmap_desc;
> + =A0 =A0const char *dir =3D RBD_DIRECTORY;
> + =A0 =A0int ret;
> +
> + =A0 =A0ret =3D create_tmap_op(CEPH_OSD_TMAP_SET, name, &tmap_desc);
> + =A0 =A0if (ret < 0) {
> + =A0 =A0 =A0 =A0return ret;
> + =A0 =A0}
> +
> + =A0 =A0ret =3D rados_tmap_update(pool, dir, tmap_desc, ret);
> + =A0 =A0free_tmap_op(tmap_desc);
> +
> + =A0 =A0return ret;
> +}
> +
> +static int touch_rbd_info(rados_pool_t pool, const char *info_oid)
> +{
> + =A0 =A0int r =3D rados_write(pool, info_oid, 0, NULL, 0);
> + =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0return r;
> + =A0 =A0}
> + =A0 =A0return 0;
> +}
> +
> +static int rbd_assign_bid(rados_pool_t pool, uint64_t *id)
> +{
> + =A0 =A0uint64_t out[1];
> + =A0 =A0const char *info_oid =3D RBD_INFO;
> +
> + =A0 =A0*id =3D 0;
> +
> + =A0 =A0int r =3D touch_rbd_info(pool, info_oid);
> + =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0return r;
> + =A0 =A0}
> +
> + =A0 =A0r =3D rados_exec(pool, info_oid, "rbd", "assign_bid", NULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, (char *)out, sizeof(out));
> + =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0return r;
> + =A0 =A0}
> +
> + =A0 =A0*id =3D out[0];
> + =A0 =A0le64_to_cpus(out);
> +
> + =A0 =A0return 0;
> +}
> +
> +static int rbd_create(const char *filename, QEMUOptionParameter *opt=
ions)
> +{
> + =A0 =A0int64_t bytes =3D 0;
> + =A0 =A0int64_t objsize;
> + =A0 =A0uint64_t size;
> + =A0 =A0time_t mtime;
> + =A0 =A0uint8_t obj_order =3D RBD_DEFAULT_OBJ_ORDER;
> + =A0 =A0char pool[RBD_MAX_SEG_NAME_SIZE];
> + =A0 =A0char n[RBD_MAX_SEG_NAME_SIZE];
> + =A0 =A0char name[RBD_MAX_SEG_NAME_SIZE];
> + =A0 =A0char *snap;
> + =A0 =A0RbdHeader1 header;
> + =A0 =A0rados_pool_t p;
> + =A0 =A0uint64_t bid;
> + =A0 =A0uint32_t hi, lo;
> + =A0 =A0int ret;
> +
> + =A0 =A0if (rbd_parsename(filename, pool, &snap, name) < 0) {
> + =A0 =A0 =A0 =A0return -EINVAL;
> + =A0 =A0}
> +
> + =A0 =A0snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", name, RBD_SUFFIX)=
;
> +
> + =A0 =A0/* Read out options */
> + =A0 =A0while (options && options->name) {
> + =A0 =A0 =A0 =A0if (!strcmp(options->name, BLOCK_OPT_SIZE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0bytes =3D options->value.n;
> + =A0 =A0 =A0 =A0} else if (!strcmp(options->name, BLOCK_OPT_CLUSTER_=
SIZE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0if (options->value.n) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0objsize =3D options->value.n;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((objsize - 1) & objsize) { =A0 =A0=
/* not a power of 2? */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error_report("obj size needs=
 to be power of 2");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (objsize < 4096) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error_report("obj size too s=
mall");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (obj_order =3D 0; obj_order < 64=
; obj_order++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (objsize =3D=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0objsize >>=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0options++;
> + =A0 =A0}
> +
> + =A0 =A0memset(&header, 0, sizeof(header));
> + =A0 =A0pstrcpy(header.text, sizeof(header.text), RBD_HEADER_TEXT);
> + =A0 =A0pstrcpy(header.signature, sizeof(header.signature), RBD_HEAD=
ER_SIGNATURE);
> + =A0 =A0pstrcpy(header.version, sizeof(header.version), RBD_HEADER_V=
ERSION);
> + =A0 =A0header.image_size =3D bytes;
> + =A0 =A0cpu_to_le64s((uint64_t *) & header.image_size);
> + =A0 =A0header.options.order =3D obj_order;
> + =A0 =A0header.options.crypt_type =3D RBD_CRYPT_NONE;
> + =A0 =A0header.options.comp_type =3D RBD_COMP_NONE;
> + =A0 =A0header.snap_seq =3D 0;
> + =A0 =A0header.snap_count =3D 0;
> + =A0 =A0cpu_to_le32s(&header.snap_count);
> +
> + =A0 =A0if (rados_initialize(0, NULL) < 0) {
> + =A0 =A0 =A0 =A0error_report("error initializing");
> + =A0 =A0 =A0 =A0return -EIO;
> + =A0 =A0}
> +
> + =A0 =A0if (rados_open_pool(pool, &p)) {
> + =A0 =A0 =A0 =A0error_report("error opening pool %s", pool);
> + =A0 =A0 =A0 =A0rados_deinitialize();
> + =A0 =A0 =A0 =A0return -EIO;
> + =A0 =A0}
> +
> + =A0 =A0/* check for existing rbd header file */
> + =A0 =A0ret =3D rados_stat(p, n, &size, &mtime);
> + =A0 =A0if (ret =3D=3D 0) {
> + =A0 =A0 =A0 =A0ret=3D-EEXIST;
> + =A0 =A0 =A0 =A0goto done;
> + =A0 =A0}
> +
> + =A0 =A0ret =3D rbd_assign_bid(p, &bid);
> + =A0 =A0if (ret < 0) {
> + =A0 =A0 =A0 =A0error_report("failed assigning block id");
> + =A0 =A0 =A0 =A0rados_deinitialize();
> + =A0 =A0 =A0 =A0return -EIO;
> + =A0 =A0}
> + =A0 =A0hi =3D bid >> 32;
> + =A0 =A0lo =3D bid & 0xFFFFFFFF;
> + =A0 =A0snprintf(header.block_name, sizeof(header.block_name), "rb.%=
x.%x", hi, lo);
> +
> + =A0 =A0/* create header file */
> + =A0 =A0ret =3D rados_write(p, n, 0, (const char *)&header, sizeof(h=
eader));
> + =A0 =A0if (ret < 0) {
> + =A0 =A0 =A0 =A0goto done;
> + =A0 =A0}
> +
> + =A0 =A0ret =3D rbd_register_image(p, name);
> +done:
> + =A0 =A0rados_close_pool(p);
> + =A0 =A0rados_deinitialize();
> +
> + =A0 =A0return ret;
> +}
> +
> +static void rbd_aio_completion_cb(void *opaque)
> +{
> + =A0 =A0BDRVRBDState *s =3D opaque;
> +
> + =A0 =A0uint64_t val;
> + =A0 =A0ssize_t ret;
> +
> + =A0 =A0do {
> + =A0 =A0 =A0 =A0if ((ret =3D read(s->efd, &val, sizeof(val))) > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0s->qemu_aio_count -=3D val;
> + =A0 =A0 =A0 =A0}
> + =A0 =A0} while (ret < 0 && errno =3D=3D EINTR);
> +
> + =A0 =A0return;
> +}
> +
> +static int rbd_aio_flush_cb(void *opaque)
> +{
> + =A0 =A0BDRVRBDState *s =3D opaque;
> +
> + =A0 =A0return (s->qemu_aio_count > 0);
> +}
> +
> +
> +static int rbd_set_snapc(rados_pool_t pool, const char *snap, RbdHea=
der1 *header)
> +{
> + =A0 =A0uint32_t snap_count =3D header->snap_count;
> + =A0 =A0rados_snap_t *snaps =3D NULL;
> + =A0 =A0rados_snap_t seq;
> + =A0 =A0uint32_t i;
> + =A0 =A0uint64_t snap_names_len =3D header->snap_names_len;
> + =A0 =A0int r;
> + =A0 =A0rados_snap_t snapid =3D 0;
> +
> + =A0 =A0cpu_to_le32s(&snap_count);
> + =A0 =A0cpu_to_le64s(&snap_names_len);
> + =A0 =A0if (snap_count) {
> + =A0 =A0 =A0 =A0const char *header_snap =3D (const char *)&header->s=
naps[snap_count];
> + =A0 =A0 =A0 =A0const char *end =3D header_snap + snap_names_len;
> + =A0 =A0 =A0 =A0snaps =3D qemu_malloc(sizeof(rados_snap_t) * header-=
>snap_count);
> +
> + =A0 =A0 =A0 =A0for (i=3D0; i < snap_count; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0snaps[i] =3D (uint64_t)header->snaps[i].id;
> + =A0 =A0 =A0 =A0 =A0 =A0cpu_to_le64s(&snaps[i]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0if (snap && strcmp(snap, header_snap) =3D=3D=
 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snapid =3D snaps[i];
> + =A0 =A0 =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0 =A0 =A0header_snap +=3D strlen(header_snap) + 1;
> + =A0 =A0 =A0 =A0 =A0 =A0if (header_snap > end)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error_report("bad header, snapshot l=
ist broken");
> + =A0 =A0 =A0 =A0}
> + =A0 =A0}
> +
> + =A0 =A0if (snap && !snapid) {
> + =A0 =A0 =A0 =A0error_report("snapshot not found");
> + =A0 =A0 =A0 =A0return -ENOENT;
> + =A0 =A0}
> + =A0 =A0seq =3D header->snap_seq;
> + =A0 =A0cpu_to_le32s((uint32_t *)&seq);
> +
> + =A0 =A0r =3D rados_set_snap_context(pool, seq, snaps, snap_count);
> +
> + =A0 =A0rados_set_snap(pool, snapid);
> +
> + =A0 =A0qemu_free(snaps);
> +
> + =A0 =A0return r;
> +}
> +
> +#define BUF_READ_START_LEN =A0 =A04096
> +
> +static int rbd_read_header(BDRVRBDState *s, char **hbuf)
> +{
> + =A0 =A0char *buf =3D NULL;
> + =A0 =A0char n[RBD_MAX_SEG_NAME_SIZE];
> + =A0 =A0uint64_t len =3D BUF_READ_START_LEN;
> + =A0 =A0int r;
> +
> + =A0 =A0snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", s->name, RBD_SUFF=
IX);
> +
> + =A0 =A0buf =3D qemu_malloc(len);
> +
> + =A0 =A0r =3D rados_read(s->header_pool, n, 0, buf, len);
> + =A0 =A0if (r < 0)
> + =A0 =A0 =A0 =A0goto failed;
> +
> + =A0 =A0if (r < len)
> + =A0 =A0 =A0 =A0goto done;
> +
> + =A0 =A0qemu_free(buf);
> + =A0 =A0buf =3D qemu_malloc(len);
> +
> + =A0 =A0r =3D rados_stat(s->header_pool, n, &len, NULL);
> + =A0 =A0if (r < 0)
> + =A0 =A0 =A0 =A0goto failed;
> +
> + =A0 =A0r =3D rados_read(s->header_pool, n, 0, buf, len);
> + =A0 =A0if (r < 0)
> + =A0 =A0 =A0 =A0goto failed;
> +
> +done:
> + =A0 =A0*hbuf =3D buf;
> + =A0 =A0return 0;
> +
> +failed:
> + =A0 =A0qemu_free(buf);
> + =A0 =A0return r;
> +}
> +
> +static int rbd_open(BlockDriverState *bs, const char *filename, int =
flags)
> +{
> + =A0 =A0BDRVRBDState *s =3D bs->opaque;
> + =A0 =A0char pool[RBD_MAX_SEG_NAME_SIZE];
> + =A0 =A0char *snap;
> + =A0 =A0char *hbuf =3D NULL;
> + =A0 =A0int r;
> +
> + =A0 =A0if (rbd_parsename(filename, pool, &snap, s->name) < 0) {
> + =A0 =A0 =A0 =A0return -EINVAL;
> + =A0 =A0}
> +
> + =A0 =A0if ((r =3D rados_initialize(0, NULL)) < 0) {
> + =A0 =A0 =A0 =A0error_report("error initializing");
> + =A0 =A0 =A0 =A0return r;
> + =A0 =A0}
> +
> + =A0 =A0if ((r =3D rados_open_pool(pool, &s->pool))) {
> + =A0 =A0 =A0 =A0error_report("error opening pool %s", pool);
> + =A0 =A0 =A0 =A0rados_deinitialize();
> + =A0 =A0 =A0 =A0return r;
> + =A0 =A0}
> +
> + =A0 =A0if ((r =3D rados_open_pool(pool, &s->header_pool))) {
> + =A0 =A0 =A0 =A0error_report("error opening pool %s", pool);
> + =A0 =A0 =A0 =A0rados_deinitialize();
> + =A0 =A0 =A0 =A0return r;
> + =A0 =A0}
> +
> + =A0 if ((r =3D rbd_read_header(s, &hbuf)) < 0) {
> + =A0 =A0 =A0 =A0error_report("error reading header from %s", s->name=
);
> + =A0 =A0 =A0 =A0goto failed;
> + =A0 =A0}
> +
> + =A0 =A0if (strncmp(hbuf + 64, RBD_HEADER_SIGNATURE, 4)) {
> + =A0 =A0 =A0 =A0error_report("Invalid header signature %s", hbuf + 6=
4);
> + =A0 =A0 =A0 =A0r =3D -EMEDIUMTYPE;
> + =A0 =A0 =A0 =A0goto failed;
> + =A0 =A0}
> +
> + =A0 =A0if (strncmp(hbuf + 68, RBD_HEADER_VERSION, 8)) {
> + =A0 =A0 =A0 =A0error_report("Unknown image version %s", hbuf + 68);
> + =A0 =A0 =A0 =A0r =3D -EMEDIUMTYPE;
> + =A0 =A0 =A0 =A0goto failed;
> + =A0 =A0}
> +
> + =A0 =A0RbdHeader1 *header;
> +
> + =A0 =A0header =3D (RbdHeader1 *) hbuf;
> + =A0 =A0le64_to_cpus((uint64_t *) & header->image_size);
> + =A0 =A0s->size =3D header->image_size;
> + =A0 =A0s->objsize =3D 1 << header->options.order;
> + =A0 =A0memcpy(s->block_name, header->block_name, sizeof(header->blo=
ck_name));
> +
> + =A0 =A0r =3D rbd_set_snapc(s->pool, snap, header);
> + =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0error_report("failed setting snap context: %s", stre=
rror(-r));
> + =A0 =A0 =A0 =A0goto failed;
> + =A0 =A0}
> +
> + =A0 =A0s->read_only =3D (snap !=3D NULL);
> +
> + =A0 =A0s->efd =3D eventfd(0, 0);
> + =A0 =A0if (s->efd < 0) {
> + =A0 =A0 =A0 =A0error_report("error opening eventfd");
> + =A0 =A0 =A0 =A0goto failed;
> + =A0 =A0}
> + =A0 =A0fcntl(s->efd, F_SETFL, O_NONBLOCK);
> + =A0 =A0qemu_aio_set_fd_handler(s->efd, rbd_aio_completion_cb, NULL,
> + =A0 =A0 =A0 =A0rbd_aio_flush_cb, NULL, s);
> +
> + =A0 =A0qemu_free(hbuf);
> +
> + =A0 =A0return 0;
> +
> +failed:
> + =A0 =A0if (hbuf)
> + =A0 =A0 =A0 =A0qemu_free(hbuf);
> +
> + =A0 =A0rados_close_pool(s->header_pool);
> + =A0 =A0rados_close_pool(s->pool);
> + =A0 =A0rados_deinitialize();
> + =A0 =A0return r;
> +}
> +
> +static void rbd_close(BlockDriverState *bs)
> +{
> + =A0 =A0BDRVRBDState *s =3D bs->opaque;
> +
> + =A0 =A0close(s->efd);
> + =A0 =A0qemu_aio_set_fd_handler(s->efd, NULL , NULL, NULL, NULL, NUL=
L);
> +
> + =A0 =A0rados_close_pool(s->header_pool);
> + =A0 =A0rados_close_pool(s->pool);
> + =A0 =A0rados_deinitialize();
> +}
> +
> +static int rbd_rw(BlockDriverState *bs, int64_t sector_num,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint8_t *buf, int nb_sectors, in=
t write)
> +{
> + =A0 =A0BDRVRBDState *s =3D bs->opaque;
> + =A0 =A0char n[RBD_MAX_SEG_NAME_SIZE];
> +
> + =A0 =A0int64_t segnr, segoffs, segsize, r;
> + =A0 =A0int64_t off, size;
> +
> + =A0 =A0off =3D sector_num * BDRV_SECTOR_SIZE;
> + =A0 =A0size =3D nb_sectors * BDRV_SECTOR_SIZE;
> + =A0 =A0segnr =3D off / s->objsize;
> + =A0 =A0segoffs =3D off % s->objsize;
> + =A0 =A0segsize =3D s->objsize - segoffs;
> +
> + =A0 =A0while (size > 0) {
> + =A0 =A0 =A0 =A0if (size < segsize) {
> + =A0 =A0 =A0 =A0 =A0 =A0segsize =3D size;
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012" PRIx64,=
 s->block_name, segnr);
> +
> + =A0 =A0 =A0 =A0if (write) {
> + =A0 =A0 =A0 =A0 =A0 =A0if (s->read_only)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EROFS;
> + =A0 =A0 =A0 =A0 =A0 =A0if ((r =3D rados_write(s->pool, n, segoffs, =
(const char *)buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0segsize)) < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return r;
> + =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0} else {
> + =A0 =A0 =A0 =A0 =A0 =A0r =3D rados_read(s->pool, n, segoffs, (char =
*)buf, segsize);
> + =A0 =A0 =A0 =A0 =A0 =A0if (r =3D=3D -ENOENT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(buf, 0, segsize);
> + =A0 =A0 =A0 =A0 =A0 =A0} else if (r < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return r;
> + =A0 =A0 =A0 =A0 =A0 =A0} else if (r < segsize) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(buf + r, 0, segsize - r);
> + =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0buf +=3D segsize;
> + =A0 =A0 =A0 =A0size -=3D segsize;
> + =A0 =A0 =A0 =A0segoffs =3D 0;
> + =A0 =A0 =A0 =A0segsize =3D s->objsize;
> + =A0 =A0 =A0 =A0segnr++;
> + =A0 =A0}
> +
> + =A0 =A0return 0;
> +}
> +
> +static int rbd_read(BlockDriverState *bs, int64_t sector_num,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint8_t *buf, int nb_sectors=
)
> +{
> + =A0 =A0return rbd_rw(bs, sector_num, buf, nb_sectors, 0);
> +}
> +
> +static int rbd_write(BlockDriverState *bs, int64_t sector_num,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const uint8_t *buf, int nb_=
sectors)
> +{
> + =A0 =A0return rbd_rw(bs, sector_num, (uint8_t *) buf, nb_sectors, 1=
);
> +}
> +
> +static void rbd_aio_cancel(BlockDriverAIOCB *blockacb)
> +{
> + =A0 =A0RBDAIOCB *acb =3D (RBDAIOCB *) blockacb;
> + =A0 =A0qemu_bh_delete(acb->bh);
> + =A0 =A0acb->bh =3D NULL;
> + =A0 =A0qemu_aio_release(acb);
> +}
> +
> +static AIOPool rbd_aio_pool =3D {
> + =A0 =A0.aiocb_size =3D sizeof(RBDAIOCB),
> + =A0 =A0.cancel =3D rbd_aio_cancel,
> +};
> +
> +/* This is the callback function for rados_aio_read and _write */
> +
> +static void rbd_finish_aiocb(rados_completion_t c, RADOSCB *rcb)
> +{
> + =A0 =A0RBDAIOCB *acb =3D rcb->acb;
> + =A0 =A0int64_t r;
> + =A0 =A0uint64_t buf =3D 1;
> + =A0 =A0int i;
> +
> + =A0 =A0acb->aiocnt--;
> + =A0 =A0r =3D rados_aio_get_return_value(c);
> + =A0 =A0rados_aio_release(c);
> + =A0 =A0if (acb->write) {
> + =A0 =A0 =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0acb->ret =3D r;
> + =A0 =A0 =A0 =A0 =A0 =A0acb->error =3D 1;
> + =A0 =A0 =A0 =A0} else if (!acb->error) {
> + =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D rcb->segsize;
> + =A0 =A0 =A0 =A0}
> + =A0 =A0} else {
> + =A0 =A0 =A0 =A0if (r =3D=3D -ENOENT) {
> + =A0 =A0 =A0 =A0 =A0 =A0memset(rcb->buf, 0, rcb->segsize);
> + =A0 =A0 =A0 =A0 =A0 =A0if (!acb->error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D rcb->segsize;
> + =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0} else if (r < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0acb->ret =3D r;
> + =A0 =A0 =A0 =A0 =A0 =A0acb->error =3D 1;
> + =A0 =A0 =A0 =A0} else if (r < rcb->segsize) {
> + =A0 =A0 =A0 =A0 =A0 =A0memset(rcb->buf + r, 0, rcb->segsize - r);
> + =A0 =A0 =A0 =A0 =A0 =A0if (!acb->error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D rcb->segsize;
> + =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0} else if (!acb->error) {
> + =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D r;
> + =A0 =A0 =A0 =A0}
> + =A0 =A0}
> + =A0 =A0if (write(acb->s->efd, &buf, sizeof(buf)) < 0)
> + =A0 =A0 =A0 =A0error_report("failed writing to acb->s->efd\n");
> + =A0 =A0qemu_free(rcb);
> + =A0 =A0i =3D 0;
> + =A0 =A0if (!acb->aiocnt && acb->bh) {
> + =A0 =A0 =A0 =A0qemu_bh_schedule(acb->bh);
> + =A0 =A0}
> +}
> +
> +/* Callback when all queued rados_aio requests are complete */
> +
> +static void rbd_aio_bh_cb(void *opaque)
> +{
> + =A0 =A0RBDAIOCB *acb =3D opaque;
> + =A0 =A0uint64_t buf =3D 1;
> +
> + =A0 =A0if (!acb->write) {
> + =A0 =A0 =A0 =A0qemu_iovec_from_buffer(acb->qiov, acb->bounce, acb->=
qiov->size);
> + =A0 =A0}
> + =A0 =A0qemu_vfree(acb->bounce);
> + =A0 =A0acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->=
ret));
> + =A0 =A0qemu_bh_delete(acb->bh);
> + =A0 =A0acb->bh =3D NULL;
> +
> + =A0 =A0if (write(acb->s->efd, &buf, sizeof(buf)) < 0)
> + =A0 =A0 =A0 =A0error_report("failed writing to acb->s->efd\n");
> + =A0 =A0qemu_aio_release(acb);
> +}
> +
> +static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState *bs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 int64_t sector_num,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 QEMUIOVector *qiov,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 int nb_sectors,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 BlockDriverCompletionFunc *cb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 void *opaque, int write)
> +{
> + =A0 =A0RBDAIOCB *acb;
> + =A0 =A0RADOSCB *rcb;
> + =A0 =A0rados_completion_t c;
> + =A0 =A0char n[RBD_MAX_SEG_NAME_SIZE];
> + =A0 =A0int64_t segnr, segoffs, segsize, last_segnr;
> + =A0 =A0int64_t off, size;
> + =A0 =A0char *buf;
> +
> + =A0 =A0BDRVRBDState *s =3D bs->opaque;
> +
> + =A0 =A0acb =3D qemu_aio_get(&rbd_aio_pool, bs, cb, opaque);
> + =A0 =A0acb->write =3D write;
> + =A0 =A0acb->qiov =3D qiov;
> + =A0 =A0acb->bounce =3D qemu_blockalign(bs, qiov->size);
> + =A0 =A0acb->aiocnt =3D 0;
> + =A0 =A0acb->ret =3D 0;
> + =A0 =A0acb->error =3D 0;
> + =A0 =A0acb->s =3D s;
> +
> + =A0 =A0if (!acb->bh) {
> + =A0 =A0 =A0 =A0acb->bh =3D qemu_bh_new(rbd_aio_bh_cb, acb);
> + =A0 =A0}
> +
> + =A0 =A0if (write) {
> + =A0 =A0 =A0 =A0qemu_iovec_to_buffer(acb->qiov, acb->bounce);
> + =A0 =A0}
> +
> + =A0 =A0buf =3D acb->bounce;
> +
> + =A0 =A0off =3D sector_num * BDRV_SECTOR_SIZE;
> + =A0 =A0size =3D nb_sectors * BDRV_SECTOR_SIZE;
> + =A0 =A0segnr =3D off / s->objsize;
> + =A0 =A0segoffs =3D off % s->objsize;
> + =A0 =A0segsize =3D s->objsize - segoffs;
> +
> + =A0 =A0last_segnr =3D ((off + size - 1) / s->objsize);
> + =A0 =A0acb->aiocnt =3D (last_segnr - segnr) + 1;
> +
> + =A0 =A0s->qemu_aio_count+=3Dacb->aiocnt + 1; /* All the RADOSCB and=
 the related RBDAIOCB */
> +
> + =A0 =A0if (write && s->read_only) {
> + =A0 =A0 =A0 =A0acb->ret =3D -EROFS;
> + =A0 =A0 =A0 =A0return NULL;
> + =A0 =A0}
> +
> + =A0 =A0while (size > 0) {
> + =A0 =A0 =A0 =A0if (size < segsize) {
> + =A0 =A0 =A0 =A0 =A0 =A0segsize =3D size;
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012" PRIx64,=
 s->block_name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 segnr);
> +
> + =A0 =A0 =A0 =A0rcb =3D qemu_malloc(sizeof(RADOSCB));
> + =A0 =A0 =A0 =A0rcb->done =3D 0;
> + =A0 =A0 =A0 =A0rcb->acb =3D acb;
> + =A0 =A0 =A0 =A0rcb->segsize =3D segsize;
> + =A0 =A0 =A0 =A0rcb->buf =3D buf;
> +
> + =A0 =A0 =A0 =A0if (write) {
> + =A0 =A0 =A0 =A0 =A0 =A0rados_aio_create_completion(rcb, NULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(rados_callback_t) rbd_finish_aiocb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0&c);
> + =A0 =A0 =A0 =A0 =A0 =A0rados_aio_write(s->pool, n, segoffs, buf, se=
gsize, c);
> + =A0 =A0 =A0 =A0} else {
> + =A0 =A0 =A0 =A0 =A0 =A0rados_aio_create_completion(rcb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(rados_callback_t) rbd_finish_aiocb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0NULL, &c);
> + =A0 =A0 =A0 =A0 =A0 =A0rados_aio_read(s->pool, n, segoffs, buf, seg=
size, c);
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0buf +=3D segsize;
> + =A0 =A0 =A0 =A0size -=3D segsize;
> + =A0 =A0 =A0 =A0segoffs =3D 0;
> + =A0 =A0 =A0 =A0segsize =3D s->objsize;
> + =A0 =A0 =A0 =A0segnr++;
> + =A0 =A0}
> +
> + =A0 =A0return &acb->common;
> +}
> +
> +static BlockDriverAIOCB *rbd_aio_readv(BlockDriverState * bs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 int64_t sector_num, QEMUIOVector * qiov,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 int nb_sectors,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 BlockDriverCompletionFunc * cb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 void *opaque)
> +{
> + =A0 =A0return rbd_aio_rw_vector(bs, sector_num, qiov, nb_sectors, c=
b, opaque, 0);
> +}
> +
> +static BlockDriverAIOCB *rbd_aio_writev(BlockDriverState * bs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0int64_t sector_num, QEMUIOVector * qiov,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0int nb_sectors,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0BlockDriverCompletionFunc * cb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0void *opaque)
> +{
> + =A0 =A0return rbd_aio_rw_vector(bs, sector_num, qiov, nb_sectors, c=
b, opaque, 1);
> +}
> +
> +static int rbd_getinfo(BlockDriverState * bs, BlockDriverInfo * bdi)
> +{
> + =A0 =A0BDRVRBDState *s =3D bs->opaque;
> + =A0 =A0bdi->cluster_size =3D s->objsize;
> + =A0 =A0return 0;
> +}
> +
> +static int64_t rbd_getlength(BlockDriverState * bs)
> +{
> + =A0 =A0BDRVRBDState *s =3D bs->opaque;
> +
> + =A0 =A0return s->size;
> +}
> +
> +static int rbd_snap_create(BlockDriverState *bs, QEMUSnapshotInfo *s=
n_info)
> +{
> + =A0 =A0BDRVRBDState *s =3D bs->opaque;
> + =A0 =A0char inbuf[512], outbuf[128];
> + =A0 =A0uint64_t snap_id;
> + =A0 =A0int r;
> + =A0 =A0char *p =3D inbuf;
> + =A0 =A0char *end =3D inbuf + sizeof(inbuf);
> + =A0 =A0char n[RBD_MAX_SEG_NAME_SIZE];
> + =A0 =A0char *hbuf =3D NULL;
> +
> + =A0 =A0if (sn_info->name[0] =3D=3D '\0')
> + =A0 =A0 =A0 =A0return -EINVAL; /* we need a name for rbd snapshots =
*/
> +
> + =A0 =A0/*
> + =A0 =A0 * rbd snapshots are using the name as the user controlled u=
nique identifier
> + =A0 =A0 * we can't use the rbd snapid for that purpose, as it can't=
 be set
> + =A0 =A0 */
> + =A0 =A0if (sn_info->id_str[0] !=3D '\0' &&
> + =A0 =A0 =A0 =A0strcmp(sn_info->id_str, sn_info->name) !=3D 0)
> + =A0 =A0 =A0 =A0return -EINVAL;
> +
> + =A0 =A0if (strlen(sn_info->name) >=3D sizeof(sn_info->id_str))
> + =A0 =A0 =A0 =A0return -ERANGE;
> +
> + =A0 =A0r =3D rados_selfmanaged_snap_create(s->header_pool, &snap_id=
);
> + =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0error_report("failed to create snap id: %s", strerro=
r(-r));
> + =A0 =A0 =A0 =A0return r;
> + =A0 =A0}
> +
> + =A0 =A0*(uint32_t *)p =3D strlen(sn_info->name);
> + =A0 =A0cpu_to_le32s((uint32_t *)p);
> + =A0 =A0p +=3D sizeof(uint32_t);
> + =A0 =A0strncpy(p, sn_info->name, end - p);
> + =A0 =A0p +=3D strlen(p);
> + =A0 =A0if (p + sizeof(snap_id) > end) {
> + =A0 =A0 =A0 =A0error_report("invalid input parameter");
> + =A0 =A0 =A0 =A0return -EINVAL;
> + =A0 =A0}
> +
> + =A0 =A0*(uint64_t *)p =3D snap_id;
> + =A0 =A0cpu_to_le64s((uint64_t *)p);
> +
> + =A0 =A0snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", s->name, RBD_SUFF=
IX);
> +
> + =A0 =A0r =3D rados_exec(s->header_pool, n, "rbd", "snap_add", inbuf=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(inbuf), outbuf, sizeof(o=
utbuf));
> + =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0error_report("rbd.snap_add execution failed failed: =
%s", strerror(-r));
> + =A0 =A0 =A0 =A0return r;
> + =A0 =A0}
> +
> + =A0 =A0sprintf(sn_info->id_str, "%s", sn_info->name);
> +
> + =A0 =A0r =3D rbd_read_header(s, &hbuf);
> + =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0error_report("failed reading header: %s", strerror(-=
r));
> + =A0 =A0 =A0 =A0return r;
> + =A0 =A0}
> +
> + =A0 =A0RbdHeader1 *header;
> +
> + =A0 =A0header =3D (RbdHeader1 *) hbuf;
> + =A0 =A0r =3D rbd_set_snapc(s->pool, sn_info->name, header);
> + =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0error_report("failed setting snap context: %s", stre=
rror(-r));
> + =A0 =A0 =A0 =A0goto failed;
> + =A0 =A0}
> +
> + =A0 =A0return 0;
> +
> +failed:
> + =A0 =A0if (hbuf)
> + =A0 =A0 =A0 =A0qemu_free(header);
> + =A0 =A0return r;
> +}
> +
> +static QEMUOptionParameter rbd_create_options[] =3D {
> + =A0 =A0{
> + =A0 =A0 .name =3D BLOCK_OPT_SIZE,
> + =A0 =A0 .type =3D OPT_SIZE,
> + =A0 =A0 .help =3D "Virtual disk size"
> + =A0 =A0},
> + =A0 =A0{
> + =A0 =A0 .name =3D BLOCK_OPT_CLUSTER_SIZE,
> + =A0 =A0 .type =3D OPT_SIZE,
> + =A0 =A0 .help =3D "RBD object size"
> + =A0 =A0},
> + =A0 =A0{NULL}
> +};
> +
> +static BlockDriver bdrv_rbd =3D {
> + =A0 =A0.format_name =A0 =A0 =A0 =A0=3D "rbd",
> + =A0 =A0.instance_size =A0 =A0 =A0=3D sizeof(BDRVRBDState),
> + =A0 =A0.bdrv_file_open =A0 =A0 =3D rbd_open,
> + =A0 =A0.bdrv_read =A0 =A0 =A0 =A0 =A0=3D rbd_read,
> + =A0 =A0.bdrv_write =A0 =A0 =A0 =A0 =3D rbd_write,
> + =A0 =A0.bdrv_close =A0 =A0 =A0 =A0 =3D rbd_close,
> + =A0 =A0.bdrv_create =A0 =A0 =A0 =A0=3D rbd_create,
> + =A0 =A0.bdrv_get_info =A0 =A0 =A0=3D rbd_getinfo,
> + =A0 =A0.create_options =A0 =A0 =3D rbd_create_options,
> + =A0 =A0.bdrv_getlength =A0 =A0 =3D rbd_getlength,
> + =A0 =A0.protocol_name =A0 =A0 =A0=3D "rbd",
> +
> + =A0 =A0.bdrv_aio_readv =A0 =A0 =3D rbd_aio_readv,
> + =A0 =A0.bdrv_aio_writev =A0 =A0=3D rbd_aio_writev,
> +
> + =A0 =A0.bdrv_snapshot_create =3D rbd_snap_create,
> +};
> +
> +static void bdrv_rbd_init(void)
> +{
> + =A0 =A0bdrv_register(&bdrv_rbd);
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
> + * Foundation. =A0See file COPYING.
> + *
> + */
> +
> +#ifndef CEPH_RBD_TYPES_H
> +#define CEPH_RBD_TYPES_H
> +
> +
> +/*
> + * rbd image 'foo' consists of objects
> + * =A0 foo.rbd =A0 =A0 =A0- image metadata
> + * =A0 foo.00000000
> + * =A0 foo.00000001
> + * =A0 ... =A0 =A0 =A0 =A0 =A0- data
> + */
> +
> +#define RBD_SUFFIX =A0 =A0 =A0 =A0 =A0 =A0 =A0".rbd"
> +#define RBD_DIRECTORY =A0 =A0 =A0 =A0 =A0 "rbd_directory"
> +#define RBD_INFO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"rbd_info"
> +
> +#define RBD_DEFAULT_OBJ_ORDER =A0 22 =A0 /* 4MB */
> +
> +#define RBD_MAX_OBJ_NAME_SIZE =A0 96
> +#define RBD_MAX_BLOCK_NAME_SIZE 24
> +#define RBD_MAX_SEG_NAME_SIZE =A0 128
> +
> +#define RBD_COMP_NONE =A0 =A0 =A0 =A0 =A0 0
> +#define RBD_CRYPT_NONE =A0 =A0 =A0 =A0 =A00
> +
> +#define RBD_HEADER_TEXT =A0 =A0 =A0 =A0 "<<< Rados Block Device Imag=
e >>>\n"
> +#define RBD_HEADER_SIGNATURE =A0 =A0"RBD"
> +#define RBD_HEADER_VERSION =A0 =A0 =A0"001.005"
> +
> +struct rbd_info {
> + =A0 =A0uint64_t max_id;
> +} __attribute__ ((packed));
> +
> +struct rbd_obj_snap_ondisk {
> + =A0 =A0uint64_t id;
> + =A0 =A0uint64_t image_size;
> +} __attribute__((packed));
> +
> +struct rbd_obj_header_ondisk {
> + =A0 =A0char text[40];
> + =A0 =A0char block_name[RBD_MAX_BLOCK_NAME_SIZE];
> + =A0 =A0char signature[4];
> + =A0 =A0char version[8];
> + =A0 =A0struct {
> + =A0 =A0 =A0 =A0uint8_t order;
> + =A0 =A0 =A0 =A0uint8_t crypt_type;
> + =A0 =A0 =A0 =A0uint8_t comp_type;
> + =A0 =A0 =A0 =A0uint8_t unused;
> + =A0 =A0} __attribute__((packed)) options;
> + =A0 =A0uint64_t image_size;
> + =A0 =A0uint64_t snap_seq;
> + =A0 =A0uint32_t snap_count;
> + =A0 =A0uint32_t reserved;
> + =A0 =A0uint64_t snap_names_len;
> + =A0 =A0struct rbd_obj_snap_ondisk snaps[0];
> +} __attribute__((packed));
> +
> +
> +#endif
> diff --git a/configure b/configure
> index a20371c..3fb7c90 100755
> --- a/configure
> +++ b/configure
> @@ -315,6 +315,7 @@ pkgversion=3D""
> =A0check_utests=3D"no"
> =A0user_pie=3D"no"
> =A0zero_malloc=3D""
> +rbd=3D""
>
> =A0# OS specific
> =A0if check_define __linux__ ; then
> @@ -709,6 +710,10 @@ for opt do
> =A0 ;;
> =A0 --*dir)
> =A0 ;;
> + =A0--disable-rbd) rbd=3D"no"
> + =A0;;
> + =A0--enable-rbd) rbd=3D"yes"
> + =A0;;
> =A0 *) echo "ERROR: unknown option $opt"; show_help=3D"yes"
> =A0 ;;
> =A0 esac
> @@ -895,6 +900,7 @@ echo " =A0--enable-docs =A0 =A0 =A0 =A0 =A0 =A0en=
able documentation build"
> =A0echo " =A0--disable-docs =A0 =A0 =A0 =A0 =A0 disable documentation=
 build"
> =A0echo " =A0--disable-vhost-net =A0 =A0 =A0disable vhost-net acceler=
ation support"
> =A0echo " =A0--enable-vhost-net =A0 =A0 =A0 enable vhost-net accelera=
tion support"
> +echo " =A0--enable-rbd =A0 =A0 =A0 =A0 =A0 =A0 enable building the r=
ados block device (rbd)"
> =A0echo ""
> =A0echo "NOTE: The object files are built at the place where configur=
e is launched"
> =A0exit 1
> @@ -1701,6 +1707,27 @@ if test "$mingw32" !=3D yes -a "$pthread" =3D =
no; then
> =A0fi
>
> =A0##########################################
> +# rbd probe
> +if test "$rbd" !=3D "no" ; then
> + =A0cat > $TMPC <<EOF
> +#include <stdio.h>
> +#include <rados/librados.h>
> +int main(void) { rados_initialize(0, NULL); return 0; }
> +EOF
> + =A0rbd_libs=3D"-lrados -lcrypto"
> + =A0if compile_prog "" "$rbd_libs" ; then
> + =A0 =A0rbd=3Dyes
> + =A0 =A0libs_tools=3D"$rbd_libs $libs_tools"
> + =A0 =A0libs_softmmu=3D"$rbd_libs $libs_softmmu"
> + =A0else
> + =A0 =A0if test "$rbd" =3D "yes" ; then
> + =A0 =A0 =A0feature_not_found "rados block device"
> + =A0 =A0fi
> + =A0 =A0rbd=3Dno
> + =A0fi
> +fi
> +
> +##########################################
> =A0# linux-aio probe
>
> =A0if test "$linux_aio" !=3D "no" ; then
> @@ -2187,6 +2214,7 @@ echo "preadv support =A0 =A0$preadv"
> =A0echo "fdatasync =A0 =A0 =A0 =A0 $fdatasync"
> =A0echo "uuid support =A0 =A0 =A0$uuid"
> =A0echo "vhost-net support $vhost_net"
> +echo "rbd support =A0 =A0 =A0 $rbd"
>
> =A0if test $sdl_too_old =3D "yes"; then
> =A0echo "-> Your SDL version is too old - please upgrade to have SDL =
support"
> @@ -2434,6 +2462,9 @@ echo "CONFIG_UNAME_RELEASE=3D\"$uname_release\"=
" >> $config_host_mak
> =A0if test "$zero_malloc" =3D "yes" ; then
> =A0 echo "CONFIG_ZERO_MALLOC=3Dy" >> $config_host_mak
> =A0fi
> +if test "$rbd" =3D "yes" ; then
> + =A0echo "CONFIG_RBD=3Dy" >> $config_host_mak
> +fi
>
> =A0# USB host support
> =A0case "$usb" in
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
