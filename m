From: juncheng bai <baijuncheng@unitedstack.com>
Subject: Re: [PATCH RFC] storage:rbd: make the size of request is equal to
 the, size of the object
Date: Wed, 17 Jun 2015 11:04:00 +0800
Message-ID: <5580E3A0.6050504@unitedstack.com>
References: <557EB47F.6090708@unitedstack.com>	<CAOi1vP9iF6LVGrHsORoYGUkx_Ttqr7gsBUMz7EM--b7asOUPCA@mail.gmail.com>	<557ED1D4.20605@unitedstack.com>	<CAOi1vP_VLVVhoFrJ+ETRa7+o+sAjyHquZR_g2kYdO9n-8jxdoQ@mail.gmail.com>	<557F97CB.6070608@unitedstack.com>	<CAOi1vP-2dqn_FmgCK-1O6M10FHGpEPVxkAKs6SMoUB_kU9X5TQ@mail.gmail.com>	<55800F24.6060100@unitedstack.com>	<CAOi1vP-jnE+1-TA5P2=rGx9Bdoc4fTyp7u0g+QDpksm9RTxAqA@mail.gmail.com>	<55802F46.7020804@unitedstack.com> <CAOi1vP8=kMQR0=nXC-QtfGPvZGOnByKt4NpSod5HKP57spfN5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP8=kMQR0=nXC-QtfGPvZGOnByKt4NpSod5HKP57spfN5Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: idryomov@redhat.com, Alex Elder <elder@linaro.org>, Josh Durgin <josh.durgin@inktank.com>, Guangliang Zhao <lucienchao@gmail.com>, jeff@garzik.org, yehuda@hq.newdream.net, Sage Weil <sage@newdream.net>, elder@inktank.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org



On 2015/6/16 23:51, Ilya Dryomov wrote:
> On Tue, Jun 16, 2015 at 5:14 PM, juncheng bai
> <baijuncheng@unitedstack.com> wrote:
>>
>>
>> On 2015/6/16 21:30, Ilya Dryomov wrote:
>>>
>>> On Tue, Jun 16, 2015 at 2:57 PM, juncheng bai
>>> <baijuncheng@unitedstack.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2015/6/16 16:37, Ilya Dryomov wrote:
>>>>>
>>>>>
>>>>> On Tue, Jun 16, 2015 at 6:28 AM, juncheng bai
>>>>> <baijuncheng@unitedstack.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2015/6/15 22:27, Ilya Dryomov wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On Mon, Jun 15, 2015 at 4:23 PM, juncheng bai
>>>>>>> <baijuncheng@unitedstack.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2015/6/15 21:03, Ilya Dryomov wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Mon, Jun 15, 2015 at 2:18 PM, juncheng bai
>>>>>>>>> <baijuncheng@unitedstack.com> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>      From 6213215bd19926d1063d4e01a248107dab8a899b Mon Sep 17
>>>>>>>>>> 00:00:00
>>>>>>>>>> 2001
>>>>>>>>>> From: juncheng bai <baijuncheng@unitedstack.com>
>>>>>>>>>> Date: Mon, 15 Jun 2015 18:34:00 +0800
>>>>>>>>>> Subject: [PATCH] storage:rbd: make the size of request is equal to
>>>>>>>>>> the
>>>>>>>>>>       size of the object
>>>>>>>>>>
>>>>>>>>>> ensures that the merged size of request can achieve the size of
>>>>>>>>>> the object.
>>>>>>>>>> when merge a bio to request or merge a request to request, the
>>>>>>>>>> sum of the segment number of the current request and the segment
>>>>>>>>>> number of the bio is not greater than the max segments of the
>>>>>>>>>> request,
>>>>>>>>>> so the max size of request is 512k if the max segments of request
>>>>>>>>>> is
>>>>>>>>>> BLK_MAX_SEGMENTS.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: juncheng bai <baijuncheng@unitedstack.com>
>>>>>>>>>> ---
>>>>>>>>>>       drivers/block/rbd.c | 2 ++
>>>>>>>>>>       1 file changed, 2 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>>>>>>>>>> index 0a54c58..dec6045 100644
>>>>>>>>>> --- a/drivers/block/rbd.c
>>>>>>>>>> +++ b/drivers/block/rbd.c
>>>>>>>>>> @@ -3757,6 +3757,8 @@ static int rbd_init_disk(struct rbd_device
>>>>>>>>>> *rbd_dev)
>>>>>>>>>>              segment_size = rbd_obj_bytes(&rbd_dev->header);
>>>>>>>>>>              blk_queue_max_hw_sectors(q, segment_size /
>>>>>>>>>> SECTOR_SIZE);
>>>>>>>>>>              blk_queue_max_segment_size(q, segment_size);
>>>>>>>>>> +       if (segment_size > BLK_MAX_SEGMENTS * PAGE_SIZE)
>>>>>>>>>> +               blk_queue_max_segments(q, segment_size /
>>>>>>>>>> PAGE_SIZE);
>>>>>>>>>>              blk_queue_io_min(q, segment_size);
>>>>>>>>>>              blk_queue_io_opt(q, segment_size);
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I made a similar patch on Friday, investigating blk-mq plugging
>>>>>>>>> issue
>>>>>>>>> reported by Nick.  My patch sets it to BIO_MAX_PAGES unconditionally
>>>>>>>>> -
>>>>>>>>> AFAIU there is no point in setting to anything bigger since the bios
>>>>>>>>> will be clipped to that number of vecs.  Given that BIO_MAX_PAGES is
>>>>>>>>> 256, this gives is 1M direct I/Os.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Hi. For signal bio, the max number of bio_vec is BIO_MAX_PAGES, but a
>>>>>>>> request can be merged from multiple bios. We can see the below
>>>>>>>> function:
>>>>>>>> ll_back_merge_fn, ll_front_merge_fn and etc.
>>>>>>>> And I test in kernel 3.18 use this patch, and do:
>>>>>>>> echo 4096 > /sys/block/rbd0/queue/max_sectors_kb
>>>>>>>> We use systemtap to trace the request size, It is upto 4M.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Kernel 3.18 is pre rbd blk-mq transition, which happened in 4.0.  You
>>>>>>> should test whatever patches you have with at least 4.0.
>>>>>>>
>>>>>>> Putting that aside, I must be missing something.  You'll get 4M
>>>>>>> requests on 3.18 both with your patch and without it, the only
>>>>>>> difference would be the size of bios being merged - 512k vs 1M.  Can
>>>>>>> you describe your test workload and provide before and after traces?
>>>>>>>
>>>>>> Hi. I update kernel version to 4.0.5. The test information as shown
>>>>>> below:
>>>>>> The base information:
>>>>>> 03:28:13-root@server-186:~$uname -r
>>>>>> 4.0.5
>>>>>>
>>>>>> My simple systemtap script:
>>>>>> probe module("rbd").function("rbd_img_request_create")
>>>>>> {
>>>>>>        printf("offset:%lu length:%lu\n", ulong_arg(2), ulong_arg(3));
>>>>>> }
>>>>>>
>>>>>> I use dd to execute the test case:
>>>>>> dd if=/dev/zero  of=/dev/rbd0 bs=4M count=1 oflag=direct
>>>>>>
>>>>>> Case one: Without patch
>>>>>> 03:30:23-root@server-186:~$cat /sys/block/rbd0/queue/max_sectors_kb
>>>>>> 4096
>>>>>> 03:30:35-root@server-186:~$cat /sys/block/rbd0/queue/max_segments
>>>>>> 128
>>>>>>
>>>>>> The output of systemtap for nornal data:
>>>>>> offset:0 length:524288
>>>>>> offset:524288 length:524288
>>>>>> offset:1048576 length:524288
>>>>>> offset:1572864 length:524288
>>>>>> offset:2097152 length:524288
>>>>>> offset:2621440 length:524288
>>>>>> offset:3145728 length:524288
>>>>>> offset:3670016 length:524288
>>>>>>
>>>>>> Case two:With patch
>>>>>> cat /sys/block/rbd0/queue/max_sectors_kb
>>>>>> 4096
>>>>>> 03:49:14-root@server-186:linux-4.0.5$cat
>>>>>> /sys/block/rbd0/queue/max_segments
>>>>>> 1024
>>>>>> The output of systemtap for nornal data:
>>>>>> offset:0 length:1048576
>>>>>> offset:1048576 length:1048576
>>>>>> offset:2097152 length:1048576
>>>>>> offset:3145728 length:1048576
>>>>>>
>>>>>> According to the test, you are right.
>>>>>> Because the blk-mq doesn't use any scheduling policy.
>>>>>> 03:52:13-root@server-186:linux-4.0.5$cat
>>>>>> /sys/block/rbd0/queue/scheduler
>>>>>> none
>>>>>>
>>>>>> In previous versions of the kernel 4.0, the rbd use the defualt
>>>>>> scheduler:cfq
>>>>>>
>>>>>> So, I think that the blk-mq need to do more?
>>>>>
>>>>>
>>>>>
>>>>> There is no scheduler support in blk-mq as of now but your numbers
>>>>> don't have anything to do with that.  The current behaviour is a result
>>>>> of a bug in blk-mq.  It's fixed by [1], if you apply it you should see
>>>>> 4M requests with your stap script.
>>>>>
>>>>> [1] http://article.gmane.org/gmane.linux.kernel/1941750
>>>>>
>>>> Hi.
>>>> First, Let's look at the result in the kernel version 3.18
>>>> The function blk_limits_max_hw_sectors different implemention between
>>>> 3.18
>>>> and 4.0+. We need do:
>>>> echo 4094 >/sys/block/rbd0/queue/max_sectors_kb
>>>>
>>>> The rbd device information:
>>>> 11:13:18-root@server-186:~$cat /sys/block/rbd0/queue/max_sectors_kb
>>>> 4094
>>>> 11:15:28-root@server-186:~$cat /sys/block/rbd0/queue/max_segments
>>>> 1024
>>>>
>>>> The test command:
>>>> dd if=/dev/zero of=/dev/rbd0 bs=4M count=1
>>>>
>>>> The simple stap script:
>>>> probe module("rbd").function("rbd_img_request_create")
>>>> {
>>>>       printf("offset:%lu length:%lu\n", ulong_arg(2), ulong_arg(3));
>>>> }
>>>>
>>>> The output from stap:
>>>> offset:0 length:4190208
>>>> offset:21474770944 length:4096
>>>>
>>>> Second, thanks for your patch [1].
>>>> I use the patch [1], and recompile the kernel.
>>>> The test information as shown below:
>>>> 12:26:12-root@server-186:$cat /sys/block/rbd0/queue/max_segments
>>>> 1024
>>>> 12:26:23-root@server-186:$cat /sys/block/rbd0/queue/max_sectors_kb
>>>> 4096
>>>>
>>>> The test command:
>>>> dd if=/dev/zero  of=/dev/rbd0 bs=4M count=2 oflag=direct
>>>>
>>>> The simple systemtap script:
>>>> probe module("rbd").function("rbd_img_request_create")
>>>> {
>>>>       printf("offset:%lu length:%lu\n", ulong_arg(2), ulong_arg(3));
>>>> }
>>>>
>>>> The output of systemtap for nornal data:
>>>> offset:0 length:4194304
>>>> offset:4194304 length:4194304
>>>> offset:21474770944 length:4096
>>>
>>>
>>> Sorry, I fail to see the purpose of the above tests.  The test commands
>>> differ, the kernels differ and it looks like you had your patch applied
>>> for both tests.  What I'm trying to get you to do is to show me some
>>> data that will back your claim (which your patch is based on):
>>>
>>>>
>>>> So, I think that the max_segments of request_limits should be divide the
>>>> object size by PAGE_SIZE.
>>>
>>>
>>> For that you need to use the same kernel and run the same workload.
>>> The only difference should be whether your patch is applied or not.
>>> I still think that setting rbd max_segments to anything above
>>> BIO_MAX_PAGES is bogus, but I'd be happy to be shown wrong on that
>>> since that would mean better performance, at least in some
>>> workloads.
>>>
>> Hi.
>> For cloned image, it will avoid doing copyup if the request size is
>> equal to the object size, I think that it is the key effect of this
>> patch.
>> The big request would result in overtime if the ceph backend is busy
>> or the network bandwidth is too low.
>
> You are right, but then again: we get rbd object size sized requests
> even with the default max_segments.  This is true for both < 4.0 and
>> = 4.0 kernels (with the plugging fix applied).
Hi.
Yeah, you are right, use the default max_segments, the request size can
be the object size, because the bi_phys_segments of bio could be 
recount, there's just a possibility.

I want to fully understand the bi_phys_segments, hope you can give me 
some information, thanks.

The test information as shown below:
The systemtap script:
global greq=0;
probe kernel.function("bio_attempt_back_merge")
{
     greq=pointer_arg(2);
}

probe kernel.function("bio_attempt_back_merge").return
{
     printf("after req addr:%p req segments:%d req offset:%lu req 
length:%lu\n",
         greq,
         @cast(greq, "request")->nr_phys_segments,
         @cast(greq, "request")->__sector * 512,
         @cast(greq, "request")->__data_len);
}

probe kernel.function("blk_mq_start_request")
{
     printf("req addr:%p nr_phys_segments:%d, offset:%lu len:%lu\n",
         pointer_arg(1),
         @cast(pointer_arg(1), "request")->nr_phys_segments,
         @cast(pointer_arg(1), "request")->__sector * 512,
         @cast(pointer_arg(1), "request")->__data_len);
}

Test command:
dd if=/dev/zero  of=/dev/rbd0 bs=4M count=2 oflag=direct seek=100

Cast one:
blk_queue_max_segments(q, 256);

The output of stap:
after req addr:0xffff880ff60a08c0 req segments:73 req offset:419430400 
req length:2097152
after req addr:0xffff880ff60a08c0 req segments:73 req offset:419430400 
req length:2097152
after req addr:0xffff880ff60a0a80 req segments:186 req offset:421527552 
req length:1048576
req addr:0xffff880ff60a08c0 nr_phys_segments:73, offset:419430400 
len:2097152
req addr:0xffff880ff60a0a80 nr_phys_segments:186, offset:421527552 
len:1048576
req addr:0xffff880ff60a0c40 nr_phys_segments:232, offset:422576128 
len:1048576

after req addr:0xffff880ff60a0c40 req segments:73 req offset:423624704 
req length:2097152
after req addr:0xffff880ff60a0c40 req segments:73 req offset:423624704 
req length:2097152
after req addr:0xffff880ff60a0e00 req segments:186 req offset:425721856 
req length:1048576
req addr:0xffff880ff60a0c40 nr_phys_segments:73, offset:423624704 
len:2097152
req addr:0xffff880ff60a0e00 nr_phys_segments:186, offset:425721856 
len:1048576
req addr:0xffff880ff60a0fc0 nr_phys_segments:232, offset:426770432 
len:1048576

Case two:
blk_queue_max_segments(q, segment_size / PAGE_SIZE);

The output of stap:
after req addr:0xffff88101c9a0000 req segments:478 req offset:419430400 
req length:4194304
req addr:0xffff88101c9a0000 nr_phys_segments:478, offset:419430400 
len:4194304

after req addr:0xffff88101c9a0000 req segments:478 req offset:423624704 
req length:4194304
req addr:0xffff88101c9a0000 nr_phys_segments:478, offset:423624704 
len:4194304

1.Based on the setting of max_sectors and max_segments, decides the
   size of a request.
2.We have already set max_sectors to an object's size, so we should try
   to ensure that a request to the size as possible as merge bio.

Thanks.
----
juncheng bai
>
>> I suggest that add a module parameter to control the value which
>> decided by the user settings.
>
> A module parameter for what exactly?
It likes the single_major of module rbd.
>
> Thanks,
>
>                  Ilya
>
