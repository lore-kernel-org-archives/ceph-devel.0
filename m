From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 4/8] rbd: pass and populate rbd_options structure
Date: Mon, 29 Oct 2012 14:27:37 -0700
Message-ID: <508EF4C9.60108@inktank.com>
References: <508B11E3.3040108@inktank.com> <508B1505.20209@inktank.com> <508B1678.5030704@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34859 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756505Ab2J2V1q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Oct 2012 17:27:46 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3719739pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Oct 2012 14:27:46 -0700 (PDT)
In-Reply-To: <508B1678.5030704@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 10/26/2012 04:02 PM, Alex Elder wrote:
> Have the caller pass the address of an rbd_options structure to
> rbd_add_parse_args(), to be initialized with the information
> gleaned as a result of the parse.
>
> I know, this is another near-reversal of a recent change...
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   30 +++++++++++++++++++-----------
>   1 file changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 948a084..392dded 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2842,15 +2842,16 @@ static inline char *dup_token(const char **buf,
> size_t *lenp)
>    * Note: rbd_dev is assumed to have been initially zero-filled.
>    */
>   static struct ceph_options *rbd_add_parse_args(struct rbd_device *rbd_dev,
> -						const char *buf)
> +						const char *buf,
> +						struct rbd_options **opts)
>   {
>   	size_t len;
>   	const char *mon_addrs;
>   	size_t mon_addrs_size;
>   	char *options;
>   	struct ceph_options *err_ptr = ERR_PTR(-EINVAL);
> -	struct rbd_options rbd_opts;
>   	struct ceph_options *ceph_opts;
> +	struct rbd_options *rbd_opts = NULL;
>
>   	/* The first four tokens are required */
>
> @@ -2899,17 +2900,17 @@ static struct ceph_options
> *rbd_add_parse_args(struct rbd_device *rbd_dev,
>
>   	/* Initialize all rbd options to the defaults */
>
> -	rbd_opts.read_only = RBD_READ_ONLY_DEFAULT;
> +	rbd_opts = kzalloc(sizeof (*rbd_opts), GFP_KERNEL);
> +	if (!rbd_opts)
> +		goto out_mem;
> +
> +	rbd_opts->read_only = RBD_READ_ONLY_DEFAULT;
>
>   	ceph_opts = ceph_parse_options(options, mon_addrs,
>   					mon_addrs + mon_addrs_size - 1,
> -					parse_rbd_opts_token, &rbd_opts);
> +					parse_rbd_opts_token, rbd_opts);
>   	kfree(options);
> -
> -	/* Record the parsed rbd options */
> -
> -	if (!IS_ERR(ceph_opts))
> -		rbd_dev->mapping.read_only = rbd_opts.read_only;
> +	*opts = rbd_opts;
>
>   	return ceph_opts;
>   out_mem:
> @@ -3131,6 +3132,7 @@ static ssize_t rbd_add(struct bus_type *bus,
>   {
>   	struct rbd_device *rbd_dev = NULL;
>   	struct ceph_options *ceph_opts;
> +	struct rbd_options *rbd_opts = NULL;
>   	struct ceph_osd_client *osdc;
>   	int rc = -ENOMEM;
>
> @@ -3139,7 +3141,7 @@ static ssize_t rbd_add(struct bus_type *bus,
>
>   	rbd_dev = kzalloc(sizeof(*rbd_dev), GFP_KERNEL);
>   	if (!rbd_dev)
> -		goto err_out_mem;
> +		return -ENOMEM;
>
>   	/* static rbd_device initialization */
>   	spin_lock_init(&rbd_dev->lock);
> @@ -3148,11 +3150,12 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	init_rwsem(&rbd_dev->header_rwsem);
>
>   	/* parse add command */
> -	ceph_opts = rbd_add_parse_args(rbd_dev, buf);
> +	ceph_opts = rbd_add_parse_args(rbd_dev, buf, &rbd_opts);
>   	if (IS_ERR(ceph_opts)) {
>   		rc = PTR_ERR(ceph_opts);
>   		goto err_out_mem;
>   	}
> +	rbd_dev->mapping.read_only = rbd_opts->read_only;
>
>   	rc = rbd_get_client(rbd_dev, ceph_opts);
>   	if (rc < 0)
> @@ -3219,6 +3222,8 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	if (rc)
>   		goto err_out_bus;
>
> +	kfree(rbd_opts);
> +
>   	/* Everything's ready.  Announce the disk to the world. */
>
>   	add_disk(rbd_dev->disk);
> @@ -3232,6 +3237,8 @@ err_out_bus:
>   	/* this will also clean up rest of rbd_dev stuff */
>
>   	rbd_bus_del_dev(rbd_dev);
> +	kfree(rbd_opts);
> +
>   	return rc;
>
>   err_out_disk:
> @@ -3254,6 +3261,7 @@ err_out_args:
>   	kfree(rbd_dev->snap_name);
>   	kfree(rbd_dev->image_name);
>   	kfree(rbd_dev->pool_name);
> +	kfree(rbd_opts);
>   err_out_mem:
>   	kfree(rbd_dev);
>

