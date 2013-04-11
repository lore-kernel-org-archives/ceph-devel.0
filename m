From: Laurent Barbe <laurent@ksperis.com>
Subject: Re: [PATCH] rbd: revalidate_disk upon rbd resize
Date: Thu, 11 Apr 2013 15:59:57 +0200
Message-ID: <CADksbcr2otxYeNeZe6X0cysVxbva-bDTq+XcGvcMim1Ov-rmiw@mail.gmail.com>
References: <1365609989-14493-1-git-send-email-laurent@ksperis.com>
	<5165BDE1.7010908@inktank.com>
	<516625A7.9020403@inktank.com>
	<CADksbcpbhp8-Db2bqQc_fFwmT-iObYdjK+rXJF5DiZ9wu1sSQA@mail.gmail.com>
	<5166BA48.6070809@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5166BA48.6070809@inktank.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Ok,
thank you for your explanation, I'll look a little later.

2013/4/11 Alex Elder <elder@inktank.com>:
> On 04/11/2013 03:47 AM, Laurent Barbe wrote:
>> Thanks Alex,
>>
>> What do you mean about "lock inversion", deadlock ?
>> Is it the mutex_lock in block_dev.c:revalidate_disk() and the mutex
>> in rbd_dev_refresh ?
>
> Yes.
>
> When we refresh an rbd device we get the rbd device header
> semaphore, and with this patch we then acquire the bdev's
> mutex.
>
> Meanhwhile, via blkdev_close() __blkdev_put() acquires the
> bdev->bd_mutex, and eventually we get down to creating an
> image object request.  If it's a write, we need to get the
> snapshot context, and to do that we get the rbd device
> header mutex.
>
> So we're acquiring the locks in two different orders, and
> that's what I meant by "lock inversion," and yes, that
> can lead to deadlock.
>
> There may be a simple fix--like holding off calling
> revalidate_disk() until after we release the lock,
> most likely in rbd_dev_refresh().  But I just haven't
> really thought it through yet.
>
>                                         -Alex
>
>>
>> 2013/4/11 Alex Elder <elder@inktank.com>
>>
>>> On 04/10/2013 02:30 PM, Alex Elder wrote:
>>>> On 04/10/2013 11:06 AM, Laurent Barbe wrote:
>>>>> If rbd disk is open and rbd resize is done, new size is not visible by
>>>>> filesystem.
>>>>> Like is done in virtio-blk and dm driver, revalidate_disk() permits to
>>>>> update the bd_inode size.
>>>>
>>>> Looks good to me.  I'll take this in via the ceph-client tree.
>>>> Thanks a lot.
>>>
>>> Unfortunately this leads to a lock inversion.  I'm going to
>>> think about how to go about resolving it, so I won't be
>>> committing it just yet.
>>>
>>>                                         -Alex
>>>
>>>>
>>>> Reviewed-by: Alex Elder <elder@inktank.com>
>>>>
>>>>> Signed-off-by: Laurent Barbe <laurent@ksperis.com>
>>>>> ---
>>>>>  drivers/block/rbd.c |    1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>>>>> index f556f8a..1963025 100644
>>>>> --- a/drivers/block/rbd.c
>>>>> +++ b/drivers/block/rbd.c
>>>>> @@ -2293,6 +2293,7 @@ static void rbd_update_mapping_size(struct
>>> rbd_device *rbd_dev)
>>>>>      dout("setting size to %llu sectors", (unsigned long long) size);
>>>>>      rbd_dev->mapping.size = (u64) size;
>>>>>      set_capacity(rbd_dev->disk, size);
>>>>> +    revalidate_disk(rbd_dev->disk);
>>>>>  }
>>>>>
>>>>>  /*
>>>>>
>>>>
>>>
>>>
>>
>
