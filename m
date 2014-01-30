From: Gregory Farnum <greg@inktank.com>
Subject: Re: DISCARD support in kernel driver
Date: Thu, 30 Jan 2014 07:24:45 -0800
Message-ID: <CAPYLRzi5gx-zSnvnAaywNaHq6SNevLL-815P7F_D3zCadVchFg@mail.gmail.com>
References: <52EA1BE7.5030504@ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:36985 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbaA3PYq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jan 2014 10:24:46 -0500
Received: by mail-qc0-f170.google.com with SMTP id e9so5229627qcy.29
        for <ceph-devel@vger.kernel.org>; Thu, 30 Jan 2014 07:24:45 -0800 (PST)
In-Reply-To: <52EA1BE7.5030504@ovh.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jean-Tiare LE BIGOT <jean-tiare.le-bigot@ovh.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jan 30, 2014 at 1:31 AM, Jean-Tiare LE BIGOT
<jean-tiare.le-bigot@ovh.net> wrote:
> Hi,
>
> I started to implement 'DISCARD' support in RBD kernel driver as described
> on http://tracker.ceph.com/issues/190
>
> This first (easy) step was to add at the end of
> drivers/block/rbd.c:rbd_init_disk
>
>     /* Advertise discard support for aligned blocks */
>     queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
>     disk->queue->limits.discard_granularity = segment_size;
>     disk->queue->limits.discard_alignment = segment_size;
>
> With this both 'mount -o discard' and 'fstrim' stopped to complain about
> missing 'DISCARD' support. Good !
>
> Next step was to add support on `rbd_request_fn` which I did (sort of). But
> here I'm stuck. If I understood well FS drivers uses `REQ_DISCARD` flag of
> `rq->cmd_flags` to notify the driver of the discard operation. But the
> problem is that (rq->cmd_flags & REQ_DISCARD) never appears to be set.
>
> I tried copying then removing large files, lots of small files, forcing
> fstrim. But I never got it. I must be missing something obvious but I can't
> manage to find what ? Do you have any clue what could be wrong ?

I don't know anything about the relevant kernel internal interfaces
here, but don't most FSes need to be told explicitly to do trimming?
Did you do that?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
