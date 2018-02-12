From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2] ceph: minor cleanups of showing options
Date: Mon, 12 Feb 2018 16:58:38 +0100
Message-ID: <CAOi1vP9NOTMNVZgGvAf1OHXX4Ew+u67p3oUqqJsHXAD+BkotYw@mail.gmail.com>
References: <1517925261-50747-1-git-send-email-cgxu519@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:46730 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932878AbeBLP6j (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Feb 2018 10:58:39 -0500
Received: by mail-io0-f179.google.com with SMTP id k80so6398571ioe.13
        for <ceph-devel@vger.kernel.org>; Mon, 12 Feb 2018 07:58:39 -0800 (PST)
In-Reply-To: <1517925261-50747-1-git-send-email-cgxu519@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>

On Tue, Feb 6, 2018 at 2:54 PM, Chengguang Xu <cgxu519@icloud.com> wrote:
> Minor cleanups of showing options for mount and client.
>
> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
> ---
> Changes since v1:
> - Do not change comma seqence in ceph_print_client_options()
>  because there is another caller from different path.
>
>  fs/ceph/super.c        | 13 ++-----------
>  net/ceph/ceph_common.c |  3 +++
>  2 files changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index bfc85b2..7f1e212 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -489,21 +489,12 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
>  {
>         struct ceph_fs_client *fsc = ceph_sb_to_client(root->d_sb);
>         struct ceph_mount_options *fsopt = fsc->mount_options;
> -       size_t pos;
>         int ret;
>
> -       /* a comma between MNT/MS and client options */
> -       seq_putc(m, ',');
> -       pos = m->count;
> -
>         ret = ceph_print_client_options(m, fsc->client);
>         if (ret)
>                 return ret;
>
> -       /* retract our comma if no client options */
> -       if (m->count == pos)
> -               m->count--;
> -
>         if (fsopt->flags & CEPH_MOUNT_OPT_DIRSTAT)
>                 seq_puts(m, ",dirstat");
>         if ((fsopt->flags & CEPH_MOUNT_OPT_RBYTES))
> @@ -514,7 +505,7 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
>                 seq_puts(m, ",nodcache");
>         if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE) {
>                 if (fsopt->fscache_uniq)
> -                       seq_printf(m, ",fsc=%s", fsopt->fscache_uniq);
> +                       seq_show_option(m, "fsc", fsopt->fscache_uniq);
>                 else
>                         seq_puts(m, ",fsc");
>         }
> @@ -529,7 +520,7 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
>  #endif
>
>         if (fsopt->mds_namespace)
> -               seq_printf(m, ",mds_namespace=%s", fsopt->mds_namespace);
> +               seq_show_option(m, "mds_namespace", fsopt->mds_namespace);
>         if (fsopt->wsize)
>                 seq_printf(m, ",wsize=%d", fsopt->wsize);
>         if (fsopt->rsize != CEPH_MAX_READ_SIZE)

I don't think changing the way commas work is worth it.  If you resend
just the seq_printf -> seq_show_option bits, I'll take that patch.

Thanks,

                Ilya
