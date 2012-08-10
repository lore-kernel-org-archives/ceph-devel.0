From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH] rbd: drop dev reference on error in rbd_open()
Date: Fri, 10 Aug 2012 12:20:13 -0700
Message-ID: <CAC-hyiFVH3_+gML1_Zg+LxC6AZQPVPtrOgK=M5OZU5seNm6y3g@mail.gmail.com>
References: <50255E0F.4070406@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37373 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab2HJTUP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Aug 2012 15:20:15 -0400
Received: by bkwj10 with SMTP id j10so721531bkw.19
        for <ceph-devel@vger.kernel.org>; Fri, 10 Aug 2012 12:20:13 -0700 (PDT)
In-Reply-To: <50255E0F.4070406@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Fri, Aug 10, 2012 at 12:16 PM, Alex Elder <elder@inktank.com> wrote:
> If a read-only rbd device is opened for writing in rbd_open(), it
> returns without dropping the just-acquired device reference.
>
> Fix this by moving the read-only check before getting the reference.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> Index: b/drivers/block/rbd.c
> ===================================================================
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -246,13 +246,12 @@ static int rbd_open(struct block_device
>  {
>         struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
>
> -       rbd_get_dev(rbd_dev);
> -
> -       set_device_ro(bdev, rbd_dev->read_only);
> -
>         if ((mode & FMODE_WRITE) && rbd_dev->read_only)
>                 return -EROFS;
>
> +       rbd_get_dev(rbd_dev);
> +       set_device_ro(bdev, rbd_dev->read_only);
> +
>         return 0;
>  }
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
