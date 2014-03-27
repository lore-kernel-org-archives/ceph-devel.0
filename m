From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 31/33] libceph: add support for osd primary affinity
Date: Thu, 27 Mar 2014 15:59:57 -0500
Message-ID: <5334914D.5000407@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-32-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:49262 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170AbaC0U7f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 16:59:35 -0400
Received: by mail-ig0-f180.google.com with SMTP id hl1so17287igb.13
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 13:59:35 -0700 (PDT)
In-Reply-To: <1395944299-21970-32-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
> Respond to non-default primary_affinity values accordingly.  (Primary
> affinity allows the admin to shift 'primary responsibility' away from
> specific osds, effectively shifting around the read side of the
> workload and whatever overhead is incurred by peering and writes by
> virtue of being the primary).

The code looks good, I presume it matches the algorithm.
I have a few questions below but nothing serious.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index ed52b47d0ddb..8c596a13c60f 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1589,6 +1589,72 @@ static int raw_to_up_osds(struct ceph_osdmap *osdmap,
>  	return len;
>  }
>  
> +static void apply_primary_affinity(struct ceph_osdmap *osdmap, u32 pps,
> +				   struct ceph_pg_pool_info *pool,
> +				   int *osds, int len, int *primary)
> +{
> +	int i;
> +	int pos = -1;
> +
> +	/*
> +	 * Do we have any non-default primary_affinity values for these
> +	 * osds?
> +	 */
> +	if (!osdmap->osd_primary_affinity)
> +		return;
> +
> +	for (i = 0; i < len; i++) {
> +		if (osds[i] != CRUSH_ITEM_NONE &&
> +		    osdmap->osd_primary_affinity[i] !=
> +					CEPH_OSD_DEFAULT_PRIMARY_AFFINITY) {
> +			break;
> +		}
> +	}
> +	if (i == len)
> +		return;

So if they're all DEFAULT_AFFINITY they you don't bother.

I'm trying to understand what happens if at least one is
DEFAULT and at least one is not DEFAULT.

> +
> +	/*
> +	 * Pick the primary.  Feed both the seed (for the pg) and the
> +	 * osd into the hash/rng so that a proportional fraction of an
> +	 * osd's pgs get rejected as primary.
> +	 */
> +	for (i = 0; i < len; i++) {
> +		int o;
> +		u32 a;

Maybe "osd" and "aff" for osd number and affinity values?

> +
> +		o = osds[i];
> +		if (o == CRUSH_ITEM_NONE)
> +			continue;
> +
> +		a = osdmap->osd_primary_affinity[o];
> +		if (a < CEPH_OSD_MAX_PRIMARY_AFFINITY &&

So CEPH_OSD_MAX_PRIMARY_AFFINITY is actually one more than
the maximum allowed value, right?

> +		    (crush_hash32_2(CRUSH_HASH_RJENKINS1,
> +				    pps, o) >> 16) >= a) {
> +			/*
> +			 * We chose not to use this primary.  Note it
> +			 * anyway as a fallback in case we don't pick
> +			 * anyone else, but keep looking.
> +			 */
> +			if (pos < 0)
> +				pos = i;
> +		} else {
> +			pos = i;
> +			break;
> +		}
> +	}
> +	if (pos < 0)
> +		return;
> +
> +	*primary = osds[pos];
> +
> +	if (ceph_can_shift_osds(pool) && pos > 0) {
> +		/* move the new primary to the front */
> +		for (i = pos; i > 0; i--)
> +			osds[i] = osds[i - 1];
> +		osds[0] = *primary;
> +	}

So the first one *is* the primary, you just renumber them.
I see.

> +}
> +
>  /*
>   * Given up set, apply pg_temp and primary_temp mappings.
>   *
> @@ -1691,6 +1757,8 @@ int ceph_calc_pg_acting(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
>  
>  	len = raw_to_up_osds(osdmap, pool, osds, len, primary);
>  
> +	apply_primary_affinity(osdmap, pps, pool, osds, len, primary);
> +
>  	len = apply_temps(osdmap, pool, pgid, osds, len, primary);
>  
>  	return len;
> 

