From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 24/33] libceph: ceph_osd_{exists,is_up,is_down}(osd) definitions
Date: Thu, 27 Mar 2014 15:33:39 -0500
Message-ID: <53348B23.4090204@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-25-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:46857 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086AbaC0UdR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 16:33:17 -0400
Received: by mail-ie0-f182.google.com with SMTP id y20so4046561ier.27
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 13:33:17 -0700 (PDT)
In-Reply-To: <1395944299-21970-25-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
> Sync up with ceph.git definitions.  Bring in ceph_osd_is_down().

Looks good.  (Though I didn't verify it matches Ceph's definitions...)

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  include/linux/ceph/osdmap.h |   14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
> index 6e030cb3c9ca..0895797b9e28 100644
> --- a/include/linux/ceph/osdmap.h
> +++ b/include/linux/ceph/osdmap.h
> @@ -125,9 +125,21 @@ static inline void ceph_oid_copy(struct ceph_object_id *dest,
>  	dest->name_len = src->name_len;
>  }
>  
> +static inline int ceph_osd_exists(struct ceph_osdmap *map, int osd)
> +{
> +	return osd >= 0 && osd < map->max_osd &&
> +	       (map->osd_state[osd] & CEPH_OSD_EXISTS);
> +}
> +
>  static inline int ceph_osd_is_up(struct ceph_osdmap *map, int osd)
>  {
> -	return (osd < map->max_osd) && (map->osd_state[osd] & CEPH_OSD_UP);
> +	return ceph_osd_exists(map, osd) &&
> +	       (map->osd_state[osd] & CEPH_OSD_UP);
> +}
> +
> +static inline int ceph_osd_is_down(struct ceph_osdmap *map, int osd)
> +{
> +	return !ceph_osd_is_up(map, osd);
>  }
>  
>  static inline bool ceph_osdmap_flag(struct ceph_osdmap *map, int flag)
> 

