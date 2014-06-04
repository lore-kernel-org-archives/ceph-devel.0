From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: fix ida/idr memory leak
Date: Wed, 04 Jun 2014 12:01:56 -0500
Message-ID: <538F5104.4000705@ieee.org>
References: <1401899917-11254-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:46981 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbaFDRBu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jun 2014 13:01:50 -0400
Received: by mail-ie0-f173.google.com with SMTP id lx4so7563049iec.32
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jun 2014 10:01:49 -0700 (PDT)
In-Reply-To: <1401899917-11254-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 06/04/2014 11:38 AM, Ilya Dryomov wrote:
> ida_destroy() needs to be called on module exit to release ida caches.

Looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  drivers/block/rbd.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 94747afc2e78..ecdd4aee173c 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -5464,6 +5464,7 @@ err_out_slab:
>  
>  static void __exit rbd_exit(void)
>  {
> +	ida_destroy(&rbd_dev_id_ida);
>  	rbd_sysfs_cleanup();
>  	if (single_major)
>  		unregister_blkdev(rbd_major, RBD_DRV_NAME);
> 

