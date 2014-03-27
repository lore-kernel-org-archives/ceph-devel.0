From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 07/33] libceph: safely decode max_osd value in osdmap_decode()
Date: Thu, 27 Mar 2014 14:27:39 -0500
Message-ID: <53347BAB.9010806@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-8-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:49102 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643AbaC0T1S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 15:27:18 -0400
Received: by mail-ig0-f169.google.com with SMTP id h18so1859694igc.2
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 12:27:17 -0700 (PDT)
In-Reply-To: <1395944299-21970-8-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:17 PM, Ilya Dryomov wrote:
> max_osd value is not covered by any ceph_decode_need().  Use a safe
> version of ceph_decode_* macro to decode it.

I know it's slightly more efficient, but I never liked those
ceph_decode_need() statements that added together a bunch
of things you're about to go decode...

Anyway, this is the right thing to do.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 298d076eee89..ec06010657b3 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -687,9 +687,10 @@ static int osdmap_set_max_osd(struct ceph_osdmap *map, int max)
>  static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
>  {
>  	u16 version;
> -	u32 len, max, i;
>  	u32 epoch = 0;
>  	void *start = *p;
> +	u32 max;
> +	u32 len, i;
>  	int err;
>  	struct ceph_pg_pool_info *pi;
>  
> @@ -736,7 +737,8 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
>  
>  	ceph_decode_32_safe(p, end, map->flags, e_inval);
>  
> -	max = ceph_decode_32(p);
> +	/* max_osd */
> +	ceph_decode_32_safe(p, end, max, e_inval);
>  
>  	/* (re)alloc osd arrays */
>  	err = osdmap_set_max_osd(map, max);
> 

