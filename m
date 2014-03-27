From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 17/33] libceph: introduce get_osdmap_client_data_v()
Date: Thu, 27 Mar 2014 15:17:53 -0500
Message-ID: <53348771.6060201@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-18-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:56084 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756679AbaC0URd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 16:17:33 -0400
Received: by mail-ig0-f169.google.com with SMTP id h18so16073igc.0
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 13:17:33 -0700 (PDT)
In-Reply-To: <1395944299-21970-18-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
> Full and incremental osdmaps are structured identically and have
> identical headers.  Add a helper to decode both "old" (16-bit version,
> v6) and "new" (8-bit struct_v+struct_compat+struct_len, v7) osdmap
> enconding headers and switch to it.

It wasn't clear to me at first that this was adding a
new bit of functionality--support for v7 OSD map encodings.

A couple comments below but this looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |   81 ++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 65 insertions(+), 16 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 0134df3639d2..ae96c73aff71 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -683,6 +683,63 @@ static int osdmap_set_max_osd(struct ceph_osdmap *map, int max)
>  	return 0;
>  }
>  
> +#define OSDMAP_WRAPPER_COMPAT_VER	7
> +#define OSDMAP_CLIENT_DATA_COMPAT_VER	1

Don't these definitions belong in a common header?

> +/*
> + * Return 0 or error.  On success, *v is set to 0 for old (v6) osdmaps,
> + * to struct_v of the client_data section for new (v7 and above)
> + * osdmaps.
> + */
> +static int get_osdmap_client_data_v(void **p, void *end,
> +				    const char *s, u8 *v)

I like to avoid one-character names (in this case, "s").
Mainly because it's hard to search for them.

You could pass a Boolean "full" and use that to select
what's printed in the warning messages.

> +{
> +	u8 struct_v;
> +
> +	ceph_decode_8_safe(p, end, struct_v, e_inval);
> +	if (struct_v >= 7) {
> +		u8 struct_compat;
> +
> +		ceph_decode_8_safe(p, end, struct_compat, e_inval);
> +		if (struct_compat > OSDMAP_WRAPPER_COMPAT_VER) {
> +			pr_warning("got v %d cv %d > %d of %s ceph_osdmap\n",
> +				   struct_v, struct_compat,
> +				   OSDMAP_WRAPPER_COMPAT_VER, s);
> +			return -EINVAL;
> +		}
> +		*p += 4; /* ignore wrapper struct_len */
> +
> +		ceph_decode_8_safe(p, end, struct_v, e_inval);
> +		ceph_decode_8_safe(p, end, struct_compat, e_inval);
> +		if (struct_compat > OSDMAP_CLIENT_DATA_COMPAT_VER) {
> +			pr_warning("got v %d cv %d > %d of %s ceph_osdmap client data\n",
> +				   struct_v, struct_compat,
> +				   OSDMAP_CLIENT_DATA_COMPAT_VER, s);
> +			return -EINVAL;
> +		}
> +		*p += 4; /* ignore client data struct_len */
> +	} else {
> +		u16 version;
> +
> +		*p -= 1;
> +		ceph_decode_16_safe(p, end, version, e_inval);
> +		if (version < 6) {
> +			pr_warning("got v %d < 6 of %s ceph_osdmap\n", version,
> +				   s);
> +			return -EINVAL;
> +		}
> +
> +		/* old osdmap enconding */
> +		struct_v = 0;
> +	}
> +
> +	*v = struct_v;
> +	return 0;
> +
> +e_inval:
> +	return -EINVAL;
> +}
> +
>  static int __decode_pools(void **p, void *end, struct ceph_osdmap *map,
>  			  bool incremental)
>  {
> @@ -798,7 +855,7 @@ static int decode_new_pg_temp(void **p, void *end, struct ceph_osdmap *map)
>   */
>  static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
>  {
> -	u16 version;
> +	u8 struct_v;
>  	u32 epoch = 0;
>  	void *start = *p;
>  	u32 max;
> @@ -807,15 +864,9 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
>  
>  	dout("%s %p to %p len %d\n", __func__, *p, end, (int)(end - *p));
>  
> -	ceph_decode_16_safe(p, end, version, e_inval);
> -	if (version > 6) {
> -		pr_warning("got unknown v %d > 6 of osdmap\n", version);
> -		goto e_inval;
> -	}
> -	if (version < 6) {
> -		pr_warning("got old v %d < 6 of osdmap\n", version);
> -		goto e_inval;
> -	}
> +	err = get_osdmap_client_data_v(p, end, "full", &struct_v);
> +	if (err)
> +		goto bad;
>  
>  	/* fsid, epoch, created, modified */
>  	ceph_decode_need(p, end, sizeof(map->fsid) + sizeof(u32) +
> @@ -937,15 +988,13 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  	__s32 new_flags, max;
>  	void *start = *p;
>  	int err;
> -	u16 version;
> +	u8 struct_v;
>  
>  	dout("%s %p to %p len %d\n", __func__, *p, end, (int)(end - *p));
>  
> -	ceph_decode_16_safe(p, end, version, e_inval);
> -	if (version != 6) {
> -		pr_warning("got unknown v %d != 6 of inc osdmap\n", version);
> -		goto e_inval;
> -	}
> +	err = get_osdmap_client_data_v(p, end, "inc", &struct_v);
> +	if (err)
> +		goto bad;
>  
>  	/* fsid, epoch, modified, new_pool_max, new_flags */
>  	ceph_decode_need(p, end, sizeof(fsid) + sizeof(u32) + sizeof(modified) +
> 

