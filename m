From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/4] rbd: define rbd_dev_{create,destroy}() helpers
Date: Wed, 31 Oct 2012 13:56:01 -0700
Message-ID: <50919061.3000602@inktank.com>
References: <50904265.2050603@inktank.com> <50904337.5090509@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:65125 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760226Ab2JaU4N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 16:56:13 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1230771pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 13:56:13 -0700 (PDT)
In-Reply-To: <50904337.5090509@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 10/30/2012 02:14 PM, Alex Elder wrote:
> Encapsulate the creation/initialization and destruction of rbd
> device structures.  The rbd_client and the rbd_spec structures
> provided on creation hold references whose ownership is transferred
> to the new rbd_device structure.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   62
> ++++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 41 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4771de2..a8ad8f8 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -504,7 +504,8 @@ static void rbd_client_release(struct kref *kref)
>    */
>   static void rbd_put_client(struct rbd_client *rbdc)
>   {
> -	kref_put(&rbdc->kref, rbd_client_release);
> +	if (rbdc)
> +		kref_put(&rbdc->kref, rbd_client_release);
>   }
>
>   /*
> @@ -2166,6 +2167,34 @@ static void rbd_spec_free(struct kref *kref)
>   	kfree(spec);
>   }
>
> +struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
> +				struct rbd_spec *spec)
> +{
> +	struct rbd_device *rbd_dev;
> +
> +	rbd_dev = kzalloc(sizeof (*rbd_dev), GFP_KERNEL);
> +	if (!rbd_dev)
> +		return NULL;
> +
> +	spin_lock_init(&rbd_dev->lock);
> +	INIT_LIST_HEAD(&rbd_dev->node);
> +	INIT_LIST_HEAD(&rbd_dev->snaps);
> +	init_rwsem(&rbd_dev->header_rwsem);
> +
> +	rbd_dev->spec = spec;
> +	rbd_dev->rbd_client = rbdc;
> +
> +	return rbd_dev;
> +}
> +
> +static void rbd_dev_destroy(struct rbd_device *rbd_dev)
> +{
> +	kfree(rbd_dev->header_name);
> +	rbd_put_client(rbd_dev->rbd_client);
> +	rbd_spec_put(rbd_dev->spec);
> +	kfree(rbd_dev);
> +}
> +
>   static bool rbd_snap_registered(struct rbd_snap *snap)
>   {
>   	bool ret = snap->dev.type == &rbd_snap_device_type;
> @@ -3242,7 +3271,7 @@ static ssize_t rbd_add(struct bus_type *bus,
>   		rc = PTR_ERR(rbdc);
>   		goto err_out_args;
>   	}
> -	ceph_opts = NULL;	/* ceph_opts now owned by rbd_dev client */
> +	ceph_opts = NULL;	/* rbd_dev client now owns this */
>
>   	/* pick the pool */
>   	osdc = &rbdc->client->osdc;
> @@ -3251,22 +3280,19 @@ static ssize_t rbd_add(struct bus_type *bus,
>   		goto err_out_client;
>   	spec->pool_id = (u64) rc;
>
> -	rbd_dev = kzalloc(sizeof (*rbd_dev), GFP_KERNEL);
> +	rbd_dev = rbd_dev_create(rbdc, spec);
>   	if (!rbd_dev)
>   		goto err_out_client;
> -
> -	spin_lock_init(&rbd_dev->lock);
> -	INIT_LIST_HEAD(&rbd_dev->node);
> -	INIT_LIST_HEAD(&rbd_dev->snaps);
> -	init_rwsem(&rbd_dev->header_rwsem);
> -	rbd_dev->rbd_client = rbdc;
> -	rbd_dev->spec = spec;
> +	rbdc = NULL;		/* rbd_dev now owns this */
> +	spec = NULL;		/* rbd_dev now owns this */
>
>   	rbd_dev->mapping.read_only = rbd_opts->read_only;
> +	kfree(rbd_opts);
> +	rbd_opts = NULL;	/* done with this */
>
>   	rc = rbd_dev_probe(rbd_dev);
>   	if (rc < 0)
> -		goto err_out_mem;
> +		goto err_out_rbd_dev;
>
>   	/* no need to lock here, as rbd_dev is not registered yet */
>   	rc = rbd_dev_snaps_update(rbd_dev);
> @@ -3317,8 +3343,6 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	if (rc)
>   		goto err_out_bus;
>
> -	kfree(rbd_opts);
> -
>   	/* Everything's ready.  Announce the disk to the world. */
>
>   	add_disk(rbd_dev->disk);
> @@ -3332,7 +3356,6 @@ err_out_bus:
>   	/* this will also clean up rest of rbd_dev stuff */
>
>   	rbd_bus_del_dev(rbd_dev);
> -	kfree(rbd_opts);
>
>   	return rc;
>
> @@ -3346,9 +3369,8 @@ err_out_snaps:
>   	rbd_remove_all_snaps(rbd_dev);
>   err_out_probe:
>   	rbd_header_free(&rbd_dev->header);
> -	kfree(rbd_dev->header_name);
> -err_out_mem:
> -	kfree(rbd_dev);
> +err_out_rbd_dev:
> +	rbd_dev_destroy(rbd_dev);
>   err_out_client:
>   	rbd_put_client(rbdc);
>   err_out_args:
> @@ -3394,7 +3416,6 @@ static void rbd_dev_release(struct device *dev)
>   	if (rbd_dev->watch_event)
>   		rbd_req_sync_unwatch(rbd_dev);
>
> -	rbd_put_client(rbd_dev->rbd_client);
>
>   	/* clean up and free blkdev */
>   	rbd_free_disk(rbd_dev);
> @@ -3404,10 +3425,9 @@ static void rbd_dev_release(struct device *dev)
>   	rbd_header_free(&rbd_dev->header);
>
>   	/* done with the id, and with the rbd_dev */
> -	kfree(rbd_dev->header_name);
>   	rbd_dev_id_put(rbd_dev);
> -	rbd_spec_put(rbd_dev->spec);
> -	kfree(rbd_dev);
> +	rbd_assert(rbd_dev->rbd_client != NULL);
> +	rbd_dev_destroy(rbd_dev);
>
>   	/* release module ref */
>   	module_put(THIS_MODULE);
>

