From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 28/33] libceph: switch ceph_calc_pg_acting() to new helpers
Date: Thu, 27 Mar 2014 15:49:10 -0500
Message-ID: <53348EC6.1070504@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-29-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:61274 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757309AbaC0Usu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 16:48:50 -0400
Received: by mail-ig0-f174.google.com with SMTP id h18so10263igc.1
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 13:48:49 -0700 (PDT)
In-Reply-To: <1395944299-21970-29-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
> Switch ceph_calc_pg_acting() to new helpers: pg_to_raw_osds(),
> raw_to_up_osds() and apply_temps().

So that's why you have a temp map in each osdmap.
The result is pretty clean and you eliminate the
local rawosds array.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  include/linux/ceph/osdmap.h |    2 +-
>  net/ceph/osdmap.c           |   51 ++++++++++++++++++++++++++++++++-----------
>  2 files changed, 39 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
> index 4e28c1e5d62f..b0c8f8490663 100644
> --- a/include/linux/ceph/osdmap.h
> +++ b/include/linux/ceph/osdmap.h
> @@ -212,7 +212,7 @@ extern int ceph_oloc_oid_to_pg(struct ceph_osdmap *osdmap,
>  
>  extern int ceph_calc_pg_acting(struct ceph_osdmap *osdmap,
>  			       struct ceph_pg pgid,
> -			       int *acting);
> +			       int *osds);
>  extern int ceph_calc_pg_primary(struct ceph_osdmap *osdmap,
>  				struct ceph_pg pgid);
>  
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 6d418433d80d..1963623bd488 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1642,24 +1642,49 @@ static int apply_temps(struct ceph_osdmap *osdmap,
>  }
>  
>  /*
> - * Return acting set for given pgid.
> + * Calculate acting set for given pgid.
> + *
> + * Return acting set length, or error.
>   */
>  int ceph_calc_pg_acting(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
> -			int *acting)
> +			int *osds)
>  {
> -	int rawosds[CEPH_PG_MAX_SIZE], *osds;
> -	int i, o, num = CEPH_PG_MAX_SIZE;
> +	struct ceph_pg_pool_info *pool;
> +	u32 pps;
> +	int len;
> +	int primary;
>  
> -	osds = calc_pg_raw(osdmap, pgid, rawosds, &num);
> -	if (!osds)
> -		return -1;
> +	pool = __lookup_pg_pool(&osdmap->pg_pools, pgid.pool);
> +	if (!pool)
> +		return 0;
>  
> -	/* primary is first up osd */
> -	o = 0;
> -	for (i = 0; i < num; i++)
> -		if (ceph_osd_is_up(osdmap, osds[i]))
> -			acting[o++] = osds[i];
> -	return o;
> +	if (pool->flags & CEPH_POOL_FLAG_HASHPSPOOL) {
> +		/* hash pool id and seed so that pool PGs do not overlap */
> +		pps = crush_hash32_2(CRUSH_HASH_RJENKINS1,
> +				     ceph_stable_mod(pgid.seed, pool->pgp_num,
> +						     pool->pgp_num_mask),
> +				     pgid.pool);
> +	} else {
> +		/*
> +		 * legacy ehavior: add ps and pool together.  this is

Typo "behavior"

> +		 * not a great approach because the PGs from each pool
> +		 * will overlap on top of each other: 0.5 == 1.4 ==
> +		 * 2.3 == ...
> +		 */
> +		pps = ceph_stable_mod(pgid.seed, pool->pgp_num,
> +				      pool->pgp_num_mask) +
> +			(unsigned)pgid.pool;
> +	}
> +
> +	len = pg_to_raw_osds(osdmap, pool, pgid, pps, osds);
> +	if (len < 0)
> +		return len;
> +
> +	len = raw_to_up_osds(osdmap, pool, osds, len, &primary);
> +
> +	len = apply_temps(osdmap, pool, pgid, osds, len, &primary);
> +
> +	return len;
>  }
>  
>  /*
> 

