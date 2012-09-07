From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/7] rbd: record mapped size
Date: Fri, 07 Sep 2012 12:10:22 -0700
Message-ID: <504A469E.2030203@inktank.com>
References: <5049F951.2030706@inktank.com> <5049FA71.1020809@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38044 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756514Ab2IGTKZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 15:10:25 -0400
Received: by pbbrr13 with SMTP id rr13so45382pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 12:10:24 -0700 (PDT)
In-Reply-To: <5049FA71.1020809@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 09/07/2012 06:45 AM, Alex Elder wrote:
> Add the size of the mapped image to the set of mapping-specific
> fields in an rbd_device, and use it when setting the capacity of the
> disk.
>
> Rename the "seq" argument to snap_by_name() to be "snap_id" to be
> consistent with other usage.

This doesn't seem to be part of this commit anymore.
Assuming the commit message is fixed,

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index dff6210..4377a83 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -151,6 +151,7 @@ struct rbd_snap {
>   struct rbd_mapping {
>   	char                    *snap_name;
>   	u64                     snap_id;
> +	u64                     size;
>   	bool                    snap_exists;
>   	bool			read_only;
>   };
> @@ -643,7 +644,7 @@ static int snap_by_name(struct rbd_image_header
> *header, const char *snap_name,
>   	return -ENOENT;
>   }
>
> -static int rbd_header_set_snap(struct rbd_device *rbd_dev, u64 *size)
> +static int rbd_header_set_snap(struct rbd_device *rbd_dev)
>   {
>   	int ret;
>
> @@ -652,19 +653,16 @@ static int rbd_header_set_snap(struct rbd_device
> *rbd_dev, u64 *size)
>   	if (!memcmp(rbd_dev->mapping.snap_name, RBD_SNAP_HEAD_NAME,
>   		    sizeof (RBD_SNAP_HEAD_NAME))) {
>   		rbd_dev->mapping.snap_id = CEPH_NOSNAP;
> +		rbd_dev->mapping.size = rbd_dev->header.image_size;
>   		rbd_dev->mapping.snap_exists = false;
>   		rbd_dev->mapping.read_only = rbd_dev->rbd_opts.read_only;
> -		if (size)
> -			*size = rbd_dev->header.image_size;
>   	} else {
> -		u64 snap_id = 0;
> -
>   		ret = snap_by_name(&rbd_dev->header,
>   					rbd_dev->mapping.snap_name,
> -					&snap_id, size);
> +					&rbd_dev->mapping.snap_id,
> +					&rbd_dev->mapping.size);
>   		if (ret < 0)
>   			goto done;
> -		rbd_dev->mapping.snap_id = snap_id;
>   		rbd_dev->mapping.snap_exists = true;
>   		rbd_dev->mapping.read_only = true;
>   	}
> @@ -1830,8 +1828,12 @@ static int __rbd_refresh_header(struct rbd_device
> *rbd_dev, u64 *hver)
>   	if (rbd_dev->mapping.snap_id == CEPH_NOSNAP) {
>   		sector_t size = (sector_t) h.image_size / SECTOR_SIZE;
>
> -		dout("setting size to %llu sectors", (unsigned long long) size);
> -		set_capacity(rbd_dev->disk, size);
> +		if (size != (sector_t) rbd_dev->mapping.size) {
> +			dout("setting size to %llu sectors",
> +				(unsigned long long) size);
> +			rbd_dev->mapping.size = (u64) size;
> +			set_capacity(rbd_dev->disk, size);
> +		}
>   	}
>
>   	/* rbd_dev->header.object_prefix shouldn't change */
> @@ -1875,7 +1877,6 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>   	struct request_queue *q;
>   	int rc;
>   	u64 segment_size;
> -	u64 total_size = 0;
>
>   	/* contact OSD, request size info about the object being mapped */
>   	rc = rbd_read_header(rbd_dev, &rbd_dev->header);
> @@ -1887,7 +1888,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>   	if (rc)
>   		return rc;
>
> -	rc = rbd_header_set_snap(rbd_dev, &total_size);
> +	rc = rbd_header_set_snap(rbd_dev);
>   	if (rc)
>   		return rc;
>
> @@ -1928,11 +1929,11 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>   	rbd_dev->disk = disk;
>
>   	/* finally, announce the disk to the world */
> -	set_capacity(disk, total_size / SECTOR_SIZE);
> +	set_capacity(disk, (sector_t) rbd_dev->mapping.size / SECTOR_SIZE);
>   	add_disk(disk);
>
>   	pr_info("%s: added with size 0x%llx\n",
> -		disk->disk_name, (unsigned long long)total_size);
> +		disk->disk_name, (unsigned long long) rbd_dev->mapping.size);
>   	return 0;
>
>   out_disk:
>

