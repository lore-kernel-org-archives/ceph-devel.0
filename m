From: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Subject: Re: [Qemu-devel] [PATCH -v5] ceph/rbd block driver for qemu-kvm
Date: Sat, 9 Oct 2010 08:53:31 -0700
Message-ID: <AANLkTikU=X9yKCWX1k6gFUZz9CH2FFh8tUmWfrqmiFRz@mail.gmail.com>
References: <19221282ddcd1045bb3464903e5d8d9ea57cee25.1286563426.git.yehuda@hq.newdream.net>
	<AANLkTim35HsnQ=VJ7BAiqQtt6sZiNr6azC967ywocR7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <AANLkTim35HsnQ=VJ7BAiqQtt6sZiNr6azC967ywocR7w@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>, Kevin Wolf <kwolf@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>
List-Id: ceph-devel.vger.kernel.org

On Sat, Oct 9, 2010 at 2:21 AM, Stefan Hajnoczi <stefanha@gmail.com> wr=
ote:
> On Fri, Oct 8, 2010 at 8:00 PM, Yehuda Sadeh <yehuda@hq.newdream.net>=
 wrote:
> No flush operation is supported. =A0Can the guest be sure written dat=
a
> is on stable storage when it receives completion?
>
That's part of the consistency that rados provides.

>> +/*
>> + * This aio completion is being called from rbd_aio_event_reader() =
and
>> + * runs in qemu context. It schedules a bh, but just in case the ai=
o
>> + * was not cancelled before.
>
> Cancellation looks unsafe to me because acb is freed for cancel but
> then accessed here! =A0Also see my comment on aio_cancel() below.

Right. Added ->cancelled field instead of releasing the acb.

>
>> +/*
>> + * Cancel aio. Since we don't reference acb in a non qemu threads,
>> + * it is safe to access it here.
>> + */
>> +static void rbd_aio_cancel(BlockDriverAIOCB *blockacb)
>> +{
>> + =A0 =A0RBDAIOCB *acb =3D (RBDAIOCB *) blockacb;
>> + =A0 =A0qemu_bh_delete(acb->bh);
>> + =A0 =A0acb->bh =3D NULL;
>> + =A0 =A0qemu_aio_release(acb);
>
> Any pending librados completions are still running here and will then
> cause acb to be accessed after they complete. =A0If there is no safe =
way
> to cancel then wait for the request to complete.

Yeah, we'll keep the acb alive now and just set the ->cancelled.  When
last rados cb arrives for this acb we'll clean it up.
>
>> +}
>> +
>> +static AIOPool rbd_aio_pool =3D {
>> + =A0 =A0.aiocb_size =3D sizeof(RBDAIOCB),
>> + =A0 =A0.cancel =3D rbd_aio_cancel,
>> +};
>> +
>> +/*
>> + * This is the callback function for rados_aio_read and _write
>> + *
>> + * Note: this function is being called from a non qemu thread so
>> + * we need to be careful about what we do here. Generally we only
>> + * write to the block notification pipe, and do the rest of the
>> + * io completion handling from rbd_aio_event_reader() which
>> + * runs in a qemu context.
>
> Do librados threads have all signals blocked? =A0QEMU uses signals so=
 it
> is important that this signal not get sent to a librados thread and
> discarded. =A0I have seen this issue in the past when using threaded
> libraries in QEMU.

We're no longer blocking threads. We've hit that before too.

>
>> + */
>> +static void rbd_finish_aiocb(rados_completion_t c, RADOSCB *rcb)
>> +{
>> + =A0 =A0rcb->ret =3D rados_aio_get_return_value(c);
>> + =A0 =A0rados_aio_release(c);
>> + =A0 =A0if (write(rcb->s->fds[RBD_FD_WRITE], (void *)&rcb, sizeof(&=
rcb)) < 0) {
>
> You are writing RADOSCB* so sizeof(rcb) should be used.
Oops.

>
>> + =A0 =A0 =A0 =A0error_report("failed writing to acb->s->fds\n");
>> + =A0 =A0 =A0 =A0qemu_free(rcb);
>> + =A0 =A0}
>> +}
>> +
>> +/* Callback when all queued rados_aio requests are complete */
>> +
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
>> +
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
>> + =A0 =A0acb->s =3D s;
>> +
>> + =A0 =A0if (!acb->bh) {
>> + =A0 =A0 =A0 =A0acb->bh =3D qemu_bh_new(rbd_aio_bh_cb, acb);
>> + =A0 =A0}
>
> When do you expect acb->bh to be non-NULL?

I guess this part was copied from somewhere else. We're not expecting
it as we clean it up always, so check is removed.

>
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
>> + =A0 =A0s->qemu_aio_count +=3D acb->aiocnt; /* All the RADOSCB */
>> +
>> + =A0 =A0if (write && s->read_only) {
>> + =A0 =A0 =A0 =A0acb->ret =3D -EROFS;
>> + =A0 =A0 =A0 =A0return NULL;
>> + =A0 =A0}
>
> block.c:bdrv_aio_writev() will reject writes to read-only block
> devices. =A0This check can be eliminated and it also prevents leaking
> acb here.

Removed.

Thanks,
Yehuda

diff --git a/block/rbd.c b/block/rbd.c
index a51fc36..575e481 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -51,6 +51,7 @@ typedef struct RBDAIOCB {
     int aiocnt;
     int error;
     struct BDRVRBDState *s;
+    int cancelled;
 } RBDAIOCB;

 typedef struct RADOSCB {
@@ -325,8 +326,18 @@ static void rbd_complete_aio(RADOSCB *rcb)
     int64_t r;
     int i;

-    r =3D rcb->ret;
     acb->aiocnt--;
+
+    if (acb->cancelled) {
+        if (!acb->aiocnt) {
+            qemu_vfree(acb->bounce);
+            qemu_aio_release(acb);
+        }
+        goto done;
+    }
+
+    r =3D rcb->ret;
+
     if (acb->write) {
         if (r < 0) {
             acb->ret =3D r;
@@ -356,6 +367,7 @@ static void rbd_complete_aio(RADOSCB *rcb)
     if (!acb->aiocnt && acb->bh) {
         qemu_bh_schedule(acb->bh);
     }
+done:
     qemu_free(rcb);
     i =3D 0;
 }
@@ -585,7 +597,7 @@ static void rbd_aio_cancel(BlockDriverAIOCB *blocka=
cb)
     RBDAIOCB *acb =3D (RBDAIOCB *) blockacb;
     qemu_bh_delete(acb->bh);
     acb->bh =3D NULL;
-    qemu_aio_release(acb);

+    acb->cancelled =3D 1;
 }

 static AIOPool rbd_aio_pool =3D {
@@ -606,7 +618,7 @@ static void rbd_finish_aiocb(rados_completion_t c,
RADOSCB *rcb)
 {
     rcb->ret =3D rados_aio_get_return_value(c);
     rados_aio_release(c);
-    if (write(rcb->s->fds[RBD_FD_WRITE], (void *)&rcb, sizeof(&rcb)) <=
 0) {
+    if (write(rcb->s->fds[RBD_FD_WRITE], (void *)&rcb, sizeof(rcb)) < =
0) {
         error_report("failed writing to acb->s->fds\n");
         qemu_free(rcb);
     }
@@ -654,10 +666,8 @@ static BlockDriverAIOCB
*rbd_aio_rw_vector(BlockDriverState *bs,
     acb->ret =3D 0;
     acb->error =3D 0;
     acb->s =3D s;
-
-    if (!acb->bh) {
-        acb->bh =3D qemu_bh_new(rbd_aio_bh_cb, acb);
-    }
+    acb->cancelled =3D 0;
+    acb->bh =3D qemu_bh_new(rbd_aio_bh_cb, acb);

     if (write) {
         qemu_iovec_to_buffer(acb->qiov, acb->bounce);
@@ -676,11 +686,6 @@ static BlockDriverAIOCB
*rbd_aio_rw_vector(BlockDriverState *bs,

     s->qemu_aio_count +=3D acb->aiocnt; /* All the RADOSCB */

-    if (write && s->read_only) {
-        acb->ret =3D -EROFS;
-        return NULL;
-    }
-
     while (size > 0) {
         if (size < segsize) {
             segsize =3D size;
