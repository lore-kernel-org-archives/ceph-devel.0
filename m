From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH v3 3/5] rbd: fix use-after free of rbd_dev->disk
Date: Mon, 09 Sep 2013 08:37:12 -0500
Message-ID: <522DCF08.8050708@linaro.org>
References: <1378711022-20158-1-git-send-email-josh.durgin@inktank.com> <1378711022-20158-4-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:59895 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab3IINhK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Sep 2013 09:37:10 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so6287315oag.7
        for <ceph-devel@vger.kernel.org>; Mon, 09 Sep 2013 06:37:09 -0700 (PDT)
In-Reply-To: <1378711022-20158-4-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 09/09/2013 02:17 AM, Josh Durgin wrote:
> Removing a device deallocates the disk, unschedules the watch, and
> finally cleans up the rbd_dev structure. rbd_dev_refresh(), called
> from the watch callback, updates the disk size and rbd_dev
> structure. With no locking between them, rbd_dev_refresh() may use the
> device or rbd_dev after they've been freed.
> 
> To fix this, check whether RBD_DEV_FLAG_REMOVING is set before
> updating the disk size in rbd_dev_refresh(). In order to prevent a
> race where rbd_dev_refresh() is already revalidating the disk when
> rbd_remove() is called, move the call to rbd_bus_del_dev() after the
> watch is unregistered and all notifies are complete. It's safe to
> defer deleting this structure because no new requests can be submitted
> once the RBD_DEV_FLAG_REMOVING is set, since the device cannot be
> opened.
> 
> Fixes: http://tracker.ceph.com/issues/5636
> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>

I'm really sorry but I think I still see a problem.  This stuff
is very tricky...

> ---
>  drivers/block/rbd.c |   34 +++++++++++++++++++++++++++-------
>  1 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 9e5f07f..fe5767a 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3325,6 +3325,31 @@ static void rbd_exists_validate(struct rbd_device *rbd_dev)
>  		clear_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
>  }
>  
> +static void rbd_dev_update_size(struct rbd_device *rbd_dev)
> +{
> +	sector_t size;
> +	bool removing;
> +
> +	/*
> +	 * Don't hold the lock while doing disk operations,
> +	 * or lock ordering will conflict with the bdev mutex via:
> +	 * rbd_add() -> blkdev_get() -> rbd_open()
> +	 */
> +	spin_lock_irq(&rbd_dev->lock);
> +	removing = test_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags);
> +	spin_unlock_irq(&rbd_dev->lock);

(This is not the problem I was referring to, but thinking about
it led me to the real issue.  This is just some explanation
behind the logic, FYI.)

It is safe to do so, of course, but it's not necessary to hold
the lock for just testing the bit.  test_bit() (and clear_bit(),
etc.) are all atomic operations.  The only reason the lock
is held in rbd_open() is so that testing the bit value and
updating the open count are done together, atomically.  (The
same basic reasoning applies in rbd_remove()).

It may be necessary, however, to do a (read or full) memory
barrier before calling test_bit() if you're not using the lock.
(My history with memory barriers in this code is a bit checkered
though.  Looking at it again now I think I still got it wrong.)

> +	/*
> +	 * If the device is being removed, rbd_dev->disk has
> +	 * been destroyed, so don't try to update its size
> +	 */
> +	if (!removing) {

Here's the problem.  It is the same one faced by the open path.

You determined above whether or not the device was getting removed.
But you haven't left any state that indicates that the image is
getting refreshed (or more specifically, getting its size updated).

So, if the device is mapped but isn't actually opened by anybody
there's nothing stopping the code in rbd_remove() from going
ahead anyway.  So the possibility of the structures getting freed
remains (though the window is a little smaller now).

I think you can resolve this problem by using the open count.
That is, use the same interlock between the open count and the
removing flag that's used for rbd_open() and rbd_remove().
The open count in some sense represents someone still needing
the data structures for the image.  So treat the refresh activity
as one of those "somebodies" by claiming one of those opens
while the size update is going on.

If you encapsulated some code now in place for this purpose,
something like the following might be helpful.  (I've renamed
"open_count" to be "inuse_count" here.)

static inline int rbd_request_access(struct rbd_device *rbd_dev)
{
	int ret = 0;

	spin_lock_irq(&rbd_dev->lock);
	if (!test_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags))
		rbd_dev->inuse_count++;
	else
		ret = -ENOENT;
	spin_unlock_irq(&rbd_dev->lock);

	return ret;
}

static inline int rbd_release_access(struct rbd_device *rbd_dev)
{
	int ret = 0;

	spin_lock_irq(&rbd_dev->lock);
	if (rbd_dev->inuse_count)
		rbd_dev->inuse_count--;
	else
		ret = -EINVAL;
	spin_unlock_irq(&rbd_dev->lock);

	return ret;
}

static inline int rbd_prevent_access(struct rbd_device *rbd_dev)
{
	int ret = 0;

	spin_lock_irq(&rbd_dev->lock);
	if (rbd_dev->inuse_count)
		ret = -EBUSY;
	else if (test_and_set_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags))
		ret = -EINPROGRESS;
	spin_unlock_irq(&rbd_dev->lock);

	return ret;
}

I'll assume you know what I'm talking about at this point and
won't go into exactly where and how you'd use these.

> +		size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
> +		dout("setting size to %llu sectors", (unsigned long long)size);
> +		set_capacity(rbd_dev->disk, size);
> +		revalidate_disk(rbd_dev->disk);
> +	}
> +}+-
> +
>  static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>  {
>  	u64 mapping_size;

Everything below is good.

> @@ -3344,12 +3369,7 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>  	up_write(&rbd_dev->header_rwsem);
>  
>  	if (mapping_size != rbd_dev->mapping.size) {
> -		sector_t size;
> -
> -		size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
> -		dout("setting size to %llu sectors", (unsigned long long)size);
> -		set_capacity(rbd_dev->disk, size);
> -		revalidate_disk(rbd_dev->disk);
> +		rbd_dev_update_size(rbd_dev);
>  	}
>  
>  	return ret;
> @@ -5160,7 +5180,6 @@ static ssize_t rbd_remove(struct bus_type *bus,
>  	if (ret < 0 || already)
>  		return ret;
>  
> -	rbd_bus_del_dev(rbd_dev);
>  	ret = rbd_dev_header_watch_sync(rbd_dev, false);
>  	if (ret)
>  		rbd_warn(rbd_dev, "failed to cancel watch event (%d)\n", ret);
> @@ -5171,6 +5190,7 @@ static ssize_t rbd_remove(struct bus_type *bus,
>  	 */
>  	dout("%s: flushing notifies", __func__);
>  	ceph_osdc_flush_notifies(&rbd_dev->rbd_client->client->osdc);
> +	rbd_bus_del_dev(rbd_dev);
>  	rbd_dev_image_release(rbd_dev);
>  	module_put(THIS_MODULE);
>  
> 

