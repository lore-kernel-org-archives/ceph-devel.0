From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 4/9] rbd: get rid of RBD_MAX_SEG_NAME_LEN
Date: Fri, 14 Dec 2012 17:26:04 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212141724470.14354@cobra.newdream.net>
References: <50CA0915.1090801@inktank.com> <50CA0A03.1010900@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40528 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932266Ab2LOB0E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 20:26:04 -0500
In-Reply-To: <50CA0A03.1010900@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

On Thu, 13 Dec 2012, Alex Elder wrote:

> RBD_MAX_SEG_NAME_LEN represents the maximum length of an rbd object
> name (i.e., one of the objects providing storage backing an rbd
> image).
> 
> Another symbol, MAX_OBJ_NAME_SIZE, is used in the osd client code to
> define the maximum length of any object name in an osd request.
> 
> Right now they disagree, with RBD_MAX_SEG_NAME_LEN being too big.
> 
> There's no real benefit at this point to defining the rbd object
> name length limit separate from any other object name, so just
> get rid of RBD_MAX_SEG_NAME_LEN and use MAX_OBJ_NAME_SIZE in its
> place.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c       |    6 +++---
>  drivers/block/rbd_types.h |    2 --
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index c7bf961..ce26b749 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -740,13 +740,13 @@ static char *rbd_segment_name(struct rbd_device
> *rbd_dev, u64 offset)
>  	u64 segment;
>  	int ret;
> 
> -	name = kmalloc(RBD_MAX_SEG_NAME_LEN + 1, GFP_NOIO);
> +	name = kmalloc(MAX_OBJ_NAME_SIZE + 1, GFP_NOIO);
>  	if (!name)
>  		return NULL;
>  	segment = offset >> rbd_dev->header.obj_order;
> -	ret = snprintf(name, RBD_MAX_SEG_NAME_LEN, "%s.%012llx",
> +	ret = snprintf(name, MAX_OBJ_NAME_SIZE + 1, "%s.%012llx",
>  			rbd_dev->header.object_prefix, segment);
> -	if (ret < 0 || ret >= RBD_MAX_SEG_NAME_LEN) {
> +	if (ret < 0 || ret > MAX_OBJ_NAME_SIZE) {
>  		pr_err("error formatting segment name for #%llu (%d)\n",
>  			segment, ret);
>  		kfree(name);
> diff --git a/drivers/block/rbd_types.h b/drivers/block/rbd_types.h
> index cbe77fa..49d77cb 100644
> --- a/drivers/block/rbd_types.h
> +++ b/drivers/block/rbd_types.h
> @@ -46,8 +46,6 @@
>  #define RBD_MIN_OBJ_ORDER       16
>  #define RBD_MAX_OBJ_ORDER       30
> 
> -#define RBD_MAX_SEG_NAME_LEN	128
> -
>  #define RBD_COMP_NONE		0
>  #define RBD_CRYPT_NONE		0
> 
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
