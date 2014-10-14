From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 2/3] rbd: rbd workqueues need a resque worker
Date: Tue, 14 Oct 2014 08:57:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410140857500.10462@cobra.newdream.net>
References: <1412965626-11165-1-git-send-email-idryomov@redhat.com> <1412965626-11165-3-git-send-email-idryomov@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36089 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932229AbaJNP56 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Oct 2014 11:57:58 -0400
In-Reply-To: <1412965626-11165-3-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org, Micha Krause <micha@krausam.de>

Reviewed-by: Sage Weil <sage@redhat.com>

On Fri, 10 Oct 2014, Ilya Dryomov wrote:

> Need to use WQ_MEM_RECLAIM for our workqueues to prevent I/O lockups
> under memory pressure - we sit on the memory reclaim path.
> 
> Cc: stable@vger.kernel.org # 3.17, needs backporting for 3.16
> Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
> Tested-by: Micha Krause <micha@krausam.de>
> ---
>  drivers/block/rbd.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 7712ae65753c..0a54c588e433 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -5242,7 +5242,8 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
>  	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
>  	set_disk_ro(rbd_dev->disk, rbd_dev->mapping.read_only);
>  
> -	rbd_dev->rq_wq = alloc_workqueue("%s", 0, 0, rbd_dev->disk->disk_name);
> +	rbd_dev->rq_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0,
> +					 rbd_dev->disk->disk_name);
>  	if (!rbd_dev->rq_wq) {
>  		ret = -ENOMEM;
>  		goto err_out_mapping;
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
