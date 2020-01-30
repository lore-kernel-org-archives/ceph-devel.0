From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rbd: optimize barrier usage for Rmw atomic bitops
Date: Thu, 30 Jan 2020 13:52:32 +0100
Message-ID: <CAOi1vP-75uoBBsnX262WoVL_jNreiSgnGmtytDKcsUE==ny2Jw@mail.gmail.com>
References: <20200129181253.24999-1-dave@stgolabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200129181253.24999-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dbueso@suse.de>
List-Id: ceph-devel.vger.kernel.org

On Wed, Jan 29, 2020 at 7:23 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> For both set and clear_bit, we can avoid the unnecessary barrier
> on non LL/SC architectures, such as x86. Instead, use the
> smp_mb__{before,after}_atomic() calls.
>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  drivers/block/rbd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 2b184563cd32..7bc79b2b8f65 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1371,13 +1371,13 @@ static void rbd_osd_submit(struct ceph_osd_request *osd_req)
>  static void img_request_layered_set(struct rbd_img_request *img_request)
>  {
>         set_bit(IMG_REQ_LAYERED, &img_request->flags);
> -       smp_mb();
> +       smp_mb__after_atomic();
>  }
>
>  static void img_request_layered_clear(struct rbd_img_request *img_request)
>  {
>         clear_bit(IMG_REQ_LAYERED, &img_request->flags);
> -       smp_mb();
> +       smp_mb__after_atomic();
>  }
>
>  static bool img_request_layered_test(struct rbd_img_request *img_request)

Hi Davidlohr,

I don't think these barriers are needed at all.  I'll remove them.

Thanks,

                Ilya
