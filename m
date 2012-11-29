From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] rbd block driver fix race between aio completition and
 aio cancel
Date: Thu, 29 Nov 2012 10:24:11 -0500 (EST)
Message-ID: <936506501.16251874.1354202651225.JavaMail.root@redhat.com>
References: <50B541D6.90707@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:54833 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677Ab2K2PYT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 10:24:19 -0500
In-Reply-To: <50B541D6.90707@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, ceph-devel@vger.kernel.org, Stefan Priebe <s.priebe@profihost.ag>


> > @@ -574,6 +570,12 @@ static void
> > qemu_rbd_aio_cancel(BlockDriverAIOCB *blockacb)
> >   {
> >       RBDAIOCB *acb = (RBDAIOCB *) blockacb;
> >       acb->cancelled = 1;
> > +
> > +    while (acb->status == -EINPROGRESS) {
> > +        qemu_aio_wait();
> > +    }
> > +
> 
> There should be a qemu_vfree(acb->bounce); here

No, because the BH will have run at this point and you'd doubly-free
the buffer.

Paolo

> > +    qemu_aio_release(acb);
> >   }
> >
> >   static AIOPool rbd_aio_pool = {
> > @@ -646,7 +648,8 @@ static void rbd_aio_bh_cb(void *opaque)
> >       qemu_bh_delete(acb->bh);
> >       acb->bh = NULL;
> >
> > -    qemu_aio_release(acb);
> > +    if (!acb->cancelled)
> > +        qemu_aio_release(acb);
> >   }
> >
> >   static int rbd_aio_discard_wrapper(rbd_image_t image,
> > @@ -691,6 +694,7 @@ static BlockDriverAIOCB
> > *rbd_start_aio(BlockDriverState *bs,
> >       acb->s = s;
> >       acb->cancelled = 0;
> >       acb->bh = NULL;
> > +    acb->status = -EINPROGRESS;
> >
> >       if (cmd == RBD_AIO_WRITE) {
> >           qemu_iovec_to_buf(acb->qiov, 0, acb->bounce, qiov->size);
> > @@ -737,7 +741,8 @@ static BlockDriverAIOCB
> > *rbd_start_aio(BlockDriverState *bs,
> >   failed:
> >       g_free(rcb);
> >       s->qemu_aio_count--;
> > -    qemu_aio_release(acb);
> > +    if (!acb->cancelled)
> 
> qemu_vfree(acb->bounce) should be here as well, although that's a
> separate bug that's probably never hit.
> 
> > +        qemu_aio_release(acb);
> >       return NULL;
> >   }
> >
> >
> 
> 
