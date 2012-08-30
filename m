From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 06/11] rbd: add read_only rbd map option
Date: Thu, 30 Aug 2012 10:29:52 -0700
Message-ID: <CAC-hyiF89PV9=J9rTL0DY-8C2Rg4b7+VyZwEYfer0g2dAY4HvQ@mail.gmail.com>
References: <5037AB20.4000103@inktank.com>
	<5037AD10.9010203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49745 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab2H3R3y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 13:29:54 -0400
Received: by bkwj10 with SMTP id j10so926896bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 10:29:52 -0700 (PDT)
In-Reply-To: <5037AD10.9010203@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Aug 24, 2012 at 9:34 AM, Alex Elder <elder@inktank.com> wrote:
> Add the ability to map an rbd image read-only, by specifying either
> "read_only" or "ro" as an option on the rbd "command line."
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c |   22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b40f553..5e22bb5 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -69,7 +69,8 @@
>  #define DEV_NAME_LEN           32
>  #define MAX_INT_FORMAT_WIDTH   ((5 * sizeof (int)) / 2 + 1)
>
> -#define RBD_NOTIFY_TIMEOUT_DEFAULT 10
> +#define RBD_NOTIFY_TIMEOUT_DEFAULT     10
> +#define RBD_READ_ONLY_DEFAULT          false
>
>  /*
>   * block device image metadata (in-memory version)
> @@ -91,6 +92,7 @@ struct rbd_image_header {
>
>  struct rbd_options {
>         int     notify_timeout;
> +       bool    read_only;
>  };
>
>  /*
> @@ -176,7 +178,7 @@ struct rbd_device {
>         u64                     snap_id;        /* current snapshot id */
>         /* whether the snap_id this device reads from still exists */
>         bool                    snap_exists;
> -       int                     read_only;
> +       bool                    read_only;
>
>         struct list_head        node;
>
> @@ -351,12 +353,18 @@ enum {
>         /* int args above */
>         Opt_last_string,
>         /* string args above */
> +       Opt_read_only,
> +       /* Boolean args above */
> +       Opt_last_bool,
>  };
>
>  static match_table_t rbd_opts_tokens = {
>         {Opt_notify_timeout, "notify_timeout=%d"},
>         /* int args above */
>         /* string args above */
> +       {Opt_read_only, "read_only"},
> +       {Opt_read_only, "ro"},          /* Alternate spelling */
> +       /* Boolean args above */
>         {-1, NULL}
>  };
>
> @@ -381,6 +389,8 @@ static int parse_rbd_opts_token(char *c, void *private)
>         } else if (token > Opt_last_int && token < Opt_last_string) {
>                 dout("got string token %d val %s\n", token,
>                      argstr[0].from);
> +       } else if (token > Opt_last_string && token < Opt_last_bool) {
> +               dout("got Boolean token %d\n", token);
>         } else {
>                 dout("got token %d\n", token);
>         }
> @@ -389,6 +399,9 @@ static int parse_rbd_opts_token(char *c, void *private)
>         case Opt_notify_timeout:
>                 rbd_opts->notify_timeout = intval;
>                 break;
> +       case Opt_read_only:
> +               rbd_opts->read_only = !rbd_opts->read_only;

should this be a flip-flop? better have "rw" and "read_write" options
instead, or just set it to true here.

> +               break;
>         default:
>                 BUG_ON(token);
>         }
> @@ -407,6 +420,7 @@ static int rbd_get_client(struct rbd_device
> *rbd_dev, const char *mon_addr,
>         struct rbd_client *rbdc;
>
>         rbd_opts->notify_timeout = RBD_NOTIFY_TIMEOUT_DEFAULT;
> +       rbd_opts->read_only = RBD_READ_ONLY_DEFAULT;
>
>         ceph_opts = ceph_parse_options(options, mon_addr,
>                                         mon_addr + mon_addr_len,
> @@ -613,7 +627,7 @@ static int rbd_header_set_snap(struct rbd_device
> *rbd_dev, u64 *size)
>                     sizeof (RBD_SNAP_HEAD_NAME))) {
>                 rbd_dev->snap_id = CEPH_NOSNAP;
>                 rbd_dev->snap_exists = false;
> -               rbd_dev->read_only = 0;
> +               rbd_dev->read_only = rbd_dev->rbd_opts.read_only;
>                 if (size)
>                         *size = rbd_dev->header.image_size;
>         } else {
> @@ -625,7 +639,7 @@ static int rbd_header_set_snap(struct rbd_device
> *rbd_dev, u64 *size)
>                         goto done;
>                 rbd_dev->snap_id = snap_id;
>                 rbd_dev->snap_exists = true;
> -               rbd_dev->read_only = 1;
> +               rbd_dev->read_only = true;      /* No choice for snapshots */
>         }
>
>         ret = 0;
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
