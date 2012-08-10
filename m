From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: drop dev reference on error in rbd_open()
Date: Fri, 10 Aug 2012 12:36:29 -0700
Message-ID: <502562BD.9000209@inktank.com>
References: <50255E0F.4070406@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65288 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876Ab2HJTgf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Aug 2012 15:36:35 -0400
Received: by pbbrr13 with SMTP id rr13so3183382pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 10 Aug 2012 12:36:35 -0700 (PDT)
In-Reply-To: <50255E0F.4070406@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 08/10/2012 12:16 PM, Alex Elder wrote:
> If a read-only rbd device is opened for writing in rbd_open(), it
> returns without dropping the just-acquired device reference.
>
> Fix this by moving the read-only check before getting the reference.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> Index: b/drivers/block/rbd.c
> ===================================================================
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -246,13 +246,12 @@ static int rbd_open(struct block_device
>   {
>       struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
>
> -    rbd_get_dev(rbd_dev);
> -
> -    set_device_ro(bdev, rbd_dev->read_only);
> -
>       if ((mode & FMODE_WRITE) && rbd_dev->read_only)
>           return -EROFS;
>
> +    rbd_get_dev(rbd_dev);
> +    set_device_ro(bdev, rbd_dev->read_only);
> +
>       return 0;
>   }

