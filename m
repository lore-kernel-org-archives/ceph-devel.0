From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2] ceph: fix posix acl couldn't be settable
Date: Tue, 11 Feb 2020 11:35:30 +0100
Message-ID: <CAOi1vP-MZscD1d0DbgqDbjV0SjNmOBWu+onc7xOR31izgxYxOQ@mail.gmail.com>
References: <20200211065316.59091-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-il1-f193.google.com ([209.85.166.193]:44326 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbgBKKfM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Feb 2020 05:35:12 -0500
Received: by mail-il1-f193.google.com with SMTP id s85so2980808ill.11
        for <ceph-devel@vger.kernel.org>; Tue, 11 Feb 2020 02:35:11 -0800 (PST)
In-Reply-To: <20200211065316.59091-1-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, David Howells <dhowells@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Feb 11, 2020 at 7:53 AM <xiubli@redhat.com> wrote:
>
> From: Xiubo Li <xiubli@redhat.com>
>
> For the old mount API, the module parameters parseing function will
> be called in ceph_mount() and also just after the default posix acl
> flag set, so we can control to enable/disable it via the mount option.
>
> But for the new mount API, it will call the module parameters
> parseing function before ceph_get_tree(), so the posix acl will always
> be enabled.
>
> Fixes: 82995cc6c5ae ("libceph, rbd, ceph: convert to use the new mount API")
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>
> Changed in V2:
> - move default fc->sb_flags setting to ceph_init_fs_context().
>
>  fs/ceph/super.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 5fef4f59e13e..c3d9ac768cec 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -1089,10 +1089,6 @@ static int ceph_get_tree(struct fs_context *fc)
>         if (!fc->source)
>                 return invalf(fc, "ceph: No source");
>
> -#ifdef CONFIG_CEPH_FS_POSIX_ACL
> -       fc->sb_flags |= SB_POSIXACL;
> -#endif
> -
>         /* create client (which we may/may not use) */
>         fsc = create_fs_client(pctx->opts, pctx->copts);
>         pctx->opts = NULL;
> @@ -1215,6 +1211,10 @@ static int ceph_init_fs_context(struct fs_context *fc)
>         fsopt->max_readdir_bytes = CEPH_MAX_READDIR_BYTES_DEFAULT;
>         fsopt->congestion_kb = default_congestion_kb();
>
> +#ifdef CONFIG_CEPH_FS_POSIX_ACL
> +       fc->sb_flags |= SB_POSIXACL;
> +#endif
> +
>         fc->fs_private = pctx;
>         fc->ops = &ceph_context_ops;
>         return 0;

Applied.

Thanks,

                Ilya
