From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: avoid memory leak when specifying same option
 several times
Date: Tue, 6 Feb 2018 11:26:01 +0100
Message-ID: <CAOi1vP9z9-cTn5jpiqgb93W4Osb=EQP7YewVQeScE9jsQY+_rg@mail.gmail.com>
References: <1517876755-46814-1-git-send-email-cgxu519@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33837 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752183AbeBFK0C (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Feb 2018 05:26:02 -0500
Received: by mail-io0-f195.google.com with SMTP id c17so1973735iod.1
        for <ceph-devel@vger.kernel.org>; Tue, 06 Feb 2018 02:26:02 -0800 (PST)
In-Reply-To: <1517876755-46814-1-git-send-email-cgxu519@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>

On Tue, Feb 6, 2018 at 1:25 AM, Chengguang Xu <cgxu519@icloud.com> wrote:
> When parsing string option, in order to avoid memory leak we need to
> carefully free it first in case of specifying same option several times.
>
> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
> ---
>  fs/ceph/super.c        | 2 ++
>  net/ceph/ceph_common.c | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index a62d2a9..bfc85b2 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -225,6 +225,7 @@ static int parse_fsopt_token(char *c, void *private)
>                         return -ENOMEM;
>                 break;
>         case Opt_mds_namespace:
> +               kfree(fsopt->mds_namespace);
>                 fsopt->mds_namespace = kstrndup(argstr[0].from,
>                                                 argstr[0].to-argstr[0].from,
>                                                 GFP_KERNEL);
> @@ -232,6 +233,7 @@ static int parse_fsopt_token(char *c, void *private)
>                         return -ENOMEM;
>                 break;
>         case Opt_fscache_uniq:
> +               kfree(fsopt->fscache_uniq);
>                 fsopt->fscache_uniq = kstrndup(argstr[0].from,
>                                                argstr[0].to-argstr[0].from,
>                                                GFP_KERNEL);
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 5c036d2..cdb5b69 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -418,11 +418,15 @@ struct ceph_options *
>                                 opt->flags |= CEPH_OPT_FSID;
>                         break;
>                 case Opt_name:
> +                       kfree(opt->name);
>                         opt->name = kstrndup(argstr[0].from,
>                                               argstr[0].to-argstr[0].from,
>                                               GFP_KERNEL);
>                         break;
>                 case Opt_secret:
> +                       ceph_crypto_key_destroy(opt->key);
> +                       kfree(opt->key);
> +
>                         opt->key = kzalloc(sizeof(*opt->key), GFP_KERNEL);
>                         if (!opt->key) {
>                                 err = -ENOMEM;
> @@ -433,6 +437,9 @@ struct ceph_options *
>                                 goto out;
>                         break;
>                 case Opt_key:
> +                       ceph_crypto_key_destroy(opt->key);
> +                       kfree(opt->key);
> +
>                         opt->key = kzalloc(sizeof(*opt->key), GFP_KERNEL);
>                         if (!opt->key) {
>                                 err = -ENOMEM;

Applied.

Thanks,

                Ilya
