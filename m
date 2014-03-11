From: Sage Weil <sage@inktank.com>
Subject: Re: DISCARD support in kernel driver
Date: Tue, 11 Mar 2014 09:50:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1403110950150.24219@cobra.newdream.net>
References: <52EA1BE7.5030504@ovh.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40940 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbaCKQu1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Mar 2014 12:50:27 -0400
In-Reply-To: <52EA1BE7.5030504@ovh.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jean-Tiare LE BIGOT <jean-tiare.le-bigot@ovh.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Jean-Tiare,

How is this going?

sage


On Thu, 30 Jan 2014, Jean-Tiare LE BIGOT wrote:
> Hi,
> 
> I started to implement 'DISCARD' support in RBD kernel driver as described on
> http://tracker.ceph.com/issues/190
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
> `rq->cmd_flags` to notify the driver of the discard operation. But the problem
> is that (rq->cmd_flags & REQ_DISCARD) never appears to be set.
> 
> I tried copying then removing large files, lots of small files, forcing
> fstrim. But I never got it. I must be missing something obvious but I can't
> manage to find what ? Do you have any clue what could be wrong ?
> 
> Thanks,
> 
> -- 
> Jean-Tiare, shared-hosting team
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
