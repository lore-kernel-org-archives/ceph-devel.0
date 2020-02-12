From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: remove CEPH_MOUNT_OPT_FSCACHE flag
Date: Wed, 12 Feb 2020 10:59:57 +0100
Message-ID: <CAOi1vP88LOiZ051+xNkPTaxb0Z=iM=Ygs=reW3EQwOyRpyON0A@mail.gmail.com>
References: <20200212082435.18118-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io1-f65.google.com ([209.85.166.65]:35739 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbgBLJ7i (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Feb 2020 04:59:38 -0500
Received: by mail-io1-f65.google.com with SMTP id h8so1562296iob.2
        for <ceph-devel@vger.kernel.org>; Wed, 12 Feb 2020 01:59:38 -0800 (PST)
In-Reply-To: <20200212082435.18118-1-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Feb 12, 2020 at 9:24 AM <xiubli@redhat.com> wrote:
>
> From: Xiubo Li <xiubli@redhat.com>
>
> Since we can figure out whether the fscache is enabled or not by
> using the fscache_uniq and this flag is redundant.
>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/ceph/super.c | 9 +++------
>  fs/ceph/super.h | 9 ++++-----
>  2 files changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 48f86eb82b9b..8df506dd9039 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -383,10 +383,7 @@ static int ceph_parse_mount_param(struct fs_context *fc,
>  #ifdef CONFIG_CEPH_FSCACHE
>                 kfree(fsopt->fscache_uniq);
>                 fsopt->fscache_uniq = NULL;
> -               if (result.negated) {
> -                       fsopt->flags &= ~CEPH_MOUNT_OPT_FSCACHE;
> -               } else {
> -                       fsopt->flags |= CEPH_MOUNT_OPT_FSCACHE;
> +               if (!result.negated) {
>                         fsopt->fscache_uniq = param->string;
>                         param->string = NULL;
>                 }
> @@ -605,7 +602,7 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
>                 seq_puts(m, ",nodcache");
>         if (fsopt->flags & CEPH_MOUNT_OPT_INO32)
>                 seq_puts(m, ",ino32");
> -       if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE) {
> +       if (fsopt->fscache_uniq) {
>                 seq_show_option(m, "fsc", fsopt->fscache_uniq);
>         }
>         if (fsopt->flags & CEPH_MOUNT_OPT_NOPOOLPERM)
> @@ -969,7 +966,7 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
>                         goto out;
>
>                 /* setup fscache */
> -               if (fsc->mount_options->flags & CEPH_MOUNT_OPT_FSCACHE) {
> +               if (fsc->mount_options->fscache_uniq) {
>                         err = ceph_fscache_register_fs(fsc, fc);
>                         if (err < 0)
>                                 goto out;
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index ebc25072b19b..ad44b98f3c3b 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -38,11 +38,10 @@
>  #define CEPH_MOUNT_OPT_NOASYNCREADDIR  (1<<7) /* no dcache readdir */
>  #define CEPH_MOUNT_OPT_INO32           (1<<8) /* 32 bit inos */
>  #define CEPH_MOUNT_OPT_DCACHE          (1<<9) /* use dcache for readdir etc */
> -#define CEPH_MOUNT_OPT_FSCACHE         (1<<10) /* use fscache */
> -#define CEPH_MOUNT_OPT_NOPOOLPERM      (1<<11) /* no pool permission check */
> -#define CEPH_MOUNT_OPT_MOUNTWAIT       (1<<12) /* mount waits if no mds is up */
> -#define CEPH_MOUNT_OPT_NOQUOTADF       (1<<13) /* no root dir quota in statfs */
> -#define CEPH_MOUNT_OPT_NOCOPYFROM      (1<<14) /* don't use RADOS 'copy-from' op */
> +#define CEPH_MOUNT_OPT_NOPOOLPERM      (1<<10) /* no pool permission check */
> +#define CEPH_MOUNT_OPT_MOUNTWAIT       (1<<11) /* mount waits if no mds is up */
> +#define CEPH_MOUNT_OPT_NOQUOTADF       (1<<12) /* no root dir quota in statfs */
> +#define CEPH_MOUNT_OPT_NOCOPYFROM      (1<<13) /* don't use RADOS 'copy-from' op */
>
>  #define CEPH_MOUNT_OPT_DEFAULT                 \
>         (CEPH_MOUNT_OPT_DCACHE |                \

Hi Xiubo,

Did you test this both with and without supplying a uniquifier (i.e.
both "-o fsc=<uniquifier>" and "-o fsc" cases?  I'm pretty sure this
breaks "-o fsc" case...

Thanks,

                Ilya
