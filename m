From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [RFC v2 PATCH 1/4] ceph: add seqlock for snaprealm hierarchy
 change detection
Date: Tue, 19 Dec 2017 17:22:43 +0800
Message-ID: <CAAM7YAmwdoEp+SHtnN7ubRaDRcO9U=XZMa5vCbZL+FtEsvBbrQ@mail.gmail.com>
References: <20171218153902.7455-1-lhenriques@suse.com> <20171218153902.7455-2-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:35294 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761441AbdLSJWo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Dec 2017 04:22:44 -0500
Received: by mail-ot0-f194.google.com with SMTP id q3so16209082oth.2
        for <ceph-devel@vger.kernel.org>; Tue, 19 Dec 2017 01:22:44 -0800 (PST)
In-Reply-To: <20171218153902.7455-2-lhenriques@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Henriques <lhenriques@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>, Jan Fajerski <jfajerski@suse.com>

On Mon, Dec 18, 2017 at 11:38 PM, Luis Henriques <lhenriques@suse.com> wrote:
> It is possible to receive an update to the snaprealms hierarchy from an
> MDS while walking through this hierarchy.  This patch adds a mechanism
> similar to the one used in dcache to detect renames in lookups.  A new
> seqlock is used to allow a retry in case a change has occurred while
> walking through the snaprealms.
>
> Link: http://tracker.ceph.com/issues/22372
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/snap.c  | 45 +++++++++++++++++++++++++++++++++++++++------
>  fs/ceph/super.h |  2 ++
>  2 files changed, 41 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> index 8a2ca41e4b97..8b9d6c7c0df4 100644
> --- a/fs/ceph/snap.c
> +++ b/fs/ceph/snap.c
> @@ -54,6 +54,25 @@
>   * console).
>   */
>
> +/*
> + * While walking through the snaprealm hierarchy it is possible that
> + * this hierarchy is updated (for ex, when a different client moves
> + * directories around).  snaprealm_lock isn't supposed to prevent this
> + * but, just like the rename_lock in dcache, to detect that this has
> + * happen so that a lookup can be retried.
> + *
> + * Here's a typical usage pattern for this lock:
> + *
> + * retry:
> + *     seq = read_seqbegin(&snaprealm_lock);
> + *     realm = ci->i_snap_realm;
> + *     ceph_get_snap_realm(mdsc, realm);
> + *     ... do stuff ...
> + *     ceph_put_snap_realm(mdsc, realm);
> + *     if (read_seqretry(&snaprealm_lock, seq))
> + *             goto retry;
> + */

A seq lock is not enough for protecting snaprealm hierarchy walk.  The
code may access snaprealm that has been freed by other thread. If we
really want to use seq lock here, we need to use kfree_rcu to free
snaprealm data structure and use rcu_read_lock to protect the
hierarchy walk code.

> +DEFINE_SEQLOCK(snaprealm_lock);
>
>  /*
>   * increase ref count for the realm
> @@ -81,10 +100,12 @@ void ceph_get_snap_realm(struct ceph_mds_client *mdsc,
>  static void __insert_snap_realm(struct rb_root *root,
>                                 struct ceph_snap_realm *new)
>  {
> -       struct rb_node **p = &root->rb_node;
> +       struct rb_node **p;
>         struct rb_node *parent = NULL;
>         struct ceph_snap_realm *r = NULL;
>
> +       write_seqlock(&snaprealm_lock);
> +       p  = &root->rb_node;
>         while (*p) {
>                 parent = *p;
>                 r = rb_entry(parent, struct ceph_snap_realm, node);
> @@ -98,6 +119,7 @@ static void __insert_snap_realm(struct rb_root *root,
>
>         rb_link_node(&new->node, parent, p);
>         rb_insert_color(&new->node, root);
> +       write_sequnlock(&snaprealm_lock);
>  }

Adding/removing snaprealm to/from mdsc->snap_realms do not directly
change snaprealm hierarchy.  The places that change snaprealm
hierarchy should be adjust_snap_realm_parent() and the code block in
ceph_handle_snap() that handle CEPH_SNAP_OP_SPLIT.

The code block in ceph_handle_snap() that handle CEPH_SNAP_OP_SPLIT
may require lots of cpu cycles, not suitable for seq lock.

>
>  /*
> @@ -136,9 +158,14 @@ static struct ceph_snap_realm *ceph_create_snap_realm(
>  static struct ceph_snap_realm *__lookup_snap_realm(struct ceph_mds_client *mdsc,
>                                                    u64 ino)
>  {
> -       struct rb_node *n = mdsc->snap_realms.rb_node;
> -       struct ceph_snap_realm *r;
> -
> +       struct rb_node *n;
> +       struct ceph_snap_realm *realm, *r;
> +       unsigned seq;
> +
> +retry:
> +       realm = NULL;
> +       seq = read_seqbegin(&snaprealm_lock);
> +       n = mdsc->snap_realms.rb_node;
>         while (n) {
>                 r = rb_entry(n, struct ceph_snap_realm, node);
>                 if (ino < r->ino)
> @@ -147,10 +174,14 @@ static struct ceph_snap_realm *__lookup_snap_realm(struct ceph_mds_client *mdsc,
>                         n = n->rb_right;
>                 else {
>                         dout("lookup_snap_realm %llx %p\n", r->ino, r);
> -                       return r;
> +                       realm = r;
> +                       break;
>                 }
>         }
> -       return NULL;
> +
> +       if (read_seqretry(&snaprealm_lock, seq))
> +               goto retry;
> +       return realm;
>  }

caller of __lookup_snap_realm() should hold mdsc->snap_rwsem, no need
to use seq lock.

>
>  struct ceph_snap_realm *ceph_lookup_snap_realm(struct ceph_mds_client *mdsc,
> @@ -174,7 +205,9 @@ static void __destroy_snap_realm(struct ceph_mds_client *mdsc,
>  {
>         dout("__destroy_snap_realm %p %llx\n", realm, realm->ino);
>
> +       write_seqlock(&snaprealm_lock);
>         rb_erase(&realm->node, &mdsc->snap_realms);
> +       write_sequnlock(&snaprealm_lock);
>
>         if (realm->parent) {
>                 list_del_init(&realm->child_item);
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 2beeec07fa76..6474e8d875b7 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -760,6 +760,8 @@ static inline int default_congestion_kb(void)
>
>
>  /* snap.c */
> +extern seqlock_t snaprealm_lock;
> +
>  struct ceph_snap_realm *ceph_lookup_snap_realm(struct ceph_mds_client *mdsc,
>                                                u64 ino);
>  extern void ceph_get_snap_realm(struct ceph_mds_client *mdsc,
> --

For the above reason, I think we'd better not to introduce the new seq
lock. Just read lock mdsc->snap_rwsem when walking the snaprealm
hierarchy.

Regards
Yan, Zheng

> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
