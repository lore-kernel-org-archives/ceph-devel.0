From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 20/33] libceph: primary_temp decode bits
Date: Thu, 27 Mar 2014 15:23:47 -0500
Message-ID: <533488D3.7060008@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-21-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:47950 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756679AbaC0UX0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 16:23:26 -0400
Received: by mail-ie0-f182.google.com with SMTP id y20so4033183ier.27
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 13:23:25 -0700 (PDT)
In-Reply-To: <1395944299-21970-21-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
> Add a common helper to decode both primary_temp (full map, map<pg_t,
> u32>) and new_primary_temp (inc map, same) and switch to it.

The code looks reasonable.  I'll have to assume
it's doing the decoding properly.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index d78c3e5d60f7..0ca7f36e88b4 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -857,6 +857,61 @@ static int decode_new_pg_temp(void **p, void *end, struct ceph_osdmap *map)
>  	return __decode_pg_temp(p, end, map, true);
>  }
>  
> +static int __decode_primary_temp(void **p, void *end, struct ceph_osdmap *map,
> +				 bool incremental)
> +{
> +	u32 n;
> +
> +	ceph_decode_32_safe(p, end, n, e_inval);
> +	while (n--) {
> +		struct ceph_pg pgid;
> +		u32 osd;
> +		int ret;
> +
> +		ret = ceph_decode_pgid(p, end, &pgid);
> +		if (ret)
> +			return ret;
> +
> +		ceph_decode_32_safe(p, end, osd, e_inval);
> +
> +		ret = __remove_pg_mapping(&map->primary_temp, pgid);
> +		BUG_ON(!incremental && ret != -ENOENT);
> +
> +		if (!incremental || osd != (u32)-1) {
> +			struct ceph_pg_mapping *pg;
> +
> +			pg = kzalloc(sizeof(*pg), GFP_NOFS);
> +			if (!pg)
> +				return -ENOMEM;
> +
> +			pg->pgid = pgid;
> +			pg->primary_temp.osd = osd;
> +
> +			ret = __insert_pg_mapping(pg, &map->primary_temp);
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
> +static int decode_primary_temp(void **p, void *end, struct ceph_osdmap *map)
> +{
> +	return __decode_primary_temp(p, end, map, false);
> +}
> +
> +static int decode_new_primary_temp(void **p, void *end,
> +				   struct ceph_osdmap *map)
> +{
> +	return __decode_primary_temp(p, end, map, true);
> +}
> +
>  /*
>   * decode a full map.
>   */
> @@ -927,6 +982,13 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
>  	if (err)
>  		goto bad;
>  
> +	/* primary_temp */
> +	if (struct_v >= 1) {
> +		err = decode_primary_temp(p, end, map);
> +		if (err)
> +			goto bad;
> +	}
> +
>  	/* crush */
>  	ceph_decode_32_safe(p, end, len, e_inval);
>  	map->crush = crush_decode(*p, min(*p + len, end));
> @@ -1127,6 +1189,13 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  	if (err)
>  		goto bad;
>  
> +	/* new_primary_temp */
> +	if (struct_v >= 1) {
> +		err = decode_new_primary_temp(p, end, map);
> +		if (err)
> +			goto bad;
> +	}
> +
>  	/* ignore the rest */
>  	*p = end;
>  
> 

