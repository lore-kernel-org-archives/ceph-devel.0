From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 2/5] libceph: decode CRUSH device/bucket types and
 names
Date: Mon, 01 Jun 2020 06:49:41 -0400
Message-ID: <ce644470a74c0d7865ea92cdf29c13dbe609fca9.camel@kernel.org>
References: <20200530153439.31312-1-idryomov@gmail.com>
         <20200530153439.31312-3-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgFAKtn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 1 Jun 2020 06:49:43 -0400
In-Reply-To: <20200530153439.31312-3-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On Sat, 2020-05-30 at 17:34 +0200, Ilya Dryomov wrote:
> These would be matched with the provided client location to calculate
> the locality value.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  include/linux/crush/crush.h |  6 +++
>  net/ceph/crush/crush.c      |  3 ++
>  net/ceph/osdmap.c           | 85 ++++++++++++++++++++++++++++++++++++-
>  3 files changed, 92 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
> index 38b0e4d50ed9..29b0de2e202b 100644
> --- a/include/linux/crush/crush.h
> +++ b/include/linux/crush/crush.h
> @@ -301,6 +301,12 @@ struct crush_map {
>  
>  	__u32 *choose_tries;
>  #else
> +	/* device/bucket type id -> type name (CrushWrapper::type_map) */
> +	struct rb_root type_names;
> +
> +	/* device/bucket id -> name (CrushWrapper::name_map) */
> +	struct rb_root names;
> +

I'm not as familiar with the OSD client-side code, but I don't see any
mention of locking here. What protects these new rbtrees? From reading
over the code, I'd assume the osdc->lock, but it might be nice to have a
comment here that makes that clear.

>  	/* CrushWrapper::choose_args */
>  	struct rb_root choose_args;
>  #endif
> diff --git a/net/ceph/crush/crush.c b/net/ceph/crush/crush.c
> index 3d70244bc1b6..2e6b29fa8518 100644
> --- a/net/ceph/crush/crush.c
> +++ b/net/ceph/crush/crush.c
> @@ -2,6 +2,7 @@
>  #ifdef __KERNEL__
>  # include <linux/slab.h>
>  # include <linux/crush/crush.h>
> +void clear_crush_names(struct rb_root *root);
>  void clear_choose_args(struct crush_map *c);
>  #else
>  # include "crush_compat.h"
> @@ -130,6 +131,8 @@ void crush_destroy(struct crush_map *map)
>  #ifndef __KERNEL__
>  	kfree(map->choose_tries);
>  #else
> +	clear_crush_names(&map->type_names);
> +	clear_crush_names(&map->names);
>  	clear_choose_args(map);
>  #endif
>  	kfree(map);
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 5d00ce2b5339..e74130876d3a 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -138,6 +138,79 @@ static int crush_decode_straw2_bucket(void **p, void *end,
>  	return -EINVAL;
>  }
>  
> +struct crush_name_node {
> +	struct rb_node cn_node;
> +	int cn_id;
> +	char cn_name[];
> +};
> +
> +static struct crush_name_node *alloc_crush_name(size_t name_len)
> +{
> +	struct crush_name_node *cn;
> +
> +	cn = kmalloc(sizeof(*cn) + name_len + 1, GFP_NOIO);
> +	if (!cn)
> +		return NULL;
> +
> +	RB_CLEAR_NODE(&cn->cn_node);
> +	return cn;
> +}
> +
> +static void free_crush_name(struct crush_name_node *cn)
> +{
> +	WARN_ON(!RB_EMPTY_NODE(&cn->cn_node));
> +
> +	kfree(cn);
> +}
> +
> +DEFINE_RB_FUNCS(crush_name, struct crush_name_node, cn_id, cn_node)
> +
> +static int decode_crush_names(void **p, void *end, struct rb_root *root)
> +{
> +	u32 n;
> +
> +	ceph_decode_32_safe(p, end, n, e_inval);
> +	while (n--) {
> +		struct crush_name_node *cn;
> +		int id;
> +		u32 name_len;
> +
> +		ceph_decode_32_safe(p, end, id, e_inval);
> +		ceph_decode_32_safe(p, end, name_len, e_inval);
> +		ceph_decode_need(p, end, name_len, e_inval);
> +
> +		cn = alloc_crush_name(name_len);
> +		if (!cn)
> +			return -ENOMEM;
> +
> +		cn->cn_id = id;
> +		memcpy(cn->cn_name, *p, name_len);
> +		cn->cn_name[name_len] = '\0';
> +		*p += name_len;
> +
> +		if (!__insert_crush_name(root, cn)) {
> +			free_crush_name(cn);
> +			return -EEXIST;
> +		}
> +	}
> +
> +	return 0;
> +
> +e_inval:
> +	return -EINVAL;
> +}
> +
> +void clear_crush_names(struct rb_root *root)
> +{
> +	while (!RB_EMPTY_ROOT(root)) {
> +		struct crush_name_node *cn =
> +		    rb_entry(rb_first(root), struct crush_name_node, cn_node);
> +
> +		erase_crush_name(root, cn);
> +		free_crush_name(cn);
> +	}
> +}
> +
>  static struct crush_choose_arg_map *alloc_choose_arg_map(void)
>  {
>  	struct crush_choose_arg_map *arg_map;
> @@ -354,6 +427,8 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
>  	if (c == NULL)
>  		return ERR_PTR(-ENOMEM);
>  
> +	c->type_names = RB_ROOT;
> +	c->names = RB_ROOT;
>  	c->choose_args = RB_ROOT;
>  
>          /* set tunables to default values */
> @@ -510,8 +585,14 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
>  		}
>  	}
>  
> -	ceph_decode_skip_map(p, end, 32, string, bad); /* type_map */
> -	ceph_decode_skip_map(p, end, 32, string, bad); /* name_map */
> +	err = decode_crush_names(p, end, &c->type_names);
> +	if (err)
> +		goto fail;
> +
> +	err = decode_crush_names(p, end, &c->names);
> +	if (err)
> +		goto fail;
> +
>  	ceph_decode_skip_map(p, end, 32, string, bad); /* rule_name_map */
>  
>          /* tunables */

-- 
Jeff Layton <jlayton@kernel.org>
