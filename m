From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: simplify __rbd_init_snaps_header()
Date: Tue, 07 Aug 2012 16:27:30 -0700
Message-ID: <5021A462.2030603@inktank.com>
References: <502002D4.6070701@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58405 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030260Ab2HGX1e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Aug 2012 19:27:34 -0400
Received: by yenl2 with SMTP id l2so199569yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Aug 2012 16:27:33 -0700 (PDT)
In-Reply-To: <502002D4.6070701@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/06/2012 10:45 AM, Alex Elder wrote:
> The purpose of __rbd_init_snaps_header() is to compare a new
> snapshot context with an rbd device's list of existing snapshots.
> It updates the list by adding any new snapshots or removing any
> that are not present in the new snapshot context.
>
> The code as written is a little confusing, because it traverses both
> the existing snapshot list and the set of snapshots in the snapshot
> context in reverse.  This was done based on an assumption about
> snapshots that is not true--namely that a duplicate snapshot name
> could cause an error in intepreting things if they were not
> processed in ascending order.
>
> These precautions are not necessary, because:
>      - all snapshots are uniquely identified by their snapshot id
>      - a new snapshot cannot be created if the rbd device has another
>        snapshot with the same name
> (It is furthermore not currently possible to rename a snapshot.)
>
> This patch re-implements __rbd_init_snaps_header() so it passes
> through both the existing snapshot list and the entries in the
> snapshot context in forward order.  It still does the same thing
> as before, but I find the logic considerably easier to understand.
>
> By going forward through the names in the snapshot context, there
> is no longer a need for the rbd_prev_snap_name() helper function.
>
> Signed-off-by: Alex Elder <elder@inktank.com>

This is more readable to me as well, but a few nits below. Other than 
those, Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> ---
>   drivers/block/rbd.c |  166
> +++++++++++++++++++++++++++-------------------------
>   1 file changed, 88 insertions(+), 78 deletions(-)
>
> Index: b/drivers/block/rbd.c
> ===================================================================
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2066,98 +2066,108 @@ err:
>       return ERR_PTR(ret);
>   }
>
> +/* These might otherwise belong in <linux/list.h> */
> +
> +/* Return the next list entry, or a null pointer if there are no more */
> +
> +#define list_next_entry(list, head, type, member) \
> +    (list_is_last(list, head) ? NULL : list_entry(list, type, member))
> +

This isn't used in this patch, is it used later?

>   /*
> - * search for the previous snap in a null delimited string list
> + * Insert a new entry before the given next one in the list.  Adjust
> + * the list header if appropriate.
>    */
> -const char *rbd_prev_snap_name(const char *name, const char *start)
> +static inline void list_insert(struct list_head *new,
> +                   struct list_head *next,
> +                   struct list_head *head)

It looks like list_add_tail(new, next) does what we need in the one
place that uses this.

>   {
> -    if (name < start + 2)
> -        return NULL;
> +    struct list_head *prev = next->prev;
>
> -    name -= 2;
> -    while (*name) {
> -        if (name == start)
> -            return start;
> -        name--;
> -    }
> -    return name + 1;
> +    new->prev = prev;
> +    prev->next = new;
> +    new->next = next;
> +    next->prev = new;
> +    if (next == head)
> +        head->next = new;
>   }
>
>   /*
> - * compare the old list of snapshots that we have to what's in the header
> - * and update it accordingly. Note that the header holds the snapshots
> - * in a reverse order (from newest to oldest) and we need to go from
> - * older to new so that we don't get a duplicate snap name when
> - * doing the process (e.g., removed snapshot and recreated a new
> - * one with the same name.
> + * Scan the rbd device's current snapshot list and compare it to the
> + * newly-received snapshot context.  Remove any existing snapshots
> + * not present in the new snapshot context.  Add a new snapshot for
> + * any snaphots in the snapshot context not in the current list.
> + * And verify there are no changes to snapshots we already know
> + * about.
> + *
> + * Assumes the snapshots in the snapshot context are sorted by
> + * snapshot id, highest id first.  (Snapshots in the rbd_dev's list
> + * are also maintained in that order.)
>    */
>   static int __rbd_init_snaps_header(struct rbd_device *rbd_dev)
>   {
> -    const char *name, *first_name;
> -    int i = rbd_dev->header.total_snaps;
> -    struct rbd_snap *snap, *old_snap = NULL;
> -    struct list_head *p, *n;
> -
> -    first_name = rbd_dev->header.snap_names;
> -    name = first_name + rbd_dev->header.snap_names_len;
> -
> -    list_for_each_prev_safe(p, n, &rbd_dev->snaps) {
> -        u64 cur_id;
> -
> -        old_snap = list_entry(p, struct rbd_snap, node);
> -
> -        if (i)
> -            cur_id = rbd_dev->header.snapc->snaps[i - 1];
> -
> -        if (!i || old_snap->id < cur_id) {
> -            /*
> -             * old_snap->id was skipped, thus was
> -             * removed.  If this rbd_dev is mapped to
> -             * the removed snapshot, record that it no
> -             * longer exists, to prevent further I/O.
> -             */
> -            if (rbd_dev->snap_id == old_snap->id)
> +    struct ceph_snap_context * const snapc = rbd_dev->header.snapc;

Putting the const after the type looks odd to me, especially when it's
the opposite on the next line.

> +    const u32 snap_count = snapc->num_snaps;
> +    char *snap_name = rbd_dev->header.snap_names;
> +    struct list_head * const head = &rbd_dev->snaps;

same here

> +    struct list_head *links = head->next;
> +    u32 index = 0;
> +
> +    while (index < snap_count || links != head) {
> +        u64 snap_id;
> +        struct rbd_snap *snap;
> +
> +        snap_id = index < snap_count ? snapc->snaps[index]
> +                         : CEPH_NOSNAP;
> +        snap = links != head ? list_entry(links, struct rbd_snap, node)
> +                     : NULL;
> +        BUG_ON(snap && snap->id == CEPH_NOSNAP);
> +
> +        if (snap_id == CEPH_NOSNAP || (snap && snap->id > snap_id)) {
> +            struct list_head *next = links->next;
> +
> +            /* Existing snapshot not in the new snap context */
> +
> +            if (rbd_dev->snap_id == snap->id)
>                   rbd_dev->snap_exists = false;
> -            __rbd_remove_snap_dev(old_snap);
> -            continue;
> -        }
> -        if (old_snap->id == cur_id) {
> -            /* we have this snapshot already */
> -            i--;
> -            name = rbd_prev_snap_name(name, first_name);
> +            __rbd_remove_snap_dev(snap);
> +
> +            /* Done with this list entry; advance */
> +
> +            links = next;

This could just be links = links->next like you have later.

>               continue;
>           }
> -        for (; i > 0;
> -             i--, name = rbd_prev_snap_name(name, first_name)) {
> -            if (!name) {
> -                WARN_ON(1);
> -                return -EINVAL;
> -            }
> -            cur_id = rbd_dev->header.snapc->snaps[i];
> -            /* snapshot removal? handle it above */
> -            if (cur_id >= old_snap->id)
> -                break;
> -            /* a new snapshot */
> -            snap = __rbd_add_snap_dev(rbd_dev, i - 1, name);
> -            if (IS_ERR(snap))
> -                return PTR_ERR(snap);
> -
> -            /* note that we add it backward so using n and not p */
> -            list_add(&snap->node, n);
> -            p = &snap->node;
> -        }
> -    }
> -    /* we're done going over the old snap list, just add what's left */
> -    for (; i > 0; i--) {
> -        name = rbd_prev_snap_name(name, first_name);
> -        if (!name) {
> -            WARN_ON(1);
> -            return -EINVAL;
> +
> +        if (!snap || (snap_id != CEPH_NOSNAP && snap->id < snap_id)) {
> +            struct rbd_snap *new_snap;
> +
> +            /* We haven't seen this snapshot before */
> +
> +            new_snap = __rbd_add_snap_dev(rbd_dev, index,
> +                            snap_name);
> +            if (IS_ERR(new_snap))
> +                return PTR_ERR(new_snap);
> +
> +            /* New goes before existing, or at end of list */
> +
> +            if (snap)
> +                list_insert(&new_snap->node, &snap->node, head);
> +            else
> +                list_add(&new_snap->node, head);
> +        } else {
> +            /* Already have this one */
> +
> +            BUG_ON(snap->size != rbd_dev->header.snap_sizes[index]);
> +            BUG_ON(strcmp(snap_name, snap->name));
> +
> +            /* Done with this list entry; advance */
> +
> +            links = links->next;
>           }
> -        snap = __rbd_add_snap_dev(rbd_dev, i - 1, name);
> -        if (IS_ERR(snap))
> -            return PTR_ERR(snap);
> -        list_add(&snap->node, &rbd_dev->snaps);
> +
> +        /* Advance to the next entry in the snapshot context */
> +
> +        index++;
> +        snap_name += strlen(snap_name) + 1;
>       }
>
>       return 0;

