From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH REPOST 4/4] rbd: add warnings to rbd_dev_probe_update_spec()
Date: Thu, 17 Jan 2013 09:39:02 -0800
Message-ID: <50F83736.1000006@inktank.com>
References: <50E5D7A9.6040101@inktank.com> <50E5D816.9010104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:62088 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596Ab3AQRjK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 12:39:10 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so1203836dak.2
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 09:39:10 -0800 (PST)
In-Reply-To: <50E5D816.9010104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/03/2013 11:12 AM, Alex Elder wrote:
> Josh suggested adding warnings to this function to help users
> diagnose problems.
>
> Other than memory allocatino errors, there are two places where
> errors can be returned.  Both represent problems that should
> have been caught earlier, and as such might well have been
> handled with BUG_ON() calls.  But if either ever did manage to
> happen, it will be reported.

The pool could be deleted without us knowing after
our first check.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index ce6c0cb..530a121 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2644,8 +2644,11 @@ static int rbd_dev_probe_update_spec(struct
> rbd_device *rbd_dev)
>
>   	osdc = &rbd_dev->rbd_client->client->osdc;
>   	name = ceph_pg_pool_name_by_id(osdc->osdmap, rbd_dev->spec->pool_id);
> -	if (!name)
> -		return -EIO;	/* pool id too large (>= 2^31) */
> +	if (!name) {
> +		rbd_warn(rbd_dev, "there is no pool with id %llu",
> +			rbd_dev->spec->pool_id);	/* Really a BUG() */
> +		return -EIO;
> +	}
>
>   	rbd_dev->spec->pool_name = kstrdup(name, GFP_KERNEL);
>   	if (!rbd_dev->spec->pool_name)
> @@ -2663,6 +2666,8 @@ static int rbd_dev_probe_update_spec(struct
> rbd_device *rbd_dev)
>
>   	name = rbd_snap_name(rbd_dev, rbd_dev->spec->snap_id);
>   	if (!name) {
> +		rbd_warn(rbd_dev, "no snapshot with id %llu",
> +			rbd_dev->spec->snap_id);	/* Really a BUG() */
>   		ret = -EIO;
>   		goto out_err;
>   	}
>

