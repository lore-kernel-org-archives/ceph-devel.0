From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 02/16] rbd: drop a useless local variable
Date: Wed, 11 Jul 2012 09:58:53 -0700
Message-ID: <CAC-hyiHGPzgXzrBW3LNQ8B9F+K+EHYhXraaaY9=YRJOQ7ZwrQQ@mail.gmail.com>
References: <4FFD847C.7070205@inktank.com>
	<4FFD8710.60002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64428 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081Ab2GKQ6y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 12:58:54 -0400
Received: by bkwj10 with SMTP id j10so1341484bkw.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 09:58:53 -0700 (PDT)
In-Reply-To: <4FFD8710.60002@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Wed, Jul 11, 2012 at 7:00 AM, Alex Elder <elder@inktank.com> wrote:
> In rbd_req_sync_notify_ack(), a local variable was needlessly being
> used to hold a null pointer.  Just pass NULL instead.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 8f428a8..2ae3bb0 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1187,7 +1187,6 @@ static int rbd_req_sync_notify_ack(struct
> rbd_device *dev,
>                                    const char *obj)
>  {
>         struct ceph_osd_req_op *ops;
> -       struct page **pages = NULL;
>         int ret;
>
>         ret = rbd_create_rw_ops(&ops, 1, CEPH_OSD_OP_NOTIFY_ACK, 0);
> @@ -1200,7 +1199,7 @@ static int rbd_req_sync_notify_ack(struct
> rbd_device *dev,
>
>         ret = rbd_do_request(NULL, dev, NULL, CEPH_NOSNAP,
>                           obj, 0, 0, NULL,
> -                         pages, 0,
> +                         NULL, 0,
>                           CEPH_OSD_FLAG_READ,
>                           ops,
>                           1,
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
