From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: DISCARD support in kernel driver
Date: Fri, 31 Jan 2014 18:36:36 -0800
Message-ID: <lchmj8$vgv$1@ger.gmane.org>
References: <52EA1BE7.5030504@ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39808 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932462AbaBACgw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 31 Jan 2014 21:36:52 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1W9QRs-0001bH-QD
	for ceph-devel@vger.kernel.org; Sat, 01 Feb 2014 03:36:48 +0100
Received: from c-50-132-41-203.hsd1.wa.comcast.net ([50.132.41.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 01 Feb 2014 03:36:48 +0100
Received: from eternaleye by c-50-132-41-203.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 01 Feb 2014 03:36:48 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Jean-Tiare LE BIGOT wrote:

> Hi,
> 
> I started to implement 'DISCARD' support in RBD kernel driver as
> described on http://tracker.ceph.com/issues/190
> 
> This first (easy) step was to add at the end of
> drivers/block/rbd.c:rbd_init_disk
> 
>      /* Advertise discard support for aligned blocks */
>      queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
>      disk->queue->limits.discard_granularity = segment_size;
>      disk->queue->limits.discard_alignment = segment_size;
> 
> With this both 'mount -o discard' and 'fstrim' stopped to complain about
> missing 'DISCARD' support. Good !
> 
> Next step was to add support on `rbd_request_fn` which I did (sort of).
> But here I'm stuck. If I understood well FS drivers uses `REQ_DISCARD`
> flag of `rq->cmd_flags` to notify the driver of the discard operation.
> But the problem is that (rq->cmd_flags & REQ_DISCARD) never appears to
> be set.
> 
> I tried copying then removing large files, lots of small files, forcing
> fstrim. But I never got it. I must be missing something obvious but I
> can't manage to find what ? Do you have any clue what could be wrong ?
> 
> Thanks,
> 

Well, you can use the "blkdiscard" command to force a discard of an 
arbitrary portion of a block device directly. You can used dd or ddrescue to 
copy test patterns (maybe 0xFF) to and from RBD device, and use blkdiscard 
to trim parts of that.

If that doesn't work, then the error must be elsewhere.

