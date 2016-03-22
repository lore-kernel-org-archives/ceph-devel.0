From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 1/3] rbd: use KMEM_CACHE macro
Date: Tue, 22 Mar 2016 17:55:43 +0100
Message-ID: <CAOi1vP9aT=kS9KPoD4Asa+RMBCLS5rsk973JqdrG7ndSOqvqwg@mail.gmail.com>
References: <9242267d62daeec8a0de5a1230f750ca486d62cd.1457853190.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36108 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbcCVQzp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Mar 2016 12:55:45 -0400
In-Reply-To: <9242267d62daeec8a0de5a1230f750ca486d62cd.1457853190.git.geliangtang@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Geliang Tang <geliangtang@163.com>
Cc: Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Mar 13, 2016 at 8:17 AM, Geliang Tang <geliangtang@163.com> wrote:
> Use KMEM_CACHE() instead of kmem_cache_create() to simplify the code.
>
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
>  drivers/block/rbd.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4a87678..70eba86 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -5643,18 +5643,12 @@ static void rbd_sysfs_cleanup(void)
>  static int rbd_slab_init(void)
>  {
>         rbd_assert(!rbd_img_request_cache);
> -       rbd_img_request_cache = kmem_cache_create("rbd_img_request",
> -                                       sizeof (struct rbd_img_request),
> -                                       __alignof__(struct rbd_img_request),
> -                                       0, NULL);
> +       rbd_img_request_cache = KMEM_CACHE(rbd_img_request, 0);
>         if (!rbd_img_request_cache)
>                 return -ENOMEM;
>
>         rbd_assert(!rbd_obj_request_cache);
> -       rbd_obj_request_cache = kmem_cache_create("rbd_obj_request",
> -                                       sizeof (struct rbd_obj_request),
> -                                       __alignof__(struct rbd_obj_request),
> -                                       0, NULL);
> +       rbd_obj_request_cache = KMEM_CACHE(rbd_obj_request, 0);
>         if (!rbd_obj_request_cache)
>                 goto out_err;
>

Applied.

Thanks,

                Ilya
