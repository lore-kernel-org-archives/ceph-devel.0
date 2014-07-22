From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] rbd: Use kmem_cache_free
Date: Tue, 22 Jul 2014 22:32:10 +0400
Message-ID: <CALFYKtDo0ivvYWhjAKJs-LiBRQfrxeN8QAQ1QPX4aswb0+VkWw@mail.gmail.com>
References: <20140722181130.GA3278@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140722181130.GA3278@himangi-Dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Himangi Saraogi <himangi774@gmail.com>
Cc: Alex Elder <elder@kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

On Tue, Jul 22, 2014 at 10:11 PM, Himangi Saraogi <himangi774@gmail.com> wrote:
> Free memory allocated using kmem_cache_zalloc using kmem_cache_free
> rather than kfree.
>
> The Coccinelle semantic patch that makes this change is as follows:
>
> // <smpl>
> @@
> expression x,E,c;
> @@
>
>  x = \(kmem_cache_alloc\|kmem_cache_zalloc\|kmem_cache_alloc_node\)(c,...)
>  ... when != x = E
>      when != &x
> ?-kfree(x)
> +kmem_cache_free(c,x)
> // </smpl>
>
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> ---
>  drivers/block/rbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b2c98c1..8381c54 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1158,7 +1158,7 @@ static const char *rbd_segment_name(struct rbd_device *rbd_dev, u64 offset)
>         if (ret < 0 || ret > CEPH_MAX_OID_NAME_LEN) {
>                 pr_err("error formatting segment name for #%llu (%d)\n",
>                         segment, ret);
> -               kfree(name);
> +               kmem_cache_free(rbd_segment_name_cache, name);
>                 name = NULL;
>         }

We seem to have a helper for this, rbd_segment_name_free().  Care to
resend?

Thanks,

                Ilya
