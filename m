From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH AUTOSEL 5.3 15/71] rbd: fix response length parameter for
 encoded strings
Date: Tue, 1 Oct 2019 19:15:49 +0200
Message-ID: <CAOi1vP-2iSHxJVOabN05+NCiSZ0DxBC9fGN=5cx98mk5RvaDZA@mail.gmail.com>
References: <20191001163922.14735-1-sashal@kernel.org> <20191001163922.14735-15-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001163922.14735-15-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Dongsheng Yang <dongsheng.yang@easystack.cn>, Ceph Development <ceph-devel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Oct 1, 2019 at 6:39 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
>
> [ Upstream commit 5435d2069503e2aa89c34a94154f4f2fa4a0c9c4 ]
>
> rbd_dev_image_id() allocates space for length but passes a smaller
> value to rbd_obj_method_sync().  rbd_dev_v2_object_prefix() doesn't
> allocate space for length.  Fix both to be consistent.
>
> Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
> Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/block/rbd.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index c8fb886aebd4e..69db7385c8df5 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -5669,17 +5669,20 @@ static int rbd_dev_v2_image_size(struct rbd_device *rbd_dev)
>
>  static int rbd_dev_v2_object_prefix(struct rbd_device *rbd_dev)
>  {
> +       size_t size;
>         void *reply_buf;
>         int ret;
>         void *p;
>
> -       reply_buf = kzalloc(RBD_OBJ_PREFIX_LEN_MAX, GFP_KERNEL);
> +       /* Response will be an encoded string, which includes a length */
> +       size = sizeof(__le32) + RBD_OBJ_PREFIX_LEN_MAX;
> +       reply_buf = kzalloc(size, GFP_KERNEL);
>         if (!reply_buf)
>                 return -ENOMEM;
>
>         ret = rbd_obj_method_sync(rbd_dev, &rbd_dev->header_oid,
>                                   &rbd_dev->header_oloc, "get_object_prefix",
> -                                 NULL, 0, reply_buf, RBD_OBJ_PREFIX_LEN_MAX);
> +                                 NULL, 0, reply_buf, size);
>         dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
>         if (ret < 0)
>                 goto out;
> @@ -6696,7 +6699,6 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
>         dout("rbd id object name is %s\n", oid.name);
>
>         /* Response will be an encoded string, which includes a length */
> -
>         size = sizeof (__le32) + RBD_IMAGE_ID_LEN_MAX;
>         response = kzalloc(size, GFP_NOIO);
>         if (!response) {
> @@ -6708,7 +6710,7 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
>
>         ret = rbd_obj_method_sync(rbd_dev, &oid, &rbd_dev->header_oloc,
>                                   "get_id", NULL, 0,
> -                                 response, RBD_IMAGE_ID_LEN_MAX);
> +                                 response, size);
>         dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
>         if (ret == -ENOENT) {
>                 image_id = kstrdup("", GFP_KERNEL);

Hi Sasha,

This patch just made things consistent, there was no bug here.  I don't
think it should be backported.

Thanks,

                Ilya
