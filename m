From: Christian Brunner <chb@muc.de>
Subject: Re: [PATCH] ceph/rbd block driver for qemu-kvm (v3)
Date: Thu, 17 Jun 2010 21:05:30 +0200
Message-ID: <AANLkTimQ8voPJC6krCAsvlzoOZOZ-1LDXXI6_asbO9xT@mail.gmail.com>
References: <20100531193140.GA13993@chb-desktop>
	<4C1293B7.1060307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35882 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759992Ab0FQTFc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jun 2010 15:05:32 -0400
In-Reply-To: <4C1293B7.1060307@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simone Gotti <simone.gotti@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

Hi Simone,

sorry for the late reply. I've been on vacation for a week.

Thanks for sending the patch. At first sight your patch looks good.
I'll do some testing by the weekend.

Kevin also sent me a note about the missing aio support, but I didn't
have the time to implement it yet. Now it seems, that I don't have to
do it, since you where quicker... :)

Regarding locking: There were some problems with the thread handling,
when I started writing the driver. But Yehuda removed the use of
SIGUSERx and Sage modified librados, so that the Ceph Thread class is
masking signals on any new thread it creates. (see
http://ceph.newdream.net/git/?p=3Dceph.git;a=3Dcommit;h=3Dcf4414684dd2c=
a5f2a565449be4686849695f62f
and http://ceph.newdream.net/git/?p=3Dceph.git;a=3Dcommit;h=3De4e775b60=
f117ba2d07da9e0e438714b409447b6).
I think that this is also sufficient for the aio callbacks.

Regards

Christian

2010/6/11 Simone Gotti <simone.gotti@gmail.com>:
> Hi Christian,
>
> thanks for you patch. I tried it a little and it worked quite well bu=
t
> during some live migration tests I noticed a problem.
>
>
> The problem is related to live migration with high I/O using the AIO
> calls (I triggered it with a simple "dd").
>
> If you launch a live migration and the guest is stopped and started o=
n
> the new qemu process while some AIO was in flight the guest on the ne=
w
> qemu will wait undefinitely for data this will never come. With ata
> emulation an ata reset is sent after some seconds but with virtio thi=
s
> won't happen.
>
> I'm not a qemu expert but from what I understand qemu in
> savevm.c:do_savevm calls qemu_aio_flush to wait that all the asyncron=
ous
> aio returned (the callback si called). But the rbd block driver doesn=
't
> use the qemu aio model but the rados one so that function will never
> know of the rados aio.
>
> So a solution will be to glue the block driver with the qemu aio mode=
l.
> I tried to do this to test if this will work in the attached patch. I
> only tested with one rbd block device but the live migration tests
> worked (in the patch I removed all the debug prints I adedd to see if
> all AIO requets really returned.
>
> This is an RFC just to know what you think about this possible soluti=
on.
> As qemu's aio model is event based and it needs a file descriptor for
> event communication i used eventfd to do this.
> Let me know if you need a detailed description of the patch!
>
>
> I've also got a question: as librados is multithreaded the callbacks =
are
> called in another thread. Is there the need to protect some critical
> sections with a lock (for example in rbd_aio_rw_vector and in
> rbd_finish_aiocb)?
>
>
> Thanks!
>
> Bye!
>
>
> From: Simone Gotti <simone.gotti@gmail.com>
> Date: Fri, 11 Jun 2010 21:19:39 +0200
> Subject: [PATCH] block/rbd: Added glue to qemu aio model to fix live
> migration with outstanding aio
>
> Signed-off-by: Simone Gotti <simone.gotti@gmail.com>
>
>
> ---
> =A0block/rbd.c | =A0 63
> +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
> =A01 files changed, 57 insertions(+), 6 deletions(-)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 4d22069..83b7898 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -25,6 +25,8 @@
>
> =A0#include <signal.h>
>
> +#include <sys/eventfd.h>
> +
> =A0/*
> =A0* When specifying the image filename use:
> =A0*
> @@ -47,6 +49,15 @@
>
> =A0#define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
>
> +typedef struct BDRVRBDState {
> + =A0 =A0int efd;
> + =A0 =A0rados_pool_t pool;
> + =A0 =A0char name[RBD_MAX_OBJ_NAME_SIZE];
> + =A0 =A0uint64_t size;
> + =A0 =A0uint64_t objsize;
> + =A0 =A0int qemu_aio_count;
> +} BDRVRBDState;
> +
> =A0typedef struct RBDAIOCB {
> =A0 =A0 BlockDriverAIOCB common;
> =A0 =A0 QEMUBH *bh;
> @@ -57,6 +68,7 @@ typedef struct RBDAIOCB {
> =A0 =A0 int64_t sector_num;
> =A0 =A0 int aiocnt;
> =A0 =A0 int error;
> + =A0 =A0BDRVRBDState *s;
> =A0} RBDAIOCB;
>
> =A0typedef struct RADOSCB {
> @@ -67,12 +79,6 @@ typedef struct RADOSCB {
> =A0 =A0 char *buf;
> =A0} RADOSCB;
>
> -typedef struct BDRVRBDState {
> - =A0 =A0rados_pool_t pool;
> - =A0 =A0char name[RBD_MAX_OBJ_NAME_SIZE];
> - =A0 =A0uint64_t size;
> - =A0 =A0uint64_t objsize;
> -} BDRVRBDState;
>
> =A0typedef struct rbd_obj_header_ondisk RbdHeader1;
>
> @@ -255,6 +261,31 @@ done:
> =A0 =A0 return ret;
> =A0}
>
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
> + =A0 =A0 =A0 }
> + =A0 =A0} while (ret =3D=3D -1 && errno =3D=3D EINTR);
> +
> + =A0 =A0return;
> +}
> +
> +static int rbd_aio_flush_cb(void *opaque)
> +{
> + =A0 =A0BDRVRBDState *s =3D opaque;
> +
> + =A0 =A0return (s->qemu_aio_count > 0) ? 1 : 0;
> +}
> +
> +
> +
> =A0static int rbd_open(BlockDriverState *bs, const char *filename, in=
t flags)
> =A0{
> =A0 =A0 BDRVRBDState *s =3D bs->opaque;
> @@ -303,6 +334,15 @@ static int rbd_open(BlockDriverState *bs, const
> char *filename, int flags)
> =A0 =A0 s->size =3D header->image_size;
> =A0 =A0 s->objsize =3D 1 << header->options.order;
>
> + =A0 =A0s->efd =3D eventfd(0, 0);
> + =A0 =A0if (s->efd =3D=3D -1) {
> + =A0 =A0 =A0 =A0error_report("error opening eventfd");
> + =A0 =A0 =A0 =A0goto failed;
> + =A0 =A0}
> + =A0 =A0fcntl(s->efd, F_SETFL, O_NONBLOCK);
> + =A0 =A0qemu_aio_set_fd_handler(s->efd, rbd_aio_completion_cb, NULL,
> + =A0 =A0 =A0 =A0rbd_aio_flush_cb, NULL, s);
> +
> =A0 =A0 return 0;
>
> =A0failed:
> @@ -393,6 +433,7 @@ static AIOPool rbd_aio_pool =3D {
> =A0};
>
> =A0/* This is the callback function for rados_aio_read and _write */
> +
> =A0static void rbd_finish_aiocb(rados_completion_t c, RADOSCB *rcb)
> =A0{
> =A0 =A0 RBDAIOCB *acb =3D rcb->acb;
> @@ -427,6 +468,8 @@ static void rbd_finish_aiocb(rados_completion_t c=
,
> RADOSCB *rcb)
> =A0 =A0 =A0 =A0 =A0 =A0 acb->ret +=3D r;
> =A0 =A0 =A0 =A0 }
> =A0 =A0 }
> + =A0 =A0uint64_t buf =3D 1;
> + =A0 =A0write(acb->s->efd, &buf, sizeof(buf));
> =A0 =A0 qemu_free(rcb);
> =A0 =A0 i =3D 0;
> =A0 =A0 if (!acb->aiocnt && acb->bh) {
> @@ -435,6 +478,7 @@ static void rbd_finish_aiocb(rados_completion_t c=
,
> RADOSCB *rcb)
> =A0}
>
> =A0/* Callback when all queued rados_aio requests are complete */
> +
> =A0static void rbd_aio_bh_cb(void *opaque)
> =A0{
> =A0 =A0 RBDAIOCB *acb =3D opaque;
> @@ -446,6 +490,10 @@ static void rbd_aio_bh_cb(void *opaque)
> =A0 =A0 acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->r=
et));
> =A0 =A0 qemu_bh_delete(acb->bh);
> =A0 =A0 acb->bh =3D NULL;
> +
> + =A0 =A0uint64_t buf =3D 1;
> + =A0 =A0write(acb->s->efd, &buf, sizeof(buf));
> +
> =A0 =A0 qemu_aio_release(acb);
> =A0}
>
> @@ -473,6 +521,7 @@ static BlockDriverAIOCB
> *rbd_aio_rw_vector(BlockDriverState *bs,
> =A0 =A0 acb->aiocnt =3D 0;
> =A0 =A0 acb->ret =3D 0;
> =A0 =A0 acb->error =3D 0;
> + =A0 =A0acb->s =3D s;
>
> =A0 =A0 if (!acb->bh) {
> =A0 =A0 =A0 =A0 acb->bh =3D qemu_bh_new(rbd_aio_bh_cb, acb);
> @@ -493,6 +542,8 @@ static BlockDriverAIOCB
> *rbd_aio_rw_vector(BlockDriverState *bs,
> =A0 =A0 last_segnr =3D ((off + size - 1) / s->objsize);
> =A0 =A0 acb->aiocnt =3D (last_segnr - segnr) + 1;
>
> + =A0 =A0s->qemu_aio_count+=3Dacb->aiocnt + 1; /* All the RADOSCB and=
 the
> related RBDAIOCB */
> +
> =A0 =A0 while (size > 0) {
> =A0 =A0 =A0 =A0 if (size < segsize) {
> =A0 =A0 =A0 =A0 =A0 =A0 segsize =3D size;
> --
> 1.7.0.1
>
>
>
>
>
>
> On 05/31/2010 09:31 PM, Christian Brunner wrote:
>> Hi Kevin,
>>
>> here is an updated patch for the ceph/rbd driver. I hope that everyt=
hing
>> is fine now.
>>
>> Regards,
>> Christian
>>
>>
>> This is a block driver for the distributed file system Ceph
>> (http://ceph.newdream.net/). This driver uses librados (which
>> is part of the Ceph server) for direct access to the Ceph object
>> store and is running entirely in userspace. Therefore it is
>> called "rbd" - rados block device.
>>
>> To compile the driver a recent version of ceph (unstable/testing git
>> head or 0.20.3 once it is released) is needed.
>>
>> Additional information is available on the Ceph-Wiki:
>>
>> http://ceph.newdream.net/wiki/Kvm-rbd
>>
>> The patch is based on git://repo.or.cz/qemu/kevin.git block
>>
>>
>> Signed-off-by: Christian Brunner <chb@muc.de>
>> ---
>> =A0Makefile.objs =A0 =A0 | =A0 =A01 +
>> =A0block/rbd.c =A0 =A0 =A0 | =A0600 ++++++++++++++++++++++++++++++++=
+++++++++++++++++++++
>> =A0block/rbd_types.h | =A0 64 ++++++
>> =A0configure =A0 =A0 =A0 =A0 | =A0 31 +++
>> =A04 files changed, 696 insertions(+), 0 deletions(-)
>> =A0create mode 100644 block/rbd.c
>> =A0create mode 100644 block/rbd_types.h
>>
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
>> index 0000000..4a60dda
>> --- /dev/null
>> +++ b/block/rbd.c
>> @@ -0,0 +1,600 @@
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
>> +#include "qemu-error.h"
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
>> +typedef struct BDRVRBDState {
>> + =A0 =A0rados_pool_t pool;
>> + =A0 =A0char name[RBD_MAX_OBJ_NAME_SIZE];
>> + =A0 =A0uint64_t size;
>> + =A0 =A0uint64_t objsize;
>> +} BDRVRBDState;
>> +
>> +typedef struct rbd_obj_header_ondisk RbdHeader1;
>> +
>> +static int rbd_parsename(const char *filename, char *pool, char *na=
me)
>> +{
>> + =A0 =A0const char *rbdname;
>> + =A0 =A0char *p;
>> + =A0 =A0int l;
>> +
>> + =A0 =A0if (!strstart(filename, "rbd:", &rbdname)) {
>> + =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0}
>> +
>> + =A0 =A0pstrcpy(pool, 2 * RBD_MAX_SEG_NAME_SIZE, rbdname);
>> + =A0 =A0p =3D strchr(pool, '/');
>> + =A0 =A0if (p =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0}
>> +
>> + =A0 =A0*p =3D '\0';
>> +
>> + =A0 =A0l =3D strlen(pool);
>> + =A0 =A0if(l >=3D RBD_MAX_SEG_NAME_SIZE) {
>> + =A0 =A0 =A0 =A0error_report("pool name to long");
>> + =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0} else if (l <=3D 0) {
>> + =A0 =A0 =A0 =A0error_report("pool name to short");
>> + =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0}
>> +
>> + =A0 =A0l =3D strlen(++p);
>> + =A0 =A0if (l >=3D RBD_MAX_OBJ_NAME_SIZE) {
>> + =A0 =A0 =A0 =A0error_report("object name to long");
>> + =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0} else if (l <=3D 0) {
>> + =A0 =A0 =A0 =A0error_report("object name to short");
>> + =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0}
>> +
>> + =A0 =A0strcpy(name, p);
>> +
>> + =A0 =A0return l;
>> +}
>> +
>> +static int create_tmap_op(uint8_t op, const char *name, char **tmap=
_desc)
>> +{
>> + =A0 =A0uint32_t len =3D strlen(name);
>> + =A0 =A0/* total_len =3D encoding op + name + empty buffer */
>> + =A0 =A0uint32_t total_len =3D 1 + (sizeof(uint32_t) + len) + sizeo=
f(uint32_t);
>> + =A0 =A0char *desc =3D NULL;
>> +
>> + =A0 =A0qemu_malloc(total_len);
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
>> + =A0 =A0int ret;
>> +
>> + =A0 =A0if (rbd_parsename(filename, pool, name) < 0) {
>> + =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0}
>> +
>> + =A0 =A0snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", name, RBD_SUFFIX=
);
>> +
>> + =A0 =A0/* Read out options */
>> + =A0 =A0while (options && options->name) {
>> + =A0 =A0 =A0 =A0if (!strcmp(options->name, BLOCK_OPT_SIZE)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0bytes =3D options->value.n;
>> + =A0 =A0 =A0 =A0} else if (!strcmp(options->name, BLOCK_OPT_CLUSTER=
_SIZE)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0if (options->value.n) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0objsize =3D options->value.n;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((objsize - 1) & objsize) { =A0 =
=A0/* not a power of 2? */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error_report("obj size need=
s to be power of 2");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (objsize < 4096) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error_report("obj size too =
small");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (obj_order =3D 0; obj_order < 6=
4; obj_order++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (objsize =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0objsize >>=3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0options++;
>> + =A0 =A0}
>> +
>> + =A0 =A0memset(&header, 0, sizeof(header));
>> + =A0 =A0pstrcpy(header.text, sizeof(header.text), RBD_HEADER_TEXT);
>> + =A0 =A0pstrcpy(header.signature, sizeof(header.signature), RBD_HEA=
DER_SIGNATURE);
>> + =A0 =A0pstrcpy(header.version, sizeof(header.version), RBD_HEADER_=
VERSION);
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
>> + =A0 =A0 =A0 =A0error_report("error initializing");
>> + =A0 =A0 =A0 =A0return -EIO;
>> + =A0 =A0}
>> +
>> + =A0 =A0if (rados_open_pool(pool, &p)) {
>> + =A0 =A0 =A0 =A0error_report("error opening pool %s", pool);
>> + =A0 =A0 =A0 =A0rados_deinitialize();
>> + =A0 =A0 =A0 =A0return -EIO;
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
>> + =A0 =A0BDRVRBDState *s =3D bs->opaque;
>> + =A0 =A0char pool[RBD_MAX_SEG_NAME_SIZE];
>> + =A0 =A0char n[RBD_MAX_SEG_NAME_SIZE];
>> + =A0 =A0char hbuf[4096];
>> + =A0 =A0int r;
>> +
>> + =A0 =A0if (rbd_parsename(filename, pool, s->name) < 0) {
>> + =A0 =A0 =A0 =A0return -EINVAL;
>> + =A0 =A0}
>> + =A0 =A0snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", s->name, RBD_SUF=
=46IX);
>> +
>> + =A0 =A0if ((r =3D rados_initialize(0, NULL)) < 0) {
>> + =A0 =A0 =A0 =A0error_report("error initializing");
>> + =A0 =A0 =A0 =A0return r;
>> + =A0 =A0}
>> +
>> + =A0 =A0if ((r =3D rados_open_pool(pool, &s->pool))) {
>> + =A0 =A0 =A0 =A0error_report("error opening pool %s", pool);
>> + =A0 =A0 =A0 =A0rados_deinitialize();
>> + =A0 =A0 =A0 =A0return r;
>> + =A0 =A0}
>> +
>> + =A0 =A0if ((r =3D rados_read(s->pool, n, 0, hbuf, 4096)) < 0) {
>> + =A0 =A0 =A0 =A0error_report("error reading header from %s", s->nam=
e);
>> + =A0 =A0 =A0 =A0goto failed;
>> + =A0 =A0}
>> +
>> + =A0 =A0if (strncmp(hbuf + 64, RBD_HEADER_SIGNATURE, 4)) {
>> + =A0 =A0 =A0 =A0error_report("Invalid header signature %s", hbuf + =
64);
>> + =A0 =A0 =A0 =A0r =3D -EMEDIUMTYPE;
>> + =A0 =A0 =A0 =A0goto failed;
>> + =A0 =A0}
>> +
>> + =A0 =A0if (strncmp(hbuf + 68, RBD_HEADER_VERSION, 8)) {
>> + =A0 =A0 =A0 =A0error_report("Unknown image version %s", hbuf + 68)=
;
>> + =A0 =A0 =A0 =A0r =3D -EMEDIUMTYPE;
>> + =A0 =A0 =A0 =A0goto failed;
>> + =A0 =A0}
>> +
>> + =A0 =A0RbdHeader1 *header;
>> +
>> + =A0 =A0header =3D (RbdHeader1 *) hbuf;
>> + =A0 =A0le64_to_cpus((uint64_t *) & header->image_size);
>> + =A0 =A0s->size =3D header->image_size;
>> + =A0 =A0s->objsize =3D 1 << header->options.order;
>> +
>> + =A0 =A0return 0;
>> +
>> +failed:
>> + =A0 =A0rados_close_pool(s->pool);
>> + =A0 =A0rados_deinitialize();
>> + =A0 =A0return r;
>> +}
>> +
>> +static void rbd_close(BlockDriverState *bs)
>> +{
>> + =A0 =A0BDRVRBDState *s =3D bs->opaque;
>> +
>> + =A0 =A0rados_close_pool(s->pool);
>> + =A0 =A0rados_deinitialize();
>> +}
>> +
>> +static int rbd_rw(BlockDriverState *bs, int64_t sector_num,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint8_t *buf, int nb_sectors, i=
nt write)
>> +{
>> + =A0 =A0BDRVRBDState *s =3D bs->opaque;
>> + =A0 =A0char n[RBD_MAX_SEG_NAME_SIZE];
>> +
>> + =A0 =A0int64_t segnr, segoffs, segsize, r;
>> + =A0 =A0int64_t off, size;
>> +
>> + =A0 =A0off =3D sector_num * BDRV_SECTOR_SIZE;
>> + =A0 =A0size =3D nb_sectors * BDRV_SECTOR_SIZE;
>> + =A0 =A0segnr =3D off / s->objsize;
>> + =A0 =A0segoffs =3D off % s->objsize;
>> + =A0 =A0segsize =3D s->objsize - segoffs;
>> +
>> + =A0 =A0while (size > 0) {
>> + =A0 =A0 =A0 =A0if (size < segsize) {
>> + =A0 =A0 =A0 =A0 =A0 =A0segsize =3D size;
>> + =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 =A0snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012" PRIx64=
, s->name, segnr);
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return r;
>> + =A0 =A0 =A0 =A0 =A0 =A0} else if (r < segsize) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(buf + r, 0, segsize - r);
>> + =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 =A0buf +=3D segsize;
>> + =A0 =A0 =A0 =A0size -=3D segsize;
>> + =A0 =A0 =A0 =A0segoffs =3D 0;
>> + =A0 =A0 =A0 =A0segsize =3D s->objsize;
>> + =A0 =A0 =A0 =A0segnr++;
>> + =A0 =A0}
>> +
>> + =A0 =A0return 0;
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
>> +{
>> + =A0 =A0RBDAIOCB *acb;
>> + =A0 =A0RADOSCB *rcb;
>> + =A0 =A0rados_completion_t c;
>> + =A0 =A0char n[RBD_MAX_SEG_NAME_SIZE];
>> + =A0 =A0int64_t segnr, segoffs, segsize, last_segnr;
>> + =A0 =A0int64_t off, size;
>> + =A0 =A0char *buf;
>> +
>> + =A0 =A0BDRVRBDState *s =3D bs->opaque;
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
>> + =A0 =A0off =3D sector_num * BDRV_SECTOR_SIZE;
>> + =A0 =A0size =3D nb_sectors * BDRV_SECTOR_SIZE;
>> + =A0 =A0segnr =3D off / s->objsize;
>> + =A0 =A0segoffs =3D off % s->objsize;
>> + =A0 =A0segsize =3D s->objsize - segoffs;
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
 =A0 =A0 =A0(rados_callback_t) rbd_finish_aiocb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0&c);
>> + =A0 =A0 =A0 =A0 =A0 =A0rados_aio_write(s->pool, n, segoffs, buf, s=
egsize, c);
>> + =A0 =A0 =A0 =A0} else {
>> + =A0 =A0 =A0 =A0 =A0 =A0rados_aio_create_completion(rcb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(rados_callback_t) rbd_finish_aiocb,
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
>> + =A0 =A0BDRVRBDState *s =3D bs->opaque;
>> + =A0 =A0bdi->cluster_size =3D s->objsize;
>> + =A0 =A0return 0;
>> +}
>> +
>> +static int64_t rbd_getlength(BlockDriverState * bs)
>> +{
>> + =A0 =A0BDRVRBDState *s =3D bs->opaque;
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
>> + =A0 =A0.format_name =A0 =A0 =A0 =A0=3D "rbd",
>> + =A0 =A0.instance_size =A0 =A0 =A0=3D sizeof(BDRVRBDState),
>> + =A0 =A0.bdrv_file_open =A0 =A0 =3D rbd_open,
>> + =A0 =A0.bdrv_read =A0 =A0 =A0 =A0 =A0=3D rbd_read,
>> + =A0 =A0.bdrv_write =A0 =A0 =A0 =A0 =3D rbd_write,
>> + =A0 =A0.bdrv_close =A0 =A0 =A0 =A0 =3D rbd_close,
>> + =A0 =A0.bdrv_create =A0 =A0 =A0 =A0=3D rbd_create,
>> + =A0 =A0.bdrv_get_info =A0 =A0 =A0=3D rbd_getinfo,
>> + =A0 =A0.create_options =A0 =A0 =3D rbd_create_options,
>> + =A0 =A0.bdrv_getlength =A0 =A0 =3D rbd_getlength,
>> + =A0 =A0.protocol_name =A0 =A0 =A0=3D "rbd",
>> +
>> + =A0 =A0.bdrv_aio_readv =A0 =A0 =3D rbd_aio_readv,
>> + =A0 =A0.bdrv_aio_writev =A0 =A0=3D rbd_aio_writev,
>> +};
>> +
>> +static void bdrv_rbd_init(void)
>> +{
>> + =A0 =A0bdrv_register(&bdrv_rbd);
>> +}
>> +
>> +block_init(bdrv_rbd_init);
>> diff --git a/block/rbd_types.h b/block/rbd_types.h
>> new file mode 100644
>> index 0000000..91ac4f9
>> --- /dev/null
>> +++ b/block/rbd_types.h
>> @@ -0,0 +1,64 @@
>> +/*
>> + * Ceph - scalable distributed file system
>> + *
>> + * Copyright (C) 2004-2010 Sage Weil <sage@newdream.net>
>> + *
>> + * This is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License version 2.1, as published by the Free Software
>> + * Foundation. =A0See file COPYING.
>> + *
>> + */
>> +
>> +#ifndef QEMU_BLOCK_RBD_TYPES_H
>> +#define QEMU_BLOCK_RBD_TYPES_H
>> +
>> +
>> +/*
>> + * rbd image 'foo' consists of objects
>> + * =A0 foo.rbd =A0 =A0 =A0- image metadata
>> + * =A0 foo.00000000
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
>> +#define RBD_HEADER_TEXT =A0 =A0 =A0 =A0 "<<< Rados Block Device Ima=
ge >>>\n"
>> +#define RBD_HEADER_SIGNATURE =A0 =A0"RBD"
>> +#define RBD_HEADER_VERSION =A0 =A0 =A0"001.004"
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
>> index 3cd2c5f..3f5c8ce 100755
>> --- a/configure
>> +++ b/configure
>> @@ -299,6 +299,7 @@ pkgversion=3D""
>> =A0check_utests=3D"no"
>> =A0user_pie=3D"no"
>> =A0zero_malloc=3D""
>> +rbd=3D""
>>
>> =A0# OS specific
>> =A0if check_define __linux__ ; then
>> @@ -660,6 +661,10 @@ for opt do
>> =A0 =A0;;
>> =A0 =A0--enable-vhost-net) vhost_net=3D"yes"
>> =A0 =A0;;
>> + =A0--disable-rbd) rbd=3D"no"
>> + =A0;;
>> + =A0--enable-rbd) rbd=3D"yes"
>> + =A0;;
>> =A0 =A0*) echo "ERROR: unknown option $opt"; show_help=3D"yes"
>> =A0 =A0;;
>> =A0 =A0esac
>> @@ -826,6 +831,7 @@ echo " =A0--enable-docs =A0 =A0 =A0 =A0 =A0 =A0e=
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
>> @@ -1579,6 +1585,27 @@ if test "$mingw32" !=3D yes -a "$pthread" =3D=
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
>> + =A0rbd_libs=3D"-lrados -lcrypto"
>> + =A0if compile_prog "" "$rbd_libs" ; then
>> + =A0 =A0rbd=3Dyes
>> + =A0 =A0libs_tools=3D"$rbd_libs $libs_tools"
>> + =A0 =A0libs_softmmu=3D"$rbd_libs $libs_softmmu"
>> + =A0else
>> + =A0 =A0if test "$rbd" =3D "yes" ; then
>> + =A0 =A0 =A0feature_not_found "rados block device"
>> + =A0 =A0fi
>> + =A0 =A0rbd=3Dno
>> + =A0fi
>> +fi
>> +
>> +##########################################
>> =A0# linux-aio probe
>>
>> =A0if test "$linux_aio" !=3D "no" ; then
>> @@ -2041,6 +2068,7 @@ echo "preadv support =A0 =A0$preadv"
>> =A0echo "fdatasync =A0 =A0 =A0 =A0 $fdatasync"
>> =A0echo "uuid support =A0 =A0 =A0$uuid"
>> =A0echo "vhost-net support $vhost_net"
>> +echo "rbd support =A0 =A0 =A0 $rbd"
>>
>> =A0if test $sdl_too_old =3D "yes"; then
>> =A0echo "-> Your SDL version is too old - please upgrade to have SDL=
 support"
>> @@ -2270,6 +2298,9 @@ echo "CONFIG_UNAME_RELEASE=3D\"$uname_release\=
"" >> $config_host_mak
>> =A0if test "$zero_malloc" =3D "yes" ; then
>> =A0 =A0echo "CONFIG_ZERO_MALLOC=3Dy" >> $config_host_mak
>> =A0fi
>> +if test "$rbd" =3D "yes" ; then
>> + =A0echo "CONFIG_RBD=3Dy" >> $config_host_mak
>> +fi
>>
>> =A0# USB host support
>> =A0case "$usb" in
>>
>
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
