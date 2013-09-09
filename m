From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH v3 5/5] rbd: fix error handling from rbd_snap_name()
Date: Mon, 09 Sep 2013 08:49:07 -0500
Message-ID: <522DD1D3.2040805@linaro.org>
References: <1378711022-20158-1-git-send-email-josh.durgin@inktank.com> <1378711022-20158-6-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:44159 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab3IINtD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Sep 2013 09:49:03 -0400
Received: by mail-oa0-f43.google.com with SMTP id i10so6440681oag.2
        for <ceph-devel@vger.kernel.org>; Mon, 09 Sep 2013 06:49:02 -0700 (PDT)
In-Reply-To: <1378711022-20158-6-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 09/09/2013 02:17 AM, Josh Durgin wrote:
> rbd_snap_name() calls rbd_dev_v{1,2}_snap_name() depending on the
> format of the image. The format 1 version returns NULL on error, which
> is handled by the caller. The format 2 version returns an ERR_PTR,
> which the caller of rbd_snap_name() does not expect.
> 
> Fortunately this is unlikely to occur in practice because
> rbd_snap_id_by_name() is called before rbd_snap_name(). This would hit
> similar errors to rbd_snap_name() (like the snapshot not existing) and
> return early, so rbd_snap_name() would not hit an error unless the
> snapshot was removed between the two calls or memory was exhausted.
> 
> Use an ERR_PTR in rbd_dev_v1_snap_name() so that the specific error
> can be propagated, and it is consistent with rbd_dev_v2_snap_name().
> Handle the ERR_PTR in the only rbd_snap_name() caller.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Suggested-by: Alex Elder <alex.elder@linaro.org>
> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
> ---
>  drivers/block/rbd.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 226fa04..16384b7 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -927,12 +927,14 @@ static const char *rbd_dev_v1_snap_name(struct rbd_device *rbd_dev,
>  					u64 snap_id)
>  {
>  	u32 which;
> +	const char *snap_name;
>  
>  	which = rbd_dev_snap_index(rbd_dev, snap_id);
>  	if (which == BAD_SNAP_INDEX)
> -		return NULL;
> +		return ERR_PTR(-ENOENT);
>  
> -	return _rbd_dev_v1_snap_name(rbd_dev, which);
> +	snap_name = _rbd_dev_v1_snap_name(rbd_dev, which);
> +	return snap_name ? snap_name : ERR_PTR(-ENOMEM);
>  }
>  
>  static const char *rbd_snap_name(struct rbd_device *rbd_dev, u64 snap_id)
> @@ -4163,8 +4165,8 @@ static int rbd_dev_spec_update(struct rbd_device *rbd_dev)
>  	/* Look up the snapshot name, and make a copy */
>  
>  	snap_name = rbd_snap_name(rbd_dev, spec->snap_id);
> -	if (!snap_name) {
> -		ret = -ENOMEM;
> +	if (IS_ERR(snap_name)) {
> +		ret = PTR_ERR(snap_name);
>  		goto out_err;
>  	}
>  
> 

