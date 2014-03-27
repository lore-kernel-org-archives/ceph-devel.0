From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 14/33] libceph: introduce decode{,_new}_pools() and switch
 to them
Date: Thu, 27 Mar 2014 14:56:54 -0500
Message-ID: <53348286.9010903@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-15-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:56856 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755AbaC0T4d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 15:56:33 -0400
Received: by mail-ig0-f181.google.com with SMTP id h18so2060998igc.14
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 12:56:32 -0700 (PDT)
In-Reply-To: <1395944299-21970-15-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
> Consolidate pools (full map, map<u64, pg_pool_t>) and new_pools (inc
> map, same) decoding logic into a common helper and switch to it.

Nice refactoring.

Reviewed-by: Alex Elder <elder@linaro.org>


> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |   94 ++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 57 insertions(+), 37 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index cd8f34abe7b7..d6a569c5508f 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -681,6 +681,55 @@ static int osdmap_set_max_osd(struct ceph_osdmap *map, int max)
>  	return 0;
>  }
>  
> +static int __decode_pools(void **p, void *end, struct ceph_osdmap *map,
> +			  bool incremental)
> +{
> +	u32 n;
> +
> +	ceph_decode_32_safe(p, end, n, e_inval);
> +	while (n--) {
> +		struct ceph_pg_pool_info *pi;
> +		u64 pool;
> +		int ret;
> +
> +		ceph_decode_64_safe(p, end, pool, e_inval);
> +
> +		pi = __lookup_pg_pool(&map->pg_pools, pool);
> +		if (!incremental || !pi) {
> +			pi = kzalloc(sizeof(*pi), GFP_NOFS);
> +			if (!pi)
> +				return -ENOMEM;
> +
> +			pi->id = pool;
> +
> +			ret = __insert_pg_pool(&map->pg_pools, pi);
> +			if (ret) {
> +				kfree(pi);
> +				return ret;
> +			}
> +		}
> +
> +		ret = decode_pool(p, end, pi);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +
> +e_inval:
> +	return -EINVAL;
> +}
> +
> +static int decode_pools(void **p, void *end, struct ceph_osdmap *map)
> +{
> +	return __decode_pools(p, end, map, false);
> +}
> +
> +static int decode_new_pools(void **p, void *end, struct ceph_osdmap *map)
> +{
> +	return __decode_pools(p, end, map, true);
> +}
> +
>  /*
>   * decode a full map.
>   */
> @@ -692,7 +741,6 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
>  	u32 max;
>  	u32 len, i;
>  	int err;
> -	struct ceph_pg_pool_info *pi;
>  
>  	dout("%s %p to %p len %d\n", __func__, *p, end, (int)(end - *p));
>  
> @@ -714,22 +762,10 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
>  	ceph_decode_copy(p, &map->created, sizeof(map->created));
>  	ceph_decode_copy(p, &map->modified, sizeof(map->modified));
>  
> -	ceph_decode_32_safe(p, end, max, e_inval);
> -	while (max--) {
> -		ceph_decode_need(p, end, 8 + 2, e_inval);
> -		pi = kzalloc(sizeof(*pi), GFP_NOFS);
> -		if (!pi) {
> -			err = -ENOMEM;
> -			goto bad;
> -		}
> -		pi->id = ceph_decode_64(p);
> -		err = decode_pool(p, end, pi);
> -		if (err < 0) {
> -			kfree(pi);
> -			goto bad;
> -		}
> -		__insert_pg_pool(&map->pg_pools, pi);
> -	}
> +	/* pools */
> +	err = decode_pools(p, end, map);
> +	if (err)
> +		goto bad;
>  
>  	/* pool_name */
>  	err = decode_pool_names(p, end, map);
> @@ -928,26 +964,10 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  		newcrush = NULL;
>  	}
>  
> -	/* new_pool */
> -	ceph_decode_32_safe(p, end, len, e_inval);
> -	while (len--) {
> -		struct ceph_pg_pool_info *pi;
> -
> -		ceph_decode_64_safe(p, end, pool, e_inval);
> -		pi = __lookup_pg_pool(&map->pg_pools, pool);
> -		if (!pi) {
> -			pi = kzalloc(sizeof(*pi), GFP_NOFS);
> -			if (!pi) {
> -				err = -ENOMEM;
> -				goto bad;
> -			}
> -			pi->id = pool;
> -			__insert_pg_pool(&map->pg_pools, pi);
> -		}
> -		err = decode_pool(p, end, pi);
> -		if (err < 0)
> -			goto bad;
> -	}
> +	/* new_pools */
> +	err = decode_new_pools(p, end, map);
> +	if (err)
> +		goto bad;
>  
>  	/* new_pool_names */
>  	err = decode_pool_names(p, end, map);
> 

