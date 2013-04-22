From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: activate support for layered images
Date: Mon, 22 Apr 2013 15:24:54 -0700
Message-ID: <5175B8B6.3030908@inktank.com>
References: <51746031.1030109@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f47.google.com ([209.85.210.47]:40015 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab3DVWZj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 18:25:39 -0400
Received: by mail-da0-f47.google.com with SMTP id p1so608624dad.6
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 15:25:38 -0700 (PDT)
In-Reply-To: <51746031.1030109@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/21/2013 02:54 PM, Alex Elder wrote:
> (This patch and the next one are available in the
> "review/wip-enable-layering" branch of the ceph-client
> git respository.)
>
>
> Now that we have most everything in place to support layered rbd
> images, enable support for them in the kernel client.  Issue a
> warning to the log that the support is considered experimental
> whenever a format 2 layered image is mapped.
>
> Note that we also have to claim to support the STRIPINGV2 feature,
> due to a mistake in the way the rbd CLI set up those flags.  This
> feature can work if it has the right parameters, and safeguards
> have been put in place to reject those images that do not have
> compatible parameters.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index d23cc8f..1ddbcdc 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -80,7 +80,7 @@
>
>   /* Features supported by this (client software) implementation. */
>
> -#define RBD_FEATURES_SUPPORTED	(0)
> +#define RBD_FEATURES_SUPPORTED	(RBD_FEATURES_ALL)
>
>   /*
>    * An RBD device name will be "rbd#", where the "rbd" comes from
> @@ -4723,6 +4723,8 @@ static int rbd_dev_v2_probe(struct rbd_device
> *rbd_dev)
>   		ret = rbd_dev_v2_parent_info(rbd_dev);
>   		if (ret)
>   			goto out_err;
> +		rbd_warn(rbd_dev, "WARNING: layered rbd image support "
> +					"is EXPERIMENTAL!");

Maybe add "for the kernel rbd driver" or something, since librbd
support isn't experimental. If you're removing this warning soon
it doesn't matter though. Either way is fine with me.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>


