From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: nuke the 32-bit pool id check
Date: Tue, 9 Aug 2016 09:45:50 -0500
Message-ID: <446d126b-1e14-e93f-456f-a9f48fdcdddf@ieee.org>
References: <1470753737-5729-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:34998 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbcHIOpx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Aug 2016 10:45:53 -0400
Received: by mail-io0-f175.google.com with SMTP id m101so13486881ioi.2
        for <ceph-devel@vger.kernel.org>; Tue, 09 Aug 2016 07:45:52 -0700 (PDT)
In-Reply-To: <1470753737-5729-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

On 08/09/2016 09:42 AM, Ilya Dryomov wrote:
> ceph_file_layout::pool_id is now s64.  rbd_add_get_pool_id() and
> ceph_pg_poolid_by_name() both return an int, so it's bogus anyway.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

If a pool id is really 64 bits (signed), shouldn't
rbd_add_get_pool_id() and ceph_pg_poolid_by_name()
be changed to return that type (first)?

This otherwise looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/block/rbd.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 07668a6f0607..6c6519f6492a 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -5337,15 +5337,6 @@ static ssize_t do_rbd_add(struct bus_type *bus,
>  	}
>  	spec->pool_id = (u64)rc;
>  
> -	/* The ceph file layout needs to fit pool id in 32 bits */
> -
> -	if (spec->pool_id > (u64)U32_MAX) {
> -		rbd_warn(NULL, "pool id too large (%llu > %u)",
> -				(unsigned long long)spec->pool_id, U32_MAX);
> -		rc = -EIO;
> -		goto err_out_client;
> -	}
> -
>  	rbd_dev = rbd_dev_create(rbdc, spec, rbd_opts);
>  	if (!rbd_dev) {
>  		rc = -ENOMEM;
> 

