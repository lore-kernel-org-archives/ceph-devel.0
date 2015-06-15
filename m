From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH RFC] storage:rbd: make the size of request is equal to
 the, size of the object
Date: Mon, 15 Jun 2015 17:27:31 +0300
Message-ID: <CAOi1vP_VLVVhoFrJ+ETRa7+o+sAjyHquZR_g2kYdO9n-8jxdoQ@mail.gmail.com>
References: <557EB47F.6090708@unitedstack.com>
	<CAOi1vP9iF6LVGrHsORoYGUkx_Ttqr7gsBUMz7EM--b7asOUPCA@mail.gmail.com>
	<557ED1D4.20605@unitedstack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34074 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322AbbFOO1c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jun 2015 10:27:32 -0400
In-Reply-To: <557ED1D4.20605@unitedstack.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: juncheng bai <baijuncheng@unitedstack.com>
Cc: idryomov@redhat.com, Alex Elder <elder@linaro.org>, Josh Durgin <josh.durgin@inktank.com>, lucienchao@gmail.com, jeff@garzik.org, yehuda@hq.newdream.net, Sage Weil <sage@newdream.net>, elder@inktank.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jun 15, 2015 at 4:23 PM, juncheng bai
<baijuncheng@unitedstack.com> wrote:
>
>
> On 2015/6/15 21:03, Ilya Dryomov wrote:
>>
>> On Mon, Jun 15, 2015 at 2:18 PM, juncheng bai
>> <baijuncheng@unitedstack.com> wrote:
>>>
>>>  From 6213215bd19926d1063d4e01a248107dab8a899b Mon Sep 17 00:00:00 2001
>>> From: juncheng bai <baijuncheng@unitedstack.com>
>>> Date: Mon, 15 Jun 2015 18:34:00 +0800
>>> Subject: [PATCH] storage:rbd: make the size of request is equal to the
>>>   size of the object
>>>
>>> ensures that the merged size of request can achieve the size of
>>> the object.
>>> when merge a bio to request or merge a request to request, the
>>> sum of the segment number of the current request and the segment
>>> number of the bio is not greater than the max segments of the request,
>>> so the max size of request is 512k if the max segments of request is
>>> BLK_MAX_SEGMENTS.
>>>
>>> Signed-off-by: juncheng bai <baijuncheng@unitedstack.com>
>>> ---
>>>   drivers/block/rbd.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>>> index 0a54c58..dec6045 100644
>>> --- a/drivers/block/rbd.c
>>> +++ b/drivers/block/rbd.c
>>> @@ -3757,6 +3757,8 @@ static int rbd_init_disk(struct rbd_device
>>> *rbd_dev)
>>>          segment_size = rbd_obj_bytes(&rbd_dev->header);
>>>          blk_queue_max_hw_sectors(q, segment_size / SECTOR_SIZE);
>>>          blk_queue_max_segment_size(q, segment_size);
>>> +       if (segment_size > BLK_MAX_SEGMENTS * PAGE_SIZE)
>>> +               blk_queue_max_segments(q, segment_size / PAGE_SIZE);
>>>          blk_queue_io_min(q, segment_size);
>>>          blk_queue_io_opt(q, segment_size);
>>
>>
>> I made a similar patch on Friday, investigating blk-mq plugging issue
>> reported by Nick.  My patch sets it to BIO_MAX_PAGES unconditionally -
>> AFAIU there is no point in setting to anything bigger since the bios
>> will be clipped to that number of vecs.  Given that BIO_MAX_PAGES is
>> 256, this gives is 1M direct I/Os.
>
> Hi. For signal bio, the max number of bio_vec is BIO_MAX_PAGES, but a
> request can be merged from multiple bios. We can see the below function:
> ll_back_merge_fn, ll_front_merge_fn and etc.
> And I test in kernel 3.18 use this patch, and do:
> echo 4096 > /sys/block/rbd0/queue/max_sectors_kb
> We use systemtap to trace the request size, It is upto 4M.

Kernel 3.18 is pre rbd blk-mq transition, which happened in 4.0.  You
should test whatever patches you have with at least 4.0.

Putting that aside, I must be missing something.  You'll get 4M
requests on 3.18 both with your patch and without it, the only
difference would be the size of bios being merged - 512k vs 1M.  Can
you describe your test workload and provide before and after traces?

Thanks,

                Ilya
