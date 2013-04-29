From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 5/7] rbd: make rbd_dev_destroy() match rbd_dev_create()
Date: Mon, 29 Apr 2013 08:58:47 -0700
Message-ID: <517E98B7.6090407@inktank.com>
References: <517AC047.6060000@inktank.com> <517AC0D0.30708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:43351 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757284Ab3D2P61 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 11:58:27 -0400
Received: by mail-pd0-f181.google.com with SMTP id q10so1333206pdj.40
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 08:58:27 -0700 (PDT)
In-Reply-To: <517AC0D0.30708@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/26/2013 11:00 AM, Alex Elder wrote:
> Currently, rbd_dev_destroy() does more than just the inverse of what
> rbd_dev_create() does.  Stop doing that, and move the two extra
> things it does into the three call sites.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 63040fd..0356bba 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3425,8 +3425,6 @@ static struct rbd_device *rbd_dev_create(struct
> rbd_client *rbdc,
>
>   static void rbd_dev_destroy(struct rbd_device *rbd_dev)
>   {
> -	rbd_spec_put(rbd_dev->parent_spec);
> -	kfree(rbd_dev->header_name);
>   	rbd_put_client(rbd_dev->rbd_client);
>   	rbd_spec_put(rbd_dev->spec);
>   	kfree(rbd_dev);
> @@ -4784,6 +4782,8 @@ static int rbd_dev_probe_finish(struct rbd_device
> *rbd_dev)
>   	return ret;
>
>   err_out_parent:
> +	rbd_spec_put(rbd_dev->parent_spec);
> +	kfree(rbd_dev->header_name);
>   	rbd_dev_destroy(parent);
>   err_out_spec:
>   	rbd_spec_put(parent_spec);
> @@ -4905,6 +4905,8 @@ static ssize_t rbd_add(struct bus_type *bus,
>
>   	return count;
>   err_out_rbd_dev:
> +	rbd_spec_put(rbd_dev->parent_spec);
> +	kfree(rbd_dev->header_name);
>   	rbd_dev_destroy(rbd_dev);
>   err_out_client:
>   	rbd_put_client(rbdc);
> @@ -4955,6 +4957,8 @@ static void rbd_dev_release(struct device *dev)
>   	/* done with the id, and with the rbd_dev */
>   	rbd_dev_id_put(rbd_dev);
>   	rbd_assert(rbd_dev->rbd_client != NULL);
> +	rbd_spec_put(rbd_dev->parent_spec);
> +	kfree(rbd_dev->header_name);
>   	rbd_dev_destroy(rbd_dev);
>
>   	/* release module ref */
>

