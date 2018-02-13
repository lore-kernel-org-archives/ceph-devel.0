From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: use seq_show_option for string type options
Date: Tue, 13 Feb 2018 10:45:43 +0100
Message-ID: <CAOi1vP9pT2GSpOqULvrUiACZ-tAdh8bHXASyDEfqrcsyaUTFXA@mail.gmail.com>
References: <1518485459-199037-1-git-send-email-cgxu519@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:39968 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934243AbeBMJpo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Feb 2018 04:45:44 -0500
Received: by mail-it0-f68.google.com with SMTP id v186so4896278itc.5
        for <ceph-devel@vger.kernel.org>; Tue, 13 Feb 2018 01:45:44 -0800 (PST)
In-Reply-To: <1518485459-199037-1-git-send-email-cgxu519@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Feb 13, 2018 at 2:30 AM, Chengguang Xu <cgxu519@icloud.com> wrote:
> Using seq_show_option to replace seq_printf for string type options.
>
> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
> ---
>  fs/ceph/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index a62d2a9..d8a33ad 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -512,7 +512,7 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
>                 seq_puts(m, ",nodcache");
>         if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE) {
>                 if (fsopt->fscache_uniq)
> -                       seq_printf(m, ",fsc=%s", fsopt->fscache_uniq);
> +                       seq_show_option(m, "fsc", fsopt->fscache_uniq);
>                 else
>                         seq_puts(m, ",fsc");

Hi Chengguang,

seq_show_option() should be able to handle !fsopt->fscache_uniq?

Thanks,

                Ilya
