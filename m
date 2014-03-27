From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 11/33] libceph: nuke bogus encoding version check in osdmap_apply_incremental()
Date: Thu, 27 Mar 2014 14:50:37 -0500
Message-ID: <5334810D.5020009@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-12-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:48454 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755024AbaC0TuQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 15:50:16 -0400
Received: by mail-ig0-f172.google.com with SMTP id hn18so2033962igb.17
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 12:50:15 -0700 (PDT)
In-Reply-To: <1395944299-21970-12-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:17 PM, Ilya Dryomov wrote:
> Only version 6 of osdmap encoding is supported, anything other than
> version 6 results in an error and halts the decoding process.  Checking
> if version is >= 5 is therefore bogus.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 0fc29a930c06..75e192e99173 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -946,11 +946,10 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  		if (err < 0)
>  			goto bad;
>  	}
> -	if (version >= 5) {
> -		err = __decode_pool_names(p, end, map);
> -		if (err)
> -			goto bad;
> -	}
> +
> +	err = __decode_pool_names(p, end, map);
> +	if (err)
> +		goto bad;
>  
>  	/* old_pool */
>  	ceph_decode_32_safe(p, end, len, e_inval);
> 

