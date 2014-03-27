From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 10/33] libceph: fixup error handling in osdmap_apply_incremental()
Date: Thu, 27 Mar 2014 14:49:32 -0500
Message-ID: <533480CC.5060707@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-11-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:39448 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755171AbaC0TtL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 15:49:11 -0400
Received: by mail-ig0-f174.google.com with SMTP id h18so2033303igc.13
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 12:49:11 -0700 (PDT)
In-Reply-To: <1395944299-21970-11-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:17 PM, Ilya Dryomov wrote:
> The existing error handling scheme requires resetting err to -EINVAL
> prior to calling any ceph_decode_* macro.  This is ugly and fragile,
> and there already are a few places where we would return 0 on error,
> due to a missing reset.  Follow osdmap_decode() and fix this by adding
> a special e_inval label to be used by all ceph_decode_* macros.

Same comments as last time.  Otherwise, looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |   66 +++++++++++++++++++++++++++--------------------------
>  1 file changed, 34 insertions(+), 32 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index b70357adbdc0..0fc29a930c06 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -861,19 +861,19 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  	__s64 new_pool_max;
>  	__s32 new_flags, max;
>  	void *start = *p;
> -	int err = -EINVAL;
> +	int err;
>  	u16 version;
>  
>  	dout("%s %p to %p len %d\n", __func__, *p, end, (int)(end - *p));
>  
> -	ceph_decode_16_safe(p, end, version, bad);
> +	ceph_decode_16_safe(p, end, version, e_inval);
>  	if (version != 6) {
>  		pr_warning("got unknown v %d != 6 of inc osdmap\n", version);
> -		goto bad;
> +		goto e_inval;
>  	}
>  
>  	ceph_decode_need(p, end, sizeof(fsid)+sizeof(modified)+2*sizeof(u32),
> -			 bad);
> +			 e_inval);
>  	ceph_decode_copy(p, &fsid, sizeof(fsid));
>  	epoch = ceph_decode_32(p);
>  	BUG_ON(epoch != map->epoch+1);
> @@ -882,7 +882,7 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  	new_flags = ceph_decode_32(p);
>  
>  	/* full map? */
> -	ceph_decode_32_safe(p, end, len, bad);
> +	ceph_decode_32_safe(p, end, len, e_inval);
>  	if (len > 0) {
>  		dout("apply_incremental full map len %d, %p to %p\n",
>  		     len, *p, end);
> @@ -890,13 +890,14 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  	}
>  
>  	/* new crush? */
> -	ceph_decode_32_safe(p, end, len, bad);
> +	ceph_decode_32_safe(p, end, len, e_inval);
>  	if (len > 0) {
> -		dout("apply_incremental new crush map len %d, %p to %p\n",
> -		     len, *p, end);
>  		newcrush = crush_decode(*p, min(*p+len, end));
> -		if (IS_ERR(newcrush))
> -			return ERR_CAST(newcrush);
> +		if (IS_ERR(newcrush)) {
> +			err = PTR_ERR(newcrush);
> +			newcrush = NULL;
> +			goto bad;
> +		}
>  		*p += len;
>  	}
>  
> @@ -906,13 +907,13 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  	if (new_pool_max >= 0)
>  		map->pool_max = new_pool_max;
>  
> -	ceph_decode_need(p, end, 5*sizeof(u32), bad);
> +	ceph_decode_need(p, end, 5*sizeof(u32), e_inval);
>  
>  	/* new max? */
>  	max = ceph_decode_32(p);
>  	if (max >= 0) {
>  		err = osdmap_set_max_osd(map, max);
> -		if (err < 0)
> +		if (err)
>  			goto bad;
>  	}
>  
> @@ -926,11 +927,11 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  	}
>  
>  	/* new_pool */
> -	ceph_decode_32_safe(p, end, len, bad);
> +	ceph_decode_32_safe(p, end, len, e_inval);
>  	while (len--) {
>  		struct ceph_pg_pool_info *pi;
>  
> -		ceph_decode_64_safe(p, end, pool, bad);
> +		ceph_decode_64_safe(p, end, pool, e_inval);
>  		pi = __lookup_pg_pool(&map->pg_pools, pool);
>  		if (!pi) {
>  			pi = kzalloc(sizeof(*pi), GFP_NOFS);
> @@ -947,29 +948,28 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  	}
>  	if (version >= 5) {
>  		err = __decode_pool_names(p, end, map);
> -		if (err < 0)
> +		if (err)
>  			goto bad;
>  	}
>  
>  	/* old_pool */
> -	ceph_decode_32_safe(p, end, len, bad);
> +	ceph_decode_32_safe(p, end, len, e_inval);
>  	while (len--) {
>  		struct ceph_pg_pool_info *pi;
>  
> -		ceph_decode_64_safe(p, end, pool, bad);
> +		ceph_decode_64_safe(p, end, pool, e_inval);
>  		pi = __lookup_pg_pool(&map->pg_pools, pool);
>  		if (pi)
>  			__remove_pg_pool(&map->pg_pools, pi);
>  	}
>  
>  	/* new_up */
> -	err = -EINVAL;
> -	ceph_decode_32_safe(p, end, len, bad);
> +	ceph_decode_32_safe(p, end, len, e_inval);
>  	while (len--) {
>  		u32 osd;
>  		struct ceph_entity_addr addr;
> -		ceph_decode_32_safe(p, end, osd, bad);
> -		ceph_decode_copy_safe(p, end, &addr, sizeof(addr), bad);
> +		ceph_decode_32_safe(p, end, osd, e_inval);
> +		ceph_decode_copy_safe(p, end, &addr, sizeof(addr), e_inval);
>  		ceph_decode_addr(&addr);
>  		pr_info("osd%d up\n", osd);
>  		BUG_ON(osd >= map->max_osd);
> @@ -978,11 +978,11 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  	}
>  
>  	/* new_state */
> -	ceph_decode_32_safe(p, end, len, bad);
> +	ceph_decode_32_safe(p, end, len, e_inval);
>  	while (len--) {
>  		u32 osd;
>  		u8 xorstate;
> -		ceph_decode_32_safe(p, end, osd, bad);
> +		ceph_decode_32_safe(p, end, osd, e_inval);
>  		xorstate = **(u8 **)p;
>  		(*p)++;  /* clean flag */
>  		if (xorstate == 0)
> @@ -994,10 +994,10 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  	}
>  
>  	/* new_weight */
> -	ceph_decode_32_safe(p, end, len, bad);
> +	ceph_decode_32_safe(p, end, len, e_inval);
>  	while (len--) {
>  		u32 osd, off;
> -		ceph_decode_need(p, end, sizeof(u32)*2, bad);
> +		ceph_decode_need(p, end, sizeof(u32)*2, e_inval);
>  		osd = ceph_decode_32(p);
>  		off = ceph_decode_32(p);
>  		pr_info("osd%d weight 0x%x %s\n", osd, off,
> @@ -1008,7 +1008,7 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  	}
>  
>  	/* new_pg_temp */
> -	ceph_decode_32_safe(p, end, len, bad);
> +	ceph_decode_32_safe(p, end, len, e_inval);
>  	while (len--) {
>  		struct ceph_pg_mapping *pg;
>  		int j;
> @@ -1018,22 +1018,22 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  		err = ceph_decode_pgid(p, end, &pgid);
>  		if (err)
>  			goto bad;
> -		ceph_decode_need(p, end, sizeof(u32), bad);
> +		ceph_decode_need(p, end, sizeof(u32), e_inval);
>  		pglen = ceph_decode_32(p);
>  		if (pglen) {
> -			ceph_decode_need(p, end, pglen*sizeof(u32), bad);
> +			ceph_decode_need(p, end, pglen*sizeof(u32), e_inval);
>  
>  			/* removing existing (if any) */
>  			(void) __remove_pg_mapping(&map->pg_temp, pgid);
>  
>  			/* insert */
> -			err = -EINVAL;
>  			if (pglen > (UINT_MAX - sizeof(*pg)) / sizeof(u32))
> -				goto bad;
> -			err = -ENOMEM;
> +				goto e_inval;
>  			pg = kmalloc(sizeof(*pg) + sizeof(u32)*pglen, GFP_NOFS);
> -			if (!pg)
> +			if (!pg) {
> +				err = -ENOMEM;
>  				goto bad;
> +			}
>  			pg->pgid = pgid;
>  			pg->len = pglen;
>  			for (j = 0; j < pglen; j++)
> @@ -1057,6 +1057,8 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  	dout("inc osdmap epoch %d max_osd %d\n", map->epoch, map->max_osd);
>  	return map;
>  
> +e_inval:
> +	err = -EINVAL;
>  bad:
>  	pr_err("corrupt inc osdmap (%d) epoch %d off %d (%p of %p-%p)\n",
>  	       err, epoch, (int)(*p - start), *p, start, end);
> 

