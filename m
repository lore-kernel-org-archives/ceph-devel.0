From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v3] rbd: Remove VLA usage
Date: Tue, 20 Mar 2018 16:01:38 +0100
Message-ID: <CAOi1vP-Fjy4JsSn+kRbGBJ2uPsNXEZRVirHbSf5Tden62jWtHA@mail.gmail.com>
References: <1521305041-18181-1-git-send-email-kyle@spiers.me>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521305041-18181-1-git-send-email-kyle@spiers.me>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Spiers <kyle@spiers.me>
Cc: Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, "Tobin C. Harding" <me@tobin.cc>
List-Id: ceph-devel.vger.kernel.org

On Sat, Mar 17, 2018 at 5:44 PM, Kyle Spiers <kyle@spiers.me> wrote:
>
> As part of the effort to remove VLAs from the kernel[1], this moves
> the literal values into the stack array calculation instead of using a
> variable for the sizing. The resulting size can be found from
> sizeof(buf).
>
> [1] https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Kyle Spiers <kyle@spiers.me>
> ---
>  drivers/block/rbd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 8e40da0..46893e0 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3100,8 +3100,8 @@ static int __rbd_notify_op_lock(struct rbd_device *rbd_dev,
>  {
>         struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
>         struct rbd_client_id cid = rbd_get_cid(rbd_dev);
> -       int buf_size = 4 + 8 + 8 + CEPH_ENCODING_START_BLK_LEN;
> -       char buf[buf_size];
> +       char buf[4 + 8 + 8 + CEPH_ENCODING_START_BLK_LEN];
> +       int buf_size = sizeof(buf);
>         void *p = buf;
>
>         dout("%s rbd_dev %p notify_op %d\n", __func__, rbd_dev, notify_op);
> @@ -3619,8 +3619,8 @@ static void __rbd_acknowledge_notify(struct rbd_device *rbd_dev,
>                                      u64 notify_id, u64 cookie, s32 *result)
>  {
>         struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
> -       int buf_size = 4 + CEPH_ENCODING_START_BLK_LEN;
> -       char buf[buf_size];
> +       char buf[4 + CEPH_ENCODING_START_BLK_LEN];
> +       int buf_size = sizeof(buf);
>         int ret;
>
>         if (result) {

Applied.

Thanks,

                Ilya
