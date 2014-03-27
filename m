From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 27/33] libceph: introduce apply_temps() helper
Date: Thu, 27 Mar 2014 15:41:21 -0500
Message-ID: <53348CF1.7070206@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-28-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:61295 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757369AbaC0UlE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 16:41:04 -0400
Received: by mail-ie0-f169.google.com with SMTP id to1so4055979ieb.0
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 13:41:04 -0700 (PDT)
In-Reply-To: <1395944299-21970-28-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
> apply_temp() helper for applying various temporary mappings (at this
> point only pg_temp mappings) to the up set, therefore transforming it
> into an acting set.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index ee095e07cf98..6d418433d80d 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1590,6 +1590,58 @@ static int raw_to_up_osds(struct ceph_osdmap *osdmap,
>  }
>  
>  /*
> + * Given up set, apply pg_temp mapping.
> + *
> + * Return acting set length.  *primary is set to acting primary osd id,
> + * or -1 if acting set is empty.
> + */
> +static int apply_temps(struct ceph_osdmap *osdmap,
> +		       struct ceph_pg_pool_info *pool, struct ceph_pg pgid,
> +		       int *osds, int len, int *primary)
> +{
> +	struct ceph_pg_mapping *pg;
> +	int temp_len;
> +	int temp_primary;
> +	int i;
> +
> +	/* raw_pg -> pg */
> +	pgid.seed = ceph_stable_mod(pgid.seed, pool->pg_num,
> +				    pool->pg_num_mask);
> +
> +	/* pg_temp? */
> +	pg = __lookup_pg_mapping(&osdmap->pg_temp, pgid);
> +	if (pg) {
> +		temp_len = 0;
> +		temp_primary = -1;
> +
> +		for (i = 0; i < pg->pg_temp.len; i++) {
> +			if (ceph_osd_is_down(osdmap, pg->pg_temp.osds[i])) {
> +				if (ceph_can_shift_osds(pool))
> +					continue;
> +				else
> +					osds[temp_len++] = CRUSH_ITEM_NONE;
> +			} else {
> +				osds[temp_len++] = pg->pg_temp.osds[i];
> +			}
> +		}
> +
> +		/* apply pg_temp's primary */
> +		for (i = 0; i < temp_len; i++) {
> +			if (osds[i] != CRUSH_ITEM_NONE) {
> +				temp_primary = osds[i];
> +				break;
> +			}
> +		}
> +	} else {
> +		temp_len = len;
> +		temp_primary = *primary;
> +	}
> +
> +	*primary = temp_primary;
> +	return temp_len;
> +}
> +
> +/*
>   * Return acting set for given pgid.
>   */
>  int ceph_calc_pg_acting(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
> 

