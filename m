From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] rbd: fix module sysfs setup/teardown code
Date: Fri, 2 Mar 2012 13:30:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203021329550.6413@cobra.newdream.net>
References: <4F4DA2DC.8010202@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48101 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762Ab2CBVaL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 16:30:11 -0500
In-Reply-To: <4F4DA2DC.8010202@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@newdream.net>

On Tue, 28 Feb 2012, Alex Elder wrote:

> Once rbd_bus_type is registered, it allows an "add" operation via
> the /sys/bus/rbd/add bus attribute, and adding a new rbd device that
> way establishes a connection between the device and rbd_root_dev.
> But rbd_root_dev is not registered until after the rbd_bus_type
> registration is complete.  This could (in principle anyway) result
> in an invalid state.
> 
> Since rbd_root_dev has no tie to rbd_bus_type we can reorder these
> two initializations and never be faced with this scenario.
> 
> In addition, unregister the device in the event the bus registration
> fails at module init time.
> 
> Signed-off-by: Alex Elder <elder@dreamhost.com>
> ---
>  drivers/block/rbd.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index bc539cd..b7c9af5 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2560,19 +2560,21 @@ static int rbd_sysfs_init(void)
>  {
>  	int ret;
> 
> -	ret = bus_register(&rbd_bus_type);
> +	ret = device_register(&rbd_root_dev);
>  	if (ret < 0)
>  		return ret;
> 
> -	ret = device_register(&rbd_root_dev);
> +	ret = bus_register(&rbd_bus_type);
> +	if (ret)
> +		device_unregister(&rbd_root_dev);
> 
>  	return ret;
>  }
> 
>  static void rbd_sysfs_cleanup(void)
>  {
> -	device_unregister(&rbd_root_dev);
>  	bus_unregister(&rbd_bus_type);
> +	device_unregister(&rbd_root_dev);
>  }
> 
>  int __init rbd_init(void)
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
