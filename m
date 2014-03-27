From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 16/33] libceph: introduce decode{,_new}_pg_temp() and
 switch to them
Date: Thu, 27 Mar 2014 15:05:00 -0500
Message-ID: <5334846C.8050805@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-17-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:39922 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757221AbaC0UEi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 16:04:38 -0400
Received: by mail-ig0-f178.google.com with SMTP id hn18so2068178igb.11
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 13:04:38 -0700 (PDT)
In-Reply-To: <1395944299-21970-17-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
> Consolidate pg_temp (full map, map<pg_t, vector<u32>>) and new_pg_temp
> (inc map, same) decoding logic into a common helper and switch to it.

Again, it's nice to see this kind of refactoring being done.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>


> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |  139 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 67 insertions(+), 72 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 4565c72fec5c..0134df3639d2 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -732,6 +732,67 @@ static int decode_new_pools(void **p, void *end, struct ceph_osdmap *map)
>  	return __decode_pools(p, end, map, true);
>  }
>  
> +static int __decode_pg_temp(void **p, void *end, struct ceph_osdmap *map,
> +			    bool incremental)
> +{
> +	u32 n;
> +
> +	ceph_decode_32_safe(p, end, n, e_inval);
> +	while (n--) {
> +		struct ceph_pg pgid;
> +		u32 len, i;
> +		int ret;
> +
> +		ret = ceph_decode_pgid(p, end, &pgid);
> +		if (ret)
> +			return ret;
> +
> +		ceph_decode_32_safe(p, end, len, e_inval);
> +
> +		ret = __remove_pg_mapping(&map->pg_temp, pgid);
> +		BUG_ON(!incremental && ret != -ENOENT);
> +
> +		if (!incremental || len > 0) {
> +			struct ceph_pg_mapping *pg;
> +
> +			ceph_decode_need(p, end, len*sizeof(u32), e_inval);
> +
> +			if (len > (UINT_MAX - sizeof(*pg)) / sizeof(u32))
> +				return -EINVAL;
> +
> +			pg = kzalloc(sizeof(*pg) + len*sizeof(u32), GFP_NOFS);
> +			if (!pg)
> +				return -ENOMEM;
> +
> +			pg->pgid = pgid;
> +			pg->len = len;
> +			for (i = 0; i < len; i++)
> +				pg->osds[i] = ceph_decode_32(p);
> +
> +			ret = __insert_pg_mapping(pg, &map->pg_temp);
> +			if (ret) {
> +				kfree(pg);
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +
> +e_inval:
> +	return -EINVAL;
> +}
> +
> +static int decode_pg_temp(void **p, void *end, struct ceph_osdmap *map)
> +{
> +	return __decode_pg_temp(p, end, map, false);
> +}
> +
> +static int decode_new_pg_temp(void **p, void *end, struct ceph_osdmap *map)
> +{
> +	return __decode_pg_temp(p, end, map, true);
> +}
> +
>  /*
>   * decode a full map.
>   */
> @@ -804,36 +865,9 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
>  		ceph_decode_addr(&map->osd_addr[i]);
>  
>  	/* pg_temp */
> -	ceph_decode_32_safe(p, end, len, e_inval);
> -	for (i = 0; i < len; i++) {
> -		int n, j;
> -		struct ceph_pg pgid;
> -		struct ceph_pg_mapping *pg;
> -
> -		err = ceph_decode_pgid(p, end, &pgid);
> -		if (err)
> -			goto bad;
> -		ceph_decode_need(p, end, sizeof(u32), e_inval);
> -		n = ceph_decode_32(p);
> -		if (n > (UINT_MAX - sizeof(*pg)) / sizeof(u32))
> -			goto e_inval;
> -		ceph_decode_need(p, end, n * sizeof(u32), e_inval);
> -		pg = kmalloc(sizeof(*pg) + n*sizeof(u32), GFP_NOFS);
> -		if (!pg) {
> -			err = -ENOMEM;
> -			goto bad;
> -		}
> -		pg->pgid = pgid;
> -		pg->len = n;
> -		for (j = 0; j < n; j++)
> -			pg->osds[j] = ceph_decode_32(p);
> -
> -		err = __insert_pg_mapping(pg, &map->pg_temp);
> -		if (err)
> -			goto bad;
> -		dout(" added pg_temp %lld.%x len %d\n", pgid.pool, pgid.seed,
> -		     len);
> -	}
> +	err = decode_pg_temp(p, end, map);
> +	if (err)
> +		goto bad;
>  
>  	/* crush */
>  	ceph_decode_32_safe(p, end, len, e_inval);
> @@ -1032,48 +1066,9 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  	}
>  
>  	/* new_pg_temp */
> -	ceph_decode_32_safe(p, end, len, e_inval);
> -	while (len--) {
> -		struct ceph_pg_mapping *pg;
> -		int j;
> -		struct ceph_pg pgid;
> -		u32 pglen;
> -
> -		err = ceph_decode_pgid(p, end, &pgid);
> -		if (err)
> -			goto bad;
> -		ceph_decode_need(p, end, sizeof(u32), e_inval);
> -		pglen = ceph_decode_32(p);
> -		if (pglen) {
> -			ceph_decode_need(p, end, pglen*sizeof(u32), e_inval);
> -
> -			/* removing existing (if any) */
> -			(void) __remove_pg_mapping(&map->pg_temp, pgid);
> -
> -			/* insert */
> -			if (pglen > (UINT_MAX - sizeof(*pg)) / sizeof(u32))
> -				goto e_inval;
> -			pg = kmalloc(sizeof(*pg) + sizeof(u32)*pglen, GFP_NOFS);
> -			if (!pg) {
> -				err = -ENOMEM;
> -				goto bad;
> -			}
> -			pg->pgid = pgid;
> -			pg->len = pglen;
> -			for (j = 0; j < pglen; j++)
> -				pg->osds[j] = ceph_decode_32(p);
> -			err = __insert_pg_mapping(pg, &map->pg_temp);
> -			if (err) {
> -				kfree(pg);
> -				goto bad;
> -			}
> -			dout(" added pg_temp %lld.%x len %d\n", pgid.pool,
> -			     pgid.seed, pglen);
> -		} else {
> -			/* remove */
> -			__remove_pg_mapping(&map->pg_temp, pgid);
> -		}
> -	}
> +	err = decode_new_pg_temp(p, end, map);
> +	if (err)
> +		goto bad;
>  
>  	/* ignore the rest */
>  	*p = end;
> 

