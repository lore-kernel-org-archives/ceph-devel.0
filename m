From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/6] rbd: update capacity in rbd_dev_refresh()
Date: Tue, 07 May 2013 15:49:24 -0700
Message-ID: <518984F4.5030509@inktank.com>
References: <51885A97.9070005@inktank.com> <51885AD8.1050105@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33733 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab3EGWua (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 May 2013 18:50:30 -0400
Received: by mail-pd0-f175.google.com with SMTP id y14so755037pdi.6
        for <ceph-devel@vger.kernel.org>; Tue, 07 May 2013 15:50:29 -0700 (PDT)
In-Reply-To: <51885AD8.1050105@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 05/06/2013 06:37 PM, Alex Elder wrote:
> When a mapped image changes size, we change the capacity recorded
> for the Linux disk associated with it, in rbd_update_mapping_size().
> That function is called in two places--the format 1 and format 2
> refresh routines.
>
> There is no need to set the capacity while holding the header
> semaphore.  Instead, do it in the common rbd_dev_refresh(), using
> the logic that's already there to initiate disk revalidation.
>
> Add handling in the request function, just in case a request
> that exceeds the capacity of the device comes in (perhaps one
> that was started before a refresh shrunk the device).
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 5d5e3f0..a0f1fe5 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2874,6 +2874,13 @@ static void rbd_request_fn(struct request_queue *q)
>   			goto end_request;	/* Shouldn't happen */
>   		}
>
> +		result = -ENOSPC;

blk-core.c usually uses -EIO for this case. That's more expected from a
read anyway, so I think -EIO would be better.

With that change:
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> +		if (offset + length > rbd_dev->mapping.size) {
> +			rbd_warn(rbd_dev, "beyond EOD (%llu~%llu > %llu)\n",
> +				offset, length, rbd_dev->mapping.size);
> +			goto end_request;
> +		}
> +
>   		result = -ENOMEM;
>   		img_request = rbd_img_request_create(rbd_dev, offset, length,
>   							write_request, false);
> @@ -3116,14 +3123,8 @@ static void rbd_update_mapping_size(struct
> rbd_device *rbd_dev)
>   	if (rbd_dev->spec->snap_id != CEPH_NOSNAP)
>   		return;
>
> -	if (rbd_dev->mapping.size != rbd_dev->header.image_size) {
> -		sector_t size;
> -
> +	if (rbd_dev->mapping.size != rbd_dev->header.image_size)
>   		rbd_dev->mapping.size = rbd_dev->header.image_size;
> -		size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
> -		dout("setting size to %llu sectors", (unsigned long long)size);
> -		set_capacity(rbd_dev->disk, size);
> -	}
>   }
>
>   /*
> @@ -3200,8 +3201,14 @@ static int rbd_dev_refresh(struct rbd_device
> *rbd_dev)
>
>   	rbd_exists_validate(rbd_dev);
>   	mutex_unlock(&ctl_mutex);
> -	if (mapping_size != rbd_dev->mapping.size)
> +	if (mapping_size != rbd_dev->mapping.size) {
> +		sector_t size;
> +
> +		size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
> +		dout("setting size to %llu sectors", (unsigned long long)size);
> +		set_capacity(rbd_dev->disk, size);
>   		revalidate_disk(rbd_dev->disk);
> +	}
>
>   	return ret;
>   }
>

