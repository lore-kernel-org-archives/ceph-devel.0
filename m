From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] rbd: Fix error recovery in rbd_obj_read_sync()
Date: Wed, 22 Oct 2014 11:44:17 +0400
Message-ID: <CALFYKtBx9gG1M4v94ONGcXzZb_RKZ=9EUnEbxLnFQuFuUVoSvQ@mail.gmail.com>
References: <1413962244-25630-1-git-send-email-jack@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1413962244-25630-1-git-send-email-jack@suse.cz>
Sender: stable-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: Sage Weil <sage@inktank.com>, Yehuda Sadeh <yehuda@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>, stable@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Wed, Oct 22, 2014 at 11:17 AM, Jan Kara <jack@suse.cz> wrote:
> When we fail to allocate page vector in rbd_obj_read_sync() we just
> basically ignore the problem and continue which will result in an oops
> later. Fix the problem by returning proper error.
>
> CC: Yehuda Sadeh <yehuda@inktank.com>
> CC: Sage Weil <sage@inktank.com>
> CC: ceph-devel@vger.kernel.org
> CC: stable@vger.kernel.org
> Coverity-id: 1226882
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  drivers/block/rbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 0a54c588e433..8f714c3ed25f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3532,7 +3532,7 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
>         page_count = (u32) calc_pages_for(offset, length);
>         pages = ceph_alloc_page_vector(page_count, GFP_KERNEL);
>         if (IS_ERR(pages))
> -               ret = PTR_ERR(pages);
> +               return PTR_ERR(pages);
>
>         ret = -ENOMEM;
>         obj_request = rbd_obj_request_create(object_name, offset, length,

Applied.

Thanks,

                Ilya
