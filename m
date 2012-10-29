From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/2] rbd: move ceph_parse_options() call up
Date: Mon, 29 Oct 2012 14:08:11 -0700
Message-ID: <508EF03B.8040203@inktank.com>
References: <508B11E3.3040108@inktank.com> <508B142D.7080907@inktank.com> <508B14F1.8050008@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60579 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760504Ab2J2VIV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Oct 2012 17:08:21 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4540699pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Oct 2012 14:08:21 -0700 (PDT)
In-Reply-To: <508B14F1.8050008@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 10/26/2012 03:55 PM, Alex Elder wrote:
> Move option parsing out of rbd_get_client() and into its caller.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   48 +++++++++++++++++++++++++++---------------------
>   1 file changed, 27 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index fb44d4d..6e36c63 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -453,27 +453,11 @@ static int parse_rbd_opts_token(char *c, void
> *private)
>    * Get a ceph client with specific addr and configuration, if one does
>    * not exist create it.
>    */
> -static int rbd_get_client(struct rbd_device *rbd_dev, const char *mon_addr,
> -				size_t mon_addr_len, char *options)
> +static int rbd_get_client(struct rbd_device *rbd_dev,
> +				struct ceph_options *ceph_opts)
>   {
> -	struct rbd_options rbd_opts;
> -	struct ceph_options *ceph_opts;
>   	struct rbd_client *rbdc;
>
> -	/* Initialize all rbd options to the defaults */
> -
> -	rbd_opts.read_only = RBD_READ_ONLY_DEFAULT;
> -
> -	ceph_opts = ceph_parse_options(options, mon_addr,
> -					mon_addr + mon_addr_len,
> -					parse_rbd_opts_token, &rbd_opts);
> -	if (IS_ERR(ceph_opts))
> -		return PTR_ERR(ceph_opts);
> -
> -	/* Record the parsed rbd options */
> -
> -	rbd_dev->mapping.read_only = rbd_opts.read_only;
> -
>   	rbdc = rbd_client_find(ceph_opts);
>   	if (rbdc) {
>   		/* using an existing client */
> @@ -3132,9 +3116,11 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	struct rbd_device *rbd_dev = NULL;
>   	const char *mon_addrs = NULL;
>   	size_t mon_addrs_size = 0;
> +	char *snap_name;
> +	struct rbd_options rbd_opts;
> +	struct ceph_options *ceph_opts;
>   	struct ceph_osd_client *osdc;
>   	int rc = -ENOMEM;
> -	char *snap_name;
>
>   	if (!try_module_get(THIS_MODULE))
>   		return -ENODEV;
> @@ -3160,9 +3146,26 @@ static ssize_t rbd_add(struct bus_type *bus,
>   		goto err_out_mem;
>   	}
>
> -	rc = rbd_get_client(rbd_dev, mon_addrs, mon_addrs_size - 1, options);
> -	if (rc < 0)
> +	/* Initialize all rbd options to the defaults */
> +
> +	rbd_opts.read_only = RBD_READ_ONLY_DEFAULT;
> +
> +	ceph_opts = ceph_parse_options(options, mon_addrs,
> +					mon_addrs + mon_addrs_size - 1,
> +					parse_rbd_opts_token, &rbd_opts);
> +	if (IS_ERR(ceph_opts)) {
> +		rc = PTR_ERR(ceph_opts);
>   		goto err_out_args;
> +	}
> +
> +	/* Record the parsed rbd options */
> +
> +	rbd_dev->mapping.read_only = rbd_opts.read_only;
> +
> +	rc = rbd_get_client(rbd_dev, ceph_opts);
> +	if (rc < 0)
> +		goto err_out_opts;
> +	ceph_opts = NULL;	/* ceph_opts now owned by rbd_dev client */
>
>   	/* pick the pool */
>   	osdc = &rbd_dev->rbd_client->client->osdc;
> @@ -3254,6 +3257,9 @@ err_out_client:
>   	kfree(rbd_dev->header_name);
>   	rbd_put_client(rbd_dev);
>   	kfree(rbd_dev->image_id);
> +err_out_opts:
> +	if (ceph_opts)
> +		ceph_destroy_options(ceph_opts);
>   err_out_args:
>   	kfree(rbd_dev->snap_name);
>   	kfree(rbd_dev->image_name);
>

