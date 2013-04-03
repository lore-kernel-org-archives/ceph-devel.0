From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] libceph: define ceph_decode_pgid() only once
Date: Wed, 03 Apr 2013 11:43:06 -0700
Message-ID: <515C783A.9030003@inktank.com>
References: <515ADFE8.4090508@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:39039 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762415Ab3DCSnZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Apr 2013 14:43:25 -0400
Received: by mail-pd0-f170.google.com with SMTP id 10so1000303pdi.1
        for <ceph-devel@vger.kernel.org>; Wed, 03 Apr 2013 11:43:24 -0700 (PDT)
In-Reply-To: <515ADFE8.4090508@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/02/2013 06:40 AM, Alex Elder wrote:
> There are two basically identical definitions of __decode_pgid()
> in libceph, one in "net/ceph/osdmap.c" and the other in
> "net/ceph/osd_client.c".  Get rid of both, and instead define
> a single inline version in "include/linux/ceph/osdmap.h".
>
> This resolves:
>      http://tracker.ceph.com/issues/4616
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   include/linux/ceph/osdmap.h |   24 ++++++++++++++++++++++++
>   net/ceph/osd_client.c       |   22 +---------------------
>   net/ceph/osdmap.c           |   22 ++--------------------
>   3 files changed, 27 insertions(+), 41 deletions(-)
>
> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
> index 167daf6..d05cc44 100644
> --- a/include/linux/ceph/osdmap.h
> +++ b/include/linux/ceph/osdmap.h
> @@ -3,6 +3,7 @@
>
>   #include <linux/rbtree.h>
>   #include <linux/ceph/types.h>
> +#include <linux/ceph/decode.h>
>   #include <linux/ceph/ceph_fs.h>
>   #include <linux/crush/crush.h>
>
> @@ -119,6 +120,29 @@ static inline struct ceph_entity_addr
> *ceph_osd_addr(struct ceph_osdmap *map,
>   	return &map->osd_addr[osd];
>   }
>
> +static inline int ceph_decode_pgid(void **p, void *end, struct ceph_pg
> *pgid)
> +{
> +	__u8 version;
> +
> +	if (!ceph_has_room(p, end, 1 + 8 + 4 + 4)) {
> +		pr_warning("incomplete pg encoding");
> +
> +		return -EINVAL;
> +	}
> +	version = ceph_decode_8(p);
> +	if (version > 1) {
> +		pr_warning("do not understand pg encoding %d > 1",
> +			(int)version);
> +		return -EINVAL;
> +	}
> +
> +	pgid->pool = ceph_decode_64(p);
> +	pgid->seed = ceph_decode_32(p);
> +	*p += 4;	/* skip deprecated preferred value */
> +
> +	return 0;
> +}
> +
>   extern struct ceph_osdmap *osdmap_decode(void **p, void *end);
>   extern struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>   					    struct ceph_osdmap *map,
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index abbcde3..e088792 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1263,26 +1263,6 @@ static void complete_request(struct
> ceph_osd_request *req)
>   	complete_all(&req->r_safe_completion);  /* fsync waiter */
>   }
>
> -static int __decode_pgid(void **p, void *end, struct ceph_pg *pgid)
> -{
> -	__u8 v;
> -
> -	ceph_decode_need(p, end, 1 + 8 + 4 + 4, bad);
> -	v = ceph_decode_8(p);
> -	if (v > 1) {
> -		pr_warning("do not understand pg encoding %d > 1", v);
> -		return -EINVAL;
> -	}
> -	pgid->pool = ceph_decode_64(p);
> -	pgid->seed = ceph_decode_32(p);
> -	*p += 4;
> -	return 0;
> -
> -bad:
> -	pr_warning("incomplete pg encoding");
> -	return -EINVAL;
> -}
> -
>   /*
>    * handle osd op reply.  either call the callback if it is specified,
>    * or do the completion to wake up the waiting thread.
> @@ -1316,7 +1296,7 @@ static void handle_reply(struct ceph_osd_client
> *osdc, struct ceph_msg *msg,
>   	ceph_decode_need(&p, end, object_len, bad);
>   	p += object_len;
>
> -	err = __decode_pgid(&p, end, &pg);
> +	err = ceph_decode_pgid(&p, end, &pg);
>   	if (err)
>   		goto bad;
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 0989871..603ddd9 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -654,24 +654,6 @@ static int osdmap_set_max_osd(struct ceph_osdmap
> *map, int max)
>   	return 0;
>   }
>
> -static int __decode_pgid(void **p, void *end, struct ceph_pg *pg)
> -{
> -	u8 v;
> -
> -	ceph_decode_need(p, end, 1+8+4+4, bad);
> -	v = ceph_decode_8(p);
> -	if (v != 1)
> -		goto bad;
> -	pg->pool = ceph_decode_64(p);
> -	pg->seed = ceph_decode_32(p);
> -	*p += 4; /* skip preferred */
> -	return 0;
> -
> -bad:
> -	dout("error decoding pgid\n");
> -	return -EINVAL;
> -}
> -
>   /*
>    * decode a full map.
>    */
> @@ -765,7 +747,7 @@ struct ceph_osdmap *osdmap_decode(void **p, void *end)
>   		struct ceph_pg pgid;
>   		struct ceph_pg_mapping *pg;
>
> -		err = __decode_pgid(p, end, &pgid);
> +		err = ceph_decode_pgid(p, end, &pgid);
>   		if (err)
>   			goto bad;
>   		ceph_decode_need(p, end, sizeof(u32), bad);
> @@ -983,7 +965,7 @@ struct ceph_osdmap *osdmap_apply_incremental(void
> **p, void *end,
>   		struct ceph_pg pgid;
>   		u32 pglen;
>
> -		err = __decode_pgid(p, end, &pgid);
> +		err = ceph_decode_pgid(p, end, &pgid);
>   		if (err)
>   			goto bad;
>   		ceph_decode_need(p, end, sizeof(u32), bad);
>

