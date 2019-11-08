From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rdb: fix spelling mistake "requeueing" -> "requeuing"
Date: Fri, 8 Nov 2019 12:01:19 +0100
Message-ID: <CAOi1vP_AXiZaRUaKXxBOkoK8bh+V1oh6hxMsobCjbyNq_FGpGQ@mail.gmail.com>
References: <20191107223646.416986-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107223646.416986-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>, Ceph Development <ceph-devel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Nov 7, 2019 at 11:36 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a debug message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/block/rbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 39136675dae5..8e1595d09138 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4230,7 +4230,7 @@ static void rbd_acquire_lock(struct work_struct *work)
>                  * lock owner acked, but resend if we don't see them
>                  * release the lock
>                  */
> -               dout("%s rbd_dev %p requeueing lock_dwork\n", __func__,
> +               dout("%s rbd_dev %p requeuing lock_dwork\n", __func__,
>                      rbd_dev);
>                 mod_delayed_work(rbd_dev->task_wq, &rbd_dev->lock_dwork,
>                     msecs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT * MSEC_PER_SEC));

Applied, after fixing the spelling mistake in the title ;)

Thanks,

                Ilya
