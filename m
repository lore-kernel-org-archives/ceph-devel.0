From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 6/8] rbd: update mapping size only on refresh
Date: Thu, 24 Jul 2014 08:25:21 -0500
Message-ID: <53D10941.2050205@ieee.org>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com> <1406191369-6746-7-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34754 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758806AbaGXNZW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 09:25:22 -0400
Received: by mail-ie0-f176.google.com with SMTP id tr6so2264701ieb.21
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 06:25:21 -0700 (PDT)
In-Reply-To: <1406191369-6746-7-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 07/24/2014 03:42 AM, Ilya Dryomov wrote:
> There is no sense in trying to update the mapping size before it's even
> been set.

It took me a bit to follow this.  But basically there is
no mapping unless it's mapped.  So previously this was
updating the mapping information even for unmapped
parent (or other) images.  There's no need to update
the mapping size for a snapshot--it'll never change.

Is that right?  If not, please advise; otherwise:

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  drivers/block/rbd.c |   19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 5dd6f5057ef4..16f388f2960b 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -971,12 +971,6 @@ static int rbd_header_from_disk(struct rbd_device *rbd_dev,
>  	header->snap_names = snap_names;
>  	header->snap_sizes = snap_sizes;
>  
> -	/* Make sure mapping size is consistent with header info */
> -
> -	if (rbd_dev->spec->snap_id == CEPH_NOSNAP || first_time)
> -		if (rbd_dev->mapping.size != header->image_size)
> -			rbd_dev->mapping.size = header->image_size;
> -
>  	return 0;
>  out_2big:
>  	ret = -EIO;
> @@ -3520,9 +3514,14 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>  
>  	ret = rbd_dev_header_info(rbd_dev);
>  
> -	/* If it's a mapped snapshot, validate its EXISTS flag */
> +	if (rbd_dev->spec->snap_id == CEPH_NOSNAP) {
> +		if (rbd_dev->mapping.size != rbd_dev->header.image_size)
> +			rbd_dev->mapping.size = rbd_dev->header.image_size;
> +	} else {
> +		/* validate mapped snapshot's EXISTS flag */
> +		rbd_exists_validate(rbd_dev);
> +	}
>  
> -	rbd_exists_validate(rbd_dev);
>  	up_write(&rbd_dev->header_rwsem);
>  
>  	if (mapping_size != rbd_dev->mapping.size) {
> @@ -4505,10 +4504,6 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
>  					"is EXPERIMENTAL!");
>  	}
>  
> -	if (rbd_dev->spec->snap_id == CEPH_NOSNAP)
> -		if (rbd_dev->mapping.size != rbd_dev->header.image_size)
> -			rbd_dev->mapping.size = rbd_dev->header.image_size;
> -
>  	ret = rbd_dev_v2_snap_context(rbd_dev);
>  	dout("rbd_dev_v2_snap_context returned %d\n", ret);
>  
> 

