From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 07/11] libceph: add ceph_pg_pool_by_id()
Date: Mon, 27 Jan 2014 08:38:40 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1401270838060.1080@cobra.newdream.net>
References: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com> <1390838333-32266-8-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60286 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbaA0Qik (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jan 2014 11:38:40 -0500
In-Reply-To: <1390838333-32266-8-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org

Would it make more sense to just rename and export the existing function? 
I'm not sure __ is particularly meaningful in the context of osdmap.c...

sage

On Mon, 27 Jan 2014, Ilya Dryomov wrote:

> "Lookup pool info by ID" function is hidden in osdmap.c.  Expose it to
> the rest of libceph.
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  include/linux/ceph/osdmap.h |    3 +++
>  net/ceph/osdmap.c           |    5 +++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
> index ebb8ec285de6..7f894a64c6c7 100644
> --- a/include/linux/ceph/osdmap.h
> +++ b/include/linux/ceph/osdmap.h
> @@ -174,6 +174,9 @@ extern int ceph_calc_pg_acting(struct ceph_osdmap *osdmap,
>  extern int ceph_calc_pg_primary(struct ceph_osdmap *osdmap,
>  				struct ceph_pg pgid);
>  
> +extern struct ceph_pg_pool_info *ceph_pg_pool_by_id(struct ceph_osdmap *map,
> +						    u64 id);
> +
>  extern const char *ceph_pg_pool_name_by_id(struct ceph_osdmap *map, u64 id);
>  extern int ceph_pg_poolid_by_name(struct ceph_osdmap *map, const char *name);
>  
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 768dd04eb9b1..d69d23556f0c 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -464,6 +464,11 @@ static struct ceph_pg_pool_info *__lookup_pg_pool(struct rb_root *root, u64 id)
>  	return NULL;
>  }
>  
> +struct ceph_pg_pool_info *ceph_pg_pool_by_id(struct ceph_osdmap *map, u64 id)
> +{
> +	return __lookup_pg_pool(&map->pg_pools, id);
> +}
> +
>  const char *ceph_pg_pool_name_by_id(struct ceph_osdmap *map, u64 id)
>  {
>  	struct ceph_pg_pool_info *pi;
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
