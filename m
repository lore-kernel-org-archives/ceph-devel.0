From: Jean-Tiare LE BIGOT <jean-tiare.le-bigot@ovh.net>
Subject: DISCARD support in kernel driver
Date: Thu, 30 Jan 2014 10:31:19 +0100
Message-ID: <52EA1BE7.5030504@ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:46168 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751097AbaA3Jrd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jan 2014 04:47:33 -0500
Received: from mail612.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 84E0B1000523
	for <ceph-devel@vger.kernel.org>; Thu, 30 Jan 2014 10:31:22 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I started to implement 'DISCARD' support in RBD kernel driver as 
described on http://tracker.ceph.com/issues/190

This first (easy) step was to add at the end of 
drivers/block/rbd.c:rbd_init_disk

     /* Advertise discard support for aligned blocks */
     queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
     disk->queue->limits.discard_granularity = segment_size;
     disk->queue->limits.discard_alignment = segment_size;

With this both 'mount -o discard' and 'fstrim' stopped to complain about 
missing 'DISCARD' support. Good !

Next step was to add support on `rbd_request_fn` which I did (sort of). 
But here I'm stuck. If I understood well FS drivers uses `REQ_DISCARD` 
flag of `rq->cmd_flags` to notify the driver of the discard operation. 
But the problem is that (rq->cmd_flags & REQ_DISCARD) never appears to 
be set.

I tried copying then removing large files, lots of small files, forcing 
fstrim. But I never got it. I must be missing something obvious but I 
can't manage to find what ? Do you have any clue what could be wrong ?

Thanks,

-- 
Jean-Tiare, shared-hosting team

