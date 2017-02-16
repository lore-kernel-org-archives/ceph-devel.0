From: Tiger Hu <hufh2004@gmail.com>
Subject: Re: [RFC v5] RBD: Add support readv,writev for rbd
Date: Thu, 16 Feb 2017 20:07:44 +0800
Message-ID: <D7075812-8210-4092-8ED4-BB6FAC4E612C@gmail.com>
References: <20170216084318.11122-1-jazeltq@gmail.com> <20170216090002.12511-1-jazeltq@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35114 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754211AbdBPMHv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2017 07:07:51 -0500
Received: by mail-pf0-f196.google.com with SMTP id 68so1517194pfx.2
        for <ceph-devel@vger.kernel.org>; Thu, 16 Feb 2017 04:07:51 -0800 (PST)
In-Reply-To: <20170216090002.12511-1-jazeltq@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jazeltq@gmail.com
Cc: jdurgin@redhat.com, jcody@redhat.com, dillaman@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, tianqing <tianqing@unitedstack.com>

Tianqing,

Do we have any performance data for this patch? Thanks.

Tiger
> =D4=DA 2017=C4=EA2=D4=C216=C8=D5=A3=AC=CF=C2=CE=E75:00=A3=ACjazeltq@gmai=
l.com =D0=B4=B5=C0=A3=BA
>=20
> From: tianqing <tianqing@unitedstack.com>
>=20
> Rbd can do readv and writev directly, so wo do not need to transform
> iov to buf or vice versa any more.
>=20
> Signed-off-by: tianqing <tianqing@unitedstack.com>
> ---
> block/rbd.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
> 1 file changed, 42 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index a57b3e3..75ae1d6 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -47,7 +47,7 @@
>  */
>=20
> /* rbd_aio_discard added in 0.1.2 */
> -#if LIBRBD_VERSION_CODE >=3D LIBRBD_VERSION(0, 1, 2)
> +#if LIBRBD_VERSION_CODE >=3D LIBRBD_VERSION(12, 0, 0)
> #define LIBRBD_SUPPORTS_DISCARD
> #else
> #undef LIBRBD_SUPPORTS_DISCARD
> @@ -73,7 +73,12 @@ typedef struct RBDAIOCB {
>     BlockAIOCB common;
>     int64_t ret;
>     QEMUIOVector *qiov;
> +/* Note:
> + * The LIBRBD_SUPPORTS_IOVEC is defined in librbd.h.
> + */
> +#ifndef LIBRBD_SUPPORTS_IOVEC
>     char *bounce;
> +#endif
>     RBDAIOCmd cmd;
>     int error;
>     struct BDRVRBDState *s;
> @@ -83,7 +88,9 @@ typedef struct RADOSCB {
>     RBDAIOCB *acb;
>     struct BDRVRBDState *s;
>     int64_t size;
> +#ifndef LIBRBD_SUPPORTS_IOVEC
>     char *buf;
> +#endif
>     int64_t ret;
> } RADOSCB;
>=20
> @@ -426,11 +433,21 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
>         }
>     } else {
>         if (r < 0) {
> +#ifndef LIBRBD_SUPPORTS_IOVEC
>             memset(rcb->buf, 0, rcb->size);
> +#else
> +            iov_memset(acb->qiov->iov, acb->qiov->niov, 0, 0, =
acb->qiov->size);
> +#endif
>             acb->ret =3D r;
>             acb->error =3D 1;
>         } else if (r < rcb->size) {
> +#ifndef LIBRBD_SUPPORTS_IOVEC
>             memset(rcb->buf + r, 0, rcb->size - r);
> +#else
> +            iov_memset(acb->qiov->iov, acb->qiov->niov,
> +                       r, 0, acb->qiov->size - r);
> +#endif
> +
>             if (!acb->error) {
>                 acb->ret =3D rcb->size;
>             }
> @@ -441,10 +458,12 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
>=20
>     g_free(rcb);
>=20
> +#ifndef LIBRBD_SUPPORTS_IOVEC
>     if (acb->cmd =3D=3D RBD_AIO_READ) {
>         qemu_iovec_from_buf(acb->qiov, 0, acb->bounce, =
acb->qiov->size);
>     }
>     qemu_vfree(acb->bounce);
> +#endif
>     acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->ret));
>=20
>     qemu_aio_unref(acb);
> @@ -655,8 +674,10 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState =
*bs,
>     RBDAIOCB *acb;
>     RADOSCB *rcb =3D NULL;
>     rbd_completion_t c;
> -    char *buf;
>     int r;
> +#ifndef LIBRBD_SUPPORTS_IOVEC
> +    char *buf =3D NULL;
> +#endif
>=20
>     BDRVRBDState *s =3D bs->opaque;
>=20
> @@ -664,6 +685,8 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState =
*bs,
>     acb->cmd =3D cmd;
>     acb->qiov =3D qiov;
>     assert(!qiov || qiov->size =3D=3D size);
> +#ifndef LIBRBD_SUPPORTS_IOVEC
> +
>     if (cmd =3D=3D RBD_AIO_DISCARD || cmd =3D=3D RBD_AIO_FLUSH) {
>         acb->bounce =3D NULL;
>     } else {
> @@ -672,19 +695,21 @@ static BlockAIOCB =
*rbd_start_aio(BlockDriverState *bs,
>             goto failed;
>         }
>     }
> -    acb->ret =3D 0;
> -    acb->error =3D 0;
> -    acb->s =3D s;
> -
>     if (cmd =3D=3D RBD_AIO_WRITE) {
>         qemu_iovec_to_buf(acb->qiov, 0, acb->bounce, qiov->size);
>     }
> -
>     buf =3D acb->bounce;
> +#endif
> +    acb->ret =3D 0;
> +    acb->error =3D 0;
> +    acb->s =3D s;
>=20
>     rcb =3D g_new(RADOSCB, 1);
> +
>     rcb->acb =3D acb;
> +#ifndef LIBRBD_SUPPORTS_IOVEC
>     rcb->buf =3D buf;
> +#endif
>     rcb->s =3D acb->s;
>     rcb->size =3D size;
>     r =3D rbd_aio_create_completion(rcb, (rbd_callback_t) =
rbd_finish_aiocb, &c);
> @@ -694,10 +719,18 @@ static BlockAIOCB =
*rbd_start_aio(BlockDriverState *bs,
>=20
>     switch (cmd) {
>     case RBD_AIO_WRITE:
> +#ifndef LIBRBD_SUPPORTS_IOVEC
>         r =3D rbd_aio_write(s->image, off, size, buf, c);
> +#else
> +        r =3D rbd_aio_writev(s->image, qiov->iov, qiov->niov, off, =
c);
> +#endif
>         break;
>     case RBD_AIO_READ:
> +#ifndef LIBRBD_SUPPORTS_IOVEC
>         r =3D rbd_aio_read(s->image, off, size, buf, c);
> +#else
> +        r =3D rbd_aio_readv(s->image, qiov->iov, qiov->niov, off, c);
> +#endif
>         break;
>     case RBD_AIO_DISCARD:
>         r =3D rbd_aio_discard_wrapper(s->image, off, size, c);
> @@ -719,7 +752,9 @@ failed_completion:
>     rbd_aio_release(c);
> failed:
>     g_free(rcb);
> +#ifndef LIBRBD_SUPPORTS_IOVEC
>     qemu_vfree(acb->bounce);
> +#endif
>     qemu_aio_unref(acb);
>     return NULL;
> }
> --=20
> 2.10.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

