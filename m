From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 22/33] libceph: primary_affinity decode bits
Date: Thu, 27 Mar 2014 15:31:29 -0500
Message-ID: <53348AA1.2030806@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-23-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:44178 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086AbaC0UbH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 16:31:07 -0400
Received: by mail-ie0-f171.google.com with SMTP id ar20so4030088iec.30
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 13:31:07 -0700 (PDT)
In-Reply-To: <1395944299-21970-23-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
> Add two helpers to decode primary_affinity (full map, vector<u32>) and
> new_primary_affinity (inc map, map<u32, u32>) and switch to them.

One comment below, but otherwise looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 538b8dd341e8..3ac2098972ea 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -959,6 +959,59 @@ static int set_primary_affinity(struct ceph_osdmap *map, int osd, u32 aff)
>  	return 0;
>  }
>  
> +static int decode_primary_affinity(void **p, void *end,
> +				   struct ceph_osdmap *map)
> +{
> +	u32 len, i;
> +
> +	ceph_decode_32_safe(p, end, len, e_inval);
> +	if (len == 0) {
> +		kfree(map->osd_primary_affinity);
> +		map->osd_primary_affinity = NULL;
> +		return 0;
> +	}
> +
> +	ceph_decode_need(p, end, map->max_osd*sizeof(u32), e_inval);
> +
> +	BUG_ON(len != map->max_osd);

BUG() here is too much; it should I think just return an error instead.
The test could be done earlier too, prior to ceph_decode_need().

> +	for (i = 0; i < map->max_osd; i++) {
> +		int ret;
> +
> +		ret = set_primary_affinity(map, i, ceph_decode_32(p));
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
> +static int decode_new_primary_affinity(void **p, void *end,
> +				       struct ceph_osdmap *map)
> +{
> +	u32 n;
> +
> +	ceph_decode_32_safe(p, end, n, e_inval);
> +	while (n--) {
> +		u32 osd, aff;
> +		int ret;
> +
> +		ceph_decode_32_safe(p, end, osd, e_inval);
> +		ceph_decode_32_safe(p, end, aff, e_inval);
> +
> +		ret = set_primary_affinity(map, osd, aff);
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
>  /*
>   * decode a full map.
>   */
> @@ -1036,6 +1089,17 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
>  			goto bad;
>  	}
>  
> +	/* primary_affinity */
> +	if (struct_v >= 2) {
> +		err = decode_primary_affinity(p, end, map);
> +		if (err)
> +			goto bad;
> +	} else {
> +		/* XXX can this happen? */
> +		kfree(map->osd_primary_affinity);
> +		map->osd_primary_affinity = NULL;
> +	}
> +
>  	/* crush */
>  	ceph_decode_32_safe(p, end, len, e_inval);
>  	map->crush = crush_decode(*p, min(*p + len, end));
> @@ -1243,6 +1307,13 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  			goto bad;
>  	}
>  
> +	/* new_primary_affinity */
> +	if (struct_v >= 2) {
> +		err = decode_new_primary_affinity(p, end, map);
> +		if (err)
> +			goto bad;
> +	}
> +
>  	/* ignore the rest */
>  	*p = end;
>  
> 

