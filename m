From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 11/15] rbd: drop state_mutex in __rbd_img_handle_request()
Date: Mon, 3 Feb 2020 19:01:49 +0100
Message-ID: <CAOi1vP-x5whO0U8oECsgGB0K2FyEnMFUKW=uQJrjQ_1cgeRYww@mail.gmail.com>
References: <20200131103739.136098-1-hare@suse.de> <20200131103739.136098-12-hare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io1-f67.google.com ([209.85.166.67]:40375 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgBCSBh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Feb 2020 13:01:37 -0500
In-Reply-To: <20200131103739.136098-12-hare@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sage Weil <sage@redhat.com>, Daniel Disseldorp <ddiss@suse.com>, Jens Axboe <axboe@kernel.dk>, Ceph Development <ceph-devel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>

On Fri, Jan 31, 2020 at 11:38 AM Hannes Reinecke <hare@suse.de> wrote:
>
> The use of READ_ONCE/WRITE_ONCE for the image request state allows
> us to drop the state_mutex in __rbd_img_handle_request().
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/block/rbd.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 671e941d6edf..db04401c4d8b 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -349,7 +349,6 @@ struct rbd_img_request {
>         struct list_head        object_extents; /* obj_req.ex structs */
>         struct mutex            object_mutex;
>
> -       struct mutex            state_mutex;
>         int                     pending_result;
>         struct work_struct      work;
>         struct kref             kref;
> @@ -1674,7 +1673,6 @@ static struct rbd_img_request *rbd_img_request_create(
>
>         INIT_LIST_HEAD(&img_request->lock_item);
>         INIT_LIST_HEAD(&img_request->object_extents);
> -       mutex_init(&img_request->state_mutex);
>         mutex_init(&img_request->object_mutex);
>         kref_init(&img_request->kref);
>
> @@ -2529,7 +2527,7 @@ static int __rbd_img_fill_request(struct rbd_img_request *img_req)
>                 }
>         }
>         mutex_unlock(&img_req->object_mutex);
> -       img_req->state = RBD_IMG_START;
> +       WRITE_ONCE(img_req->state, RBD_IMG_START);
>         return 0;
>  }
>
> @@ -3652,15 +3650,15 @@ static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
>         int ret;
>
>         dout("%s: img %p state %d\n", __func__, img_req, img_req->state);
> -       switch (img_req->state) {
> +       switch (READ_ONCE(img_req->state)) {
>         case RBD_IMG_START:
>                 rbd_assert(!*result);
>
> -               img_req->state = RBD_IMG_EXCLUSIVE_LOCK;
> +               WRITE_ONCE(img_req->state, RBD_IMG_EXCLUSIVE_LOCK);
>                 ret = rbd_img_exclusive_lock(img_req);
>                 if (ret < 0) {
>                         *result = ret;
> -                       img_req->state = RBD_IMG_DONE;
> +                       WRITE_ONCE(img_req->state, RBD_IMG_DONE);
>                         return true;
>                 }
>                 if (ret == 0)
> @@ -3668,17 +3666,17 @@ static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
>                 /* fall through */
>         case RBD_IMG_EXCLUSIVE_LOCK:
>                 if (*result) {
> -                       img_req->state = RBD_IMG_DONE;
> +                       WRITE_ONCE(img_req->state, RBD_IMG_DONE);
>                         return true;
>                 }
>
>                 rbd_assert(!need_exclusive_lock(img_req) ||
>                            __rbd_is_lock_owner(rbd_dev));
>
> -               img_req->state = RBD_IMG_OBJECT_REQUESTS;
> +               WRITE_ONCE(img_req->state, RBD_IMG_OBJECT_REQUESTS);
>                 if (!rbd_img_object_requests(img_req)) {
>                         *result = img_req->pending_result;
> -                       img_req->state = RBD_IMG_DONE;
> +                       WRITE_ONCE(img_req->state, RBD_IMG_DONE);
>                         return true;
>                 }
>                 return false;
> @@ -3686,7 +3684,7 @@ static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
>                 if (rbd_img_object_requests_pending(img_req))
>                         return false;
>                 *result = img_req->pending_result;
> -               img_req->state = RBD_IMG_DONE;
> +               WRITE_ONCE(img_req->state, RBD_IMG_DONE);
>                 /* fall through */
>         case RBD_IMG_DONE:
>                 return true;
> @@ -3706,16 +3704,12 @@ static bool __rbd_img_handle_request(struct rbd_img_request *img_req,
>
>         if (need_exclusive_lock(img_req)) {
>                 down_read(&rbd_dev->lock_rwsem);
> -               mutex_lock(&img_req->state_mutex);
>                 done = rbd_img_advance(img_req, result);
>                 if (done)
>                         rbd_lock_del_request(img_req);
> -               mutex_unlock(&img_req->state_mutex);
>                 up_read(&rbd_dev->lock_rwsem);
>         } else {
> -               mutex_lock(&img_req->state_mutex);
>                 done = rbd_img_advance(img_req, result);
> -               mutex_unlock(&img_req->state_mutex);
>         }
>
>         if (done && *result) {
> @@ -3985,10 +3979,8 @@ static void wake_lock_waiters(struct rbd_device *rbd_dev, int result)
>         }
>
>         list_for_each_entry(img_req, &rbd_dev->acquiring_list, lock_item) {
> -               mutex_lock(&img_req->state_mutex);
> -               rbd_assert(img_req->state == RBD_IMG_EXCLUSIVE_LOCK);
> +               rbd_assert(READ_ONCE(img_req->state) == RBD_IMG_EXCLUSIVE_LOCK);
>                 rbd_img_schedule(img_req, result);
> -               mutex_unlock(&img_req->state_mutex);
>         }
>
>         list_splice_tail_init(&rbd_dev->acquiring_list, &rbd_dev->running_list);

->state_mutex doesn't just protect ->state or ->pending_result,
it is meant to be a code lock.  In the future, we will be adding
support for timeouts and forceful unmapping of rbd devices, which
means cancelling requests at arbitrary points.  These state machines
need to be reentrant, not just from the inside (i.e. object requests)
but also from the outside.  Getting that right when ->state is managed
through READ/WRITE_ONCE and must be carefully set before dispatching
anything that might change it is going to be very challenging.

In the cover letter, this patch is listed as one of the required
steps for up to 25% speedup.  Is that really the case?  It doesn't
make top-30 contended locks in my tests...

Do you have the numbers without this and any of the preceding patches
or possibly just with patch 15?

Thanks,

                Ilya
