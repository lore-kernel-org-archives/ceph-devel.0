From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/3] rbd: close remove vs. notify race leading to use-after-free
Date: Thu, 29 Aug 2013 11:33:44 -0700
Message-ID: <521F9408.4020301@inktank.com>
References: <1377757447-23515-1-git-send-email-josh.durgin@inktank.com> <1377757447-23515-4-git-send-email-josh.durgin@inktank.com> <521F6716.1020000@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:56922 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756746Ab3H2Sfx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 14:35:53 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so812613pde.9
        for <ceph-devel@vger.kernel.org>; Thu, 29 Aug 2013 11:35:52 -0700 (PDT)
In-Reply-To: <521F6716.1020000@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <alex.elder@linaro.org>
Cc: ceph-devel@vger.kernel.org

On 08/29/2013 08:21 AM, Alex Elder wrote:
> On 08/29/2013 01:24 AM, Josh Durgin wrote:
>> Removing a device deallocates the disk, unschedules the watch, and
>> finally cleans up the rbd_dev structure. rbd_dev_refresh(), called
>> from the watch callback, updates the disk size and rbd_dev
>> structure. With no locking between them, rbd_dev_refresh() may use the
>> device or rbd_dev after they've been freed.
>>
>> To fix this, use the header_rwsem to protect all the work
>> rbd_dev_refresh() does, and take it exclusively in rbd_remove() where
>> the block device is released and the watch is canceled.
>
> It seems to me this was a little bit of a tricky area.  As I recall
> there was a problem related to lock inversion, holding the semaphore
> while calling revalidate_disk().  (I'm sorry, this may be wrong and
> I can't dig much into it further at the moment.)  In any case, make
> sure you test with lockdep enabled and look for splats to the console.

You're right, there was a lock inversion with the header_rwsem and
bdev->bd_mutex. I'll switch to using a new mutex to avoid this.

> Also, there was once a function rbd_update_mapping_size(),
> which encapsulated both updating the size field and then
> calling set_capacity() immediately thereafter.  When images
> were refreshed (in rbd_dev_vX_refresh()), these updates would
> be made by calling rbd_update_mapping_size().  That made good
> sense, but after this commit:
>      00a653e216  rbd: update capacity in rbd_dev_refresh()
> the function became pretty trivial and it got removed.
>
> I think due to the lockdep thing, revalidate_disk() was
> later called outside the protection of the mutex.  It may
> be necessary to at least move those size updates back into
> the refresh functions to resolve the lockdep problem.
>
> Anyway, having a function that encapsulates these size changes
> like before might be nice, but it's not that important.  If
> there really is a problem with calling revalidate_disk() with
> the mutex held, then it's not all done in a single unit anyway.

Good idea.

>> rbd_bus_del_dev() ends up releasing the block device, so no requests
>> to the device remain after this. This makes all the work in
>> rbd_dev_refresh() unnecessary, as well as race-prone, so skip it if
>> the watch has been canceled.
>
> This makes sense, but a brief comment explaining why you're
> skipping it at the point in the code would be helpful.

I'll add one. Thanks!

Josh

>> Finally, flush the osd client's notify queue before deallocating the
>> rbd dev, so that any callbacks remaining can read rbd_dev->watch_event
>> safely. No more notifies can enter the queue at this point since the
>> watch has been canceled.
>>
>> Fixes: http://tracker.ceph.com/issues/5636
>> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
>
> Please verify there's no lockdep reports if you haven't already.
> And consider my other comments, but barring lockdep issues:
>
> Reviewed-by: Alex Elder <elder@linaro.org>
>
>> ---
>>   drivers/block/rbd.c |   25 ++++++++++++++++++++++---
>>   1 files changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index fef3687..63e1590 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -3327,10 +3327,13 @@ static void rbd_exists_validate(struct rbd_device *rbd_dev)
>>   static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>>   {
>>   	u64 mapping_size;
>> -	int ret;
>> +	int ret = 0;
>>
>>   	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
>>   	down_write(&rbd_dev->header_rwsem);
>> +	if (!rbd_dev->watch_event)
>> +		goto out;
>> +
>>   	mapping_size = rbd_dev->mapping.size;
>>   	if (rbd_dev->image_format == 1)
>>   		ret = rbd_dev_v1_header_info(rbd_dev);
>> @@ -3340,7 +3343,6 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>>   	/* If it's a mapped snapshot, validate its EXISTS flag */
>>
>>   	rbd_exists_validate(rbd_dev);
>> -	up_write(&rbd_dev->header_rwsem);
>>
>>   	if (mapping_size != rbd_dev->mapping.size) {
>>   		sector_t size;
>> @@ -3350,7 +3352,8 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>>   		set_capacity(rbd_dev->disk, size);
>>   		revalidate_disk(rbd_dev->disk);
>>   	}
>> -
>> +out:
>> +	up_write(&rbd_dev->header_rwsem);
>>   	return ret;
>>   }
>>
>> @@ -5159,10 +5162,26 @@ static ssize_t rbd_remove(struct bus_type *bus,
>>   	if (ret < 0 || already)
>>   		return ret;
>>
>> +	/*
>> +	 * take header semaphore while destroying the device and
>> +	 * canceling the watch so that device destruction will
>> +	 * not race with device updates from the watch callback
>> +	 */
>> +	down_write(&rbd_dev->header_rwsem);
>>   	rbd_bus_del_dev(rbd_dev);
>>   	ret = rbd_dev_header_watch_sync(rbd_dev, false);
>> +	up_write(&rbd_dev->header_rwsem);
>> +
>>   	if (ret)
>>   		rbd_warn(rbd_dev, "failed to cancel watch event (%d)\n", ret);
>> +
>> +	/*
>> +	 * flush remaing watch callbacks - these don't update anything
>> +	 * anymore since rbd_dev->watch_event is NULL, but it avoids
>> +	 * the watch callback using a freed rbd_dev
>> +	 */
>> +	dout("%s: flushing notifies", __func__);
>> +	ceph_osdc_flush_notifies(&rbd_dev->rbd_client->client->osdc);
>>   	rbd_dev_image_release(rbd_dev);
>>   	module_put(THIS_MODULE);
>>
>>
>

