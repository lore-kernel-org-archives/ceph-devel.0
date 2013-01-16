From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH REPOST 1/2] rbd: make exists flag atomic
Date: Tue, 15 Jan 2013 16:29:42 -0800
Message-ID: <50F5F476.7080901@inktank.com>
References: <50E60BD0.30408@inktank.com> <50E60C02.2090605@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:36683 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235Ab3APAav (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 19:30:51 -0500
Received: by mail-pb0-f54.google.com with SMTP id wz12so368276pbc.13
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 16:30:51 -0800 (PST)
In-Reply-To: <50E60C02.2090605@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/03/2013 02:53 PM, Alex Elder wrote:
> The rbd_device->exists field can be updated asynchronously, changing
> from set to clear if a mapped snapshot disappears from the base
> image's snapshot context.
>
> Currently, value of the "exists" flag is only read and modified
> under protection of the header semaphore, but that will change with
> the next patch.  Making it atomic ensures this won't be a problem
> because the a the non-existence of device will be immediately known.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

>   drivers/block/rbd.c |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 1348825..a3b0d43 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -229,7 +229,7 @@ struct rbd_device {
>   	spinlock_t		lock;		/* queue lock */
>
>   	struct rbd_image_header	header;
> -	bool                    exists;
> +	atomic_t		exists;
>   	struct rbd_spec		*spec;
>
>   	char			*header_name;
> @@ -751,7 +751,7 @@ static int rbd_dev_set_mapping(struct rbd_device
> *rbd_dev)
>   			goto done;
>   		rbd_dev->mapping.read_only = true;
>   	}
> -	rbd_dev->exists = true;
> +	atomic_set(&rbd_dev->exists, 1);
>   done:
>   	return ret;
>   }
> @@ -1670,7 +1670,7 @@ static void rbd_rq_fn(struct request_queue *q)
>   		/* Grab a reference to the snapshot context */
>
>   		down_read(&rbd_dev->header_rwsem);
> -		if (rbd_dev->exists) {
> +		if (atomic_read(&rbd_dev->exists)) {
>   			snapc = ceph_get_snap_context(rbd_dev->header.snapc);
>   			rbd_assert(snapc != NULL);
>   		}
> @@ -2292,6 +2292,7 @@ struct rbd_device *rbd_dev_create(struct
> rbd_client *rbdc,
>   		return NULL;
>
>   	spin_lock_init(&rbd_dev->lock);
> +	atomic_set(&rbd_dev->exists, 0);
>   	INIT_LIST_HEAD(&rbd_dev->node);
>   	INIT_LIST_HEAD(&rbd_dev->snaps);
>   	init_rwsem(&rbd_dev->header_rwsem);
> @@ -2916,7 +2917,7 @@ static int rbd_dev_snaps_update(struct rbd_device
> *rbd_dev)
>   			/* Existing snapshot not in the new snap context */
>
>   			if (rbd_dev->spec->snap_id == snap->id)
> -				rbd_dev->exists = false;
> +				atomic_set(&rbd_dev->exists, 0);
>   			rbd_remove_snap_dev(snap);
>   			dout("%ssnap id %llu has been removed\n",
>   				rbd_dev->spec->snap_id == snap->id ?
>

