From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 09/11] rbd: drop needless test in rbd_rq_fn()
Date: Thu, 30 Aug 2012 10:41:11 -0700
Message-ID: <CAC-hyiF9LpaURrPDnPDWBivq-Lxe=Tc+TF4HaJ3e=pWuaUWWag@mail.gmail.com>
References: <5037AB20.4000103@inktank.com>
	<5037AD5E.5050501@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54234 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab2H3RlM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 13:41:12 -0400
Received: by bkwj10 with SMTP id j10so931617bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 10:41:11 -0700 (PDT)
In-Reply-To: <5037AD5E.5050501@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Fri, Aug 24, 2012 at 9:35 AM, Alex Elder <elder@inktank.com> wrote:
> There's a test for null rq pointer inside the while loop in
> rbd_rq_fn() that's not needed.  That same test already occurred
> in the immediatly preceding loop condition test.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c |    4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index bb8dad7..fad4ecb 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1462,10 +1462,6 @@ static void rbd_rq_fn(struct request_queue *q)
>                 struct rbd_req_coll *coll;
>                 struct ceph_snap_context *snapc;
>
> -               /* peek at request from block layer */
> -               if (!rq)
> -                       break;
> -
>                 dout("fetched request\n");
>
>                 /* filter out block requests we don't understand */
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
