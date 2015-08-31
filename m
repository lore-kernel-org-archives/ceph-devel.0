From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: format 2TB rbd device is too slow
Date: Mon, 31 Aug 2015 10:34:53 +0300
Message-ID: <CAOi1vP_nN9k0U-TgiWk4W-0n22X+py+n0Kx_P0mQJi4-GaV9HQ@mail.gmail.com>
References: <CABAwU-ahZz48B2VHfeyqssBv778fKoVeD5Z3x2=Xgcf42VxTbQ@mail.gmail.com>
	<CACJqLyY0FrJDbi4VDzBa3aUBGu30A9soxbRbiiNpAL_Mttna+w@mail.gmail.com>
	<CAOi1vP__WA0+Q1xfRwcvNfs6_7T3OeA7Wdsw58taZt1arNR+bg@mail.gmail.com>
	<CABAwU-YnEw2mzpF-EwMoWLrTmDdSt+XPQ0dgawigkbH7rGMtuw@mail.gmail.com>
	<6AA21C22F0A5DA478922644AD2EC308C1D1A5038@SHSMSX101.ccr.corp.intel.com>
	<CAOi1vP9Cx6VcZv7JJEjsT-jHpyB8RgRV7jDr2Xs4KLJMHr7v6Q@mail.gmail.com>
	<6AA21C22F0A5DA478922644AD2EC308C1D1A53B7@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:35637 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbbHaHey (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Aug 2015 03:34:54 -0400
Received: by lanb10 with SMTP id b10so30314408lan.2
        for <ceph-devel@vger.kernel.org>; Mon, 31 Aug 2015 00:34:53 -0700 (PDT)
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C1D1A53B7@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: huang jun <hjwsm1989@gmail.com>, Haomai Wang <haomaiwang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Aug 31, 2015 at 4:21 AM, Ma, Jianpeng <jianpeng.ma@intel.com> wrote:
> Ilya
>  I modify kernel code. The patch like this:
> [root@dev linux]# git diff
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index bc67a93..e4c4ea9 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -55,7 +55,7 @@
>   * universally 512 bytes.  These symbols are just slightly more
>   * meaningful than the bare numbers they represent.
>   */
> -#define        SECTOR_SHIFT    9
> +#define        SECTOR_SHIFT    12
>  #define        SECTOR_SIZE     (1ULL << SECTOR_SHIFT)
>
>  /*
> @@ -3811,6 +3811,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>         blk_queue_io_min(q, segment_size);
>         blk_queue_io_opt(q, segment_size);
>
> +       blk_queue_physical_block_size(q, SECTOR_SIZE);
>         /* enable the discard support */
>         queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
>         q->limits.discard_granularity = segment_size;
>
> I don't know the exact why this can decrease the time.

Well, that's the answer ;)  set_capacity()'s @size is always in 512
byte sectors, and it's called as follows in rbd:

    set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);

By changing the SECTOR_SIZE from 512 to 4096 (i.e. by a factor of 8)
you just shrink the block device by the same factor.  What used to be
a 2T mapping would now be a 256G mapping, and since the amount of data
mkfs.xfs has to write is proportional to the size of the device, your
7 times decrease in time is easily explained by an 8 times decrease in
size of the mapping.

>
> For the -b of mkfs.xfs, I try for 65536. But it don't change any.

Right.

Thanks,

                Ilya
