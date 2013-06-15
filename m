From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH 1/2] rbd: fetch object order before using it
Date: Sat, 15 Jun 2013 12:05:16 -0500
Message-ID: <51BC9ECC.3020809@linaro.org>
References: <1371093046-5814-1-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:47428 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741Ab3FORFM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Jun 2013 13:05:12 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so3835758ied.14
        for <ceph-devel@vger.kernel.org>; Sat, 15 Jun 2013 10:05:12 -0700 (PDT)
In-Reply-To: <1371093046-5814-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 06/12/2013 10:10 PM, Josh Durgin wrote:
> rbd_dev_v2_header_onetime() fetches striping information, and
> checks whether the image can be read by compariing the stripe unit
> to the object size. It determines the object size by shifting
> the object order, which is 0 at this point since it has not been
> read yet. Move the call to get the image size and object order
> before rbd_dev_v2_header_onetime() so it is set before use.
> 
> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/block/rbd.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index cecf5c6..9f72125 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4286,6 +4286,10 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
>  	bool first_time = rbd_dev->header.object_prefix == NULL;
>  	int ret;
>  
> +	ret = rbd_dev_v2_image_size(rbd_dev);
> +	if (ret)
> +		return ret;
> +
>  	if (first_time) {
>  		ret = rbd_dev_v2_header_onetime(rbd_dev);
>  		if (ret)
> @@ -4319,10 +4323,6 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
>  					"is EXPERIMENTAL!");
>  	}
>  
> -	ret = rbd_dev_v2_image_size(rbd_dev);
> -	if (ret)
> -		return ret;
> -
>  	if (rbd_dev->spec->snap_id == CEPH_NOSNAP)
>  		if (rbd_dev->mapping.size != rbd_dev->header.image_size)
>  			rbd_dev->mapping.size = rbd_dev->header.image_size;
> 

