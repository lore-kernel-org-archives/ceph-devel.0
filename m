From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 25/33] libceph: ceph_can_shift_osds(pool) and pool type
 defines
Date: Thu, 27 Mar 2014 15:34:20 -0500
Message-ID: <53348B4C.3020704@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-26-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:54299 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756747AbaC0Ud6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 16:33:58 -0400
Received: by mail-ie0-f169.google.com with SMTP id to1so4046328ieb.0
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 13:33:58 -0700 (PDT)
In-Reply-To: <1395944299-21970-26-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
> Bring in pg_pool_t::can_shift_osds() counterpart along with pool type
> defines.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  include/linux/ceph/osdmap.h |   12 ++++++++++++
>  include/linux/ceph/rados.h  |    5 +++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
> index 0895797b9e28..4e28c1e5d62f 100644
> --- a/include/linux/ceph/osdmap.h
> +++ b/include/linux/ceph/osdmap.h
> @@ -41,6 +41,18 @@ struct ceph_pg_pool_info {
>  	char *name;
>  };
>  
> +static inline bool ceph_can_shift_osds(struct ceph_pg_pool_info *pool)
> +{
> +	switch (pool->type) {
> +	case CEPH_POOL_TYPE_REP:
> +		return true;
> +	case CEPH_POOL_TYPE_EC:
> +		return false;
> +	default:
> +		BUG_ON(1);
> +	}
> +}
> +
>  struct ceph_object_locator {
>  	s64 pool;
>  };
> diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
> index bb6f40c9cb0f..f20e0d8a2155 100644
> --- a/include/linux/ceph/rados.h
> +++ b/include/linux/ceph/rados.h
> @@ -81,8 +81,9 @@ struct ceph_pg_v1 {
>   */
>  #define CEPH_NOPOOL  ((__u64) (-1))  /* pool id not defined */
>  
> -#define CEPH_PG_TYPE_REP     1
> -#define CEPH_PG_TYPE_RAID4   2
> +#define CEPH_POOL_TYPE_REP     1
> +#define CEPH_POOL_TYPE_RAID4   2 /* never implemented */
> +#define CEPH_POOL_TYPE_EC      3
>  
>  /*
>   * stable_mod func is used to control number of placement groups.
> 

