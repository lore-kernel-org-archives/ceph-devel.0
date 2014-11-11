From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] libceph: require cephx message signature by default
Date: Tue, 11 Nov 2014 18:41:01 +0400
Message-ID: <CALFYKtAQ0diZ0L5pr1pZ1T2FqLyQ_UFsT67ahzFxLb9QvXHc1A@mail.gmail.com>
References: <1415711038-5064-1-git-send-email-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35138 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbaKKOlD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Nov 2014 09:41:03 -0500
Received: by mail-qg0-f50.google.com with SMTP id a108so7183115qge.23
        for <ceph-devel@vger.kernel.org>; Tue, 11 Nov 2014 06:41:01 -0800 (PST)
In-Reply-To: <1415711038-5064-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 11, 2014 at 4:03 PM, Yan, Zheng <zyan@redhat.com> wrote:
> Signed-off-by: Yan, Zheng <zyan@redhat.com>
> ---
>  include/linux/ceph/libceph.h |  1 +
>  net/ceph/ceph_common.c       | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index d293f7e..8b11a79 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -29,6 +29,7 @@
>  #define CEPH_OPT_NOSHARE          (1<<1) /* don't share client with other sbs */
>  #define CEPH_OPT_MYIP             (1<<2) /* specified my ip */
>  #define CEPH_OPT_NOCRC            (1<<3) /* no data crc on writes */
> +#define CEPH_OPT_NOMSGAUTH       (1<<4) /* not require cephx message signature */
>
>  #define CEPH_OPT_DEFAULT   (0)
>
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index d361a274..5d5ab67 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -237,6 +237,8 @@ enum {
>         Opt_noshare,
>         Opt_crc,
>         Opt_nocrc,
> +       Opt_cephx_require_signatures,
> +       Opt_nocephx_require_signatures,
>  };
>
>  static match_table_t opt_tokens = {
> @@ -255,6 +257,8 @@ static match_table_t opt_tokens = {
>         {Opt_noshare, "noshare"},
>         {Opt_crc, "crc"},
>         {Opt_nocrc, "nocrc"},
> +       {Opt_cephx_require_signatures, "cephx_require_signatures"},
> +       {Opt_nocephx_require_signatures, "nocephx_require_signatures"},
>         {-1, NULL}
>  };
>
> @@ -453,6 +457,12 @@ ceph_parse_options(char *options, const char *dev_name,
>                 case Opt_nocrc:
>                         opt->flags |= CEPH_OPT_NOCRC;
>                         break;
> +               case Opt_cephx_require_signatures:
> +                       opt->flags &= ~CEPH_OPT_NOMSGAUTH;
> +                       break;
> +               case Opt_nocephx_require_signatures:
> +                       opt->flags |= CEPH_OPT_NOMSGAUTH;
> +                       break;
>
>                 default:
>                         BUG_ON(token);
> @@ -496,6 +506,9 @@ struct ceph_client *ceph_create_client(struct ceph_options *opt, void *private,
>         init_waitqueue_head(&client->auth_wq);
>         client->auth_err = 0;
>
> +       if (!ceph_test_opt(client, NOMSGAUTH))
> +               required_features |= CEPH_FEATURE_MSG_AUTH;
> +
>         client->extra_mon_dispatch = NULL;
>         client->supported_features = CEPH_FEATURES_SUPPORTED_DEFAULT |
>                 supported_features;

Reviewed-by: Ilya Dryomov <idryomov@redhat.com>

Thanks,

                Ilya
