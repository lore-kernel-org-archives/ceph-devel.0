From: Jean-Tiare LE BIGOT <jean-tiare.le-bigot@ovh.net>
Subject: Re: DISCARD support in kernel driver
Date: Thu, 30 Jan 2014 16:27:57 +0100
Message-ID: <52EA6F7D.30001@ovh.net>
References: <52EA1BE7.5030504@ovh.net> <CAPYLRzi5gx-zSnvnAaywNaHq6SNevLL-815P7F_D3zCadVchFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:36262 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752950AbaA3QRc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jan 2014 11:17:32 -0500
Received: from mail612.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 7511EFFCC1B
	for <ceph-devel@vger.kernel.org>; Thu, 30 Jan 2014 16:28:02 +0100 (CET)
In-Reply-To: <CAPYLRzi5gx-zSnvnAaywNaHq6SNevLL-815P7F_D3zCadVchFg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Greg,

Thanks for your answer. I did

  $ mount -t ext4 -o discard /dev/rbd1 /mnt
  # did not see any DISCARD op after that
  $ fstrim /mnt
  # neither

Maybe missing something there ? I expected '-o discard' to be enough ?

On 01/30/14 16:24, Gregory Farnum wrote:
> On Thu, Jan 30, 2014 at 1:31 AM, Jean-Tiare LE BIGOT
> <jean-tiare.le-bigot@ovh.net> wrote:
>> Hi,
>>
>> I started to implement 'DISCARD' support in RBD kernel driver as described
>> on http://tracker.ceph.com/issues/190
>>
>> This first (easy) step was to add at the end of
>> drivers/block/rbd.c:rbd_init_disk
>>
>>      /* Advertise discard support for aligned blocks */
>>      queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
>>      disk->queue->limits.discard_granularity = segment_size;
>>      disk->queue->limits.discard_alignment = segment_size;
>>
>> With this both 'mount -o discard' and 'fstrim' stopped to complain about
>> missing 'DISCARD' support. Good !
>>
>> Next step was to add support on `rbd_request_fn` which I did (sort of). But
>> here I'm stuck. If I understood well FS drivers uses `REQ_DISCARD` flag of
>> `rq->cmd_flags` to notify the driver of the discard operation. But the
>> problem is that (rq->cmd_flags & REQ_DISCARD) never appears to be set.
>>
>> I tried copying then removing large files, lots of small files, forcing
>> fstrim. But I never got it. I must be missing something obvious but I can't
>> manage to find what ? Do you have any clue what could be wrong ?
>
> I don't know anything about the relevant kernel internal interfaces
> here, but don't most FSes need to be told explicitly to do trimming?
> Did you do that?
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>

-- 
Jean-Tiare, shared-hosting team


