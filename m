From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 4/6] libceph: define ceph_pg_pool_name_by_id()
Date: Wed, 31 Oct 2012 18:34:44 -0700
Message-ID: <5091D1B4.3010704@inktank.com>
References: <509081C4.3050402@inktank.com> <509083AF.1000000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:32958 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002Ab2KABe4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 21:34:56 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1372947pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 18:34:56 -0700 (PDT)
In-Reply-To: <509083AF.1000000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 10/30/2012 06:49 PM, Alex Elder wrote:
> Define and export function ceph_pg_pool_name_by_id() to supply
> the name of a pg pool whose id is given.  This will be used by
> the next patch.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   include/linux/ceph/osdmap.h |    1 +
>   net/ceph/osdmap.c           |   16 ++++++++++++++++
>   2 files changed, 17 insertions(+)
>
> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
> index e88a620..5ea57ba 100644
> --- a/include/linux/ceph/osdmap.h
> +++ b/include/linux/ceph/osdmap.h
> @@ -123,6 +123,7 @@ extern int ceph_calc_pg_acting(struct ceph_osdmap
> *osdmap, struct ceph_pg pgid,
>   extern int ceph_calc_pg_primary(struct ceph_osdmap *osdmap,
>   				struct ceph_pg pgid);
>
> +extern const char *ceph_pg_pool_name_by_id(struct ceph_osdmap *map, u64
> id);
>   extern int ceph_pg_poolid_by_name(struct ceph_osdmap *map, const char
> *name);
>
>   #endif
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index f552aa4..de73214 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -469,6 +469,22 @@ static struct ceph_pg_pool_info
> *__lookup_pg_pool(struct rb_root *root, int id)
>   	return NULL;
>   }
>
> +const char *ceph_pg_pool_name_by_id(struct ceph_osdmap *map, u64 id)
> +{
> +	struct ceph_pg_pool_info *pi;
> +
> +	if (id == CEPH_NOPOOL)
> +		return NULL;
> +
> +	if (WARN_ON_ONCE(id > (u64) INT_MAX))
> +		return NULL;
> +
> +	pi = __lookup_pg_pool(&map->pg_pools, (int) id);
> +
> +	return pi ? pi->name : NULL;
> +}
> +EXPORT_SYMBOL(ceph_pg_pool_name_by_id);
> +
>   int ceph_pg_poolid_by_name(struct ceph_osdmap *map, const char *name)
>   {
>   	struct rb_node *rbp;
>

