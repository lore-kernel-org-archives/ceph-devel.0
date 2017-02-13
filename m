From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rbd: constify device_type structure
Date: Mon, 13 Feb 2017 10:12:35 +0100
Message-ID: <CAOi1vP_hHsaKi_z7h07NO+j+ykeLVUDJD0w2it9H=fitv5yCYw@mail.gmail.com>
References: <1486795478-16655-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33608 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdBMJMg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2017 04:12:36 -0500
In-Reply-To: <1486795478-16655-1-git-send-email-bhumirks@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Feb 11, 2017 at 7:44 AM, Bhumika Goyal <bhumirks@gmail.com> wrote:
> Declare device_type structure as const as it is only stored in the
> type field of a device structure. This field is of type const, so add
> const to the declaration of device_type structure.
>
> File size before:
>    text    data     bss     dec     hex filename
>   61546   11610     208   73364   11e94 drivers/block/rbd.o
>
> File size after:
>    text    data     bss     dec     hex filename
>   61610   11578     208   73396   11eb4 drivers/block/rbd.o
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/block/rbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 36d2b9f..dfc708b 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4779,7 +4779,7 @@ static ssize_t rbd_image_refresh(struct device *dev,
>
>  static void rbd_dev_release(struct device *dev);
>
> -static struct device_type rbd_device_type = {
> +static const struct device_type rbd_device_type = {
>         .name           = "rbd",
>         .groups         = rbd_attr_groups,
>         .release        = rbd_dev_release,

Applied.

Thanks,

                Ilya
