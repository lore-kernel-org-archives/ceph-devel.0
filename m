From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: [PATCH] rbd: default to single-major device number scheme
Date: Mon, 13 Nov 2017 08:18:18 -0500
Message-ID: <CA+aFP1AubmBQxMKs=cm1z77rEx2Mv3_21ZQVE8wDbtfGQRF0BQ@mail.gmail.com>
References: <1510570217-14811-1-git-send-email-idryomov@gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:51901 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbdKMNST (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Nov 2017 08:18:19 -0500
Received: by mail-yw0-f196.google.com with SMTP id k3so13338153ywk.8
        for <ceph-devel@vger.kernel.org>; Mon, 13 Nov 2017 05:18:18 -0800 (PST)
In-Reply-To: <1510570217-14811-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

Reviewed-by: Jason Dillaman <dillaman@redhat.com>

On Mon, Nov 13, 2017 at 5:50 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> It's been 3.5 years, let's turn it on by default.  Support in rbd(8)
> utility goes back to pre-firefly, "rbd map" has been loading the module
> with single_major=Y ever since.  However, if the module is already
> loaded (whether by hand or at boot time), we end up with single_major=N.
> Also, some people don't install rbd(8) and use the sysfs interface
> directly.
>
> (With single-major=N, a major number is consumed for every mapping,
> imposing a limit of ~240 rbd images per host.  single-major=Y allows
> mapping thousands of rbd images on a single machine.)
>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/rbd.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 57275298d9fc..f40050c97bb3 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -449,12 +449,11 @@ static DEFINE_IDA(rbd_dev_id_ida);
>  static struct workqueue_struct *rbd_wq;
>
>  /*
> - * Default to false for now, as single-major requires >= 0.75 version of
> - * userspace rbd utility.
> + * single-major requires >= 0.75 version of userspace rbd utility.
>   */
> -static bool single_major = false;
> +static bool single_major = true;
>  module_param(single_major, bool, S_IRUGO);
> -MODULE_PARM_DESC(single_major, "Use a single major number for all rbd devices (default: false)");
> +MODULE_PARM_DESC(single_major, "Use a single major number for all rbd devices (default: true)");
>
>  static int rbd_img_request_submit(struct rbd_img_request *img_request);
>
> --
> 2.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
