From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 4/4] rbd: set snapshot id in rbd_dev_probe_update_spec()
Date: Mon, 29 Apr 2013 08:31:13 -0700
Message-ID: <517E9241.7070105@inktank.com>
References: <517A945B.9040304@inktank.com> <517A94CE.2050408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:61681 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab3D2Pa6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 11:30:58 -0400
Received: by mail-pb0-f43.google.com with SMTP id ma3so1360026pbc.30
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 08:30:58 -0700 (PDT)
In-Reply-To: <517A94CE.2050408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/26/2013 07:53 AM, Alex Elder wrote:
> Set the rbd spec's snapshot id for an image getting mapped in
> rbd_dev_probe_update_spec() rather than rbd_dev_set_mapping().
> This is the more logical place for that to happen (even though
> it means we might look up the snapshot by name twice).
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 5f97137..5099f44 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -846,7 +846,6 @@ static int rbd_dev_set_mapping(struct rbd_device
> *rbd_dev)
>   {
>   	if (!memcmp(rbd_dev->spec->snap_name, RBD_SNAP_HEAD_NAME,
>   		    sizeof (RBD_SNAP_HEAD_NAME))) {
> -		rbd_dev->spec->snap_id = CEPH_NOSNAP;
>   		rbd_dev->mapping.size = rbd_dev->header.image_size;
>   		rbd_dev->mapping.features = rbd_dev->header.features;
>   	} else {
> @@ -855,7 +854,6 @@ static int rbd_dev_set_mapping(struct rbd_device
> *rbd_dev)
>   		snap = snap_by_name(rbd_dev, rbd_dev->spec->snap_name);
>   		if (!snap)
>   			return -ENOENT;
> -		rbd_dev->spec->snap_id = snap->id;
>   		rbd_dev->mapping.size = snap->size;
>   		rbd_dev->mapping.features = snap->features;
>   		rbd_dev->mapping.read_only = true;
> @@ -3759,6 +3757,10 @@ out:
>    * rbd_dev_snaps_update() has completed because some of the
>    * information (in particular, snapshot name) is not available
>    * until then.
> + *
> + * When an image being mapped (not a parent) is probed, we have the
> + * pool name and pool id, image name and image id, and the snapshot
> + * name.  The only thing we're missing is the snapshot id.
>    */
>   static int rbd_dev_probe_update_spec(struct rbd_device *rbd_dev)
>   {
> @@ -3767,8 +3769,24 @@ static int rbd_dev_probe_update_spec(struct
> rbd_device *rbd_dev)
>   	void *reply_buf = NULL;
>   	int ret;
>
> -	if (rbd_dev->spec->pool_name)
> -		return 0;	/* Already have the names */
> +	/*
> +	 * An image being mapped will have the pool name (etc.), but
> +	 * we need to look up the snapshot id.
> +	 */
> +	if (rbd_dev->spec->pool_name) {
> +		if (strcmp(rbd_dev->spec->snap_name, RBD_SNAP_HEAD_NAME)) {
> +			struct rbd_snap *snap;
> +
> +			snap = snap_by_name(rbd_dev, rbd_dev->spec->snap_name);
> +			if (!snap)
> +				return -ENOENT;
> +			rbd_dev->spec->snap_id = snap->id;
> +		} else {
> +			rbd_dev->spec->snap_id = CEPH_NOSNAP;
> +		}
> +
> +		return 0;
> +	}
>
>   	/* Look up the pool name */
>

