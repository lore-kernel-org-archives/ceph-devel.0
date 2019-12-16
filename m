From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rbd: Avoid calling BUG() when object_map is not empty
Date: Mon, 16 Dec 2019 11:18:30 +0100
Message-ID: <CAOi1vP_dYP05Wj1fpH-U2WLGhOBp3RmFXPvjYmjorx_MLZW6Zg@mail.gmail.com>
References: <20191215163527.25203-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191215163527.25203-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Pakki <pakki001@umn.edu>
Cc: kjlu@umn.edu, Sage Weil <sage@redhat.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>, Ceph Development <ceph-devel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Sun, Dec 15, 2019 at 5:35 PM Aditya Pakki <pakki001@umn.edu> wrote:
>
> In __rbd_object_map_load, if object_map contains data, return
> error -EINVAL upstream, instead of crashing, via BUG. The patch
> fixes this issue.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/block/rbd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 2b184563cd32..6e9a11f32a94 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1892,7 +1892,8 @@ static int __rbd_object_map_load(struct rbd_device *rbd_dev)
>         int num_pages;
>         int ret;
>
> -       rbd_assert(!rbd_dev->object_map && !rbd_dev->object_map_size);
> +       if (rbd_dev->object_map || rbd_dev->object_map_size)
> +               return -EINVAL;
>
>         num_objects = ceph_get_num_objects(&rbd_dev->layout,
>                                            rbd_dev->mapping.size);

Hi Aditya,

Could you explain what issue is being fixed?  Did you hit this assert?
If so, under what circumstances?  The fact that __rbd_object_map_load()
can fail doesn't mean that it shouldn't have asserts...

Thanks,

                Ilya
