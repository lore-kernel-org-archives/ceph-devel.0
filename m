From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] use int64_t for return values from rbd
 instead of int
Date: Wed, 21 Nov 2012 09:26:16 +0100
Message-ID: <20121121082616.GB13504@stefanha-thinkpad.redhat.com>
References: <1353415495-30561-1-git-send-email-s.priebe@profihost.ag>
 <20121120162922.GA8665@stefanha-thinkpad.redhat.com>
 <50ABD713.3050300@profihost.ag>
 <CAJSP0QXcjaRdeQ55GSPtSqam+WHUGPAz4+ohajTCMR8f+4oKrQ@mail.gmail.com>
 <50AC8704.2020407@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40775 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab2KUI0U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Nov 2012 03:26:20 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so2127510eek.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Nov 2012 00:26:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50AC8704.2020407@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, ceph-devel@vger.kernel.org, pve-devel@pve.proxmox.com, josh.durgin@inktank.com

On Wed, Nov 21, 2012 at 08:47:16AM +0100, Stefan Priebe - Profihost AG wrote:
> Am 21.11.2012 07:41, schrieb Stefan Hajnoczi:
> >On Tue, Nov 20, 2012 at 8:16 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> >>Hi Stefan,
> >>
> >>Am 20.11.2012 17:29, schrieb Stefan Hajnoczi:
> >>
> >>>On Tue, Nov 20, 2012 at 01:44:55PM +0100, Stefan Priebe wrote:
> >>>>
> >>>>rbd / rados tends to return pretty often length of writes
> >>>>or discarded blocks. These values might be bigger than int.
> >>>>
> >>>>Signed-off-by: Stefan Priebe <s.priebe@profihost.ag>
> >>>>---
> >>>>   block/rbd.c |    4 ++--
> >>>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>>
> >>>Looks good but I want to check whether this fixes an bug you've hit?
> >>>Please indicate details of the bug and how to reproduce it in the commit
> >>>message.
> >>
> >>
> >>you get various I/O errors in client. As negative return values indicate I/O
> >>errors. When now a big positive value is returned by librbd block/rbd tries
> >>to store this one in acb->ret which is an int. Then it wraps around and is
> >>negative. After that block/rbd thinks this is an I/O error and report this
> >>to the guest.
> >
> >It's still not clear whether this is a bug that you can reproduce.
> >After all, the ret value would have to be >2^31 which is a 2+ GB
> >request!
> Yes and that is the fact.
> 
> Look here:
>    if (acb->cmd == RBD_AIO_WRITE ||
>         acb->cmd == RBD_AIO_DISCARD) {
>         if (r < 0) {
>             acb->ret = r;
>             acb->error = 1;
>         } else if (!acb->error) {
>             acb->ret = rcb->size;
>         }
> 
> It sets acb->ret to rcb->size. But the size from a DISCARD if you
> DISCARD a whole device might be 500GB or today even some TB.

We're going in circles here.  I know the types are wrong in the code and
your patch fixes it, that's why I said it looks good in my first reply.

QEMU is currently in hard freeze and only critical patches should go in.
Providing steps to reproduce the bug helps me decide that this patch
should still be merged for QEMU 1.3-rc1.

Anyway, the patch is straightforward, I have applied it to my block tree
and it will be in QEMU 1.3-rc1:
https://github.com/stefanha/qemu/commits/block

Stefan
