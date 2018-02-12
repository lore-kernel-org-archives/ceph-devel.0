From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: change permission for readonly debugfs entries
Date: Mon, 12 Feb 2018 15:39:54 +0100
Message-ID: <CAOi1vP8LpE3mNJtK6-zo2OXOtOSBBaAZY6aY33vkmGaFj+R0Tg@mail.gmail.com>
References: <1518243486-215336-1-git-send-email-cgxu519@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35293 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932629AbeBLOjz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Feb 2018 09:39:55 -0500
Received: by mail-it0-f66.google.com with SMTP id e1so6735315ita.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Feb 2018 06:39:55 -0800 (PST)
In-Reply-To: <1518243486-215336-1-git-send-email-cgxu519@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>

On Sat, Feb 10, 2018 at 7:18 AM, Chengguang Xu <cgxu519@icloud.com> wrote:
> Remove write permission for debugfs entries which only have readonly function.
>
> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
> ---
>  fs/ceph/debugfs.c  |  8 ++++----
>  net/ceph/debugfs.c | 10 +++++-----
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index 644def8..abdf98d 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -260,7 +260,7 @@ int ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
>                 goto out;
>
>         fsc->debugfs_mdsmap = debugfs_create_file("mdsmap",
> -                                       0600,
> +                                       0400,
>                                         fsc->client->debugfs_dir,
>                                         fsc,
>                                         &mdsmap_show_fops);
> @@ -268,7 +268,7 @@ int ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
>                 goto out;
>
>         fsc->debugfs_mds_sessions = debugfs_create_file("mds_sessions",
> -                                       0600,
> +                                       0400,
>                                         fsc->client->debugfs_dir,
>                                         fsc,
>                                         &mds_sessions_show_fops);
> @@ -276,7 +276,7 @@ int ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
>                 goto out;
>
>         fsc->debugfs_mdsc = debugfs_create_file("mdsc",
> -                                               0600,
> +                                               0400,
>                                                 fsc->client->debugfs_dir,
>                                                 fsc,
>                                                 &mdsc_show_fops);
> @@ -292,7 +292,7 @@ int ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
>                 goto out;
>
>         fsc->debugfs_dentry_lru = debugfs_create_file("dentry_lru",
> -                                       0600,
> +                                       0400,
>                                         fsc->client->debugfs_dir,
>                                         fsc,
>                                         &dentry_lru_show_fops);
> diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
> index 1eef680..0ef0f32 100644
> --- a/net/ceph/debugfs.c
> +++ b/net/ceph/debugfs.c
> @@ -418,7 +418,7 @@ int ceph_debugfs_client_init(struct ceph_client *client)
>                 goto out;
>
>         client->monc.debugfs_file = debugfs_create_file("monc",
> -                                                     0600,
> +                                                     0400,
>                                                       client->debugfs_dir,
>                                                       client,
>                                                       &monc_show_fops);
> @@ -426,7 +426,7 @@ int ceph_debugfs_client_init(struct ceph_client *client)
>                 goto out;
>
>         client->osdc.debugfs_file = debugfs_create_file("osdc",
> -                                                     0600,
> +                                                     0400,
>                                                       client->debugfs_dir,
>                                                       client,
>                                                       &osdc_show_fops);
> @@ -434,7 +434,7 @@ int ceph_debugfs_client_init(struct ceph_client *client)
>                 goto out;
>
>         client->debugfs_monmap = debugfs_create_file("monmap",
> -                                       0600,
> +                                       0400,
>                                         client->debugfs_dir,
>                                         client,
>                                         &monmap_show_fops);
> @@ -442,7 +442,7 @@ int ceph_debugfs_client_init(struct ceph_client *client)
>                 goto out;
>
>         client->debugfs_osdmap = debugfs_create_file("osdmap",
> -                                       0600,
> +                                       0400,
>                                         client->debugfs_dir,
>                                         client,
>                                         &osdmap_show_fops);
> @@ -450,7 +450,7 @@ int ceph_debugfs_client_init(struct ceph_client *client)
>                 goto out;
>
>         client->debugfs_options = debugfs_create_file("client_options",
> -                                       0600,
> +                                       0400,
>                                         client->debugfs_dir,
>                                         client,
>                                         &client_options_show_fops);

Applied.

Thanks,

                Ilya
