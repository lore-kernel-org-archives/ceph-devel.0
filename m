From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 2/6] libceph: introduce pool namespace cache
Date: Fri, 5 Feb 2016 09:45:09 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602050943130.28396@cpach.fuggernut.com>
References: <1454682697-84638-1-git-send-email-zyan@redhat.com> <1454682697-84638-3-git-send-email-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49557 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbcBEOoz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Feb 2016 09:44:55 -0500
In-Reply-To: <1454682697-84638-3-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com

On Fri, 5 Feb 2016, Yan, Zheng wrote:
> This allows namespace data structure to be shared by cephfs inodes
> with same layout.
> 
> Signed-off-by: Yan, Zheng <zyan@redhat.com>
> ---
>  include/linux/ceph/libceph.h |   1 +
>  include/linux/ceph/pool_ns.h |  47 +++++++++++++++
>  net/ceph/Makefile            |   2 +-
>  net/ceph/ceph_common.c       |   2 +
>  net/ceph/pool_ns.c           | 133 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 184 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/ceph/pool_ns.h
>  create mode 100644 net/ceph/pool_ns.c

Would it make sense to rename this string_table and make it generic?  
There's nothing ceph (or pool ns) specific about it that I can see.

sage


> 
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index e7975e4..40e0d84 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -21,6 +21,7 @@
>  #include <linux/ceph/mon_client.h>
>  #include <linux/ceph/osd_client.h>
>  #include <linux/ceph/ceph_fs.h>
> +#include <linux/ceph/pool_ns.h>
>  
>  /*
>   * mount options
> diff --git a/include/linux/ceph/pool_ns.h b/include/linux/ceph/pool_ns.h
> new file mode 100644
> index 0000000..627cf9d
> --- /dev/null
> +++ b/include/linux/ceph/pool_ns.h
> @@ -0,0 +1,47 @@
> +#ifndef _FS_CEPH_POOL_NS_H
> +#define _FS_CEPH_POOL_NS_H
> +
> +#include <linux/types.h>
> +#include <linux/kref.h>
> +#include <linux/rbtree.h>
> +#include <linux/rcupdate.h>
> +
> +struct ceph_pool_ns {
> +	struct kref kref;
> +	union {
> +		struct rb_node node;
> +		struct rcu_head rcu;
> +	};
> +	size_t name_len;
> +	char name[];
> +};
> +
> +extern void ceph_release_pool_ns(struct kref *ref);
> +extern struct ceph_pool_ns *ceph_find_or_create_pool_ns(const char *str,
> +							size_t len);
> +extern struct ceph_pool_ns *ceph_try_get_pool_ns(struct ceph_pool_ns **pns);
> +extern void ceph_pool_ns_cleanup(void);
> +
> +static inline void ceph_get_pool_ns(struct ceph_pool_ns *ns)
> +{
> +	kref_get(&ns->kref);
> +}
> +
> +static inline void ceph_put_pool_ns(struct ceph_pool_ns *ns)
> +{
> +	if (!ns)
> +		return;
> +	kref_put(&ns->kref, ceph_release_pool_ns);
> +}
> +
> +static inline int ceph_compare_pool_ns(struct ceph_pool_ns *ns,
> +				       const char* str, size_t len)
> +{
> +	size_t nsl = ns ? ns->name_len : 0;
> +	if (nsl != len)
> +		return nsl - len;
> +	if (nsl == 0)
> +		return 0;
> +	return strncmp(ns->name, str, len);
> +}
> +#endif
> diff --git a/net/ceph/Makefile b/net/ceph/Makefile
> index 958d9856..520dab6 100644
> --- a/net/ceph/Makefile
> +++ b/net/ceph/Makefile
> @@ -11,5 +11,5 @@ libceph-y := ceph_common.o messenger.o msgpool.o buffer.o pagelist.o \
>  	crypto.o armor.o \
>  	auth_x.o \
>  	ceph_fs.o ceph_strings.o ceph_hash.o \
> -	pagevec.o snapshot.o
> +	pagevec.o snapshot.o pool_ns.o
>  
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index dcc18c6..ac60293 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -25,6 +25,7 @@
>  #include <linux/ceph/decode.h>
>  #include <linux/ceph/mon_client.h>
>  #include <linux/ceph/auth.h>
> +#include <linux/ceph/pool_ns.h>
>  #include "crypto.h"
>  
>  
> @@ -751,6 +752,7 @@ static void __exit exit_ceph_lib(void)
>  	ceph_msgr_exit();
>  	ceph_crypto_shutdown();
>  	ceph_debugfs_cleanup();
> +	ceph_pool_ns_cleanup();
>  }
>  
>  module_init(init_ceph_lib);
> diff --git a/net/ceph/pool_ns.c b/net/ceph/pool_ns.c
> new file mode 100644
> index 0000000..64ccd77
> --- /dev/null
> +++ b/net/ceph/pool_ns.c
> @@ -0,0 +1,133 @@
> +#include <linux/slab.h>
> +#include <linux/gfp.h>
> +#include <linux/string.h>
> +#include <linux/spinlock.h>
> +#include <linux/ceph/pool_ns.h>
> +
> +static DEFINE_SPINLOCK(pool_ns_lock);
> +static struct rb_root pool_ns_tree = RB_ROOT;
> +
> +struct ceph_pool_ns *ceph_find_or_create_pool_ns(const char* name, size_t len)
> +{
> +	struct ceph_pool_ns *ns, *exist;
> +	struct rb_node **p, *parent;
> +	int ret;
> +
> +	exist = NULL;
> +	spin_lock(&pool_ns_lock);
> +	p = &pool_ns_tree.rb_node;
> +	while (*p) {
> +		exist = rb_entry(*p, struct ceph_pool_ns, node);
> +		ret = ceph_compare_pool_ns(exist, name, len);
> +		if (ret > 0)
> +			p = &(*p)->rb_left;
> +		else if (ret < 0)
> +			p = &(*p)->rb_right;
> +		else
> +			break;
> +		exist = NULL;
> +	}
> +	if (exist && !kref_get_unless_zero(&exist->kref)) {
> +		rb_erase(&exist->node, &pool_ns_tree);
> +		RB_CLEAR_NODE(&exist->node);
> +		exist = NULL;
> +	}
> +	spin_unlock(&pool_ns_lock);
> +	if (exist)
> +		return exist;
> +
> +	ns = kmalloc(sizeof(*ns) + len + 1, GFP_NOFS);
> +	if (!ns)
> +		return NULL;
> +
> +	kref_init(&ns->kref);
> +	ns->name_len = len;
> +	memcpy(ns->name, name, len);
> +	ns->name[len] = 0;
> +
> +retry:
> +	exist = NULL;
> +	parent = NULL;
> +	p = &pool_ns_tree.rb_node;
> +	spin_lock(&pool_ns_lock);
> +	while (*p) {
> +		parent = *p;
> +		exist = rb_entry(*p, struct ceph_pool_ns, node);
> +		ret = ceph_compare_pool_ns(exist, name, len);
> +		if (ret > 0)
> +			p = &(*p)->rb_left;
> +		else if (ret < 0)
> +			p = &(*p)->rb_right;
> +		else
> +			break;
> +		exist = NULL;
> +	}
> +	ret = 0;
> +	if (!exist) {
> +		rb_link_node(&ns->node, parent, p);
> +		rb_insert_color(&ns->node, &pool_ns_tree);
> +	} else if (!kref_get_unless_zero(&exist->kref)) {
> +		rb_erase(&exist->node, &pool_ns_tree);
> +		RB_CLEAR_NODE(&exist->node);
> +		ret = -EAGAIN;
> +	}
> +	spin_unlock(&pool_ns_lock);
> +	if (ret == -EAGAIN)
> +		goto retry;
> +
> +	if (exist) {
> +		kfree(ns);
> +		ns = exist;
> +	}
> +
> +	return ns;
> +}
> +EXPORT_SYMBOL(ceph_find_or_create_pool_ns);
> +
> +static void ceph_free_pool_ns(struct rcu_head *head)
> +{
> +	struct ceph_pool_ns *ns = container_of(head, struct ceph_pool_ns, rcu);
> +	kfree(ns);
> +}
> +
> +void ceph_release_pool_ns(struct kref *ref)
> +{
> +	struct ceph_pool_ns *ns = container_of(ref, struct ceph_pool_ns, kref);
> +
> +	spin_lock(&pool_ns_lock);
> +	if (!RB_EMPTY_NODE(&ns->node)) {
> +		rb_erase(&ns->node, &pool_ns_tree);
> +		RB_CLEAR_NODE(&ns->node);
> +	}
> +	spin_unlock(&pool_ns_lock);
> +
> +	call_rcu(&ns->rcu, ceph_free_pool_ns);
> +}
> +EXPORT_SYMBOL(ceph_release_pool_ns);
> +
> +struct ceph_pool_ns *ceph_try_get_pool_ns(struct ceph_pool_ns **pns)
> +{
> +	struct ceph_pool_ns *ns;
> +	rcu_read_lock();
> +	ns = rcu_dereference(*pns);
> +	if (ns && !kref_get_unless_zero(&ns->kref))
> +		ns = NULL;
> +	rcu_read_unlock();
> +	return ns;
> +}
> +EXPORT_SYMBOL(ceph_try_get_pool_ns);
> +
> +void ceph_pool_ns_cleanup(void)
> +{
> +	struct rb_node *p;
> +	struct ceph_pool_ns *ns;
> +	if (RB_EMPTY_ROOT(&pool_ns_tree))
> +		return;
> +
> +	pr_err("libceph: detect pool ns leaks\n");
> +	while ((p = rb_first(&pool_ns_tree))) {
> +		ns = rb_entry(p, struct ceph_pool_ns, node);
> +		rb_erase(p, &pool_ns_tree);
> +		kfree(ns);
> +	}
> +}
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
