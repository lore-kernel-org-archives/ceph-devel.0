From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd block driver fix race between aio completition and
 aio cancel
Date: Tue, 27 Nov 2012 14:42:30 -0800
Message-ID: <50B541D6.90707@inktank.com>
References: <1353578419-5481-1-git-send-email-s.priebe@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:42433 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab2K0Wmf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Nov 2012 17:42:35 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so4448627dak.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Nov 2012 14:42:34 -0800 (PST)
In-Reply-To: <1353578419-5481-1-git-send-email-s.priebe@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, ceph-devel@vger.kernel.org, pbonzini@redhat.com

On 11/22/2012 02:00 AM, Stefan Priebe wrote:
> This one fixes a race which qemu had also in iscsi block driver
> between cancellation and io completition.
>
> qemu_rbd_aio_cancel was not synchronously waiting for the end of
> the command.
>
> To archieve this it introduces a new status flag which uses
> -EINPROGRESS.
>
> Signed-off-by: Stefan Priebe <s.priebe@profihost.ag>
> ---
>   block/rbd.c |   23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 0384c6c..783c3d7 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -77,6 +77,7 @@ typedef struct RBDAIOCB {
>       int error;
>       struct BDRVRBDState *s;
>       int cancelled;
> +    int status;
>   } RBDAIOCB;
>
>   typedef struct RADOSCB {
> @@ -376,12 +377,6 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
>       RBDAIOCB *acb = rcb->acb;
>       int64_t r;
>
> -    if (acb->cancelled) {
> -        qemu_vfree(acb->bounce);
> -        qemu_aio_release(acb);
> -        goto done;
> -    }
> -
>       r = rcb->ret;
>
>       if (acb->cmd == RBD_AIO_WRITE ||
> @@ -406,10 +401,11 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
>               acb->ret = r;
>           }
>       }
> +    acb->status = 0;
> +
>       /* Note that acb->bh can be NULL in case where the aio was cancelled */
>       acb->bh = qemu_bh_new(rbd_aio_bh_cb, acb);
>       qemu_bh_schedule(acb->bh);
> -done:
>       g_free(rcb);
>   }
>
> @@ -574,6 +570,12 @@ static void qemu_rbd_aio_cancel(BlockDriverAIOCB *blockacb)
>   {
>       RBDAIOCB *acb = (RBDAIOCB *) blockacb;
>       acb->cancelled = 1;
> +
> +    while (acb->status == -EINPROGRESS) {
> +        qemu_aio_wait();
> +    }
> +

There should be a qemu_vfree(acb->bounce); here

> +    qemu_aio_release(acb);
>   }
>
>   static AIOPool rbd_aio_pool = {
> @@ -646,7 +648,8 @@ static void rbd_aio_bh_cb(void *opaque)
>       qemu_bh_delete(acb->bh);
>       acb->bh = NULL;
>
> -    qemu_aio_release(acb);
> +    if (!acb->cancelled)
> +        qemu_aio_release(acb);
>   }
>
>   static int rbd_aio_discard_wrapper(rbd_image_t image,
> @@ -691,6 +694,7 @@ static BlockDriverAIOCB *rbd_start_aio(BlockDriverState *bs,
>       acb->s = s;
>       acb->cancelled = 0;
>       acb->bh = NULL;
> +    acb->status = -EINPROGRESS;
>
>       if (cmd == RBD_AIO_WRITE) {
>           qemu_iovec_to_buf(acb->qiov, 0, acb->bounce, qiov->size);
> @@ -737,7 +741,8 @@ static BlockDriverAIOCB *rbd_start_aio(BlockDriverState *bs,
>   failed:
>       g_free(rcb);
>       s->qemu_aio_count--;
> -    qemu_aio_release(acb);
> +    if (!acb->cancelled)

qemu_vfree(acb->bounce) should be here as well, although that's a
separate bug that's probably never hit.

> +        qemu_aio_release(acb);
>       return NULL;
>   }
>
>

