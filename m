From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/7] rbd: make rbd spec names pointer to const
Date: Mon, 29 Apr 2013 08:34:29 -0700
Message-ID: <517E9305.4060201@inktank.com>
References: <517AC047.6060000@inktank.com> <517AC09F.1020900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:47362 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab3D2PeK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 11:34:10 -0400
Received: by mail-pb0-f50.google.com with SMTP id um15so1999852pbc.23
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 08:34:09 -0700 (PDT)
In-Reply-To: <517AC09F.1020900@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/26/2013 10:59 AM, Alex Elder wrote:
> Make the names and image id in an rbd_spec be pointers to constant
> data.  This required the use of a local variable to hold the
> snapshot name in rbd_add_parse_args() to avoid a warning.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index cacbc30..d989914 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -138,13 +138,13 @@ struct rbd_image_header {
>    */
>   struct rbd_spec {
>   	u64		pool_id;
> -	char		*pool_name;
> +	const char	*pool_name;
>
> -	char		*image_id;
> -	char		*image_name;
> +	const char	*image_id;
> +	const char	*image_name;
>
>   	u64		snap_id;
> -	char		*snap_name;
> +	const char	*snap_name;
>
>   	struct kref	kref;
>   };
> @@ -4375,6 +4375,7 @@ static int rbd_add_parse_args(const char *buf,
>   	size_t len;
>   	char *options;
>   	const char *mon_addrs;
> +	char *snap_name;
>   	size_t mon_addrs_size;
>   	struct rbd_spec *spec = NULL;
>   	struct rbd_options *rbd_opts = NULL;
> @@ -4433,10 +4434,11 @@ static int rbd_add_parse_args(const char *buf,
>   		ret = -ENAMETOOLONG;
>   		goto out_err;
>   	}
> -	spec->snap_name = kmemdup(buf, len + 1, GFP_KERNEL);
> -	if (!spec->snap_name)
> +	snap_name = kmemdup(buf, len + 1, GFP_KERNEL);
> +	if (!snap_name)
>   		goto out_mem;
> -	*(spec->snap_name + len) = '\0';
> +	*(snap_name + len) = '\0';
> +	spec->snap_name = snap_name;
>
>   	/* Initialize all rbd options to the defaults */
>

