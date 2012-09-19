From: Josh Durgin <joshd@hq.newdream.net>
Subject: Re: [PATCH 9/9] rbd: activate v2 image support
Date: Wed, 19 Sep 2012 12:56:28 -0700
Message-ID: <505A236C.9000103@hq.newdream.net>
References: <504A6273.7030807@inktank.com> <504A63FC.1080005@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49173 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab2ISUGZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Sep 2012 16:06:25 -0400
In-Reply-To: <504A63FC.1080005@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Until layering is implemented, this should report an
error if features is not 0. Layering is feature bit 1.

You can copy the userspace header from ceph.git in
src/include/librbd/features.h to use the same feature macros.

On 09/07/2012 02:15 PM, Alex Elder wrote:
> Now that v2 images support is fully implemented, have
> rbd_dev_v2_probe() return 0 to indicate a successful probe.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b466393..2f83f71 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2973,7 +2973,7 @@ static int rbd_dev_v2_probe(struct rbd_device
> *rbd_dev)
>   	dout("discovered version 2 image, header name is %s\n",
>   		rbd_dev->header_name);
>
> -	return -ENOTSUPP;
> +	return 0;
>   out_err:
>   	kfree(rbd_dev->header_name);
>   	rbd_dev->header_name = NULL;
>

