From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH v2 1/3] rbd: fix use-after free of rbd_dev->disk
Date: Mon, 09 Sep 2013 00:30:15 -0700
Message-ID: <522D7907.9070106@inktank.com>
References: <1377757447-23515-4-git-send-email-josh.durgin@inktank.com> <1377824228-14632-1-git-send-email-josh.durgin@inktank.com> <5225D915.3080509@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:37123 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab3IIHaV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Sep 2013 03:30:21 -0400
Received: by mail-oa0-f49.google.com with SMTP id i7so6156416oag.8
        for <ceph-devel@vger.kernel.org>; Mon, 09 Sep 2013 00:30:21 -0700 (PDT)
In-Reply-To: <5225D915.3080509@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <alex.elder@linaro.org>
Cc: ceph-devel@vger.kernel.org

On 09/03/2013 05:41 AM, Alex Elder wrote:
> On 08/29/2013 07:57 PM, Josh Durgin wrote:
>> Removing a device deallocates the disk, unschedules the watch, and
>> finally cleans up the rbd_dev structure. rbd_dev_refresh(), called
>> from the watch callback, updates the disk size and rbd_dev
>> structure. With no locking between them, rbd_dev_refresh() may use the
>> device or rbd_dev after they've been freed.
>>
>> To fix this, add a shutting_down flag and a mutex protecting it to rbd_dev.
>> Take the mutex and check whether the flag is set before using rbd_dev->disk.
>> Move this disk-updating to a separate function as well.
>>
>> Fixes: http://tracker.ceph.com/issues/5636
>> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
>
> A few comments below.  I don't think you need the shutting_down
> flag after all.  If you disagree, say so.  Either way though,
> this looks good to me.

You're right, the extra lock turned out to be unnecessary.
Holding during revalidate_disk() also created a lock inversion
(since rbd_open() is called with bdev->lock held), so I've reworked
this in v3.

Thanks for the reviews!
Josh

> Reviewed-by: Alex Elder <elder@linaro.org>
>
>> ---
>>   drivers/block/rbd.c |   39 +++++++++++++++++++++++++++++++++------
>>   1 files changed, 33 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index fef3687..8ab3362b 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -343,6 +343,9 @@ struct rbd_device {
>>   	struct ceph_osd_event   *watch_event;
>>   	struct rbd_obj_request	*watch_request;
>>
>> +	bool			shutting_down;	/* rbd_remove() in progress */
>
> You could use a new rbd_dev_flags value for this.
>
> In fact, now that I'm looking at this, I think the REMOVING flag
> is already sufficient to indicate that bit of state.  (Sorry I
> didn't see this before.)
>
> You would still want the mutex so the shutdown won't happen until
> an underway size update completed.  (Or you could add another
> UPDATING_SIZE flag, but I think the mutex is better in this case.)
>
>> +	struct mutex		shutdown_lock;	/* protects shutting_down */
>> +
>>   	struct rbd_spec		*parent_spec;
>>   	u64			parent_overlap;
>>   	atomic_t		parent_ref;
>> @@ -3324,6 +3327,24 @@ static void rbd_exists_validate(struct rbd_device *rbd_dev)
>>   		clear_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
>>   }
>>
>> +static void rbd_dev_update_size(struct rbd_device *rbd_dev)
>> +{
>> +	sector_t size;
>> +
>> +	mutex_lock(&rbd_dev->shutdown_lock);
>> +	/*
>> +	 * If the device is being removed, rbd_dev->disk has
>> +	 * been destroyed, so don't try to update its size
>> +	 */
>> +	if (!rbd_dev->shutting_down) {
>> +		size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
>> +		dout("setting size to %llu sectors", (unsigned long long)size);
>> +		set_capacity(rbd_dev->disk, size);
>
> Is it true you don't hit that locking problem because of the new mutex?
>
>> +		revalidate_disk(rbd_dev->disk);
>> +	}
>> +	mutex_unlock(&rbd_dev->shutdown_lock);
>> +}
>> +
>>   static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>>   {
>>   	u64 mapping_size;
>> @@ -3343,12 +3364,7 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>>   	up_write(&rbd_dev->header_rwsem);
>>
>>   	if (mapping_size != rbd_dev->mapping.size) {
>> -		sector_t size;
>> -
>> -		size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
>> -		dout("setting size to %llu sectors", (unsigned long long)size);
>> -		set_capacity(rbd_dev->disk, size);
>> -		revalidate_disk(rbd_dev->disk);
>> +		rbd_dev_update_size(rbd_dev);
>>   	}
>>
>>   	return ret;
>> @@ -3656,6 +3672,8 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
>>   	atomic_set(&rbd_dev->parent_ref, 0);
>>   	INIT_LIST_HEAD(&rbd_dev->node);
>>   	init_rwsem(&rbd_dev->header_rwsem);
>> +	mutex_init(&rbd_dev->shutdown_lock);
>> +	rbd_dev->shutting_down = false;
>>
>>   	rbd_dev->spec = spec;
>>   	rbd_dev->rbd_client = rbdc;
>> @@ -5159,7 +5177,16 @@ static ssize_t rbd_remove(struct bus_type *bus,
>>   	if (ret < 0 || already)
>>   		return ret;
>>
>> +	/*
>> +	 * hold shutdown_lock while destroying the device so that
>> +	 * device destruction will not race with device updates from
>> +	 * the watch callback
>> +	 */
>> +	mutex_lock(&rbd_dev->shutdown_lock);
>> +	rbd_dev->shutting_down = true;
>>   	rbd_bus_del_dev(rbd_dev);
>> +	mutex_unlock(&rbd_dev->shutdown_lock);
>> +
>>   	ret = rbd_dev_header_watch_sync(rbd_dev, false);
>>   	if (ret)
>>   		rbd_warn(rbd_dev, "failed to cancel watch event (%d)\n", ret);
>>
>

