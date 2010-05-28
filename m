From: Christian Brunner <chb@muc.de>
Subject: Re: [Qemu-devel] [PATCH 1/1] ceph/rbd block driver for qemu-kvm (v2)
Date: Fri, 28 May 2010 22:53:49 +0200
Message-ID: <AANLkTilwxzbNFdD9o_k1AQASxF9XndOLCi3_uUJ26DxQ@mail.gmail.com>
References: <20100527191158.GB16854@chb-desktop>
	<4BFFE82E.7080701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:62905 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758786Ab0E1Uxv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 May 2010 16:53:51 -0400
In-Reply-To: <4BFFE82E.7080701@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Wolf <kwolf@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

Hi Kevin,

thanks for your review notes. Yehuda and I have already worked this int=
o the git
tree on the ceph site.

I'll do some testing on Monday. After that I'll send an updated patch.

Regards,
Christian

2010/5/28 Kevin Wolf <kwolf@redhat.com>:
> Am 27.05.2010 21:11, schrieb Christian Brunner:
>> This is a block driver for the distributed file system Ceph
>> (http://ceph.newdream.net/). This driver uses librados (which
>> is part of the Ceph server) for direct access to the Ceph object
>> store and is running entirely in userspace. Therefore it is
>> called "rbd" - rados block device.
>>
>> To compile the driver a recent version of ceph (unstable/testin git
>> head or 0.20.3 once it is released) is needed and you have to
>> "--enable-rbd" when running configure.
>>
>> Additional information is available on the Ceph-Wiki:
>>
>> http://ceph.newdream.net/wiki/Kvm-rbd
>>
>> The patch is based on git://repo.or.cz/qemu/kevin.git block
>
> Signed-off-by line is missing.
>
>> ---
>> =A0Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A03 +
>> =A0Makefile.objs =A0 =A0 | =A0 =A01 +
>> =A0block/rbd.c =A0 =A0 =A0 | =A0584 ++++++++++++++++++++++++++++++++=
+++++++++++++++++++++
>> =A0block/rbd_types.h | =A0 52 +++++
>> =A0configure =A0 =A0 =A0 =A0 | =A0 27 +++
>> =A05 files changed, 667 insertions(+), 0 deletions(-)
>> =A0create mode 100644 block/rbd.c
>> =A0create mode 100644 block/rbd_types.h
>>
>> diff --git a/Makefile b/Makefile
>> index 7986bf6..8d09612 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -27,6 +27,9 @@ configure: ;
>> =A0$(call set-vpath, $(SRC_PATH):$(SRC_PATH)/hw)
>>
>> =A0LIBS+=3D-lz $(LIBS_TOOLS)
>> +ifdef CONFIG_RBD
>> +LIBS+=3D-lrados
>> +endif
>
> You already write the -lrados option to config-host.mak in configure,=
 so
> this looks unnecessary.
>
>>
>> =A0ifdef BUILD_DOCS
>> =A0DOCS=3Dqemu-doc.html qemu-tech.html qemu.1 qemu-img.1 qemu-nbd.8
>> diff --git a/Makefile.objs b/Makefile.objs
>> index 1a942e5..08dc11f 100644
>> --- a/Makefile.objs
>> +++ b/Makefile.objs
>> @@ -18,6 +18,7 @@ block-nested-y +=3D parallels.o nbd.o blkdebug.o
>> =A0block-nested-$(CONFIG_WIN32) +=3D raw-win32.o
>> =A0block-nested-$(CONFIG_POSIX) +=3D raw-posix.o
>> =A0block-nested-$(CONFIG_CURL) +=3D curl.o
>> +block-nested-$(CONFIG_RBD) +=3D rbd.o
>>
>> =A0block-obj-y +=3D =A0$(addprefix block/, $(block-nested-y))
>>
>> diff --git a/block/rbd.c b/block/rbd.c
>> new file mode 100644
>> index 0000000..375ae9d
>> --- /dev/null
>> +++ b/block/rbd.c
>> @@ -0,0 +1,584 @@
>> +/*
>> + * QEMU Block driver for RADOS (Ceph)
>> + *
>> + * Copyright (C) 2010 Christian Brunner <chb@muc.de>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2.=
 =A0See
>> + * the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include "qemu-common.h"
>> +#include <sys/types.h>
>> +#include <stdbool.h>
>> +
>> +#include <qemu-common.h>
>> +
>> +#include "rbd_types.h"
>> +#include "module.h"
>> +#include "block_int.h"
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <rados/librados.h>
>> +
>> +#include <signal.h>
>> +
>> +/*
>> + * When specifying the image filename use:
>> + *
>> + * rbd:poolname/devicename
>> + *
>> + * poolname must be the name of an existing rados pool
>> + *
>> + * devicename is the basename for all objects used to
>> + * emulate the raw device.
>> + *
>> + * Metadata information (image size, ...) is stored in an
>> + * object with the name "devicename.rbd".
>> + *
>> + * The raw device is split into 4MB sized objects by default.
>> + * The sequencenumber is encoded in a 12 byte long hex-string,
>> + * and is attached to the devicename, separated by a dot.
>> + * e.g. "devicename.1234567890ab"
>> + *
>> + */
>> +
>> +#define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
>> +
>> +typedef struct RBDAIOCB {
>> + =A0 =A0BlockDriverAIOCB common;
>> + =A0 =A0QEMUBH *bh;
>> + =A0 =A0int ret;
>> + =A0 =A0QEMUIOVector *qiov;
>> + =A0 =A0char *bounce;
>> + =A0 =A0int write;
>> + =A0 =A0int64_t sector_num;
>> + =A0 =A0int aiocnt;
>> + =A0 =A0int error;
>> +} RBDAIOCB;
>> +
>> +typedef struct RADOSCB {
>> + =A0 =A0int rcbid;
>> + =A0 =A0RBDAIOCB *acb;
>> + =A0 =A0int done;
>> + =A0 =A0int64_t segsize;
>> + =A0 =A0char *buf;
>> +} RADOSCB;
>> +
>> +typedef struct RBDRVRBDState {
>> + =A0 =A0rados_pool_t pool;
>> + =A0 =A0char name[RBD_MAX_OBJ_NAME_SIZE];
>> + =A0 =A0int name_len;
>
> name_len looks unused.
>
>> + =A0 =A0uint64_t size;
>> + =A0 =A0uint64_t objsize;
>> +} RBDRVRBDState;
>
> Hm, you mean BDRVRBDState?
>
> Maybe ceph would have been a better driver name to avoid such type
> names. ;-)
>
>> +
>> +typedef struct rbd_obj_header_ondisk RbdHeader1;
>> +
>> +static int rbd_parsename(const char *filename, char *pool, char *na=
me)
>> +{
>> + =A0 =A0const char *rbdname;
>> + =A0 =A0char *p, *n;
>> + =A0 =A0int l;
>> +
>> + =A0 =A0if (!strstart(filename, "rbd:", &rbdname)) {
>> + =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0}
>> +
>> + =A0 =A0pstrcpy(pool, 2 * RBD_MAX_SEG_NAME_SIZE, rbdname);
>
> Why twice the size? The callers pass a char[RBD_MAX_SEG_NAME_SIZE], s=
o
> doesn't this allow buffer overflows?
>
>> + =A0 =A0p =3D strchr(pool, '/');
>> + =A0 =A0if (p =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0}
>> +
>> + =A0 =A0*p =3D '\0';
>> + =A0 =A0n =3D ++p;
>
> Why introduce a new variable here? p isn't used any more afterwards.
>
>> +
>> + =A0 =A0l =3D strlen(n);
>> +
>> + =A0 =A0if (l > RBD_MAX_OBJ_NAME_SIZE) {
>> + =A0 =A0 =A0 =A0fprintf(stderr, "object name to long\n");
>
> Off by one, you need to consider the trailing '\0'.
>
> Also, please use error_report instead of fprintf(stderr, ...) for rea=
l
> error messages. Directly printing to stderr is okay for debug code.
>
>> + =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0} else if (l <=3D 0) {
>> + =A0 =A0 =A0 =A0fprintf(stderr, "object name to short\n");
>> + =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0}
>> +
>> + =A0 =A0strcpy(name, n);
>> +
>> + =A0 =A0return l;
>> +}
>> +
>> +static int create_tmap_op(uint8_t op, const char *name, char **tmap=
_desc)
>> +{
>> + =A0 =A0uint32_t len =3D strlen(name);
>> + =A0 =A0uint32_t total_len =3D 1 + (sizeof(uint32_t) + len) + sizeo=
f(uint32_t); =A0 =A0 =A0 /* encoding op + name + empty buffer */
>
> This is more than 80 characters.
>
>> + =A0 =A0char *desc;
>> +
>> + =A0 =A0desc =3D qemu_malloc(total_len);
>> + =A0 =A0if (!desc) {
>> + =A0 =A0 =A0 =A0return -ENOMEM;
>> + =A0 =A0}
>
> qemu_malloc never returns NULL.
>
>> +
>> + =A0 =A0*tmap_desc =3D desc;
>> +
>> + =A0 =A0*desc =3D op;
>> + =A0 =A0desc++;
>> + =A0 =A0memcpy(desc, &len, sizeof(len));
>> + =A0 =A0desc +=3D sizeof(len);
>> + =A0 =A0memcpy(desc, name, len);
>> + =A0 =A0desc +=3D len;
>> + =A0 =A0len =3D 0;
>> + =A0 =A0memcpy(desc, &len, sizeof(len));
>> + =A0 =A0desc +=3D sizeof(len);
>> +
>> + =A0 =A0return desc - *tmap_desc;
>> +}
>> +
>> +static void free_tmap_op(char *tmap_desc)
>> +{
>> + =A0 =A0qemu_free(tmap_desc);
>> +}
>> +
>> +static int rbd_register_image(rados_pool_t pool, const char *name)
>> +{
>> + =A0 =A0char *tmap_desc;
>> + =A0 =A0const char *dir =3D RBD_DIRECTORY;
>> + =A0 =A0int ret;
>> +
>> + =A0 =A0ret =3D create_tmap_op(CEPH_OSD_TMAP_SET, name, &tmap_desc)=
;
>> + =A0 =A0if (ret < 0) {
>> + =A0 =A0 =A0 =A0return ret;
>> + =A0 =A0}
>> +
>> + =A0 =A0ret =3D rados_tmap_update(pool, dir, tmap_desc, ret);
>> + =A0 =A0free_tmap_op(tmap_desc);
>> +
>> + =A0 =A0return ret;
>> +}
>> +
>> +static int rbd_create(const char *filename, QEMUOptionParameter *op=
tions)
>> +{
>> + =A0 =A0int64_t bytes =3D 0;
>> + =A0 =A0int64_t objsize;
>> + =A0 =A0uint64_t size;
>> + =A0 =A0time_t mtime;
>> + =A0 =A0uint8_t obj_order =3D RBD_DEFAULT_OBJ_ORDER;
>> + =A0 =A0char pool[RBD_MAX_SEG_NAME_SIZE];
>> + =A0 =A0char n[RBD_MAX_SEG_NAME_SIZE];
>> + =A0 =A0char name[RBD_MAX_SEG_NAME_SIZE];
>> + =A0 =A0RbdHeader1 header;
>> + =A0 =A0rados_pool_t p;
>> + =A0 =A0int name_len;
>> + =A0 =A0int ret;
>> +
>> + =A0 =A0if ((name_len =3D rbd_parsename(filename, pool, name)) < 0)=
 {
>
> name_len is unused.
>
>> + =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0}
>> +
>> + =A0 =A0snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", name, RBD_SUFFIX=
);
>
> n should probably be some bytes longer than name to contain RBD_SUFFI=
X
> additionally. Otherwise, checking the return value might be a good id=
ea.
>
>> +
>> + =A0 =A0/* Read out options */
>> + =A0 =A0while (options && options->name) {
>> + =A0 =A0 =A0 =A0if (!strcmp(options->name, BLOCK_OPT_SIZE)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0bytes =3D options->value.n;
>> + =A0 =A0 =A0 =A0} else if (!strcmp(options->name, BLOCK_OPT_CLUSTER=
_SIZE)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0if (options->value.n) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0objsize =3D options->value.n;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!objsize || ((objsize - 1) & ob=
jsize)) { =A0 =A0/* not a power of 2? */
>
> !objsize can't happen here, it's the if condition above.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr, "obj size n=
eeds to be power of 2\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (objsize < 4096) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr, "obj size t=
oo small\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (obj_order =3D 0; obj_order < 6=
4; obj_order++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (objsize =3D=3D 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> Missing braces.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0objsize >>=3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0options++;
>> + =A0 =A0}
>> +
>> + =A0 =A0memset(&header, 0, sizeof(header));
>> + =A0 =A0pstrcpy(header.text, sizeof(header.text), rbd_text);
>> + =A0 =A0pstrcpy(header.signature, sizeof(header.signature), rbd_sig=
nature);
>> + =A0 =A0pstrcpy(header.version, sizeof(header.version), rbd_version=
);
>> + =A0 =A0header.image_size =3D bytes;
>> + =A0 =A0cpu_to_le64s((uint64_t *) & header.image_size);
>> + =A0 =A0header.options.order =3D obj_order;
>> + =A0 =A0header.options.crypt_type =3D RBD_CRYPT_NONE;
>> + =A0 =A0header.options.comp_type =3D RBD_COMP_NONE;
>> + =A0 =A0header.snap_seq =3D 0;
>> + =A0 =A0header.snap_count =3D 0;
>> + =A0 =A0cpu_to_le32s(&header.snap_count);
>> +
>> + =A0 =A0if (rados_initialize(0, NULL) < 0) {
>> + =A0 =A0 =A0 =A0fprintf(stderr, "error initializing\n");
>> + =A0 =A0 =A0 =A0return -EIO;
>> + =A0 =A0}
>> +
>> + =A0 =A0if (rados_open_pool(pool, &p)) {
>> + =A0 =A0 =A0 =A0fprintf(stderr, "error opening pool %s\n", pool);
>> + =A0 =A0 =A0 =A0return -EIO;
>
> No need for rados_deinitialize() here?
>
>> + =A0 =A0}
>> +
>> + =A0 =A0/* check for existing rbd header file */
>> + =A0 =A0ret =3D rados_stat(p, n, &size, &mtime);
>> + =A0 =A0if (ret =3D=3D 0) {
>> + =A0 =A0 =A0 =A0ret=3D-EEXIST;
>> + =A0 =A0 =A0 =A0goto done;
>> + =A0 =A0}
>> +
>> + =A0 =A0/* create header file */
>> + =A0 =A0ret =3D rados_write(p, n, 0, (const char *)&header, sizeof(=
header));
>> + =A0 =A0if (ret < 0) {
>> + =A0 =A0 =A0 =A0goto done;
>> + =A0 =A0}
>> +
>> + =A0 =A0ret =3D rbd_register_image(p, name);
>> +done:
>> + =A0 =A0rados_close_pool(p);
>> + =A0 =A0rados_deinitialize();
>> +
>> + =A0 =A0return ret;
>> +}
>> +
>> +static int rbd_open(BlockDriverState *bs, const char *filename, int=
 flags)
>> +{
>> + =A0 =A0RBDRVRBDState *s =3D bs->opaque;
>> + =A0 =A0char pool[RBD_MAX_SEG_NAME_SIZE];
>> + =A0 =A0char n[RBD_MAX_SEG_NAME_SIZE];
>> + =A0 =A0char hbuf[4096];
>> +
>> + =A0 =A0if ((s->name_len =3D rbd_parsename(filename, pool, s->name)=
) < 0) {
>> + =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0}
>> + =A0 =A0snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", s->name, RBD_SUF=
=46IX);
>> +
>> + =A0 =A0if (rados_initialize(0, NULL) < 0) {
>> + =A0 =A0 =A0 =A0fprintf(stderr, "error initializing\n");
>> + =A0 =A0 =A0 =A0return -EIO;
>> + =A0 =A0}
>
> What error codes do these rados_* functions return? Can we return
> something more meaningful than -EIO? Same question for the following =
calls.
>
>> +
>> + =A0 =A0if (rados_open_pool(pool, &s->pool)) {
>> + =A0 =A0 =A0 =A0fprintf(stderr, "error opening pool %s\n", pool);
>> + =A0 =A0 =A0 =A0return -EIO;
>> + =A0 =A0}
>
> rados_deinitialize? (same for the following return statements)
>
>> +
>> + =A0 =A0if (rados_read(s->pool, n, 0, hbuf, 4096) < 0) {
>> + =A0 =A0 =A0 =A0fprintf(stderr, "error reading header from %s\n", s=
->name);
>> + =A0 =A0 =A0 =A0return -EIO;
>> + =A0 =A0}
>> + =A0 =A0if (!strncmp(hbuf + 64, rbd_signature, 4)) {
>> + =A0 =A0 =A0 =A0if (!strncmp(hbuf + 68, rbd_version, 8)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0RbdHeader1 *header;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0header =3D (RbdHeader1 *) hbuf;
>> + =A0 =A0 =A0 =A0 =A0 =A0le64_to_cpus((uint64_t *) & header->image_s=
ize);
>> + =A0 =A0 =A0 =A0 =A0 =A0s->size =3D header->image_size;
>> + =A0 =A0 =A0 =A0 =A0 =A0s->objsize =3D 1 << header->options.order;
>> + =A0 =A0 =A0 =A0} else {
>> + =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr, "Unknown image version %s\n=
", hbuf + 68);
>> + =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
>> + =A0 =A0 =A0 =A0}
>> + =A0 =A0} else {
>> + =A0 =A0 =A0 =A0fprintf(stderr, "Invalid header signature %s\n", hb=
uf + 64);
>> + =A0 =A0 =A0 =A0return -EIO;
>> + =A0 =A0}
>
> Can't you go on like above, i.e. check the string and if the check fa=
ils
> return an error? Would probably be more readable than this nesting.
>
> Also, EIO for a failed string comparison is surely not the right erro=
r code?
>
>> +
>> + =A0 =A0return 0;
>> +}
>> +
>> +static void rbd_close(BlockDriverState *bs)
>> +{
>> + =A0 =A0RBDRVRBDState *s =3D bs->opaque;
>> +
>> + =A0 =A0rados_close_pool(s->pool);
>> + =A0 =A0rados_deinitialize();
>> +}
>> +
>> +static int rbd_rw(BlockDriverState *bs, int64_t sector_num,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint8_t *buf, int nb_sectors, i=
nt write)
>> +{
>> + =A0 =A0RBDRVRBDState *s =3D bs->opaque;
>> + =A0 =A0char n[RBD_MAX_SEG_NAME_SIZE];
>> +
>> + =A0 =A0int64_t segnr, segoffs, segsize, r;
>> + =A0 =A0int64_t off, size;
>> +
>> + =A0 =A0off =3D sector_num * 512;
>> + =A0 =A0size =3D nb_sectors * 512;
>
> Please use BDRV_SECTOR_SIZE.
>
>> + =A0 =A0segnr =3D (int64_t) (off / s->objsize);
>> + =A0 =A0segoffs =3D (int64_t) (off % s->objsize);
>> + =A0 =A0segsize =3D (int64_t) (s->objsize - segoffs);
>
> Why the type casts? Do they make any difference in this place?
>
>> +
>> + =A0 =A0while (size > 0) {
>> + =A0 =A0 =A0 =A0if (size < segsize) {
>> + =A0 =A0 =A0 =A0 =A0 =A0segsize =3D size;
>> + =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 =A0snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012llx", s-=
>name,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (long long unsigned int)segnr);
>
> n is possibly to short, see above. Also you could use PRIx64 instead =
of
> casting to long long.
>
>> +
>> + =A0 =A0 =A0 =A0if (write) {
>> + =A0 =A0 =A0 =A0 =A0 =A0if ((r =3D rados_write(s->pool, n, segoffs,=
 (const char *)buf,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0segsize)) < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return r;
>> + =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0} else {
>> + =A0 =A0 =A0 =A0 =A0 =A0r =3D rados_read(s->pool, n, segoffs, (char=
 *)buf, segsize);
>> + =A0 =A0 =A0 =A0 =A0 =A0if (r =3D=3D -ENOENT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(buf, 0, segsize);
>> + =A0 =A0 =A0 =A0 =A0 =A0} else if (r < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return(r);
>
> These brackets look strange (and inconsistent with all other returns =
in
> the code)
>
>> + =A0 =A0 =A0 =A0 =A0 =A0} else if (r < segsize) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(buf + r, 0, segsize - r);
>> + =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0 =A0 =A0r =3D segsize;
>
> What is this good for? r isn't used before it's overwritten in the ne=
xt
> loop iteration.
>
>> + =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 =A0buf +=3D segsize;
>> + =A0 =A0 =A0 =A0size -=3D segsize;
>> + =A0 =A0 =A0 =A0segoffs =3D 0;
>> + =A0 =A0 =A0 =A0segsize =3D s->objsize;
>> + =A0 =A0 =A0 =A0segnr++;
>> + =A0 =A0}
>> +
>> + =A0 =A0return (0);
>
> Again brackets.
>
>> +}
>> +
>> +static int rbd_read(BlockDriverState *bs, int64_t sector_num,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint8_t *buf, int nb_sector=
s)
>> +{
>> + =A0 =A0return rbd_rw(bs, sector_num, buf, nb_sectors, 0);
>> +}
>> +
>> +static int rbd_write(BlockDriverState *bs, int64_t sector_num,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const uint8_t *buf, int nb=
_sectors)
>> +{
>> + =A0 =A0return rbd_rw(bs, sector_num, (uint8_t *) buf, nb_sectors, =
1);
>> +}
>> +
>> +static void rbd_aio_cancel(BlockDriverAIOCB *blockacb)
>> +{
>> + =A0 =A0RBDAIOCB *acb =3D (RBDAIOCB *) blockacb;
>> + =A0 =A0qemu_bh_delete(acb->bh);
>> + =A0 =A0acb->bh =3D NULL;
>> + =A0 =A0qemu_aio_release(acb);
>> +}
>> +
>> +static AIOPool rbd_aio_pool =3D {
>> + =A0 =A0.aiocb_size =3D sizeof(RBDAIOCB),
>> + =A0 =A0.cancel =3D rbd_aio_cancel,
>> +};
>> +
>> +/* This is the callback function for rados_aio_read and _write */
>> +static void rbd_finish_aiocb(rados_completion_t c, RADOSCB *rcb)
>> +{
>> + =A0 =A0RBDAIOCB *acb =3D rcb->acb;
>> + =A0 =A0int64_t r;
>> + =A0 =A0int i;
>> +
>> + =A0 =A0acb->aiocnt--;
>> + =A0 =A0r =3D rados_aio_get_return_value(c);
>> + =A0 =A0rados_aio_release(c);
>> + =A0 =A0if (acb->write) {
>> + =A0 =A0 =A0 =A0if (r < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0acb->ret =3D r;
>> + =A0 =A0 =A0 =A0 =A0 =A0acb->error =3D 1;
>> + =A0 =A0 =A0 =A0} else if (!acb->error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D rcb->segsize;
>> + =A0 =A0 =A0 =A0}
>> + =A0 =A0} else {
>> + =A0 =A0 =A0 =A0if (r =3D=3D -ENOENT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0memset(rcb->buf, 0, rcb->segsize);
>> + =A0 =A0 =A0 =A0 =A0 =A0if (!acb->error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D rcb->segsize;
>> + =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0} else if (r < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0acb->ret =3D r;
>> + =A0 =A0 =A0 =A0 =A0 =A0acb->error =3D 1;
>> + =A0 =A0 =A0 =A0} else if (r < rcb->segsize) {
>> + =A0 =A0 =A0 =A0 =A0 =A0memset(rcb->buf + r, 0, rcb->segsize - r);
>> + =A0 =A0 =A0 =A0 =A0 =A0if (!acb->error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D rcb->segsize;
>> + =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0} else if (!acb->error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D r;
>> + =A0 =A0 =A0 =A0}
>> + =A0 =A0}
>> + =A0 =A0qemu_free(rcb);
>> + =A0 =A0i =3D 0;
>> + =A0 =A0if (!acb->aiocnt && acb->bh) {
>> + =A0 =A0 =A0 =A0qemu_bh_schedule(acb->bh);
>> + =A0 =A0}
>> +}
>> +
>> +/* Callback when all queued rados_aio requests are complete */
>> +static void rbd_aio_bh_cb(void *opaque)
>> +{
>> + =A0 =A0RBDAIOCB *acb =3D opaque;
>> +
>> + =A0 =A0if (!acb->write) {
>> + =A0 =A0 =A0 =A0qemu_iovec_from_buffer(acb->qiov, acb->bounce, acb-=
>qiov->size);
>> + =A0 =A0}
>> + =A0 =A0qemu_vfree(acb->bounce);
>> + =A0 =A0acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb-=
>ret));
>> + =A0 =A0qemu_bh_delete(acb->bh);
>> + =A0 =A0acb->bh =3D NULL;
>> + =A0 =A0qemu_aio_release(acb);
>> +}
>> +
>> +static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState *bs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 int64_t sector_num,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 QEMUIOVector *qiov,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 int nb_sectors,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 BlockDriverCompletionFunc *cb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 void *opaque, int write)
>
> For this function the same applies as for the synchronous one.
>
>> +{
>> + =A0 =A0RBDAIOCB *acb;
>> + =A0 =A0RADOSCB *rcb;
>> + =A0 =A0rados_completion_t c;
>> + =A0 =A0char n[RBD_MAX_SEG_NAME_SIZE];
>> + =A0 =A0int64_t segnr, segoffs, segsize, last_segnr;
>> + =A0 =A0int64_t off, size;
>> + =A0 =A0char *buf;
>> +
>> + =A0 =A0RBDRVRBDState *s =3D bs->opaque;
>> +
>> + =A0 =A0acb =3D qemu_aio_get(&rbd_aio_pool, bs, cb, opaque);
>> + =A0 =A0acb->write =3D write;
>> + =A0 =A0acb->qiov =3D qiov;
>> + =A0 =A0acb->bounce =3D qemu_blockalign(bs, qiov->size);
>> + =A0 =A0acb->aiocnt =3D 0;
>> + =A0 =A0acb->ret =3D 0;
>> + =A0 =A0acb->error =3D 0;
>> +
>> + =A0 =A0if (!acb->bh) {
>> + =A0 =A0 =A0 =A0acb->bh =3D qemu_bh_new(rbd_aio_bh_cb, acb);
>> + =A0 =A0}
>> +
>> + =A0 =A0if (write) {
>> + =A0 =A0 =A0 =A0qemu_iovec_to_buffer(acb->qiov, acb->bounce);
>> + =A0 =A0}
>> +
>> + =A0 =A0buf =3D acb->bounce;
>> +
>> + =A0 =A0off =3D sector_num * 512;
>> + =A0 =A0size =3D nb_sectors * 512;
>> + =A0 =A0segnr =3D (int64_t) (off / s->objsize);
>> + =A0 =A0segoffs =3D (int64_t) (off % s->objsize);
>> + =A0 =A0segsize =3D (int64_t) (s->objsize - segoffs);
>> +
>> + =A0 =A0last_segnr =3D ((off + size - 1) / s->objsize);
>> + =A0 =A0acb->aiocnt =3D (last_segnr - segnr) + 1;
>> +
>> + =A0 =A0while (size > 0) {
>> + =A0 =A0 =A0 =A0if (size < segsize) {
>> + =A0 =A0 =A0 =A0 =A0 =A0segsize =3D size;
>> + =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 =A0snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012llx", s-=
>name,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (long long unsigned int)segnr);
>> +
>> + =A0 =A0 =A0 =A0rcb =3D qemu_malloc(sizeof(RADOSCB));
>> + =A0 =A0 =A0 =A0rcb->done =3D 0;
>> + =A0 =A0 =A0 =A0rcb->acb =3D acb;
>> + =A0 =A0 =A0 =A0rcb->segsize =3D segsize;
>> + =A0 =A0 =A0 =A0rcb->buf =3D buf;
>> +
>> + =A0 =A0 =A0 =A0if (write) {
>> + =A0 =A0 =A0 =A0 =A0 =A0rados_aio_create_completion(rcb, NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(rados_callback_t) rbd_finish_aiocb, &c);
>> + =A0 =A0 =A0 =A0 =A0 =A0rados_aio_write(s->pool, n, segoffs, buf, s=
egsize, c);
>> + =A0 =A0 =A0 =A0} else {
>> + =A0 =A0 =A0 =A0 =A0 =A0rados_aio_create_completion(rcb, (rados_cal=
lback_t) rbd_finish_aiocb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0NULL, &c);
>> + =A0 =A0 =A0 =A0 =A0 =A0rados_aio_read(s->pool, n, segoffs, buf, se=
gsize, c);
>> + =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 =A0buf +=3D segsize;
>> + =A0 =A0 =A0 =A0size -=3D segsize;
>> + =A0 =A0 =A0 =A0segoffs =3D 0;
>> + =A0 =A0 =A0 =A0segsize =3D s->objsize;
>> + =A0 =A0 =A0 =A0segnr++;
>> + =A0 =A0}
>> +
>> + =A0 =A0return &acb->common;
>> +}
>> +
>> +static BlockDriverAIOCB *rbd_aio_readv(BlockDriverState * bs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 int64_t sector_num, QEMUIOVector * qiov,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 int nb_sectors,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 BlockDriverCompletionFunc * cb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 void *opaque)
>> +{
>> + =A0 =A0return rbd_aio_rw_vector(bs, sector_num, qiov, nb_sectors, =
cb, opaque, 0);
>> +}
>> +
>> +static BlockDriverAIOCB *rbd_aio_writev(BlockDriverState * bs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0int64_t sector_num, QEMUIOVector * qiov,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0int nb_sectors,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0BlockDriverCompletionFunc * cb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0void *opaque)
>> +{
>> + =A0 =A0return rbd_aio_rw_vector(bs, sector_num, qiov, nb_sectors, =
cb, opaque, 1);
>> +}
>> +
>> +static int rbd_getinfo(BlockDriverState * bs, BlockDriverInfo * bdi=
)
>> +{
>> + =A0 =A0RBDRVRBDState *s =3D bs->opaque;
>> + =A0 =A0bdi->cluster_size =3D s->objsize;
>> + =A0 =A0return 0;
>> +}
>> +
>> +static int64_t rbd_getlength(BlockDriverState * bs)
>> +{
>> + =A0 =A0RBDRVRBDState *s =3D bs->opaque;
>> +
>> + =A0 =A0return s->size;
>> +}
>> +
>> +static QEMUOptionParameter rbd_create_options[] =3D {
>> + =A0 =A0{
>> + =A0 =A0 .name =3D BLOCK_OPT_SIZE,
>> + =A0 =A0 .type =3D OPT_SIZE,
>> + =A0 =A0 .help =3D "Virtual disk size"
>> + =A0 =A0},
>> + =A0 =A0{
>> + =A0 =A0 .name =3D BLOCK_OPT_CLUSTER_SIZE,
>> + =A0 =A0 .type =3D OPT_SIZE,
>> + =A0 =A0 .help =3D "RBD object size"
>> + =A0 =A0},
>> + =A0 =A0{NULL}
>> +};
>> +
>> +static BlockDriver bdrv_rbd =3D {
>> + =A0 =A0.format_name =3D "rbd",
>> + =A0 =A0.instance_size =3D sizeof(RBDRVRBDState),
>> + =A0 =A0.bdrv_file_open =3D rbd_open,
>> + =A0 =A0.bdrv_read =3D rbd_read,
>> + =A0 =A0.bdrv_write =3D rbd_write,
>> + =A0 =A0.bdrv_close =3D rbd_close,
>> + =A0 =A0.bdrv_create =3D rbd_create,
>> + =A0 =A0.bdrv_get_info =3D rbd_getinfo,
>> + =A0 =A0.create_options =3D rbd_create_options,
>> + =A0 =A0.bdrv_getlength =3D rbd_getlength,
>> + =A0 =A0.protocol_name =3D "rbd",
>> +
>> + =A0 =A0.bdrv_aio_readv =3D rbd_aio_readv,
>> + =A0 =A0.bdrv_aio_writev =3D rbd_aio_writev,
>> +};
>
> Could you align the =3D to be on the same column?
>
>> +
>> +static void bdrv_rbd_init(void)
>> +{
>> + =A0 =A0bdrv_register(&bdrv_rbd);
>> +}
>> +
>> +block_init(bdrv_rbd_init);
>> diff --git a/block/rbd_types.h b/block/rbd_types.h
>> new file mode 100644
>> index 0000000..3a16a26
>> --- /dev/null
>> +++ b/block/rbd_types.h
>> @@ -0,0 +1,52 @@
>
> We need a header comment with copyright/license.
>
>> +#ifndef QEMU_BLOCK_RBD_TYPES_H
>> +#define QEMU_BLOCK_RBD_TYPES_H
>> +
>> +
>> +/*
>> + * rbd image 'foo' consists of objects
>> + * =A0 foo.rbd =A0 =A0 =A0- image metadata
>> + * =A0 foo.00000000
>
> Trailing whitespace.
>
>> + * =A0 foo.00000001
>> + * =A0 ... =A0 =A0 =A0 =A0 =A0- data
>> + */
>> +
>> +#define RBD_SUFFIX =A0 =A0 =A0 =A0 =A0 =A0 =A0".rbd"
>> +#define RBD_DIRECTORY =A0 =A0 =A0 =A0 =A0 "rbd_directory"
>> +
>> +#define RBD_DEFAULT_OBJ_ORDER =A0 22 =A0 /* 4MB */
>> +
>> +#define RBD_MAX_OBJ_NAME_SIZE =A0 96
>> +#define RBD_MAX_SEG_NAME_SIZE =A0 128
>> +
>> +#define RBD_COMP_NONE =A0 =A0 =A0 =A0 =A0 0
>> +#define RBD_CRYPT_NONE =A0 =A0 =A0 =A0 =A00
>> +
>> +static const char rbd_text[] =3D "<<< Rados Block Device Image >>>\=
n";
>> +static const char rbd_signature[] =3D "RBD";
>> +static const char rbd_version[] =3D "001.004";
>
> Move these to rbd.c?
>
>> +
>> +struct rbd_obj_snap_ondisk {
>> + =A0 =A0uint64_t id;
>> + =A0 =A0uint64_t image_size;
>> +} __attribute__((packed));
>> +
>> +struct rbd_obj_header_ondisk {
>> + =A0 =A0char text[64];
>> + =A0 =A0char signature[4];
>> + =A0 =A0char version[8];
>> + =A0 =A0struct {
>> + =A0 =A0 =A0 =A0uint8_t order;
>> + =A0 =A0 =A0 =A0uint8_t crypt_type;
>> + =A0 =A0 =A0 =A0uint8_t comp_type;
>> + =A0 =A0 =A0 =A0uint8_t unused;
>> + =A0 =A0} __attribute__((packed)) options;
>> + =A0 =A0uint64_t image_size;
>> + =A0 =A0uint64_t snap_seq;
>> + =A0 =A0uint32_t snap_count;
>> + =A0 =A0uint32_t reserved;
>> + =A0 =A0uint64_t snap_names_len;
>> + =A0 =A0struct rbd_obj_snap_ondisk snaps[0];
>> +} __attribute__((packed));
>> +
>> +
>> +#endif
>> diff --git a/configure b/configure
>> index 3cd2c5f..7d70bf8 100755
>> --- a/configure
>> +++ b/configure
>> @@ -299,6 +299,7 @@ pkgversion=3D""
>> =A0check_utests=3D"no"
>> =A0user_pie=3D"no"
>> =A0zero_malloc=3D""
>> +rbd=3D"no"
>
> Shouldn't it default to auto-detection? (rbd=3D"")
>
>>
>> =A0# OS specific
>> =A0if check_define __linux__ ; then
>> @@ -660,6 +661,8 @@ for opt do
>> =A0 =A0;;
>> =A0 =A0--enable-vhost-net) vhost_net=3D"yes"
>> =A0 =A0;;
>> + =A0--enable-rbd) rbd=3D"yes"
>> + =A0;;
>
> Would need a --disable-rbd flag then, too.
>
>> =A0 =A0*) echo "ERROR: unknown option $opt"; show_help=3D"yes"
>> =A0 =A0;;
>> =A0 =A0esac
>> @@ -826,6 +829,7 @@ echo " =A0--enable-docs =A0 =A0 =A0 =A0 =A0 =A0e=
nable documentation build"
>> =A0echo " =A0--disable-docs =A0 =A0 =A0 =A0 =A0 disable documentatio=
n build"
>> =A0echo " =A0--disable-vhost-net =A0 =A0 =A0disable vhost-net accele=
ration support"
>> =A0echo " =A0--enable-vhost-net =A0 =A0 =A0 enable vhost-net acceler=
ation support"
>> +echo " =A0--enable-rbd =A0 =A0 =A0 =A0 =A0enable building the rados=
 block device (rbd)"
>> =A0echo ""
>> =A0echo "NOTE: The object files are built at the place where configu=
re is launched"
>> =A0exit 1
>> @@ -1579,6 +1583,25 @@ if test "$mingw32" !=3D yes -a "$pthread" =3D=
 no; then
>> =A0fi
>>
>> =A0##########################################
>> +# rbd probe
>> +if test "$rbd" !=3D "no" ; then
>> + =A0cat > $TMPC <<EOF
>> +#include <stdio.h>
>> +#include <rados/librados.h>
>> +int main(void) { rados_initialize(0, NULL); return 0; }
>> +EOF
>> + =A0if compile_prog "" "-lrados -lcrypto" ; then
>> + =A0 =A0rbd=3Dyes
>> + =A0 =A0LIBS=3D"$LIBS -lrados -lcrypto"
>
> Other block features like curl or Linux AIO use $lib_tools and
> $lib_softmmu here.
>
>> + =A0else
>> + =A0 =A0if test "$rbd" =3D "yes" ; then
>> + =A0 =A0 =A0feature_not_found "rados block device"
>> + =A0 =A0fi
>> + =A0 =A0rbd=3Dno
>> + =A0fi
>> +fi
>
> But if you didn't want to auto-detect, this is more complicated than =
it
> needs to be.
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
