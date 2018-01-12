From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rbd: reacquire lock should update lock owner client id
Date: Fri, 12 Jan 2018 08:37:45 +0100
Message-ID: <CAOi1vP8NQitSsX+9PkB7RNwvY+g=XKOQ5AEnjFBSugdCSeO7pw@mail.gmail.com>
References: <87tvwumy4g.fsf@platform.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:46796 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeALHhp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jan 2018 02:37:45 -0500
Received: by mail-io0-f194.google.com with SMTP id z130so4838453ioe.13
        for <ceph-devel@vger.kernel.org>; Thu, 11 Jan 2018 23:37:45 -0800 (PST)
In-Reply-To: <87tvwumy4g.fsf@platform.sh>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Margaine <florian@platform.sh>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Dec 13, 2017 at 4:43 PM, Florian Margaine <florian@platform.sh> wrote:
> Otherwise, future operations on this RBD using exclusive-lock are
> going to require the lock from a non-existent client id.
>
> This ports commit 475dda114a7e25b43dc9066b9808a64fc0c6dc89 from librbd
> to krbd.
>
> Signed-off-by: Florian Margaine <florian@platform.sh>
> ---
>  drivers/block/rbd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index adc877dfef5c..4e2acf9c81af 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3884,6 +3884,7 @@ static void rbd_reacquire_lock(struct rbd_device *rbd_dev)
>                                            &rbd_dev->lock_dwork, 0);
>         } else {
>                 strcpy(rbd_dev->lock_cookie, cookie);
> +               queue_work(rbd_dev->task_wq, &rbd_dev->acquired_lock_work);
>         }
>  }

Hi Florian,

Just wanted to let you know that this patch has been merged into 4.15,
with a minor modification:

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=edd8ca8015800b354453b891d38960f3a474b7e4

Thanks,

                Ilya
