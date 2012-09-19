From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/9] rbd: get the object prefix for a v2 rbd image
Date: Wed, 19 Sep 2012 11:57:41 -0700
Message-ID: <505A15A5.2090304@inktank.com>
References: <504A6273.7030807@inktank.com> <504A6381.30604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38354 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932282Ab2ISS5o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Sep 2012 14:57:44 -0400
Received: by pbbrr13 with SMTP id rr13so3161525pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Sep 2012 11:57:44 -0700 (PDT)
In-Reply-To: <504A6381.30604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

One minor nit below. Otherwise looks good to me.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/07/2012 02:13 PM, Alex Elder wrote:
> The object prefix of an rbd format 2 image is fetched from the
> server using a "get_object_prefix" method.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 24d12e3..36e848a 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -66,7 +66,8 @@
>
>   #define RBD_SNAP_HEAD_NAME	"-"
>
> -#define	RBD_IMAGE_ID_LEN_MAX	64
> +#define RBD_IMAGE_ID_LEN_MAX	64
> +#define RBD_OBJ_PREFIX_LEN_MAX	64
>
>   /*
>    * An RBD device name will be "rbd#", where the "rbd" comes from
> @@ -2163,6 +2164,42 @@ static int rbd_dev_v2_image_size(struct
> rbd_device *rbd_dev)
>   					&rbd_dev->header.image_size);
>   }
>
> +static int rbd_dev_v2_object_prefix(struct rbd_device *rbd_dev)
> +{
> +	void *reply_buf;
> +	int ret;
> +	void *p;
> +
> +	reply_buf = kzalloc(RBD_OBJ_PREFIX_LEN_MAX, GFP_KERNEL);
> +	if (!reply_buf)
> +		return -ENOMEM;
> +
> +	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
> +				"rbd", "get_object_prefix",
> +				NULL, 0,
> +				reply_buf, RBD_OBJ_PREFIX_LEN_MAX,
> +				CEPH_OSD_FLAG_READ, NULL);
> +	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
> +	if (ret < 0)
> +		goto out;
> +
> +	p = reply_buf;
> +	rbd_dev->header.object_prefix = ceph_extract_encoded_string(&p,
> +						p + RBD_OBJ_PREFIX_LEN_MAX,
> +						NULL, GFP_NOIO);
> +
> +	if (IS_ERR(rbd_dev->header.object_prefix)) {
> +		ret = PTR_ERR(rbd_dev->header.object_prefix);
> +		rbd_dev->header.object_prefix = NULL;
> +	} else
> +		dout("  object_prefix = %s\n", rbd_dev->header.object_prefix);

The else block should use braces as well.

> +
> +out:
> +	kfree(reply_buf);
> +
> +	return ret;
> +}
> +
>   /*
>    * Scan the rbd device's current snapshot list and compare it to the
>    * newly-received snapshot context.  Remove any existing snapshots
> @@ -2690,6 +2727,12 @@ static int rbd_dev_v2_probe(struct rbd_device
> *rbd_dev)
>   	ret = rbd_dev_v2_image_size(rbd_dev);
>   	if (ret < 0)
>   		goto out_err;
> +
> +	/* Get the object prefix (a.k.a. block_name) for the image */
> +
> +	ret = rbd_dev_v2_object_prefix(rbd_dev);
> +	if (ret < 0)
> +		goto out_err;
>   	rbd_dev->image_format = 2;
>
>   	dout("discovered version 2 image, header name is %s\n",
> @@ -2699,6 +2742,8 @@ static int rbd_dev_v2_probe(struct rbd_device
> *rbd_dev)
>   out_err:
>   	kfree(rbd_dev->header_name);
>   	rbd_dev->header_name = NULL;
> +	kfree(rbd_dev->header.object_prefix);
> +	rbd_dev->header.object_prefix = NULL;
>
>   	return ret;
>   }
>

