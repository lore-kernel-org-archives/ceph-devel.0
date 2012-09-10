From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/4] rbd: don't register snapshots in bus_add_dev()
Date: Mon, 10 Sep 2012 15:21:35 -0700
Message-ID: <504E67EF.3020105@inktank.com>
References: <504A090F.7000706@inktank.com> <504A09B4.3080909@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41645 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab2IJWVi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Sep 2012 18:21:38 -0400
Received: by pbbrr13 with SMTP id rr13so3126637pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Sep 2012 15:21:38 -0700 (PDT)
In-Reply-To: <504A09B4.3080909@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/07/2012 07:50 AM, Alex Elder wrote:
> When rbd_bus_add_dev() is called (one spot--in rbd_add()), the rbd
> image header has not even been read yet.  This means that the list
> of snapshots will be empty at the time of the call.  As a result,
> there is no need for the code that calls rbd_register_snap_dev()
> for each entry in that list--so get rid of it.
>
> Once the header has been read (just after returning), a call will
> be made to rbd_dev_snap_devs_update(), which will then find every
> snapshot in the context to be new and will therefore call
> rbd_register_snap_dev() via __rbd_add_snap_dev() accomplishing
> the same thing.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 6af09f1..e922989 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2244,29 +2244,21 @@ static int rbd_dev_snap_devs_update(struct
> rbd_device *rbd_dev)
>
>   static int rbd_bus_add_dev(struct rbd_device *rbd_dev)
>   {
> -	int ret;
>   	struct device *dev;
> -	struct rbd_snap *snap;
> +	int ret;
>
>   	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
> -	dev = &rbd_dev->dev;
>
> +	dev = &rbd_dev->dev;
>   	dev->bus = &rbd_bus_type;
>   	dev->type = &rbd_device_type;
>   	dev->parent = &rbd_root_dev;
>   	dev->release = rbd_dev_release;
>   	dev_set_name(dev, "%d", rbd_dev->dev_id);
>   	ret = device_register(dev);
> -	if (ret < 0)
> -		goto out;
>
> -	list_for_each_entry(snap, &rbd_dev->snaps, node) {
> -		ret = rbd_register_snap_dev(snap, &rbd_dev->dev);
> -		if (ret < 0)
> -			break;
> -	}
> -out:
>   	mutex_unlock(&ctl_mutex);
> +
>   	return ret;
>   }
>

