From: Blue Swirl <blauwirbel@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] rbd block driver fix race between aio
 completition and aio cancel
Date: Sat, 24 Nov 2012 19:54:02 +0000
Message-ID: <CAAu8pHti5JOzMcAK1P_3HrtxfpQgmeJA84CMRBAO9BF7-X2TEQ@mail.gmail.com>
References: <1353578419-5481-1-git-send-email-s.priebe@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49750 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab2KXTyW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Nov 2012 14:54:22 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so4166959pad.19
        for <ceph-devel@vger.kernel.org>; Sat, 24 Nov 2012 11:54:22 -0800 (PST)
In-Reply-To: <1353578419-5481-1-git-send-email-s.priebe@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, ceph-devel@vger.kernel.org, pbonzini@redhat.com, josh.durgin@inktank.com

On Thu, Nov 22, 2012 at 10:00 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
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
>  block/rbd.c |   23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 0384c6c..783c3d7 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -77,6 +77,7 @@ typedef struct RBDAIOCB {
>      int error;
>      struct BDRVRBDState *s;
>      int cancelled;
> +    int status;
>  } RBDAIOCB;
>
>  typedef struct RADOSCB {
> @@ -376,12 +377,6 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
>      RBDAIOCB *acb = rcb->acb;
>      int64_t r;
>
> -    if (acb->cancelled) {
> -        qemu_vfree(acb->bounce);
> -        qemu_aio_release(acb);
> -        goto done;
> -    }
> -
>      r = rcb->ret;
>
>      if (acb->cmd == RBD_AIO_WRITE ||
> @@ -406,10 +401,11 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
>              acb->ret = r;
>          }
>      }
> +    acb->status = 0;
> +
>      /* Note that acb->bh can be NULL in case where the aio was cancelled */
>      acb->bh = qemu_bh_new(rbd_aio_bh_cb, acb);
>      qemu_bh_schedule(acb->bh);
> -done:
>      g_free(rcb);
>  }
>
> @@ -574,6 +570,12 @@ static void qemu_rbd_aio_cancel(BlockDriverAIOCB *blockacb)
>  {
>      RBDAIOCB *acb = (RBDAIOCB *) blockacb;
>      acb->cancelled = 1;
> +
> +    while (acb->status == -EINPROGRESS) {
> +        qemu_aio_wait();
> +    }
> +
> +    qemu_aio_release(acb);
>  }
>
>  static AIOPool rbd_aio_pool = {
> @@ -646,7 +648,8 @@ static void rbd_aio_bh_cb(void *opaque)
>      qemu_bh_delete(acb->bh);
>      acb->bh = NULL;
>
> -    qemu_aio_release(acb);
> +    if (!acb->cancelled)

Missing braces, please read CODING_STYLE.

> +        qemu_aio_release(acb);
>  }
>
>  static int rbd_aio_discard_wrapper(rbd_image_t image,
> @@ -691,6 +694,7 @@ static BlockDriverAIOCB *rbd_start_aio(BlockDriverState *bs,
>      acb->s = s;
>      acb->cancelled = 0;
>      acb->bh = NULL;
> +    acb->status = -EINPROGRESS;
>
>      if (cmd == RBD_AIO_WRITE) {
>          qemu_iovec_to_buf(acb->qiov, 0, acb->bounce, qiov->size);
> @@ -737,7 +741,8 @@ static BlockDriverAIOCB *rbd_start_aio(BlockDriverState *bs,
>  failed:
>      g_free(rcb);
>      s->qemu_aio_count--;
> -    qemu_aio_release(acb);
> +    if (!acb->cancelled)
> +        qemu_aio_release(acb);

Also here.

>      return NULL;
>  }
>
> --
> 1.7.10.4
>
>
