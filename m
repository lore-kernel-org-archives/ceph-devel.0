From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 07/11] rbd: kill notify_timeout option
Date: Thu, 30 Aug 2012 10:31:53 -0700
Message-ID: <CAC-hyiEcxwYEsKu=M2Ya+KDzck1KFOxWKPfyzo90XPUSAH-V_g@mail.gmail.com>
References: <5037AB20.4000103@inktank.com>
	<5037AD28.4050805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45569 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab2H3Rbz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 13:31:55 -0400
Received: by bkwj10 with SMTP id j10so927697bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 10:31:54 -0700 (PDT)
In-Reply-To: <5037AD28.4050805@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Fri, Aug 24, 2012 at 9:34 AM, Alex Elder <elder@inktank.com> wrote:
> The "notify_timeout" rbd device option is never used, so get rid of
> it.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c |    8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 5e22bb5..e94336d 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -69,7 +69,6 @@
>  #define DEV_NAME_LEN           32
>  #define MAX_INT_FORMAT_WIDTH   ((5 * sizeof (int)) / 2 + 1)
>
> -#define RBD_NOTIFY_TIMEOUT_DEFAULT     10
>  #define RBD_READ_ONLY_DEFAULT          false
>
>  /*
> @@ -91,7 +90,6 @@ struct rbd_image_header {
>  };
>
>  struct rbd_options {
> -       int     notify_timeout;
>         bool    read_only;
>  };
>
> @@ -348,7 +346,6 @@ static struct rbd_client *rbd_client_find(struct
> ceph_options *ceph_opts)
>   * mount options
>   */
>  enum {
> -       Opt_notify_timeout,
>         Opt_last_int,
>         /* int args above */
>         Opt_last_string,
> @@ -359,7 +356,6 @@ enum {
>  };
>
>  static match_table_t rbd_opts_tokens = {
> -       {Opt_notify_timeout, "notify_timeout=%d"},
>         /* int args above */
>         /* string args above */
>         {Opt_read_only, "read_only"},
> @@ -396,9 +392,6 @@ static int parse_rbd_opts_token(char *c, void *private)
>         }
>
>         switch (token) {
> -       case Opt_notify_timeout:
> -               rbd_opts->notify_timeout = intval;
> -               break;
>         case Opt_read_only:
>                 rbd_opts->read_only = !rbd_opts->read_only;
>                 break;
> @@ -419,7 +412,6 @@ static int rbd_get_client(struct rbd_device
> *rbd_dev, const char *mon_addr,
>         struct ceph_options *ceph_opts;
>         struct rbd_client *rbdc;
>
> -       rbd_opts->notify_timeout = RBD_NOTIFY_TIMEOUT_DEFAULT;
>         rbd_opts->read_only = RBD_READ_ONLY_DEFAULT;
>
>         ceph_opts = ceph_parse_options(options, mon_addr,
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
