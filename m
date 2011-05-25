From: Christian Brunner <chb@muc.de>
Subject: Re: [Qemu-devel] [PATCH v4 3/4] rbd: check return values when
 scheduling aio
Date: Wed, 25 May 2011 21:21:06 +0200
Message-ID: <BANLkTik3u7XuMYiUN4PLFs90GEz+2Szu=Q@mail.gmail.com>
References: <1306263078-18089-1-git-send-email-josh.durgin@dreamhost.com>
	<1306263078-18089-4-git-send-email-josh.durgin@dreamhost.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48890 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406Ab1EYTVI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 15:21:08 -0400
In-Reply-To: <1306263078-18089-4-git-send-email-josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, ceph-devel@vger.kernel.org

We should not leave this out:

Reviewed-by: Christian Brunner <chb@muc.de>

2011/5/24 Josh Durgin <josh.durgin@dreamhost.com>:
> If scheduling fails, the number of outstanding I/Os must be correct,
> or there will be a hang when waiting for everything to be flushed.
>
> Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> ---
> =A0block/rbd.c | =A0 24 ++++++++++++++++++++----
> =A01 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index ff74e8b..c9f32e4 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -580,10 +580,14 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(Bloc=
kDriverState *bs,
> =A0 =A0 rbd_completion_t c;
> =A0 =A0 int64_t off, size;
> =A0 =A0 char *buf;
> + =A0 =A0int r;
>
> =A0 =A0 BDRVRBDState *s =3D bs->opaque;
>
> =A0 =A0 acb =3D qemu_aio_get(&rbd_aio_pool, bs, cb, opaque);
> + =A0 =A0if (!acb) {
> + =A0 =A0 =A0 =A0return NULL;
> + =A0 =A0}
> =A0 =A0 acb->write =3D write;
> =A0 =A0 acb->qiov =3D qiov;
> =A0 =A0 acb->bounce =3D qemu_blockalign(bs, qiov->size);
> @@ -610,16 +614,28 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(Bloc=
kDriverState *bs,
> =A0 =A0 rcb->buf =3D buf;
> =A0 =A0 rcb->s =3D acb->s;
> =A0 =A0 rcb->size =3D size;
> + =A0 =A0r =3D rbd_aio_create_completion(rcb, (rbd_callback_t) rbd_fi=
nish_aiocb, &c);
> + =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0goto failed;
> + =A0 =A0}
>
> =A0 =A0 if (write) {
> - =A0 =A0 =A0 =A0rbd_aio_create_completion(rcb, (rbd_callback_t) rbd_=
finish_aiocb, &c);
> - =A0 =A0 =A0 =A0rbd_aio_write(s->image, off, size, buf, c);
> + =A0 =A0 =A0 =A0r =3D rbd_aio_write(s->image, off, size, buf, c);
> =A0 =A0 } else {
> - =A0 =A0 =A0 =A0rbd_aio_create_completion(rcb, (rbd_callback_t) rbd_=
finish_aiocb, &c);
> - =A0 =A0 =A0 =A0rbd_aio_read(s->image, off, size, buf, c);
> + =A0 =A0 =A0 =A0r =3D rbd_aio_read(s->image, off, size, buf, c);
> + =A0 =A0}
> +
> + =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0goto failed;
> =A0 =A0 }
>
> =A0 =A0 return &acb->common;
> +
> +failed:
> + =A0 =A0qemu_free(rcb);
> + =A0 =A0s->qemu_aio_count--;
> + =A0 =A0qemu_aio_release(acb);
> + =A0 =A0return NULL;
> =A0}
>
> =A0static BlockDriverAIOCB *qemu_rbd_aio_readv(BlockDriverState *bs,
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
