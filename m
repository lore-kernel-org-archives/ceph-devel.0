From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [PATCH -v5] ceph/rbd block driver for qemu-kvm
Date: Sat, 9 Oct 2010 10:21:02 +0100
Message-ID: <AANLkTim35HsnQ=VJ7BAiqQtt6sZiNr6azC967ywocR7w@mail.gmail.com>
References: <19221282ddcd1045bb3464903e5d8d9ea57cee25.1286563426.git.yehuda@hq.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44428 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820Ab0JIJVE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Oct 2010 05:21:04 -0400
In-Reply-To: <19221282ddcd1045bb3464903e5d8d9ea57cee25.1286563426.git.yehuda@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@hq.newdream.net>
Cc: Anthony Liguori <anthony@codemonkey.ws>, Kevin Wolf <kwolf@redhat.com>, kvm@vger.kernel.org, Yehuda Sadeh Weinraub <yehudasa@gmail.com>, qemu-devel@nongnu.org, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>

On Fri, Oct 8, 2010 at 8:00 PM, Yehuda Sadeh <yehuda@hq.newdream.net> w=
rote:
No flush operation is supported.  Can the guest be sure written data
is on stable storage when it receives completion?

> +/*
> + * This aio completion is being called from rbd_aio_event_reader() a=
nd
> + * runs in qemu context. It schedules a bh, but just in case the aio
> + * was not cancelled before.

Cancellation looks unsafe to me because acb is freed for cancel but
then accessed here!  Also see my comment on aio_cancel() below.

> +/*
> + * Cancel aio. Since we don't reference acb in a non qemu threads,
> + * it is safe to access it here.
> + */
> +static void rbd_aio_cancel(BlockDriverAIOCB *blockacb)
> +{
> + =A0 =A0RBDAIOCB *acb =3D (RBDAIOCB *) blockacb;
> + =A0 =A0qemu_bh_delete(acb->bh);
> + =A0 =A0acb->bh =3D NULL;
> + =A0 =A0qemu_aio_release(acb);

Any pending librados completions are still running here and will then
cause acb to be accessed after they complete.  If there is no safe way
to cancel then wait for the request to complete.

> +}
> +
> +static AIOPool rbd_aio_pool =3D {
> + =A0 =A0.aiocb_size =3D sizeof(RBDAIOCB),
> + =A0 =A0.cancel =3D rbd_aio_cancel,
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

Do librados threads have all signals blocked?  QEMU uses signals so it
is important that this signal not get sent to a librados thread and
discarded.  I have seen this issue in the past when using threaded
libraries in QEMU.

> + */
> +static void rbd_finish_aiocb(rados_completion_t c, RADOSCB *rcb)
> +{
> + =A0 =A0rcb->ret =3D rados_aio_get_return_value(c);
> + =A0 =A0rados_aio_release(c);
> + =A0 =A0if (write(rcb->s->fds[RBD_FD_WRITE], (void *)&rcb, sizeof(&r=
cb)) < 0) {

You are writing RADOSCB* so sizeof(rcb) should be used.

> + =A0 =A0 =A0 =A0error_report("failed writing to acb->s->fds\n");
> + =A0 =A0 =A0 =A0qemu_free(rcb);
> + =A0 =A0}
> +}
> +
> +/* Callback when all queued rados_aio requests are complete */
> +
> +static void rbd_aio_bh_cb(void *opaque)
> +{
> + =A0 =A0RBDAIOCB *acb =3D opaque;
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

When do you expect acb->bh to be non-NULL?

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
> + =A0 =A0s->qemu_aio_count +=3D acb->aiocnt; /* All the RADOSCB */
> +
> + =A0 =A0if (write && s->read_only) {
> + =A0 =A0 =A0 =A0acb->ret =3D -EROFS;
> + =A0 =A0 =A0 =A0return NULL;
> + =A0 =A0}

block.c:bdrv_aio_writev() will reject writes to read-only block
devices.  This check can be eliminated and it also prevents leaking
acb here.

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
