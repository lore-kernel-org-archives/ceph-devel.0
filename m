From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH v3 4/5] rbd: ignore unmapped snapshots that no longer
 exist
Date: Mon, 09 Sep 2013 08:47:57 -0500
Message-ID: <522DD18D.6020705@linaro.org>
References: <1378711022-20158-1-git-send-email-josh.durgin@inktank.com> <1378711022-20158-5-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:49807 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab3IINrw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Sep 2013 09:47:52 -0400
Received: by mail-ob0-f180.google.com with SMTP id va7so965908obc.39
        for <ceph-devel@vger.kernel.org>; Mon, 09 Sep 2013 06:47:52 -0700 (PDT)
In-Reply-To: <1378711022-20158-5-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 09/09/2013 02:17 AM, Josh Durgin wrote:
> This prevents erroring out while adding a device when a snapshot
> unrelated to the current mapping is deleted between reading the
> snapshot context and reading the snapshot names. If the mapped
> snapshot name is not found an error still occurs as usual.

This looks good.

In fact, you could even go as far as ignoring errors
altogether.  This function is determining the name associated
with a snapshot id, and doubles as an existence check.  We
need to look at the whole list to know that the snapshot
id doesn't exist, so errors along the way are just a distraction.

(But don't bother changing it, what you have is good.)

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
> ---
>  drivers/block/rbd.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index fe5767a..226fa04 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4078,8 +4078,13 @@ static u64 rbd_v2_snap_id_by_name(struct rbd_device *rbd_dev, const char *name)
>  
>  		snap_id = snapc->snaps[which];
>  		snap_name = rbd_dev_v2_snap_name(rbd_dev, snap_id);
> -		if (IS_ERR(snap_name))
> -			break;
> +		if (IS_ERR(snap_name)) {
> +			/* ignore no-longer existing snapshots */
> +			if (PTR_ERR(snap_name) == -ENOENT)
> +				continue;
> +			else
> +				break;
> +		}
>  		found = !strcmp(name, snap_name);
>  		kfree(snap_name);
>  	}
> 

