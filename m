From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/4] rbd: fix image id leak in initial probe
Date: Mon, 29 Apr 2013 08:27:14 -0700
Message-ID: <517E9152.6090209@inktank.com>
References: <517A945B.9040304@inktank.com> <517A94B4.4080804@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f51.google.com ([209.85.210.51]:65120 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756765Ab3D2P0y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 11:26:54 -0400
Received: by mail-da0-f51.google.com with SMTP id g27so1934808dan.24
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 08:26:54 -0700 (PDT)
In-Reply-To: <517A94B4.4080804@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/26/2013 07:52 AM, Alex Elder wrote:
> If a format 2 image id is found for an image being mapped, but the
> subsequent probe of the image fails, rbd_dev_probe() quits without
> freeing the image id.  Fix that.
>
> Also drop a redundant hunk of code in rbd_dev_image_id().
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 0774ae1..e79dfe2 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4794,17 +4794,21 @@ static int rbd_dev_probe(struct rbd_device *rbd_dev)
>   		ret = rbd_dev_v2_probe(rbd_dev);
>   	else
>   		ret = rbd_dev_v1_probe(rbd_dev);
> -	if (ret) {
> -		dout("probe failed, returning %d\n", ret);
> -
> -		return ret;
> -	}
> +	if (ret)
> +		goto out_err;
>
>   	ret = rbd_dev_probe_finish(rbd_dev);
>   	if (ret)
>   		rbd_header_free(&rbd_dev->header);
>
>   	return ret;
> +out_err:
> +	kfree(rbd_dev->spec->image_id);
> +	rbd_dev->spec->image_id = NULL;
> +
> +	dout("probe failed, returning %d\n", ret);
> +
> +	return ret;
>   }
>
>   static ssize_t rbd_add(struct bus_type *bus,
>

