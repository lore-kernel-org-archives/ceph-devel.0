From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 4/4] rbd: activate v2 image support
Date: Tue, 09 Oct 2012 16:32:21 -0700
Message-ID: <5074B405.90401@inktank.com>
References: <50748FA5.4030508@inktank.com> <507490A2.4000202@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47471 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760Ab2JIXcZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 19:32:25 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so5745707pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 16:32:24 -0700 (PDT)
In-Reply-To: <507490A2.4000202@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 10/09/2012 02:01 PM, Alex Elder wrote:
> Now that v2 images support is fully implemented, have
> rbd_dev_v2_probe() return 0 to indicate a successful probe.
>
> (Note that an image that implements layering will fail
> the probe early because of the feature chekc.)
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 86ab032..6052fff 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3013,7 +3013,7 @@ static int rbd_dev_v2_probe(struct rbd_device
> *rbd_dev)
>       dout("discovered version 2 image, header name is %s\n",
>           rbd_dev->header_name);
>
> -    return -ENOTSUPP;
> +    return 0;
>   out_err:
>       kfree(rbd_dev->header_name);
>       rbd_dev->header_name = NULL;

