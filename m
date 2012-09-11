From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 6/9] rbd: call rbd_init_disk() sooner
Date: Tue, 11 Sep 2012 08:06:10 -0700
Message-ID: <504F5362.3090701@inktank.com>
References: <504A152E.4000905@inktank.com> <504A1687.9080104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50847 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889Ab2IKPGS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 11:06:18 -0400
Received: by dady13 with SMTP id y13so365019dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 08:06:17 -0700 (PDT)
In-Reply-To: <504A1687.9080104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/07/2012 08:45 AM, Alex Elder wrote:
> Call rbd_init_disk() from rbd_add() as soon as we have the major
> device number for the mapping.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 53e5308..8e82610 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2619,10 +2619,16 @@ static ssize_t rbd_add(struct bus_type *bus,
>   		goto err_out_id;
>   	rbd_dev->major = rc;
>
> -	rc = rbd_bus_add_dev(rbd_dev);
> +	/* Set up the blkdev mapping. */
> +
> +	rc = rbd_init_disk(rbd_dev);
>   	if (rc)
>   		goto err_out_blkdev;
>
> +	rc = rbd_bus_add_dev(rbd_dev);
> +	if (rc)
> +		goto err_out_disk;
> +
>   	/*
>   	 * At this point cleanup in the event of an error is the job
>   	 * of the sysfs code (initiated by rbd_bus_del_dev()).
> @@ -2634,12 +2640,6 @@ static ssize_t rbd_add(struct bus_type *bus,
>
>   	up_write(&rbd_dev->header_rwsem);
>
> -	/* Set up the blkdev mapping. */
> -
> -	rc = rbd_init_disk(rbd_dev);
> -	if (rc)
> -		goto err_out_bus;
> -
>   	/* Everything's ready.  Announce the disk to the world. */
>
>   	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
> @@ -2662,6 +2662,8 @@ err_out_bus:
>   	kfree(options);
>   	return rc;
>
> +err_out_disk:
> +	rbd_free_disk(rbd_dev);
>   err_out_blkdev:
>   	unregister_blkdev(rbd_dev->major, rbd_dev->name);
>   err_out_id:
>

