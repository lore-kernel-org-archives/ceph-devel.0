From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rdb: convert all rbd_assert(0) to BUG()
Date: Mon, 25 Mar 2019 12:12:09 +0100
Message-ID: <CAOi1vP_KXQd5=YCGvO4m-WbnPDdpeBS5gTVKkdkBZvR=N-d7fg@mail.gmail.com>
References: <20190322165404.2859356-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322165404.2859356-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>, Jason Dillaman <dillaman@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Mar 22, 2019 at 5:54 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> rbd_assert(0) has caused different issues depending on
> the compiler version in the past, so it seems better to avoid it
> completely.
>
> Replace the remaining instances.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/rbd.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index cbcc3baf3807..564c5069cc78 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1342,7 +1342,7 @@ static void rbd_obj_zero_range(struct rbd_obj_request *obj_req, u32 off,
>                 zero_bvecs(&obj_req->bvec_pos, off, bytes);
>                 break;
>         default:
> -               rbd_assert(0);
> +               BUG();
>         }
>  }
>
> @@ -1597,7 +1597,7 @@ static void rbd_obj_request_destroy(struct kref *kref)
>                 kfree(obj_request->bvec_pos.bvecs);
>                 break;
>         default:
> -               rbd_assert(0);
> +               BUG();
>         }
>
>         kfree(obj_request->img_extents);
> @@ -1797,7 +1797,7 @@ static void rbd_osd_req_setup_data(struct rbd_obj_request *obj_req, u32 which)
>                                                     &obj_req->bvec_pos);
>                 break;
>         default:
> -               rbd_assert(0);
> +               BUG();
>         }
>  }
>
> @@ -2052,7 +2052,7 @@ static int __rbd_img_fill_request(struct rbd_img_request *img_req)
>                         ret = rbd_obj_setup_zeroout(obj_req);
>                         break;
>                 default:
> -                       rbd_assert(0);
> +                       BUG();
>                 }
>                 if (ret < 0)
>                         return ret;
> @@ -2531,7 +2531,7 @@ static int rbd_obj_issue_copyup_ops(struct rbd_obj_request *obj_req, u32 bytes)
>                 num_osd_ops += count_zeroout_ops(obj_req);
>                 break;
>         default:
> -               rbd_assert(0);
> +               BUG();
>         }
>
>         obj_req->osd_req = rbd_osd_req_create(obj_req, num_osd_ops);
> @@ -2558,7 +2558,7 @@ static int rbd_obj_issue_copyup_ops(struct rbd_obj_request *obj_req, u32 bytes)
>                 __rbd_obj_setup_zeroout(obj_req, which);
>                 break;
>         default:
> -               rbd_assert(0);
> +               BUG();
>         }
>
>         ret = ceph_osdc_alloc_messages(obj_req->osd_req, GFP_NOIO);

Applied.

Thanks,

                Ilya
