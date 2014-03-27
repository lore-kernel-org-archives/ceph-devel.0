From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 15/33] libceph: switch osdmap_set_max_osd() to krealloc()
Date: Thu, 27 Mar 2014 14:59:24 -0500
Message-ID: <5334831C.3060207@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-16-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:45784 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279AbaC0T7D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 15:59:03 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so3942053ieb.40
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 12:59:02 -0700 (PDT)
In-Reply-To: <1395944299-21970-16-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
> Use krealloc() instead of rolling our own.  (krealloc() with a NULL
> first argument acts as a kmalloc()).  Properly initalize the new array
> elements.  This is needed to make future additions to osdmap easier.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |   32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index d6a569c5508f..4565c72fec5c 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -646,38 +646,40 @@ void ceph_osdmap_destroy(struct ceph_osdmap *map)
>  }
>  
>  /*
> - * adjust max osd value.  reallocate arrays.
> + * Adjust max_osd value, (re)allocate arrays.
> + *
> + * The new elements are properly initialized.
>   */
>  static int osdmap_set_max_osd(struct ceph_osdmap *map, int max)
>  {
>  	u8 *state;
> -	struct ceph_entity_addr *addr;
>  	u32 *weight;
> +	struct ceph_entity_addr *addr;
> +	int i;
>  
> -	state = kcalloc(max, sizeof(*state), GFP_NOFS);
> -	addr = kcalloc(max, sizeof(*addr), GFP_NOFS);
> -	weight = kcalloc(max, sizeof(*weight), GFP_NOFS);
> -	if (state == NULL || addr == NULL || weight == NULL) {
> +	state = krealloc(map->osd_state, max*sizeof(*state), GFP_NOFS);
> +	weight = krealloc(map->osd_weight, max*sizeof(*weight), GFP_NOFS);
> +	addr = krealloc(map->osd_addr, max*sizeof(*addr), GFP_NOFS);
> +	if (!state || !weight || !addr) {
>  		kfree(state);
> -		kfree(addr);
>  		kfree(weight);
> +		kfree(addr);
> +
>  		return -ENOMEM;
>  	}
>  
> -	/* copy old? */
> -	if (map->osd_state) {
> -		memcpy(state, map->osd_state, map->max_osd*sizeof(*state));
> -		memcpy(addr, map->osd_addr, map->max_osd*sizeof(*addr));
> -		memcpy(weight, map->osd_weight, map->max_osd*sizeof(*weight));
> -		kfree(map->osd_state);
> -		kfree(map->osd_addr);
> -		kfree(map->osd_weight);
> +	for (i = map->max_osd; i < max; i++) {
> +		state[i] = 0;
> +		weight[i] = CEPH_OSD_OUT;
> +		memset(addr + i, 0, sizeof(*addr));
>  	}
>  
>  	map->osd_state = state;
>  	map->osd_weight = weight;
>  	map->osd_addr = addr;
> +
>  	map->max_osd = max;
> +
>  	return 0;
>  }
>  
> 

