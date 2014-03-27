From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 21/33] libceph: primary_affinity infrastructure
Date: Thu, 27 Mar 2014 15:26:42 -0500
Message-ID: <53348982.9010707@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-22-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:56091 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757057AbaC0U0U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 16:26:20 -0400
Received: by mail-ie0-f179.google.com with SMTP id lx4so4021136iec.38
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 13:26:20 -0700 (PDT)
In-Reply-To: <1395944299-21970-22-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
> Add primary_affinity infrastructure.  primary_affinity values are
> stored in an max_osd-sized array, hanging off ceph_osdmap, similar to
> a osd_weight array.
> 
> Introduce {get,set}_primary_affinity() helpers, primarily to return
> CEPH_OSD_DEFAULT_PRIMARY_AFFINITY when no affinity has been set and to
> abstract out osd_primary_affinity array allocation and initialization.

One comment about some constant definitions, but
this looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  include/linux/ceph/osdmap.h |    3 +++
>  include/linux/ceph/rados.h  |    4 ++++
>  net/ceph/debugfs.c          |    5 +++--
>  net/ceph/osdmap.c           |   47 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
> index db4fb6322aae..6e030cb3c9ca 100644
> --- a/include/linux/ceph/osdmap.h
> +++ b/include/linux/ceph/osdmap.h
> @@ -88,6 +88,8 @@ struct ceph_osdmap {
>  	struct rb_root pg_temp;
>  	struct rb_root primary_temp;
>  
> +	u32 *osd_primary_affinity;
> +
>  	struct rb_root pg_pools;
>  	u32 pool_max;
>  
> @@ -134,6 +136,7 @@ static inline bool ceph_osdmap_flag(struct ceph_osdmap *map, int flag)
>  }
>  
>  extern char *ceph_osdmap_state_str(char *str, int len, int state);
> +extern u32 ceph_get_primary_affinity(struct ceph_osdmap *map, int osd);
>  
>  static inline struct ceph_entity_addr *ceph_osd_addr(struct ceph_osdmap *map,
>  						     int osd)
> diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
> index 2caabef8d369..bb6f40c9cb0f 100644
> --- a/include/linux/ceph/rados.h
> +++ b/include/linux/ceph/rados.h
> @@ -133,6 +133,10 @@ extern const char *ceph_osd_state_name(int s);
>  #define CEPH_OSD_IN  0x10000
>  #define CEPH_OSD_OUT 0
>  
> +/* osd primary-affinity.  fixed point value: 0x10000 == baseline */
> +#define CEPH_OSD_MAX_PRIMARY_AFFINITY 0x10000
> +#define CEPH_OSD_DEFAULT_PRIMARY_AFFINITY 0x10000
> +

It seems like these definitions may also belong in a
common header file.  However I know that in some cases
it's necessary to impose limits in the kernel where
none is enforced in user space.

>  /*
>   * osd map flag bits
> diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
> index 612bf55e6a8b..34453a2b4b4d 100644
> --- a/net/ceph/debugfs.c
> +++ b/net/ceph/debugfs.c
> @@ -77,10 +77,11 @@ static int osdmap_show(struct seq_file *s, void *p)
>  		int state = map->osd_state[i];
>  		char sb[64];
>  
> -		seq_printf(s, "osd%d\t%s\t%3d%%\t(%s)\n",
> +		seq_printf(s, "osd%d\t%s\t%3d%%\t(%s)\t%3d%%\n",
>  			   i, ceph_pr_addr(&addr->in_addr),
>  			   ((map->osd_weight[i]*100) >> 16),
> -			   ceph_osdmap_state_str(sb, sizeof(sb), state));
> +			   ceph_osdmap_state_str(sb, sizeof(sb), state),
> +			   ((ceph_get_primary_affinity(map, i)*100) >> 16));
>  	}
>  	for (n = rb_first(&map->pg_temp); n; n = rb_next(n)) {
>  		struct ceph_pg_mapping *pg =
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 0ca7f36e88b4..538b8dd341e8 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -649,6 +649,7 @@ void ceph_osdmap_destroy(struct ceph_osdmap *map)
>  	kfree(map->osd_state);
>  	kfree(map->osd_weight);
>  	kfree(map->osd_addr);
> +	kfree(map->osd_primary_affinity);
>  	kfree(map);
>  }
>  
> @@ -685,6 +686,20 @@ static int osdmap_set_max_osd(struct ceph_osdmap *map, int max)
>  	map->osd_weight = weight;
>  	map->osd_addr = addr;
>  
> +	if (map->osd_primary_affinity) {
> +		u32 *affinity;
> +
> +		affinity = krealloc(map->osd_primary_affinity,
> +				    max*sizeof(*affinity), GFP_NOFS);
> +		if (!affinity)
> +			return -ENOMEM;
> +
> +		for (i = map->max_osd; i < max; i++)
> +			affinity[i] = CEPH_OSD_DEFAULT_PRIMARY_AFFINITY;
> +
> +		map->osd_primary_affinity = affinity;
> +	}
> +
>  	map->max_osd = max;
>  
>  	return 0;
> @@ -912,6 +927,38 @@ static int decode_new_primary_temp(void **p, void *end,
>  	return __decode_primary_temp(p, end, map, true);
>  }
>  
> +u32 ceph_get_primary_affinity(struct ceph_osdmap *map, int osd)
> +{
> +	BUG_ON(osd >= map->max_osd);
> +
> +	if (!map->osd_primary_affinity)
> +		return CEPH_OSD_DEFAULT_PRIMARY_AFFINITY;
> +
> +	return map->osd_primary_affinity[osd];
> +}
> +
> +static int set_primary_affinity(struct ceph_osdmap *map, int osd, u32 aff)
> +{
> +	BUG_ON(osd >= map->max_osd);
> +
> +	if (!map->osd_primary_affinity) {
> +		int i;
> +
> +		map->osd_primary_affinity = kmalloc(map->max_osd*sizeof(u32),
> +						    GFP_NOFS);
> +		if (!map->osd_primary_affinity)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < map->max_osd; i++)
> +			map->osd_primary_affinity[i] =
> +			    CEPH_OSD_DEFAULT_PRIMARY_AFFINITY;
> +	}
> +
> +	map->osd_primary_affinity[osd] = aff;
> +
> +	return 0;
> +}
> +
>  /*
>   * decode a full map.
>   */
> 

