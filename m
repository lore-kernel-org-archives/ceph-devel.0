From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH v3 3/5] rbd: fix use-after free of rbd_dev->disk
Date: Mon, 09 Sep 2013 11:43:26 -0500
Message-ID: <522DFAAE.8040902@linaro.org>
References: <1378711022-20158-1-git-send-email-josh.durgin@inktank.com> <1378711022-20158-4-git-send-email-josh.durgin@inktank.com> <522DCF08.8050708@linaro.org> <522DF405.6080602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:57654 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab3IIQnW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Sep 2013 12:43:22 -0400
Received: by mail-ob0-f172.google.com with SMTP id er7so6193274obc.3
        for <ceph-devel@vger.kernel.org>; Mon, 09 Sep 2013 09:43:21 -0700 (PDT)
In-Reply-To: <522DF405.6080602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 09/09/2013 11:15 AM, Josh Durgin wrote:
> On 09/09/2013 06:37 AM, Alex Elder wrote:
>> On 09/09/2013 02:17 AM, Josh Durgin wrote:
>>> Removing a device deallocates the disk, unschedules the watch, and
>>> finally cleans up the rbd_dev structure. rbd_dev_refresh(), called
>>> from the watch callback, updates the disk size and rbd_dev
>>> structure. With no locking between them, rbd_dev_refresh() may use the
>>> device or rbd_dev after they've been freed.

. . .

>>> +    if (!removing) {
>>
>> Here's the problem.  It is the same one faced by the open path.
>>
>> You determined above whether or not the device was getting removed.
>> But you haven't left any state that indicates that the image is
>> getting refreshed (or more specifically, getting its size updated).
>>
>> So, if the device is mapped but isn't actually opened by anybody
>> there's nothing stopping the code in rbd_remove() from going
>> ahead anyway.  So the possibility of the structures getting freed
>> remains (though the window is a little smaller now).
> 
> I think this is safe with the use of ceph_osdc_flush_notifies()
> before rbd_bus_del_dev(). Since the watch is already unregistered,
> flushing the notifies waits for all calls to rbd_watch_cb() to
> complete. This means that rbd_remove() can't actually free
> any of the rbd_dev structures until after the last revalidate_disk()
> etc. is done. Does this make sense, or am I missing something?

Yes, now I remember.  You're right.  That was the point of
doing the flush_notifies call before release anyway...

So my "nothing stopping the code in rbd_remove" was wrong.
In fact, that ceph_osdc_flush_notifies() call is stopping
it from freeing things that may still be in use.

Thanks for explaining it to me (again).

> This should probably go in a comment in rbd_remove(), since
> it's not obvious from the code there why the ordering of
> the last few calls makes sense.

Yes.  I think so.

Reviewed-by: Alex Elder <elder@linaro.org>

> Josh
> 
>> I think you can resolve this problem by using the open count.
>> That is, use the same interlock between the open count and the
>> removing flag that's used for rbd_open() and rbd_remove().
>> The open count in some sense represents someone still needing
>> the data structures for the image.  So treat the refresh activity
>> as one of those "somebodies" by claiming one of those opens
>> while the size update is going on.
>>
>> If you encapsulated some code now in place for this purpose,
>> something like the following might be helpful.  (I've renamed
>> "open_count" to be "inuse_count" here.)
>>
>> static inline int rbd_request_access(struct rbd_device *rbd_dev)
>> {
>>     int ret = 0;
>>
>>     spin_lock_irq(&rbd_dev->lock);
>>     if (!test_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags))
>>         rbd_dev->inuse_count++;
>>     else
>>         ret = -ENOENT;
>>     spin_unlock_irq(&rbd_dev->lock);
>>
>>     return ret;
>> }
>>
>> static inline int rbd_release_access(struct rbd_device *rbd_dev)
>> {
>>     int ret = 0;
>>
>>     spin_lock_irq(&rbd_dev->lock);
>>     if (rbd_dev->inuse_count)
>>         rbd_dev->inuse_count--;
>>     else
>>         ret = -EINVAL;
>>     spin_unlock_irq(&rbd_dev->lock);
>>
>>     return ret;
>> }
>>
>> static inline int rbd_prevent_access(struct rbd_device *rbd_dev)
>> {
>>     int ret = 0;
>>
>>     spin_lock_irq(&rbd_dev->lock);
>>     if (rbd_dev->inuse_count)
>>         ret = -EBUSY;
>>     else if (test_and_set_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags))
>>         ret = -EINPROGRESS;
>>     spin_unlock_irq(&rbd_dev->lock);
>>
>>     return ret;
>> }
>>
>> I'll assume you know what I'm talking about at this point and
>> won't go into exactly where and how you'd use these.
>>
>>> +        size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
>>> +        dout("setting size to %llu sectors", (unsigned long long)size);
>>> +        set_capacity(rbd_dev->disk, size);
>>> +        revalidate_disk(rbd_dev->disk);
>>> +    }
>>> +}+-
>>> +
>>>   static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>>>   {
>>>       u64 mapping_size;
>>
>> Everything below is good.
>>
>>> @@ -3344,12 +3369,7 @@ static int rbd_dev_refresh(struct rbd_device
>>> *rbd_dev)
>>>       up_write(&rbd_dev->header_rwsem);
>>>
>>>       if (mapping_size != rbd_dev->mapping.size) {
>>> -        sector_t size;
>>> -
>>> -        size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
>>> -        dout("setting size to %llu sectors", (unsigned long long)size);
>>> -        set_capacity(rbd_dev->disk, size);
>>> -        revalidate_disk(rbd_dev->disk);
>>> +        rbd_dev_update_size(rbd_dev);
>>>       }
>>>
>>>       return ret;
>>> @@ -5160,7 +5180,6 @@ static ssize_t rbd_remove(struct bus_type *bus,
>>>       if (ret < 0 || already)
>>>           return ret;
>>>
>>> -    rbd_bus_del_dev(rbd_dev);
>>>       ret = rbd_dev_header_watch_sync(rbd_dev, false);
>>>       if (ret)
>>>           rbd_warn(rbd_dev, "failed to cancel watch event (%d)\n", ret);
>>> @@ -5171,6 +5190,7 @@ static ssize_t rbd_remove(struct bus_type *bus,
>>>        */
>>>       dout("%s: flushing notifies", __func__);
>>>       ceph_osdc_flush_notifies(&rbd_dev->rbd_client->client->osdc);
>>> +    rbd_bus_del_dev(rbd_dev);
>>>       rbd_dev_image_release(rbd_dev);
>>>       module_put(THIS_MODULE);
>>>
>>>
>>
> 

