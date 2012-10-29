From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 8/8] rbd: fill rbd_spec in rbd_add_parse_args()
Date: Mon, 29 Oct 2012 15:30:14 -0700
Message-ID: <508F0376.90409@inktank.com>
References: <508B11E3.3040108@inktank.com> <508B1505.20209@inktank.com> <508B16DB.6040900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:51419 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801Ab2J2WaY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Oct 2012 18:30:24 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so2639386dak.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Oct 2012 15:30:24 -0700 (PDT)
In-Reply-To: <508B16DB.6040900@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/26/2012 04:03 PM, Alex Elder wrote:
> Pass the address of an rbd_spec structure to rbd_add_parse_args().
> Use it to hold the information defining the rbd image to be mapped
> in an rbd_add() call.
>
> Use the result in the caller to initialize the rbd_dev->id field.
>
> This means rbd_dev is no longer needed in rbd_add_parse_args(),
> so get rid of it.
>
> Now that this transformation of rbd_add_parse_args() is complete,
> correct and expand on the its header documentation to reflect the
> new reality.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |  104
> ++++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 70 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 19c7c6b..28abd31 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2887,21 +2887,53 @@ static inline char *dup_token(const char **buf,
> size_t *lenp)
>   }
>
>   /*
> - * This fills in the pool_name, image_name, image_name_len, rbd_dev,
> - * rbd_md_name, and name fields of the given rbd_dev, based on the
> - * list of monitor addresses and other options provided via
> - * /sys/bus/rbd/add.  Returns a pointer to a dynamically-allocated
> - * copy of the snapshot name to map if successful, or a
> - * pointer-coded error otherwise.
> + * Parse the options provided for an "rbd add" (i.e., rbd image
> + * mapping) request.  These arrive via a write to /sys/bus/rbd/add,
> + * and the data written is passed here via a NUL-terminated buffer.
> + * Returns 0 if successful or an error code otherwise.
>    *
> - * Note: rbd_dev is assumed to have been initially zero-filled.
> + * The information extracted from these options is recorded in
> + * the other parameters which return dynamically-allocated
> + * structures:
> + *  ceph_opts
> + *      The address of a pointer that will refer to a ceph options
> + *      structure.  Caller must release the returned pointer using
> + *      ceph_destroy_options() when it is no longer needed.
> + *  rbd_opts
> + *  	Address of an rbd options pointer.  Fully initialized by
> + *  	this function; caller must release with kfree().
> + *  spec
> + *  	Address of an rbd image specification pointer.  Fully
> + *  	initialized by this function based on parsed options.
> + *	Caller must release with kfree().
> + *
> + * The options passed take this form:
> + *  <mon_addrs> <options> <pool_name> <image_name> [<snap_id>]
> + * where:
> + *  <mon_addrs>
> + *      A comma-separated list of one or more monitor addresses.
> + *      A monitor address is an ip address, optionally followed
> + *      by a port number (separated by a colon).
> + *        I.e.:  ip1[:port1][,ip2[:port2]...]
> + *  <options>
> + *      A comma-separated list of ceph and/or rbd options.
> + *  <pool_name>
> + *      The name of the rados pool containing the rbd image.
> + *  <image_name>
> + *      The name of the image in that pool to map.
> + *  <snap_id>
> + *      An optional snapshot id.  If provided, the mapping will
> + *      present data from the image at the time that snapshot was
> + *      created.  The image head is used if no snapshot id is
> + *      provided.  Snapshot mappings are always read-only.
>    */
> -static int rbd_add_parse_args(struct rbd_device *rbd_dev,
> -				const char *buf,
> +static int rbd_add_parse_args(const char *buf,
>   				struct ceph_options **ceph_opts,
> -				struct rbd_options **opts)
> +				struct rbd_options **opts,
> +				struct rbd_spec **rbd_spec)
>   {
>   	size_t len;
> +	struct rbd_spec *spec;
>   	const char *mon_addrs;
>   	size_t mon_addrs_size;
>   	char *options;
> @@ -2917,24 +2949,27 @@ static int rbd_add_parse_args(struct rbd_device
> *rbd_dev,
>   	mon_addrs_size = len + 1;
>   	buf += len;
>
> +	spec = rbd_spec_alloc();
> +	if (!spec)
> +		return -ENOMEM;
> +
>   	ret = -EINVAL;
>   	options = dup_token(&buf, NULL);
>   	if (!options)
> -		return -ENOMEM;
> +		goto out_mem;
>   	if (!*options)
>   		goto out_err;	/* Missing options */
>
> -	rbd_dev->spec->pool_name = dup_token(&buf, NULL);
> -	if (!rbd_dev->spec->pool_name)
> +	spec->pool_name = dup_token(&buf, NULL);
> +	if (!spec->pool_name)
>   		goto out_mem;
> -	if (!*rbd_dev->spec->pool_name)
> +	if (!*spec->pool_name)
>   		goto out_err;	/* Missing pool name */
>
> -	rbd_dev->spec->image_name =
> -		dup_token(&buf, &rbd_dev->spec->image_name_len);
> -	if (!rbd_dev->spec->image_name)
> +	spec->image_name = dup_token(&buf, &spec->image_name_len);
> +	if (!spec->image_name)
>   		goto out_mem;
> -	if (!*rbd_dev->spec->image_name)
> +	if (!*spec->image_name)
>   		goto out_err;	/* Missing image name */
>
>   	/*
> @@ -2949,11 +2984,11 @@ static int rbd_add_parse_args(struct rbd_device
> *rbd_dev,
>   		ret = -ENAMETOOLONG;
>   		goto out_err;
>   	}
> -	rbd_dev->spec->snap_name = kmalloc(len + 1, GFP_KERNEL);
> -	if (!rbd_dev->spec->snap_name)
> +	spec->snap_name = kmalloc(len + 1, GFP_KERNEL);
> +	if (!spec->snap_name)
>   		goto out_mem;
> -	memcpy(rbd_dev->spec->snap_name, buf, len);
> -	*(rbd_dev->spec->snap_name + len) = '\0';
> +	memcpy(spec->snap_name, buf, len);
> +	*(spec->snap_name + len) = '\0';
>
>   	/* Initialize all rbd options to the defaults */
>
> @@ -2973,15 +3008,15 @@ static int rbd_add_parse_args(struct rbd_device
> *rbd_dev,
>   	}
>   	*opts = rbd_opts;
>
> +	*rbd_spec = spec;
> +
>   	return 0;
>   out_mem:
>   	ret = -ENOMEM;
> +	kfree(spec->image_name);
> +	kfree(spec->pool_name);
> +	kfree(spec);

This is missing spec->snap_name. Why not use rbd_spec_put()?

>   out_err:
> -	kfree(rbd_dev->spec->image_name);
> -	rbd_dev->spec->image_name = NULL;
> -	rbd_dev->spec->image_name_len = 0;
> -	kfree(rbd_dev->spec->pool_name);
> -	rbd_dev->spec->pool_name = NULL;
>   	kfree(options);
>
>   	return ret;
> @@ -3195,6 +3230,7 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	struct rbd_device *rbd_dev = NULL;
>   	struct ceph_options *ceph_opts = NULL;
>   	struct rbd_options *rbd_opts = NULL;
> +	struct rbd_spec *spec = NULL;
>   	struct ceph_osd_client *osdc;
>   	int rc = -ENOMEM;
>
> @@ -3204,9 +3240,6 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	rbd_dev = kzalloc(sizeof(*rbd_dev), GFP_KERNEL);
>   	if (!rbd_dev)
>   		return -ENOMEM;
> -	rbd_dev->spec = rbd_spec_alloc();
> -	if (!rbd_dev->spec)
> -		goto err_out_mem;
>
>   	/* static rbd_device initialization */
>   	spin_lock_init(&rbd_dev->lock);
> @@ -3215,9 +3248,10 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	init_rwsem(&rbd_dev->header_rwsem);
>
>   	/* parse add command */
> -	rc = rbd_add_parse_args(rbd_dev, buf, &ceph_opts, &rbd_opts);
> +	rc = rbd_add_parse_args(buf, &ceph_opts, &rbd_opts, &spec);
>   	if (rc < 0)
>   		goto err_out_mem;
> +
>   	rbd_dev->mapping.read_only = rbd_opts->read_only;
>
>   	rc = rbd_get_client(rbd_dev, ceph_opts);
> @@ -3227,10 +3261,12 @@ static ssize_t rbd_add(struct bus_type *bus,
>
>   	/* pick the pool */
>   	osdc = &rbd_dev->rbd_client->client->osdc;
> -	rc = ceph_pg_poolid_by_name(osdc->osdmap, rbd_dev->spec->pool_name);
> +	rc = ceph_pg_poolid_by_name(osdc->osdmap, spec->pool_name);
>   	if (rc < 0)
>   		goto err_out_client;
> -	rbd_dev->spec->pool_id = (u64) rc;
> +	spec->pool_id = (u64) rc;
> +
> +	rbd_dev->spec = spec;
>
>   	rc = rbd_dev_probe(rbd_dev);
>   	if (rc < 0)
> @@ -3321,8 +3357,8 @@ err_out_args:
>   	if (ceph_opts)
>   		ceph_destroy_options(ceph_opts);
>   	kfree(rbd_opts);
> +	rbd_spec_put(spec);
>   err_out_mem:
> -	rbd_spec_put(rbd_dev->spec);
>   	kfree(rbd_dev);
>
>   	dout("Error adding device %s\n", buf);
>

