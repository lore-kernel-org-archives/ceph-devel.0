From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 12/33] libceph: fix and clarify ceph_decode_need() sizes
Date: Thu, 27 Mar 2014 14:53:27 -0500
Message-ID: <533481B7.3050703@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-13-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:57469 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757144AbaC0TxG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 15:53:06 -0400
Received: by mail-ig0-f174.google.com with SMTP id h18so2047453igc.7
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 12:53:05 -0700 (PDT)
In-Reply-To: <1395944299-21970-13-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:17 PM, Ilya Dryomov wrote:
> Sum up sizeof(...) results instead of (incorrectly) hard-coding the
> number of bytes, expressed in ints and longs.

Yay!!!

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 75e192e99173..6dd083906a1e 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -706,7 +706,9 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
>  		goto e_inval;
>  	}
>  
> -	ceph_decode_need(p, end, 2*sizeof(u64)+6*sizeof(u32), e_inval);
> +	/* fsid, epoch, created, modified */
> +	ceph_decode_need(p, end, sizeof(map->fsid) + sizeof(u32) +
> +			 sizeof(map->created) + sizeof(map->modified), e_inval);
>  	ceph_decode_copy(p, &map->fsid, sizeof(map->fsid));
>  	epoch = map->epoch = ceph_decode_32(p);
>  	ceph_decode_copy(p, &map->created, sizeof(map->created));
> @@ -872,8 +874,9 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  		goto e_inval;
>  	}
>  
> -	ceph_decode_need(p, end, sizeof(fsid)+sizeof(modified)+2*sizeof(u32),
> -			 e_inval);
> +	/* fsid, epoch, modified, new_pool_max, new_flags */
> +	ceph_decode_need(p, end, sizeof(fsid) + sizeof(u32) + sizeof(modified) +
> +			 sizeof(u64) + sizeof(u32), e_inval);
>  	ceph_decode_copy(p, &fsid, sizeof(fsid));
>  	epoch = ceph_decode_32(p);
>  	BUG_ON(epoch != map->epoch+1);
> @@ -907,10 +910,8 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  	if (new_pool_max >= 0)
>  		map->pool_max = new_pool_max;
>  
> -	ceph_decode_need(p, end, 5*sizeof(u32), e_inval);
> -
>  	/* new max? */
> -	max = ceph_decode_32(p);
> +	ceph_decode_32_safe(p, end, max, e_inval);
>  	if (max >= 0) {
>  		err = osdmap_set_max_osd(map, max);
>  		if (err)
> 

