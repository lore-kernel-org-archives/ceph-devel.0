From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2] ceph: use seq_show_option for string type options
Date: Thu, 15 Feb 2018 16:50:59 +0100
Message-ID: <CAOi1vP_KHQHRm2ZbsPxyTh2f8J4CjRWmMSqeh3JMegE5r=bM-Q@mail.gmail.com>
References: <1518680345-17700-1-git-send-email-cgxu519@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:45128 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424947AbeBOPvB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Feb 2018 10:51:01 -0500
Received: by mail-io0-f193.google.com with SMTP id p188so1023356ioe.12
        for <ceph-devel@vger.kernel.org>; Thu, 15 Feb 2018 07:51:00 -0800 (PST)
In-Reply-To: <1518680345-17700-1-git-send-email-cgxu519@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Feb 15, 2018 at 8:39 AM, Chengguang Xu <cgxu519@icloud.com> wrote:
> Using seq_show_option to replace seq_printf for string type options.
>
> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
> ---
> Changes since v1:
> - Code cleanup for showing fscache related options.
>
>  fs/ceph/super.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index a62d2a9..f9418d4 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -511,10 +511,7 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
>         if ((fsopt->flags & CEPH_MOUNT_OPT_DCACHE) == 0)
>                 seq_puts(m, ",nodcache");
>         if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE) {
> -               if (fsopt->fscache_uniq)
> -                       seq_printf(m, ",fsc=%s", fsopt->fscache_uniq);
> -               else
> -                       seq_puts(m, ",fsc");
> +               seq_show_option(m, "fsc", fsopt->fscache_uniq);
>         }
>         if (fsopt->flags & CEPH_MOUNT_OPT_NOPOOLPERM)
>                 seq_puts(m, ",nopoolperm");
> @@ -527,7 +524,7 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
>  #endif
>
>         if (fsopt->mds_namespace)
> -               seq_printf(m, ",mds_namespace=%s", fsopt->mds_namespace);
> +               seq_show_option(m, "mds_namespace", fsopt->mds_namespace);
>         if (fsopt->wsize)
>                 seq_printf(m, ",wsize=%d", fsopt->wsize);
>         if (fsopt->rsize != CEPH_MAX_READ_SIZE)

Applied.

Thanks,

                Ilya
