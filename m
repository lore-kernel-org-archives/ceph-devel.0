From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH] rbd: ignore unmapped snapshots that no longer exist
Date: Tue, 03 Sep 2013 08:29:55 -0500
Message-ID: <5225E453.1080403@linaro.org>
References: <1377829140-13635-1-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34039 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759989Ab3ICN3u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Sep 2013 09:29:50 -0400
Received: by mail-ie0-f176.google.com with SMTP id s9so10051832iec.21
        for <ceph-devel@vger.kernel.org>; Tue, 03 Sep 2013 06:29:50 -0700 (PDT)
In-Reply-To: <1377829140-13635-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 08/29/2013 09:19 PM, Josh Durgin wrote:
> This prevents erroring out while adding a device when a snapshot
> unrelated to the current mapping is deleted between reading the
> snapshot context and reading the snapshot names. If the mapped
> snapshot name is not found an error still occurs as usual.

I mention something about a one of your comments, but even so
this looks good to me, so for this patch:

Reviewed-by: Alex Elder <elder@linaro.org>

However, in looking at this, I found something else that probably
should be resolved.

Note that rbd_dev_spec_update() calls rbd_snap_name(), but it
only checks its return value for NULL.  This test needs to be
*at least* changed to test IS_ERR_OR_NULL(), but I think it
would be better to do the change I suggest next, and make this
spot just use IS_ERR().

Right now rbd_dev_v1_snap_name() just returns NULL if any error
occurs.  It should be made to return a pointer-coded-error like
its v2 counterpart function does.  It would look something like:

static const char *rbd_dev_v1_snap_name(struct rbd_device *rbd_dev,
                                        u64 snap_id)
{
        u32 which;
	const char *snap_name;

        which = rbd_dev_snap_index(rbd_dev, snap_id);
        if (which == BAD_SNAP_INDEX)
                return ERR_PTR(-ENOENT);

	snap_name = _rbd_dev_v1_snap_name(rbd_dev, which);

	return snap_name ? snap_name : ERR_PTR(-ENOMEM);
}

I'd make this change myself but at the moment I'm not set up
to be able to rigorously test it, so I'm just suggesting it
to you and hoping for the best...

					-Alex


> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
> ---
>  drivers/block/rbd.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 0e83a10..545ceff 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4077,8 +4077,13 @@ static u64 rbd_v2_snap_id_by_name(struct rbd_device *rbd_dev, const char *name)
>  
>  		snap_id = snapc->snaps[which];
>  		snap_name = rbd_dev_v2_snap_name(rbd_dev, snap_id);
> -		if (IS_ERR(snap_name))
> -			break;
> +		if (IS_ERR(snap_name)) {
> +			/* ignore no-longer existing snapshots */

I feel like this comment doesn't really capture why it might be
normal and acceptable for a snapshot to no longer exist.  (At
least mention that it would be due to a race?)

> +			if (PTR_ERR(snap_name) == -ENOENT)
> +				continue;
> +			else
> +				break;
> +		}
>  		found = !strcmp(name, snap_name);
>  		kfree(snap_name);
>  	}
> 

