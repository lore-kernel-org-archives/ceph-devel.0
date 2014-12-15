From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] ceph: introduce global empty snap context
Date: Mon, 15 Dec 2014 16:00:27 +0300
Message-ID: <CALFYKtDHA+M-TU9nOQRx9sTd0aixHWMt5JQFd1+nPUOebwK89w@mail.gmail.com>
References: <CALFYKtAHtrg10kH7L_yVU_5UzL-fXtoPZyFNMJ8h94b_vfqYFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:53348 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbaLONA2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Dec 2014 08:00:28 -0500
Received: by mail-qc0-f175.google.com with SMTP id b13so9483516qcw.6
        for <ceph-devel@vger.kernel.org>; Mon, 15 Dec 2014 05:00:27 -0800 (PST)
In-Reply-To: <CALFYKtAHtrg10kH7L_yVU_5UzL-fXtoPZyFNMJ8h94b_vfqYFQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Nov 13, 2014 at 11:23 PM, Ilya Dryomov <ilya.dryomov@inktank.com> wrote:
> This patch wasn't posted on ceph-devel, posting..

Hi Zheng,

Ping - I had some comments (below), mostly trivial but a potential
cached_context leak is what worries me.

Thanks,

                Ilya


>
> From d57f921fd3c7cbe768f13bc58e547d83274f47a8 Mon Sep 17 00:00:00 2001
> From: "Yan, Zheng" <zyan@redhat.com>
> Date: Thu, 6 Nov 2014 15:09:41 +0800
> Subject: [PATCH] ceph: introduce global empty snap context
>
> Current snaphost code does not properly handle moving inode from one
> empty snap realm to another empty snap realm. After changing inode's
> snap realm, some dirty pages' snap context can be not equal to inode's
> i_head_snap. This can trigger BUG() in ceph_put_wrbuffer_cap_refs()
>
> The fix is introduce a global empty snap context for all empty snap
> realm. This avoids triggering the BUG() for filesystem with no snapshot.
>
> Fixes: http://tracker.ceph.com/issues/9928
> Signed-off-by: Yan, Zheng <zyan@redhat.com>
> ---
>  fs/ceph/snap.c  | 26 +++++++++++++++++++++++++-
>  fs/ceph/super.c |  6 ++++++
>  fs/ceph/super.h |  2 ++
>  3 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> index c1cc993225e3..24b454a0e64c 100644
> --- a/fs/ceph/snap.c
> +++ b/fs/ceph/snap.c
> @@ -288,6 +288,9 @@ static int cmpu64_rev(const void *a, const void *b)
>         return 0;
>  }
>
> +
> +static struct ceph_snap_context *empty_snapc;
> +
>  /*
>   * build the snap context for a given realm.
>   */
> @@ -328,6 +331,12 @@ static int build_snap_context(struct
> ceph_snap_realm *realm)
>                 return 0;
>         }
>
> +       if (num == 0 && realm->seq == empty_snapc->seq) {
> +               ceph_get_snap_context(empty_snapc);
> +               realm->cached_context = empty_snapc;
> +               return 0;
>
> Can there be a cached_context here that we would need to let go of?
> IOW, shouldn't this be
>
> +       if (num == 0 && realm->seq == empty_snapc->seq) {
> +               ceph_get_snap_context(empty_snapc);
> +               goto out;
> +       }
>
>         ...
>
>              realm->ino, realm, snapc, snapc->seq,
>              (unsigned int) snapc->num_snaps);
>
> +out:
>         ceph_put_snap_context(realm->cached_context);
>         realm->cached_context = snapc;
>         return 0;
>
> ?
>
> +       }
> +
>         /* alloc new snap context */
>         err = -ENOMEM;
>         if (num > (SIZE_MAX - sizeof(*snapc)) / sizeof(u64))
> @@ -465,6 +474,9 @@ void ceph_queue_cap_snap(struct ceph_inode_info *ci)
>                    cap_snap.  lucky us. */
>                 dout("queue_cap_snap %p already pending\n", inode);
>                 kfree(capsnap);
> +       } else if (ci->i_snap_realm->cached_context == empty_snapc) {
> +               dout("queue_cap_snap %p empty snapc\n", inode);
> +               kfree(capsnap);
>         } else if (dirty & (CEPH_CAP_AUTH_EXCL|CEPH_CAP_XATTR_EXCL|
>                             CEPH_CAP_FILE_EXCL|CEPH_CAP_FILE_WR)) {
>                 struct ceph_snap_context *snapc = ci->i_head_snapc;
> @@ -925,5 +937,17 @@ out:
>         return;
>  }
>
> +int ceph_snap_init(void)
>
> I see you put __init on the declaration.  While that seems to work
> I think it's preferred to have it on the definition:
>
> int __init ceph_snap_init(void)
>
> +{
> +       empty_snapc = ceph_create_snap_context(0, GFP_NOFS);
> +       if (!empty_snapc)
> +               return -ENOMEM;
> +       empty_snapc->seq = 1;
> +       empty_snapc->num_snaps = 0;
>
> Setting num_snaps seems unnecessary, ceph_create_snap_context() does
> that for you.
>
> +       return 0;
> +}
>
> -
> +void ceph_snap_exit(void)
> +{
> +       ceph_put_snap_context(empty_snapc);
> +}
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index f6e12377335c..2b5481f1b9c7 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -1028,6 +1028,9 @@ static int __init init_ceph(void)
>
>         ceph_flock_init();
>         ceph_xattr_init();
> +       ret = ceph_snap_init();
> +       if (ret)
> +               goto out_xattr;
>         ret = register_filesystem(&ceph_fs_type);
>         if (ret)
>                 goto out_icache;
> @@ -1037,6 +1040,8 @@ static int __init init_ceph(void)
>         return 0;
>
>  out_icache:
>
> You could rename the nonsensical out_icache to out_snap while you are
> at it.
>
> +       ceph_snap_exit();
> +out_xattr:
>         ceph_xattr_exit();
>         destroy_caches();
>  out:
> @@ -1047,6 +1052,7 @@ static void __exit exit_ceph(void)
>  {
>         dout("exit_ceph\n");
>         unregister_filesystem(&ceph_fs_type);
> +       ceph_snap_exit();
>         ceph_xattr_exit();
>         destroy_caches();
>  }
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index aca22879b41f..9f63f18bb783 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -699,6 +699,8 @@ extern void ceph_queue_cap_snap(struct ceph_inode_info *ci);
>  extern int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
>                                   struct ceph_cap_snap *capsnap);
>  extern void ceph_cleanup_empty_realms(struct ceph_mds_client *mdsc);
> +extern int __init ceph_snap_init(void);
>
> extern int ceph_snap_init(void); will do.
>
> +extern void ceph_snap_exit(void);
>
>  /*
>   * a cap_snap is "pending" if it is still awaiting an in-progress
> --
> 2.1.1
