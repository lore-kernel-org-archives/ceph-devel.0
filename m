From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2 2/6] libceph: introduce reference counted string
Date: Tue, 22 Mar 2016 07:05:19 +0100
Message-ID: <CAOi1vP8SrL71Q34W4b_ZDUkTNyi-UtDstgrTjnjq9fGE=VMa_g@mail.gmail.com>
References: <1454742006-85706-1-git-send-email-zyan@redhat.com>
	<1454742006-85706-3-git-send-email-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:34522 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbcCVGFW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Mar 2016 02:05:22 -0400
Received: by mail-lb0-f196.google.com with SMTP id vk4so13259668lbb.1
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2016 23:05:21 -0700 (PDT)
In-Reply-To: <1454742006-85706-3-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Sat, Feb 6, 2016 at 8:00 AM, Yan, Zheng <zyan@redhat.com> wrote:
> The data structure is for storing namesapce string. It allows namespace
> string to be shared by cephfs inodes with same layout.
>
> Signed-off-by: Yan, Zheng <zyan@redhat.com>
> ---
>  include/linux/ceph/libceph.h      |   1 +
>  include/linux/ceph/string_table.h |  58 ++++++++++++++++++
>  net/ceph/Makefile                 |   2 +-
>  net/ceph/ceph_common.c            |   1 +
>  net/ceph/string_table.c           | 121 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 182 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/ceph/string_table.h
>  create mode 100644 net/ceph/string_table.c
>
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index e7975e4..8e9868d 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -21,6 +21,7 @@
>  #include <linux/ceph/mon_client.h>
>  #include <linux/ceph/osd_client.h>
>  #include <linux/ceph/ceph_fs.h>
> +#include <linux/ceph/string_table.h>
>
>  /*
>   * mount options
> diff --git a/include/linux/ceph/string_table.h b/include/linux/ceph/string_table.h
> new file mode 100644
> index 0000000..427b6f9
> --- /dev/null
> +++ b/include/linux/ceph/string_table.h
> @@ -0,0 +1,58 @@
> +#ifndef _FS_CEPH_STRING_TABLE_H
> +#define _FS_CEPH_STRING_TABLE_H
> +
> +#include <linux/types.h>
> +#include <linux/kref.h>
> +#include <linux/rbtree.h>
> +#include <linux/rcupdate.h>
> +
> +struct ceph_string {
> +       struct kref kref;
> +       union {
> +               struct rb_node node;
> +               struct rcu_head rcu;
> +       };
> +       size_t len;
> +       char str[];
> +};
> +
> +extern void ceph_release_string(struct kref *ref);
> +extern struct ceph_string *ceph_find_or_create_string(const char *str,
> +                                                     size_t len);
> +extern void ceph_string_cleanup(void);
> +
> +static inline void ceph_get_string(struct ceph_string *str)
> +{
> +       kref_get(&str->kref);
> +}
> +
> +static inline void ceph_put_string(struct ceph_string *str)
> +{
> +       if (!str)
> +               return;
> +       kref_put(&str->kref, ceph_release_string);
> +}
> +
> +static inline int ceph_compare_string(struct ceph_string *cs,
> +                                     const char* str, size_t len)
> +{
> +       size_t cs_len = cs ? cs->len : 0;
> +       if (cs_len != len)
> +               return cs_len - len;
> +       if (len == 0)
> +               return 0;
> +       return strncmp(cs->str, str, len);
> +}
> +
> +#define ceph_try_get_string(x)                                 \
> +({                                                             \
> +       struct ceph_string *___str;                             \
> +       rcu_read_lock();                                        \
> +       ___str = rcu_dereference(x);                            \
> +       if (___str && !kref_get_unless_zero(&___str->kref))     \
> +               ___str = NULL;                                  \
> +       rcu_read_unlock();                                      \
> +       (___str);                                               \
> +})
> +
> +#endif
> diff --git a/net/ceph/Makefile b/net/ceph/Makefile
> index 958d9856..84cbed6 100644
> --- a/net/ceph/Makefile
> +++ b/net/ceph/Makefile
> @@ -11,5 +11,5 @@ libceph-y := ceph_common.o messenger.o msgpool.o buffer.o pagelist.o \
>         crypto.o armor.o \
>         auth_x.o \
>         ceph_fs.o ceph_strings.o ceph_hash.o \
> -       pagevec.o snapshot.o
> +       pagevec.o snapshot.o string_table.o
>
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index dcc18c6..baca649 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -751,6 +751,7 @@ static void __exit exit_ceph_lib(void)
>         ceph_msgr_exit();
>         ceph_crypto_shutdown();
>         ceph_debugfs_cleanup();
> +       ceph_string_cleanup();
>  }
>
>  module_init(init_ceph_lib);
> diff --git a/net/ceph/string_table.c b/net/ceph/string_table.c
> new file mode 100644
> index 0000000..bb49bd7
> --- /dev/null
> +++ b/net/ceph/string_table.c
> @@ -0,0 +1,121 @@
> +#include <linux/slab.h>
> +#include <linux/gfp.h>
> +#include <linux/string.h>
> +#include <linux/spinlock.h>
> +#include <linux/ceph/string_table.h>
> +
> +static DEFINE_SPINLOCK(string_tree_lock);
> +static struct rb_root string_tree = RB_ROOT;
> +
> +struct ceph_string *ceph_find_or_create_string(const char* str, size_t len)
> +{
> +       struct ceph_string *cs, *exist;
> +       struct rb_node **p, *parent;
> +       int ret;
> +
> +       exist = NULL;
> +       spin_lock(&string_tree_lock);
> +       p = &string_tree.rb_node;
> +       while (*p) {
> +               exist = rb_entry(*p, struct ceph_string, node);
> +               ret = ceph_compare_string(exist, str, len);
> +               if (ret > 0)
> +                       p = &(*p)->rb_left;
> +               else if (ret < 0)
> +                       p = &(*p)->rb_right;
> +               else
> +                       break;
> +               exist = NULL;
> +       }
> +       if (exist && !kref_get_unless_zero(&exist->kref)) {
> +               rb_erase(&exist->node, &string_tree);
> +               RB_CLEAR_NODE(&exist->node);
> +               exist = NULL;
> +       }
> +       spin_unlock(&string_tree_lock);
> +       if (exist)
> +               return exist;
> +
> +       cs = kmalloc(sizeof(*cs) + len + 1, GFP_NOFS);
> +       if (!cs)
> +               return NULL;
> +
> +       kref_init(&cs->kref);
> +       cs->len = len;
> +       memcpy(cs->str, str, len);
> +       cs->str[len] = 0;
> +
> +retry:
> +       exist = NULL;
> +       parent = NULL;
> +       p = &string_tree.rb_node;
> +       spin_lock(&string_tree_lock);
> +       while (*p) {
> +               parent = *p;
> +               exist = rb_entry(*p, struct ceph_string, node);
> +               ret = ceph_compare_string(exist, str, len);
> +               if (ret > 0)
> +                       p = &(*p)->rb_left;
> +               else if (ret < 0)
> +                       p = &(*p)->rb_right;
> +               else
> +                       break;
> +               exist = NULL;
> +       }
> +       ret = 0;
> +       if (!exist) {
> +               rb_link_node(&cs->node, parent, p);
> +               rb_insert_color(&cs->node, &string_tree);
> +       } else if (!kref_get_unless_zero(&exist->kref)) {
> +               rb_erase(&exist->node, &string_tree);
> +               RB_CLEAR_NODE(&exist->node);
> +               ret = -EAGAIN;
> +       }
> +       spin_unlock(&string_tree_lock);
> +       if (ret == -EAGAIN)
> +               goto retry;
> +
> +       if (exist) {
> +               kfree(cs);
> +               cs = exist;
> +       }
> +
> +       return cs;
> +}
> +EXPORT_SYMBOL(ceph_find_or_create_string);
> +
> +static void ceph_free_string(struct rcu_head *head)
> +{
> +       struct ceph_string *cs = container_of(head, struct ceph_string, rcu);
> +       kfree(cs);
> +}
> +
> +void ceph_release_string(struct kref *ref)
> +{
> +       struct ceph_string *cs = container_of(ref, struct ceph_string, kref);
> +
> +       spin_lock(&string_tree_lock);
> +       if (!RB_EMPTY_NODE(&cs->node)) {
> +               rb_erase(&cs->node, &string_tree);
> +               RB_CLEAR_NODE(&cs->node);
> +       }
> +       spin_unlock(&string_tree_lock);
> +
> +       call_rcu(&cs->rcu, ceph_free_string);
> +}
> +EXPORT_SYMBOL(ceph_release_string);
> +
> +void ceph_string_cleanup(void)
> +{
> +       struct rb_node *p;
> +       struct ceph_string *cs;
> +       if (RB_EMPTY_ROOT(&string_tree))
> +               return;
> +
> +       pr_err("libceph: detect string leaks\n");
> +       while ((p = rb_first(&string_tree))) {
> +               cs = rb_entry(p, struct ceph_string, node);
> +               rb_erase(p, &string_tree);
> +               kfree(cs);
> +       }
> +}

Hi Zheng,

A one and a half line commit message and an equally short cover letter
for a series such as this isn't enough.  I *happen* to know that the
basic use case for namespaces in cephfs is going to be restricting
users to different parts of the directory tree, with the enforcement
happening in ceph on the server side, as opposed to in ceph on the
client side, but I would appreciate some details on what the actual
namespace names are going to be, whether it's user input or not,
whether there are plans to use namespaces for anything else, etc.

I don't like the idea of sharing namespace name strings between libceph
and ceph modules, especially with the strings themselves hosted in
libceph.  rbd has no use for namespaces, so libceph can live with
namespace names embedded into ceph_osd_request by value or with
a simple non-owning pointer, leaving reference counting to the outside
modules, if one of the use cases is "one namespace with a long name for
the entire directory tree" or something close to it.

I think the sharing infrastructure should be moved into cephfs, and
probably changed to share entire file layouts along the way.  I don't
know this code well enough to be sure, but it seems that by sharing
file layouts and making ci->i_layout an owning pointer you might be
able to piggy back on i_ceph_lock and considerably simplify the whole
thing by dropping RCU and eliminating numerous get/put calls.

Thanks,

                Ilya
