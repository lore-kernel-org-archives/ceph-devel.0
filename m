From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rbd: set max_sectors explicitly
Date: Fri, 16 Oct 2015 16:00:27 +0200
Message-ID: <CAOi1vP8XTRMaZ5znY9n60jMWrBkKZ1jecwBcjsb_7F0jtz4NYA@mail.gmail.com>
References: <1444237232-9574-1-git-send-email-idryomov@gmail.com>
	<5620EC1F.6070607@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35201 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457AbbJPOA3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Oct 2015 10:00:29 -0400
Received: by wicll6 with SMTP id ll6so11481141wic.0
        for <ceph-devel@vger.kernel.org>; Fri, 16 Oct 2015 07:00:28 -0700 (PDT)
In-Reply-To: <5620EC1F.6070607@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Oct 16, 2015 at 2:22 PM, Alex Elder <elder@ieee.org> wrote:
> On 10/07/2015 12:00 PM, Ilya Dryomov wrote:
>> Commit 30e2bc08b2bb ("Revert "block: remove artifical max_hw_sectors
>> cap"") restored a clamp on max_sectors.  It's now 2560 sectors instead
>> of 1024, but it's not good enough: we set max_hw_sectors to rbd object
>> size because we don't want object sized I/Os to be split, and the
>> default object size is 4M.
>>
>> So, set max_sectors to max_hw_sectors in rbd at queue init time.
>>
>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>> ---
>>  drivers/block/rbd.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 05072464d25e..04e69b4df664 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -3760,6 +3760,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>>       /* set io sizes to object size */
>>       segment_size = rbd_obj_bytes(&rbd_dev->header);
>>       blk_queue_max_hw_sectors(q, segment_size / SECTOR_SIZE);
>> +     q->limits.max_sectors = queue_max_hw_sectors(q);
>
> This currently is done by default by blk_queue_max_hw_sectors().
> Do you see any different behavior with this patch in place?
>
> This change seems at least harmless so if it's not too late:

Not quite.  The commit mentioned above reintroduced this bit into
blk_limits_max_hw_sectors() in 4.3-rc1:

241         limits->max_sectors = min_t(unsigned int, max_hw_sectors,
242                                     BLK_DEF_MAX_SECTORS);

So this patch fixes a performance regression.  If you spin up 4.3-rc1+
and map an rbd image without changing any settings, the best you'll see
is 1280k I/Os despite a 4096k (typically) max_hw_sectors.

Thanks,

                Ilya
