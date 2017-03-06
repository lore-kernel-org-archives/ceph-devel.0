From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] rbd: supported_features bus attribute
Date: Mon, 6 Mar 2017 16:10:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703061610030.24356@piezo.novalocal>
References: <1488813845-4201-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37153 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753356AbdCFQQi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Mar 2017 11:16:38 -0500
In-Reply-To: <1488813845-4201-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 6 Mar 2017, Ilya Dryomov wrote:
> ... so that userspace can generate meaningful error messages and spell
> out unsupported features that need to be disabled.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Reviewed-by: Sage Weil <sage@redhat.com>

> ---
>  drivers/block/rbd.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4138ed8565c6..8cfbac1e815e 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -120,10 +120,11 @@ static int atomic_dec_return_safe(atomic_t *v)
>  
>  /* Feature bits */
>  
> -#define RBD_FEATURE_LAYERING	(1<<0)
> -#define RBD_FEATURE_STRIPINGV2	(1<<1)
> -#define RBD_FEATURE_EXCLUSIVE_LOCK (1<<2)
> -#define RBD_FEATURE_DATA_POOL (1<<7)
> +#define RBD_FEATURE_LAYERING		(1ULL<<0)
> +#define RBD_FEATURE_STRIPINGV2		(1ULL<<1)
> +#define RBD_FEATURE_EXCLUSIVE_LOCK	(1ULL<<2)
> +#define RBD_FEATURE_DATA_POOL		(1ULL<<7)
> +
>  #define RBD_FEATURES_ALL	(RBD_FEATURE_LAYERING |		\
>  				 RBD_FEATURE_STRIPINGV2 |	\
>  				 RBD_FEATURE_EXCLUSIVE_LOCK |	\
> @@ -499,16 +500,23 @@ static bool rbd_is_lock_owner(struct rbd_device *rbd_dev)
>  	return is_lock_owner;
>  }
>  
> +static ssize_t rbd_supported_features_show(struct bus_type *bus, char *buf)
> +{
> +	return sprintf(buf, "0x%llx\n", RBD_FEATURES_SUPPORTED);
> +}
> +
>  static BUS_ATTR(add, S_IWUSR, NULL, rbd_add);
>  static BUS_ATTR(remove, S_IWUSR, NULL, rbd_remove);
>  static BUS_ATTR(add_single_major, S_IWUSR, NULL, rbd_add_single_major);
>  static BUS_ATTR(remove_single_major, S_IWUSR, NULL, rbd_remove_single_major);
> +static BUS_ATTR(supported_features, S_IRUGO, rbd_supported_features_show, NULL);
>  
>  static struct attribute *rbd_bus_attrs[] = {
>  	&bus_attr_add.attr,
>  	&bus_attr_remove.attr,
>  	&bus_attr_add_single_major.attr,
>  	&bus_attr_remove_single_major.attr,
> +	&bus_attr_supported_features.attr,
>  	NULL,
>  };
>  
> -- 
> 2.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
