From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 13/33] libceph: rename __decode_pool{,_names}() to decode_pool{,_names}()
Date: Thu, 27 Mar 2014 14:54:14 -0500
Message-ID: <533481E6.7090708@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-14-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:53557 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757161AbaC0Txw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 15:53:52 -0400
Received: by mail-ig0-f178.google.com with SMTP id hn18so2054960igb.11
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 12:53:52 -0700 (PDT)
In-Reply-To: <1395944299-21970-14-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:17 PM, Ilya Dryomov wrote:
> To be in line with all the other osdmap decode helpers.

I wouldn't object to folding this into another patch, it
doesn't change anything functionally.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>


> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 6dd083906a1e..cd8f34abe7b7 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -506,7 +506,7 @@ static void __remove_pg_pool(struct rb_root *root, struct ceph_pg_pool_info *pi)
>  	kfree(pi);
>  }
>  
> -static int __decode_pool(void **p, void *end, struct ceph_pg_pool_info *pi)
> +static int decode_pool(void **p, void *end, struct ceph_pg_pool_info *pi)
>  {
>  	u8 ev, cv;
>  	unsigned len, num;
> @@ -587,7 +587,7 @@ bad:
>  	return -EINVAL;
>  }
>  
> -static int __decode_pool_names(void **p, void *end, struct ceph_osdmap *map)
> +static int decode_pool_names(void **p, void *end, struct ceph_osdmap *map)
>  {
>  	struct ceph_pg_pool_info *pi;
>  	u32 num, len;
> @@ -723,7 +723,7 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
>  			goto bad;
>  		}
>  		pi->id = ceph_decode_64(p);
> -		err = __decode_pool(p, end, pi);
> +		err = decode_pool(p, end, pi);
>  		if (err < 0) {
>  			kfree(pi);
>  			goto bad;
> @@ -731,7 +731,8 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
>  		__insert_pg_pool(&map->pg_pools, pi);
>  	}
>  
> -	err = __decode_pool_names(p, end, map);
> +	/* pool_name */
> +	err = decode_pool_names(p, end, map);
>  	if (err)
>  		goto bad;
>  
> @@ -943,12 +944,13 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  			pi->id = pool;
>  			__insert_pg_pool(&map->pg_pools, pi);
>  		}
> -		err = __decode_pool(p, end, pi);
> +		err = decode_pool(p, end, pi);
>  		if (err < 0)
>  			goto bad;
>  	}
>  
> -	err = __decode_pool_names(p, end, map);
> +	/* new_pool_names */
> +	err = decode_pool_names(p, end, map);
>  	if (err)
>  		goto bad;
>  
> 

