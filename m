From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 32/33] libceph: redo ceph_calc_pg_primary() in terms of
 ceph_calc_pg_acting()
Date: Thu, 27 Mar 2014 16:04:22 -0500
Message-ID: <53349256.9090804@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-33-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35745 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756747AbaC0VEA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 17:04:00 -0400
Received: by mail-ig0-f182.google.com with SMTP id uy17so23576igb.9
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 14:04:00 -0700 (PDT)
In-Reply-To: <1395944299-21970-33-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
> Reimplement ceph_calc_pg_primary() in terms of ceph_calc_pg_acting()
> and get rid of the now unused calc_pg_raw().

I'll be honest, my review of this one isn't very
solid but it looks OK to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |   79 +++--------------------------------------------------
>  1 file changed, 4 insertions(+), 75 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 8c596a13c60f..f0567d8ca683 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1449,71 +1449,6 @@ static int do_crush(struct ceph_osdmap *map, int ruleno, int x,
>  }
>  
>  /*
> - * Calculate raw osd vector for the given pgid.  Return pointer to osd
> - * array, or NULL on failure.
> - */
> -static int *calc_pg_raw(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
> -			int *osds, int *num)
> -{
> -	struct ceph_pg_mapping *pg;
> -	struct ceph_pg_pool_info *pool;
> -	int ruleno;
> -	int r;
> -	u32 pps;
> -
> -	pool = __lookup_pg_pool(&osdmap->pg_pools, pgid.pool);
> -	if (!pool)
> -		return NULL;
> -
> -	/* pg_temp? */
> -	pgid.seed = ceph_stable_mod(pgid.seed, pool->pg_num,
> -				    pool->pg_num_mask);
> -	pg = __lookup_pg_mapping(&osdmap->pg_temp, pgid);
> -	if (pg) {
> -		*num = pg->pg_temp.len;
> -		return pg->pg_temp.osds;
> -	}
> -
> -	/* crush */
> -	ruleno = crush_find_rule(osdmap->crush, pool->crush_ruleset,
> -				 pool->type, pool->size);
> -	if (ruleno < 0) {
> -		pr_err("no crush rule pool %lld ruleset %d type %d size %d\n",
> -		       pgid.pool, pool->crush_ruleset, pool->type,
> -		       pool->size);
> -		return NULL;
> -	}
> -
> -	if (pool->flags & CEPH_POOL_FLAG_HASHPSPOOL) {
> -		/* hash pool id and seed sothat pool PGs do not overlap */
> -		pps = crush_hash32_2(CRUSH_HASH_RJENKINS1,
> -				     ceph_stable_mod(pgid.seed, pool->pgp_num,
> -						     pool->pgp_num_mask),
> -				     pgid.pool);
> -	} else {
> -		/*
> -		 * legacy ehavior: add ps and pool together.  this is
> -		 * not a great approach because the PGs from each pool
> -		 * will overlap on top of each other: 0.5 == 1.4 ==
> -		 * 2.3 == ...
> -		 */
> -		pps = ceph_stable_mod(pgid.seed, pool->pgp_num,
> -				      pool->pgp_num_mask) +
> -			(unsigned)pgid.pool;
> -	}
> -	r = do_crush(osdmap, ruleno, pps, osds, min_t(int, pool->size, *num),
> -		     osdmap->osd_weight, osdmap->max_osd);
> -	if (r < 0) {
> -		pr_err("error %d from crush rule: pool %lld ruleset %d type %d"
> -		       " size %d\n", r, pgid.pool, pool->crush_ruleset,
> -		       pool->type, pool->size);
> -		return NULL;
> -	}
> -	*num = r;
> -	return osds;
> -}
> -
> -/*
>   * Calculate raw (crush) set for given pgid.
>   *
>   * Return raw set length, or error.
> @@ -1769,17 +1704,11 @@ int ceph_calc_pg_acting(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
>   */
>  int ceph_calc_pg_primary(struct ceph_osdmap *osdmap, struct ceph_pg pgid)
>  {
> -	int rawosds[CEPH_PG_MAX_SIZE], *osds;
> -	int i, num = CEPH_PG_MAX_SIZE;
> +	int osds[CEPH_PG_MAX_SIZE];
> +	int primary;
>  
> -	osds = calc_pg_raw(osdmap, pgid, rawosds, &num);
> -	if (!osds)
> -		return -1;
> +	ceph_calc_pg_acting(osdmap, pgid, osds, &primary);
>  
> -	/* primary is first up osd */
> -	for (i = 0; i < num; i++)
> -		if (ceph_osd_is_up(osdmap, osds[i]))
> -			return osds[i];
> -	return -1;
> +	return primary;
>  }
>  EXPORT_SYMBOL(ceph_calc_pg_primary);
> 

