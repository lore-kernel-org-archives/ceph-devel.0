From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCHv4] rbd block driver fix race between aio completition
 and aio cancel
Date: Thu, 29 Nov 2012 10:23:29 -0500 (EST)
Message-ID: <249699163.16251603.1354202609373.JavaMail.root@redhat.com>
References: <1354199315-21683-1-git-send-email-s.priebe@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:40687 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416Ab2K2PXh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 10:23:37 -0500
In-Reply-To: <1354199315-21683-1-git-send-email-s.priebe@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: stefanha@gmail.com, josh durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org



----- Messaggio originale -----
> Da: "Stefan Priebe" <s.priebe@profihost.ag>
> A: qemu-devel@nongnu.org
> Cc: stefanha@gmail.com, "josh durgin" <josh.durgin@inktank.com>, ceph=
-devel@vger.kernel.org, pbonzini@redhat.com,
> "Stefan Priebe" <s.priebe@profihost.ag>
> Inviato: Gioved=C3=AC, 29 novembre 2012 15:28:35
> Oggetto: [PATCHv4] rbd block driver fix race between aio completition=
 and aio cancel
>=20
> This one fixes a race which qemu had also in iscsi block driver
> between cancellation and io completition.
>=20
> qemu_rbd_aio_cancel was not synchronously waiting for the end of
> the command.
>=20
> To archieve this it introduces a new status flag which uses
> -EINPROGRESS.
>=20
> Changes since PATCHv3:
> - removed unnecessary if condition in rbd_start_aio as we
>   haven't start io yet
> - moved acb->status =3D 0 to rbd_aio_bh_cb so qemu_aio_wait always
>   waits until BH was executed
>=20
> Changes since PATCHv2:
> - fixed missing braces
> - added vfree for bounce
>=20
> Signed-off-by: Stefan Priebe <s.priebe@profihost.ag>
> ---
>  block/rbd.c |   16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index f3becc7..28e94ab 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -77,6 +77,7 @@ typedef struct RBDAIOCB {
>      int error;
>      struct BDRVRBDState *s;
>      int cancelled;
> +    int status;
>  } RBDAIOCB;
> =20
>  typedef struct RADOSCB {
> @@ -376,12 +377,6 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
>      RBDAIOCB *acb =3D rcb->acb;
>      int64_t r;
> =20
> -    if (acb->cancelled) {
> -        qemu_vfree(acb->bounce);
> -        qemu_aio_release(acb);
> -        goto done;
> -    }
> -
>      r =3D rcb->ret;
> =20
>      if (acb->cmd =3D=3D RBD_AIO_WRITE ||
> @@ -409,7 +404,6 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
>      /* Note that acb->bh can be NULL in case where the aio was
>      cancelled */
>      acb->bh =3D qemu_bh_new(rbd_aio_bh_cb, acb);
>      qemu_bh_schedule(acb->bh);
> -done:
>      g_free(rcb);
>  }
> =20
> @@ -568,6 +562,12 @@ static void qemu_rbd_aio_cancel(BlockDriverAIOCB
> *blockacb)
>  {
>      RBDAIOCB *acb =3D (RBDAIOCB *) blockacb;
>      acb->cancelled =3D 1;
> +
> +    while (acb->status =3D=3D -EINPROGRESS) {
> +        qemu_aio_wait();
> +    }
> +
> +    qemu_vfree(acb->bounce);

This vfree is not needed, since the BH will run and do the free.

Otherwise looks ok.

>  }
> =20
>  static const AIOCBInfo rbd_aiocb_info =3D {
> @@ -639,6 +639,7 @@ static void rbd_aio_bh_cb(void *opaque)
>      acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 :
>      acb->ret));
>      qemu_bh_delete(acb->bh);
>      acb->bh =3D NULL;
> +    acb->status =3D 0;
> =20
>      qemu_aio_release(acb);
>  }
> @@ -685,6 +686,7 @@ static BlockDriverAIOCB
> *rbd_start_aio(BlockDriverState *bs,
>      acb->s =3D s;
>      acb->cancelled =3D 0;
>      acb->bh =3D NULL;
> +    acb->status =3D -EINPROGRESS;
> =20
>      if (cmd =3D=3D RBD_AIO_WRITE) {
>          qemu_iovec_to_buf(acb->qiov, 0, acb->bounce, qiov->size);
> --
> 1.7.10.4
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
