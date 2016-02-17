From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] ceph: kill ceph_empty_snapc
Date: Wed, 17 Feb 2016 09:48:23 +0800
Message-ID: <CAAM7YAktNVX9=ndbuXgkJmRUM_arAfEm6GYAtKr2qJV1X5H3BQ@mail.gmail.com>
References: <1455660937-6694-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35786 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964801AbcBQBsY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Feb 2016 20:48:24 -0500
Received: by mail-wm0-f50.google.com with SMTP id c200so190102220wme.0
        for <ceph-devel@vger.kernel.org>; Tue, 16 Feb 2016 17:48:24 -0800 (PST)
In-Reply-To: <1455660937-6694-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Zheng Yan <zyan@redhat.com>

On Wed, Feb 17, 2016 at 6:15 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> ceph_empty_snapc->num_snaps == 0 at all times.  Passing such a snapc to
> ceph_osdc_alloc_request() (possibly through ceph_osdc_new_request()) is
> equivalent to passing NULL, as ceph_osdc_alloc_request() uses it only
> for sizing the request message.
>
> Further, in all four cases the subsequent ceph_osdc_build_request() is
> passed NULL for snapc, meaning that 0 is encoded for seq and num_snaps
> and making ceph_empty_snapc entirely useless.  The two cases where it
> actually mattered were removed in commits 860560904962 ("ceph: avoid
> sending unnessesary FLUSHSNAP message") and 23078637e054 ("ceph: fix
> queuing inode to mdsdir's snaprealm").

 Reviewed-by:  Yan, Zheng <zyan@redhat.com>

>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  fs/ceph/addr.c  | 13 +++++--------
>  fs/ceph/snap.c  | 16 ----------------
>  fs/ceph/super.c |  8 +-------
>  fs/ceph/super.h |  3 ---
>  4 files changed, 6 insertions(+), 34 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index aea449a4d038..32f57a1f1baf 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1609,7 +1609,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
>                                     ceph_vino(inode), 0, &len, 0, 1,
>                                     CEPH_OSD_OP_CREATE,
>                                     CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE,
> -                                   ceph_empty_snapc, 0, 0, false);
> +                                   NULL, 0, 0, false);
>         if (IS_ERR(req)) {
>                 err = PTR_ERR(req);
>                 goto out;
> @@ -1627,9 +1627,8 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
>                                     ceph_vino(inode), 0, &len, 1, 3,
>                                     CEPH_OSD_OP_WRITE,
>                                     CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE,
> -                                   ceph_empty_snapc,
> -                                   ci->i_truncate_seq, ci->i_truncate_size,
> -                                   false);
> +                                   NULL, ci->i_truncate_seq,
> +                                   ci->i_truncate_size, false);
>         if (IS_ERR(req)) {
>                 err = PTR_ERR(req);
>                 goto out;
> @@ -1750,8 +1749,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci, u32 pool)
>                 goto out;
>         }
>
> -       rd_req = ceph_osdc_alloc_request(&fsc->client->osdc,
> -                                        ceph_empty_snapc,
> +       rd_req = ceph_osdc_alloc_request(&fsc->client->osdc, NULL,
>                                          1, false, GFP_NOFS);
>         if (!rd_req) {
>                 err = -ENOMEM;
> @@ -1765,8 +1763,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci, u32 pool)
>                  "%llx.00000000", ci->i_vino.ino);
>         rd_req->r_base_oid.name_len = strlen(rd_req->r_base_oid.name);
>
> -       wr_req = ceph_osdc_alloc_request(&fsc->client->osdc,
> -                                        ceph_empty_snapc,
> +       wr_req = ceph_osdc_alloc_request(&fsc->client->osdc, NULL,
>                                          1, false, GFP_NOFS);
>         if (!wr_req) {
>                 err = -ENOMEM;
> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> index 4aa7122a8d38..9caaa7ffc93f 100644
> --- a/fs/ceph/snap.c
> +++ b/fs/ceph/snap.c
> @@ -296,8 +296,6 @@ static int cmpu64_rev(const void *a, const void *b)
>  }
>
>
> -struct ceph_snap_context *ceph_empty_snapc;
> -
>  /*
>   * build the snap context for a given realm.
>   */
> @@ -987,17 +985,3 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
>                 up_write(&mdsc->snap_rwsem);
>         return;
>  }
> -
> -int __init ceph_snap_init(void)
> -{
> -       ceph_empty_snapc = ceph_create_snap_context(0, GFP_NOFS);
> -       if (!ceph_empty_snapc)
> -               return -ENOMEM;
> -       ceph_empty_snapc->seq = 1;
> -       return 0;
> -}
> -
> -void ceph_snap_exit(void)
> -{
> -       ceph_put_snap_context(ceph_empty_snapc);
> -}
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index e82acc6f3ac3..715282a92a07 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -1042,19 +1042,14 @@ static int __init init_ceph(void)
>
>         ceph_flock_init();
>         ceph_xattr_init();
> -       ret = ceph_snap_init();
> -       if (ret)
> -               goto out_xattr;
>         ret = register_filesystem(&ceph_fs_type);
>         if (ret)
> -               goto out_snap;
> +               goto out_xattr;
>
>         pr_info("loaded (mds proto %d)\n", CEPH_MDSC_PROTOCOL);
>
>         return 0;
>
> -out_snap:
> -       ceph_snap_exit();
>  out_xattr:
>         ceph_xattr_exit();
>         destroy_caches();
> @@ -1066,7 +1061,6 @@ static void __exit exit_ceph(void)
>  {
>         dout("exit_ceph\n");
>         unregister_filesystem(&ceph_fs_type);
> -       ceph_snap_exit();
>         ceph_xattr_exit();
>         destroy_caches();
>  }
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index ff236d316aec..16f9edc5d1c7 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -719,7 +719,6 @@ static inline int default_congestion_kb(void)
>
>
>  /* snap.c */
> -extern struct ceph_snap_context *ceph_empty_snapc;
>  struct ceph_snap_realm *ceph_lookup_snap_realm(struct ceph_mds_client *mdsc,
>                                                u64 ino);
>  extern void ceph_get_snap_realm(struct ceph_mds_client *mdsc,
> @@ -736,8 +735,6 @@ extern void ceph_queue_cap_snap(struct ceph_inode_info *ci);
>  extern int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
>                                   struct ceph_cap_snap *capsnap);
>  extern void ceph_cleanup_empty_realms(struct ceph_mds_client *mdsc);
> -extern int ceph_snap_init(void);
> -extern void ceph_snap_exit(void);
>
>  /*
>   * a cap_snap is "pending" if it is still awaiting an in-progress
> --
> 2.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
