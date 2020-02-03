From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 09/15] rbd: count pending object requests in-line
Date: Mon, 3 Feb 2020 18:47:36 +0100
Message-ID: <CAOi1vP9Z=7XPO3N7jajEG0eJDSUF+xnvn+arfU-waubra9pg-A@mail.gmail.com>
References: <20200131103739.136098-1-hare@suse.de> <20200131103739.136098-10-hare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20200131103739.136098-10-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Sage Weil <sage@redhat.com>, Daniel Disseldorp <ddiss@suse.com>, Jens Axboe <axboe@kernel.dk>, Ceph Development <ceph-devel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Jan 31, 2020 at 11:38 AM Hannes Reinecke <hare@suse.de> wrote:
>
> Instead of having a counter for outstanding object requests
> check the state and count only those which are not in the final
> state.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/block/rbd.c | 41 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b708f5ecda07..a6c95b6e9c0c 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -350,7 +350,7 @@ struct rbd_img_request {
>         struct mutex            object_mutex;
>
>         struct mutex            state_mutex;
> -       struct pending_result   pending;
> +       int                     pending_result;
>         struct work_struct      work;
>         int                     work_result;
>         struct kref             kref;
> @@ -3602,11 +3602,12 @@ static int rbd_img_exclusive_lock(struct rbd_img_request *img_req)
>         return 0;
>  }
>
> -static void rbd_img_object_requests(struct rbd_img_request *img_req)
> +static int rbd_img_object_requests(struct rbd_img_request *img_req)
>  {
>         struct rbd_obj_request *obj_req;
> +       int num_pending = 0;
>
> -       rbd_assert(!img_req->pending.result && !img_req->pending.num_pending);
> +       rbd_assert(!img_req->pending_result);
>
>         mutex_lock(&img_req->object_mutex);
>         for_each_obj_request(img_req, obj_req) {
> @@ -3617,15 +3618,33 @@ static void rbd_img_object_requests(struct rbd_img_request *img_req)
>                              __func__, obj_req, obj_req->img_request,
>                              img_req, result);
>                         if (result) {
> -                               img_req->pending.result = result;
> -                               mutex_unlock(&img_req->object_mutex);
> -                               return;
> +                               img_req->pending_result = result;
> +                               break;
>                         }
>                 } else {
> -                       img_req->pending.num_pending++;
> +                       num_pending++;
>                 }
>         }
>         mutex_unlock(&img_req->object_mutex);
> +       return num_pending;
> +}
> +
> +static int rbd_img_object_requests_pending(struct rbd_img_request *img_req)
> +{
> +       struct rbd_obj_request *obj_req;
> +       int num_pending = 0;
> +
> +       mutex_lock(&img_req->object_mutex);
> +       for_each_obj_request(img_req, obj_req) {
> +               if (obj_req->obj_state > 1)
> +                       num_pending++;
> +               else if (WARN_ON(obj_req->obj_state == 1))
> +                       num_pending++;
> +               else if (WARN_ON(obj_req->pending.num_pending))
> +                       num_pending++;
> +       }
> +       mutex_unlock(&img_req->object_mutex);
> +       return num_pending;
>  }
>
>  static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
> @@ -3658,16 +3677,16 @@ static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
>                            __rbd_is_lock_owner(rbd_dev));
>
>                 img_req->state = RBD_IMG_OBJECT_REQUESTS;
> -               rbd_img_object_requests(img_req);
> -               if (!img_req->pending.num_pending) {
> -                       *result = img_req->pending.result;
> +               if (!rbd_img_object_requests(img_req)) {
> +                       *result = img_req->pending_result;
>                         img_req->state = RBD_IMG_DONE;
>                         return true;
>                 }
>                 return false;
>         case RBD_IMG_OBJECT_REQUESTS:
> -               if (!pending_result_dec(&img_req->pending, result))
> +               if (rbd_img_object_requests_pending(img_req))
>                         return false;
> +               *result = img_req->pending_result;
>                 img_req->state = RBD_IMG_DONE;
>                 /* fall through */
>         case RBD_IMG_DONE:

This is just to be able to drop img_req->state_mutex in patch 11,
right?

Thanks,

                Ilya
