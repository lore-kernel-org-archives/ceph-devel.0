From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 08/33] libceph: assert length of osdmap osd arrays
Date: Thu, 27 Mar 2014 14:30:33 -0500
Message-ID: <53347C59.9040004@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-9-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:55756 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757104AbaC0TaM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 15:30:12 -0400
Received: by mail-ie0-f169.google.com with SMTP id to1so3957501ieb.0
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 12:30:11 -0700 (PDT)
In-Reply-To: <1395944299-21970-9-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:17 PM, Ilya Dryomov wrote:
> Assert length of osd_state, osd_weight and osd_addr arrays.  They
> should all have exactly max_osd elements after the call to
> osdmap_set_max_osd().

Since this function is allowed to fail, could these
conditions lead to returning an error code rather than
killing the machine?

Your testing incoming data (which you can't necessarily
trust), not a fundamental assumption of the code, so
a BUG() seems harsh.

Checking is absolutely the right thing to do.

Switch it to return an error if you can.  If you feel
BUG() is right, so be it.  Either way:

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index ec06010657b3..19aca4d3c5dd 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -745,19 +745,19 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
>  	if (err)
>  		goto bad;
>  
> -	/* osds */
> +	/* osd_state, osd_weight, osd_addrs->client_addr */
>  	ceph_decode_need(p, end, 3*sizeof(u32) +
>  			 map->max_osd*(1 + sizeof(*map->osd_weight) +
>  				       sizeof(*map->osd_addr)), e_inval);
>  
> -	*p += 4; /* skip length field (should match max) */
> +	BUG_ON(ceph_decode_32(p) != map->max_osd);
>  	ceph_decode_copy(p, map->osd_state, map->max_osd);
>  
> -	*p += 4; /* skip length field (should match max) */
> +	BUG_ON(ceph_decode_32(p) != map->max_osd);
>  	for (i = 0; i < map->max_osd; i++)
>  		map->osd_weight[i] = ceph_decode_32(p);
>  
> -	*p += 4; /* skip length field (should match max) */
> +	BUG_ON(ceph_decode_32(p) != map->max_osd);
>  	ceph_decode_copy(p, map->osd_addr, map->max_osd*sizeof(*map->osd_addr));
>  	for (i = 0; i < map->max_osd; i++)
>  		ceph_decode_addr(&map->osd_addr[i]);
> 

