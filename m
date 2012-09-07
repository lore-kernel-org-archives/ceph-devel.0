From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 4/7] rbd: set mapping name with the rest
Date: Fri, 07 Sep 2012 12:39:02 -0700
Message-ID: <504A4D56.4020108@inktank.com>
References: <5049F951.2030706@inktank.com> <5049FA7E.7090305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58758 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459Ab2IGTjE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 15:39:04 -0400
Received: by pbbrr13 with SMTP id rr13so74702pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 12:39:04 -0700 (PDT)
In-Reply-To: <5049FA7E.7090305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/07/2012 06:45 AM, Alex Elder wrote:
> With the exception of the snapshot name, all of the mapping-specific
> fields in an rbd device structure are set in rbd_header_set_snap().
>
> Pass the snapshot name to be assigned into rbd_header_set_snap()
> to keep all of the mapping assignments together.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 1a64ba2..23fa962 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -644,21 +644,20 @@ static int snap_by_name(struct rbd_image_header
> *header, const char *snap_name,
>   	return -ENOENT;
>   }
>
> -static int rbd_header_set_snap(struct rbd_device *rbd_dev)
> +static int rbd_header_set_snap(struct rbd_device *rbd_dev, char *snap_name)
>   {
>   	int ret;
>
>   	down_write(&rbd_dev->header_rwsem);
>
> -	if (!memcmp(rbd_dev->mapping.snap_name, RBD_SNAP_HEAD_NAME,
> +	if (!memcmp(snap_name, RBD_SNAP_HEAD_NAME,
>   		    sizeof (RBD_SNAP_HEAD_NAME))) {
>   		rbd_dev->mapping.snap_id = CEPH_NOSNAP;
>   		rbd_dev->mapping.size = rbd_dev->header.image_size;
>   		rbd_dev->mapping.snap_exists = false;
>   		rbd_dev->mapping.read_only = rbd_dev->rbd_opts.read_only;
>   	} else {
> -		ret = snap_by_name(&rbd_dev->header,
> -					rbd_dev->mapping.snap_name,
> +		ret = snap_by_name(&rbd_dev->header, snap_name,
>   					&rbd_dev->mapping.snap_id,
>   					&rbd_dev->mapping.size);
>   		if (ret < 0)
> @@ -666,6 +665,7 @@ static int rbd_header_set_snap(struct rbd_device
> *rbd_dev)
>   		rbd_dev->mapping.snap_exists = true;
>   		rbd_dev->mapping.read_only = true;
>   	}
> +	rbd_dev->mapping.snap_name = snap_name;
>
>   	ret = 0;
>   done:
> @@ -1888,7 +1888,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>   	if (rc)
>   		return rc;
>
> -	rc = rbd_header_set_snap(rbd_dev);
> +	rc = rbd_header_set_snap(rbd_dev, snap_name);
>   	if (rc)
>   		return rc;
>
> @@ -2600,7 +2600,6 @@ static ssize_t rbd_add(struct bus_type *bus,
>   		rc = PTR_ERR(snap_name);
>   		goto err_put_id;
>   	}
> -	rbd_dev->mapping.snap_name = snap_name;
>
>   	rc = rbd_get_client(rbd_dev, mon_addrs, mon_addrs_size - 1, options);
>   	if (rc < 0)
>

