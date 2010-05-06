From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 1/2] qemu-kvm/rbd: use new librados callback for
	ack/complete
Date: Thu, 6 May 2010 14:41:55 -0700
Message-ID: <z2za37615151005061441zfd7e2e6en2474c796562756bd@mail.gmail.com>
References: <20100506205411.GA57852@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49008 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab0EFVl5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 May 2010 17:41:57 -0400
Received: by vws18 with SMTP id 18so220584vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 06 May 2010 14:41:56 -0700 (PDT)
In-Reply-To: <20100506205411.GA57852@ncolin.muc.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

This one should fix and remove the nasty usleep that handles the acb
initialization race. I didn't verify that it actually works, so please
let me know if there are any issues with it.

Thanks,
Yehuda

diff --git a/block/rbd.c b/block/rbd.c
index 3ebf285..7128e23 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -56,7 +56,6 @@ typedef struct RBDAIOCB {
     int write;
     int64_t sector_num;
     int aiocnt;
-    int rccomplete;
 } RBDAIOCB;

 typedef struct RADOSCB {
@@ -391,11 +390,7 @@ static void rbd_finish_aiocb(rados_completion_t
c, RADOSCB * rcb)
     }
     qemu_free(rcb);
     i =3D 0;
-    while ((acb->aiocnt =3D=3D 0) && !acb->rccomplete && i < 5) {
-        usleep(100);
-        i++;
-    }
-    if ((acb->aiocnt =3D=3D 0) && acb->rccomplete && acb->bh) {
+    if ((acb->aiocnt =3D=3D 0) && acb->bh) {
         qemu_bh_schedule(acb->bh);
     }
 }
@@ -425,7 +420,7 @@ static BlockDriverAIOCB
*rbd_aio_rw_vector(BlockDriverState * bs,
     RADOSCB *rcb;
     rados_completion_t c;
     char n[RBD_MAX_SEG_NAME_SIZE];
-    int64_t segnr, segoffs, segsize;
+    int64_t segnr, segoffs, segsize, last_segnr;
     int64_t off, size;
     char *buf;

@@ -437,7 +432,6 @@ static BlockDriverAIOCB
*rbd_aio_rw_vector(BlockDriverState * bs,
     acb->bounce =3D qemu_blockalign(bs, qiov->size);
     acb->aiocnt =3D 0;
     acb->ret =3D 0;
-    acb->rccomplete =3D 0;

     if (!acb->bh) {
         acb->bh =3D qemu_bh_new(rbd_aio_bh_cb, acb);
@@ -455,6 +449,9 @@ static BlockDriverAIOCB
*rbd_aio_rw_vector(BlockDriverState * bs,
     segoffs =3D (int64_t) (off % s->objsize);
     segsize =3D (int64_t) (s->objsize - segoffs);

+    last_segnr =3D ((off + size - 1) / s->objsize);
+    acb->aiocnt =3D (last_segnr - segnr) + 1;
+
     while (size > 0) {
         if (size < segsize) {
             segsize =3D size;
@@ -469,8 +466,6 @@ static BlockDriverAIOCB
*rbd_aio_rw_vector(BlockDriverState * bs,
         rcb->segsize =3D segsize;
         rcb->buf =3D buf;

-        acb->aiocnt++;
-
         rados_aio_create_completion(rcb, (rados_callback_t) rbd_finish=
_aiocb,
                                     NULL, &c);
         if (write) {
@@ -486,8 +481,6 @@ static BlockDriverAIOCB
*rbd_aio_rw_vector(BlockDriverState * bs,
         segnr++;
     }

-    acb->rccomplete =3D 1;
-
     return &acb->common;
 }

On Thu, May 6, 2010 at 1:54 PM, Christian Brunner <chb@muc.de> wrote:
>
> This patch uses the new librados aio callback function (from the unst=
able
> branch of ceph).
>
> Christian
> ---
> =A0block/rbd.c | =A0 51 ++++++++++++++++++++++++---------------------=
------
> =A01 files changed, 24 insertions(+), 27 deletions(-)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 12a85dc..dfd2eca 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -393,34 +393,31 @@ static void rbd_finish_aiocb(rados_completion_t=
 c, RADOSCB * rcb)
> =A0 =A0 int64_t r;
> =A0 =A0 int i;
>
> - =A0 =A0if (rados_aio_is_complete(c)) {
> - =A0 =A0 =A0 =A0acb->aiocnt--;
> - =A0 =A0 =A0 =A0r =3D rados_aio_get_return_value(c);
> - =A0 =A0 =A0 =A0rados_aio_set_callback(c, NULL, NULL);
> - =A0 =A0 =A0 =A0rados_aio_release(c);
> - =A0 =A0 =A0 =A0if (acb->write) {
> - =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D r;
> + =A0 =A0acb->aiocnt--;
> + =A0 =A0r =3D rados_aio_get_return_value(c);
> + =A0 =A0rados_aio_release(c);
> + =A0 =A0if (acb->write) {
> + =A0 =A0 =A0 =A0acb->ret +=3D r;
> + =A0 =A0} else {
> + =A0 =A0 =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0memset(rcb->buf, 0, rcb->segsize);
> + =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D rcb->segsize;
> + =A0 =A0 =A0 =A0} else if (r < rcb->segsize) {
> + =A0 =A0 =A0 =A0 =A0 =A0memset(rcb->buf + r, 0, rcb->segsize - r);
> + =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D rcb->segsize;
> =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0if (r < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(rcb->buf, 0, rcb->segsize);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D rcb->segsize;
> - =A0 =A0 =A0 =A0 =A0 =A0} else if (r < rcb->segsize) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(rcb->buf + r, 0, rcb->segsize=
 - r);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D rcb->segsize;
> - =A0 =A0 =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D r;
> - =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0qemu_free(rcb);
> - =A0 =A0 =A0 =A0i =3D 0;
> - =A0 =A0 =A0 =A0while ((acb->aiocnt =3D=3D 0) && !acb->rccomplete &&=
 i < 5) {
> - =A0 =A0 =A0 =A0 =A0 =A0usleep(100);
> - =A0 =A0 =A0 =A0 =A0 =A0i++;
> - =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0if ((acb->aiocnt =3D=3D 0) && acb->rccomplete && acb=
->bh) {
> - =A0 =A0 =A0 =A0 =A0 =A0qemu_bh_schedule(acb->bh);
> + =A0 =A0 =A0 =A0 =A0 =A0acb->ret +=3D r;
> =A0 =A0 =A0 =A0 }
> =A0 =A0 }
> + =A0 =A0qemu_free(rcb);
> + =A0 =A0i =3D 0;
> + =A0 =A0while ((acb->aiocnt =3D=3D 0) && !acb->rccomplete && i < 5) =
{
> + =A0 =A0 =A0 =A0usleep(100);
> + =A0 =A0 =A0 =A0i++;
> + =A0 =A0}
> + =A0 =A0if ((acb->aiocnt =3D=3D 0) && acb->rccomplete && acb->bh) {
> + =A0 =A0 =A0 =A0qemu_bh_schedule(acb->bh);
> + =A0 =A0}
> =A0}
>
> =A0static void rbd_aio_bh_cb(void *opaque)
> @@ -494,8 +491,8 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(BlockD=
riverState * bs,
>
> =A0 =A0 =A0 =A0 acb->aiocnt++;
>
> - =A0 =A0 =A0 =A0rados_aio_create_completion((rados_callback_t) rbd_f=
inish_aiocb,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0rcb, &c);
> + =A0 =A0 =A0 =A0rados_aio_create_completion(rcb, (rados_callback_t) =
rbd_finish_aiocb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0NULL, &c);
> =A0 =A0 =A0 =A0 if (write) {
> =A0 =A0 =A0 =A0 =A0 =A0 rados_aio_write(s->pool, n, segoffs, buf, seg=
size, c);
> =A0 =A0 =A0 =A0 } else {
> --
> 1.6.6.1
>
>
> --
> Christian Brunner =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0MUC.DE e.V.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 Joseph-Dollinger-Bogen 14
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 D-80807 Muenchen
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
