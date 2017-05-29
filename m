From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rbd: implement REQ_OP_WRITE_ZEROES
Date: Mon, 29 May 2017 10:39:52 +0200
Message-ID: <CAOi1vP9f2YzD_XQkf60J6Q__O3XEnUQV0R2iH3sqdNS9wt2rYQ@mail.gmail.com>
References: <1495552107-1237-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34172 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbdE2Ij6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 May 2017 04:39:58 -0400
Received: by mail-vk0-f65.google.com with SMTP id w1so3830885vkd.1
        for <ceph-devel@vger.kernel.org>; Mon, 29 May 2017 01:39:53 -0700 (PDT)
In-Reply-To: <1495552107-1237-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Hannes Reinecke <hare@suse.com>

On Tue, May 23, 2017 at 5:08 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> Commit 93c1defedcae ("rbd: remove the discard_zeroes_data flag")
> explicitly didn't implement REQ_OP_WRITE_ZEROES for rbd, while the
> following commit 48920ff2a5a9 ("block: remove the discard_zeroes_data
> flag") dropped ->discard_zeroes_data in favor of REQ_OP_WRITE_ZEROES.
>
> rbd does support efficient zeroing via CEPH_OSD_OP_ZERO opcode and will
> release either some or all blocks depending on whether the zeroing
> request is rbd_obj_bytes() aligned.  This is how we currently implement
> discards, so REQ_OP_WRITE_ZEROES can be identical to REQ_OP_DISCARD for
> now.  Caveats:
>
> - REQ_NOUNMAP is ignored, but AFAICT that's true of at least two other
>   current implementations - nvme and loop
>
> - there is no ->write_zeroes_alignment and blk_bio_write_zeroes_split()
>   is hence less helpful than blk_bio_discard_split(), but this can (and
>   should) be fixed on the rbd side
>
> In the future we will split these into two code paths to respect
> REQ_NOUNMAP on zeroout and save on zeroing blocks that couldn't be
> released on discard.
>
> Fixes: 93c1defedcae ("rbd: remove the discard_zeroes_data flag")
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/rbd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 454bf9c34882..c16f74547804 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4023,6 +4023,7 @@ static void rbd_queue_workfn(struct work_struct *work)
>
>         switch (req_op(rq)) {
>         case REQ_OP_DISCARD:
> +       case REQ_OP_WRITE_ZEROES:
>                 op_type = OBJ_OP_DISCARD;
>                 break;
>         case REQ_OP_WRITE:
> @@ -4420,6 +4421,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>         q->limits.discard_granularity = segment_size;
>         q->limits.discard_alignment = segment_size;
>         blk_queue_max_discard_sectors(q, segment_size / SECTOR_SIZE);
> +       blk_queue_max_write_zeroes_sectors(q, segment_size / SECTOR_SIZE);
>
>         if (!ceph_test_opt(rbd_dev->rbd_client->client, NOCRC))
>                 q->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;

Hi Christoph,

I'm planning to merge this into 4.12-rc because it fixes a 93c1defedcae
regression, but I'm not quite sure what you meant by "rbd only supports
discarding on large alignments, so the zeroing code would always fall
back to explicit writings of zeroes".  Care to take a look and ack?

Thanks,

                Ilya
