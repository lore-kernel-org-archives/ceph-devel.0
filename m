From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 28/47] block-rbd: Refactor a jump target in rbd_img_obj_exists_submit()
Date: Tue, 13 Sep 2016 10:10:48 +0200
Message-ID: <CAOi1vP_ETMVvw5WhRM-Zbe8Aec+sXDJm2-W8+w3EZ-bccVzEnA@mail.gmail.com>
References: <566ABCD9.1060404@users.sourceforge.net> <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
 <d35a0325-67df-8e08-5b28-827e5faecc6c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34927 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751044AbcIMIKu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Sep 2016 04:10:50 -0400
In-Reply-To: <d35a0325-67df-8e08-5b28-827e5faecc6c@users.sourceforge.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

On Mon, Sep 12, 2016 at 9:14 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 12 Sep 2016 19:44:30 +0200
>
> Adjust a jump target so that a duplicate check can then be avoided
> at the end.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/block/rbd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 17bdc21..66801ec 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2920,7 +2920,7 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
>         stat_request = rbd_obj_request_create(obj_request->object_name, 0, 0,
>                                                         OBJ_REQUEST_PAGES);
>         if (!stat_request)
> -               goto out;
> +               goto put_request;
>
>         rbd_obj_request_get(obj_request);
>         stat_request->obj_request = obj_request;
> @@ -2932,7 +2932,7 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
>         stat_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_READ, 1,
>                                                    stat_request);
>         if (!stat_request->osd_req)
> -               goto out;
> +               goto put_request;
>         stat_request->callback = rbd_img_obj_exists_callback;
>
>         osd_req_op_init(stat_request->osd_req, 0, CEPH_OSD_OP_STAT, 0);
> @@ -2942,8 +2942,8 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
>
>         osdc = &rbd_dev->rbd_client->client->osdc;
>         ret = rbd_obj_request_submit(osdc, stat_request);
> -out:
>         if (ret)
> + put_request:
>                 rbd_obj_request_put(obj_request);
>
>         return ret;
> --
> 2.10.0

Don't do this.  goto into an if block is rarely a good idea, more so
when you are attempting to micro-optimize a very cold error path.

Thanks,

                Ilya
