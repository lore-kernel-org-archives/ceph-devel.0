From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] rbd block driver fix race between aio completition and
 aio cancel
Date: Thu, 29 Nov 2012 14:58:51 +0100
Message-ID: <20121129135851.GA13694@stefanha-thinkpad.redhat.com>
References: <1353578419-5481-1-git-send-email-s.priebe@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44665 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab2K2N6z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 08:58:55 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so6416290eek.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Nov 2012 05:58:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1353578419-5481-1-git-send-email-s.priebe@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: qemu-devel@nongnu.org, josh.durgin@inktank.com, ceph-devel@vger.kernel.org, pbonzini@redhat.com

On Thu, Nov 22, 2012 at 11:00:19AM +0100, Stefan Priebe wrote:
> @@ -406,10 +401,11 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
>              acb->ret = r;
>          }
>      }
> +    acb->status = 0;
> +

I suggest doing this in the BH.  The qemu_aio_wait() loop in
qemu_rbd_aio_cancel() needs to wait until the BH has executed.  By
clearing status in the BH we ensure that no matter in which order
qemu_aio_wait() invokes BHs and callbacks, we'll always wait until the
BH has completed before ending the while loop in qemu_rbd_aio_cancel().

> @@ -737,7 +741,8 @@ static BlockDriverAIOCB *rbd_start_aio(BlockDriverState *bs,
>  failed:
>      g_free(rcb);
>      s->qemu_aio_count--;
> -    qemu_aio_release(acb);
> +    if (!acb->cancelled)
> +        qemu_aio_release(acb);
>      return NULL;
>  }

This scenario is impossible.  We haven't returned the acb back to the
caller yet so they could not have invoked qemu_aio_cancel().

Stefan
