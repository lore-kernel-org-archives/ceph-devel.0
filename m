From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 8/9] rbd: fix ceph_pg_poolid_by_name()
Date: Fri, 14 Dec 2012 21:17:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212142116220.23307@cobra.newdream.net>
References: <50CA0915.1090801@inktank.com> <50CA0A3E.7040501@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42328 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab2LOFRx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Dec 2012 00:17:53 -0500
In-Reply-To: <50CA0A3E.7040501@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Most of the code uses int64_t/__s64 for the pool id, although in a few 
cases we screwed up and limited it to 32 bits.  In reality, that's way 
overkill anyway; we could have left it at 32 bits to begin with.

My first instinct would be to change the return type to long long or s64 
and avoid the use magic #defines...



On Thu, 13 Dec 2012, Alex Elder wrote:

> Currently ceph_pg_poolid_by_name() returns an int, which is used to
> encode a ceph pool id.  This could be a problem because a pool id
> (at least in some cases) is a 64-bit value.  We have a defined pool
> id value that represents "no pool," and that's a very sensible
> return value here.
> 
> This patch changes ceph_pg_poolid_by_name() to return a 64-bit
> pool id value, or CEPH_NOPOOL if the named pool is not found.
> 
> The patch also gratuitously renames the function, separating "pool"
> from "id" in the name by an underscore.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c         |    6 +++---
>  include/linux/ceph/osdmap.h |    2 +-
>  net/ceph/osdmap.c           |   14 ++++++++------
>  3 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4daa400..706824b 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3642,11 +3642,11 @@ static ssize_t rbd_add(struct bus_type *bus,
>  	ceph_opts = NULL;	/* rbd_dev client now owns this */
> 
>  	/* pick the pool */
> +	rc = -ENOENT;
>  	osdc = &rbdc->client->osdc;
> -	rc = ceph_pg_poolid_by_name(osdc->osdmap, spec->pool_name);
> -	if (rc < 0)
> +	spec->pool_id = ceph_pg_pool_id_by_name(osdc->osdmap, spec->pool_name);
> +	if (spec->pool_id == CEPH_NOPOOL)
>  		goto err_out_client;
> -	spec->pool_id = (u64) rc;
> 
>  	rbd_dev = rbd_dev_create(rbdc, spec);
>  	if (!rbd_dev)
> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
> index 5ea57ba..c841396 100644
> --- a/include/linux/ceph/osdmap.h
> +++ b/include/linux/ceph/osdmap.h
> @@ -124,6 +124,6 @@ extern int ceph_calc_pg_primary(struct ceph_osdmap
> *osdmap,
>  				struct ceph_pg pgid);
> 
>  extern const char *ceph_pg_pool_name_by_id(struct ceph_osdmap *map, u64
> id);
> -extern int ceph_pg_poolid_by_name(struct ceph_osdmap *map, const char
> *name);
> +extern __u64 ceph_pg_pool_id_by_name(struct ceph_osdmap *map, const
> char *name);
> 
>  #endif
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index de73214..27e904e 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -485,19 +485,21 @@ const char *ceph_pg_pool_name_by_id(struct
> ceph_osdmap *map, u64 id)
>  }
>  EXPORT_SYMBOL(ceph_pg_pool_name_by_id);
> 
> -int ceph_pg_poolid_by_name(struct ceph_osdmap *map, const char *name)
> +__u64 ceph_pg_pool_id_by_name(struct ceph_osdmap *map, const char *name)
>  {
>  	struct rb_node *rbp;
> 
>  	for (rbp = rb_first(&map->pg_pools); rbp; rbp = rb_next(rbp)) {
> -		struct ceph_pg_pool_info *pi =
> -			rb_entry(rbp, struct ceph_pg_pool_info, node);
> +		struct ceph_pg_pool_info *pi;
> +
> +		pi = rb_entry(rbp, struct ceph_pg_pool_info, node);
>  		if (pi->name && strcmp(pi->name, name) == 0)
> -			return pi->id;
> +			return (__u64) pi->id;
>  	}
> -	return -ENOENT;
> +
> +	return CEPH_NOPOOL;
>  }
> -EXPORT_SYMBOL(ceph_pg_poolid_by_name);
> +EXPORT_SYMBOL(ceph_pg_pool_id_by_name);
> 
>  static void __remove_pg_pool(struct rb_root *root, struct
> ceph_pg_pool_info *pi)
>  {
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
