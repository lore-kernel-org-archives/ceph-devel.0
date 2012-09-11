From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 9/9] rbd: set up watch before announcing disk
Date: Tue, 11 Sep 2012 08:08:54 -0700
Message-ID: <504F5406.2060702@inktank.com>
References: <504A152E.4000905@inktank.com> <504A169F.3070604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57326 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889Ab2IKPI6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 11:08:58 -0400
Received: by pbbrr13 with SMTP id rr13so918598pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 08:08:57 -0700 (PDT)
In-Reply-To: <504A169F.3070604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/07/2012 08:45 AM, Alex Elder wrote:
> We're ready to handle header object (refresh) events at the point we
> call rbd_bus_add_dev().  Set up the watch request on the rbd image
> header just after that, and after we've registered the devices for
> the snapshots for the initial snapshot context.  Do this before
> announce the disk as available for use.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 51e1d21..daa428e3 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2640,23 +2640,23 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	if (rc)
>   		goto err_out_unlock;
>
> +	rc = rbd_init_watch_dev(rbd_dev);
> +	if (rc)
> +		goto err_out_unlock;
> +
>   	up_write(&rbd_dev->header_rwsem);
>
>   	/* Everything's ready.  Announce the disk to the world. */
>
>   	add_disk(rbd_dev->disk);
> +
>   	pr_info("%s: added with size 0x%llx\n", rbd_dev->disk->disk_name,
>   		(unsigned long long) rbd_dev->mapping.size);
>
> -	rc = rbd_init_watch_dev(rbd_dev);
> -	if (rc)
> -		goto err_out_bus;
> -
>   	return count;
>
>   err_out_unlock:
>   	up_write(&rbd_dev->header_rwsem);
> -err_out_bus:
>   	/* this will also clean up rest of rbd_dev stuff */
>
>   	rbd_bus_del_dev(rbd_dev);
>

