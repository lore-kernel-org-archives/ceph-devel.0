From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: [PATCH] rbd: don't mess with a page vector in rbd_notify_op_lock()
Date: Tue, 17 Mar 2020 11:25:53 -0400
Message-ID: <CA+aFP1C_M8AorihGCj16jVE7UY-z9LSnMmQ2r_o52QcN4JW3-Q@mail.gmail.com>
References: <20200317144847.10913-1-idryomov@gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51366 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbgCQP0J (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:26:09 -0400
Received: by mail-wm1-f70.google.com with SMTP id n188so7293042wmf.0
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2020 08:26:06 -0700 (PDT)
In-Reply-To: <20200317144847.10913-1-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Mar 17, 2020 at 10:50 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> rbd_notify_op_lock() isn't interested in a notify reply.  Instead of
> accepting that page vector just to free it, have watch-notify code take
> care of it.
>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/rbd.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index f44ce9ccadd6..acafdae16be2 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3754,11 +3754,7 @@ static int __rbd_notify_op_lock(struct rbd_device *rbd_dev,
>  static void rbd_notify_op_lock(struct rbd_device *rbd_dev,
>                                enum rbd_notify_op notify_op)
>  {
> -       struct page **reply_pages;
> -       size_t reply_len;
> -
> -       __rbd_notify_op_lock(rbd_dev, notify_op, &reply_pages, &reply_len);
> -       ceph_release_page_vector(reply_pages, calc_pages_for(0, reply_len));
> +       __rbd_notify_op_lock(rbd_dev, notify_op, NULL, NULL);
>  }
>
>  static void rbd_notify_acquired_lock(struct work_struct *work)
> --
> 2.19.2
>

Reviewed-by: Jason Dillaman <dillaman@redhat.com>

-- 
Jason
