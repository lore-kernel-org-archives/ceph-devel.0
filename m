From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rbd: set discard alignment to zero
Date: Wed, 1 Nov 2017 18:14:04 +0100
Message-ID: <CAOi1vP_Qt4NMG+8Hi_He6PBiCoJgfg6JBL53Ty=iJtmSRF4cTA@mail.gmail.com>
References: <20171101122439.9923-1-ddiss@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:55248 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbdKAROF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Nov 2017 13:14:05 -0400
Received: by mail-io0-f195.google.com with SMTP id e89so7575403ioi.11
        for <ceph-devel@vger.kernel.org>; Wed, 01 Nov 2017 10:14:05 -0700 (PDT)
In-Reply-To: <20171101122439.9923-1-ddiss@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Mike Christie <mchristi@redhat.com>

On Wed, Nov 1, 2017 at 1:24 PM, David Disseldorp <ddiss@suse.de> wrote:
> RBD devices are currently incorrectly initialised with the block queue
> discard_alignment set to the underlying RADOS object size.
>
> As per Documentation/ABI/testing/sysfs-block:
>   The discard_alignment parameter indicates how many bytes the beginning
>   of the partition is offset from the internal allocation unit's natural
>   alignment.
>
> Correcting the discard_alignment parameter from the RADOS object size to
> zero has no effect on how discard requests are propagated through the
> block layer - @alignment in __blkdev_issue_discard() remains zero.
> However, it does fix the UNMAP granularity alignment value advertised
> to SCSI initiators via the Block Limits VPD.
>
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  drivers/block/rbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b640ad8a6d20..cd4c65843f77 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4423,7 +4423,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>         /* enable the discard support */
>         queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
>         q->limits.discard_granularity = segment_size;
> -       q->limits.discard_alignment = segment_size;
> +       q->limits.discard_alignment = 0;
>         blk_queue_max_discard_sectors(q, segment_size / SECTOR_SIZE);
>         blk_queue_max_write_zeroes_sectors(q, segment_size / SECTOR_SIZE);

Hi David,

Yeah, discard_alignment == discard_granularity seems bogus.  The name
is misleading too, but that probably comes from SBC, which talks about
OPTIMAL UNMAP GRANULARITY and UNMAP GRANULARITY ALIGNMENT.

0 is the default -- let's just drop discard_alignment assignment?
Also, you quoted <disk>/<partition>/discard_alignment description, but
this is about <disk>/discard_alignment.  This had me confused for
a moment.

Thanks,

                Ilya
