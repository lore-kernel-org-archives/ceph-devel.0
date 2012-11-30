From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCHv6] rbd block driver fix race between aio completition and
 aio cancel
Date: Fri, 30 Nov 2012 14:50:13 +0100
Message-ID: <CAJSP0QUk=L628z4Nb7Z6Zx3U2BA7iEvA=rVoBMMwj3n-x=DW8w@mail.gmail.com>
References: <1354265746-8390-1-git-send-email-s.priebe@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60722 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932974Ab2K3NuP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Nov 2012 08:50:15 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so464974lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 30 Nov 2012 05:50:14 -0800 (PST)
In-Reply-To: <1354265746-8390-1-git-send-email-s.priebe@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: qemu-devel <qemu-devel@nongnu.org>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Nov 30, 2012 at 9:55 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> This one fixes a race which qemu had also in iscsi block driver
> between cancellation and io completition.
>
> qemu_rbd_aio_cancel was not synchronously waiting for the end of
> the command.
>
> To archieve this it introduces a new status flag which uses
> -EINPROGRESS.
>
> Changes since PATCHv5:
> - qemu_aio_release has to be done in qemu_rbd_aio_cancel if I/O
>   was cancelled
>
> Changes since PATCHv4:
> - removed unnecessary qemu_vfree of acb->bounce as BH will always
>   run
>
> Changes since PATCHv3:
> - removed unnecessary if condition in rbd_start_aio as we
>   haven't start io yet
> - moved acb->status = 0 to rbd_aio_bh_cb so qemu_aio_wait always
>   waits until BH was executed
>
> Changes since PATCHv2:
> - fixed missing braces
> - added vfree for bounce
>
> Signed-off-by: Stefan Priebe <s.priebe@profihost.ag>
>
> ---
>  block/rbd.c |   20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@gmail.com>
