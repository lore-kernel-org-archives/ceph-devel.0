From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2] rbd: Remove VLA usage
Date: Fri, 16 Mar 2018 09:49:32 +0100
Message-ID: <CAOi1vP-0n8rjBdFkurRCsUnCRsPwRrqN37RfLvz1wWmeWFB=Gw@mail.gmail.com>
References: <1521174763-13282-1-git-send-email-kyle@spiers.me>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521174763-13282-1-git-send-email-kyle@spiers.me>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Spiers <kyle@spiers.me>
Cc: Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, "Tobin C. Harding" <me@tobin.cc>
List-Id: ceph-devel.vger.kernel.org

On Fri, Mar 16, 2018 at 5:32 AM, Kyle Spiers <kyle@spiers.me> wrote:
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
> index 8e40da0..0e94e1f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3100,8 +3100,8 @@ static int __rbd_notify_op_lock(struct rbd_device *rbd_dev,
>  {
>         struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
>         struct rbd_client_id cid = rbd_get_cid(rbd_dev);
> -       int buf_size = 4 + 8 + 8 + CEPH_ENCODING_START_BLK_LEN;
> -       char buf[buf_size];
> +       char buf[4 + 4 + 8 + 8 + CEPH_ENCODING_START_BLK_LEN];

Where is this extra 4 came from?

> +       int buf_size = sizeof(buf)

A semicolon is missing here.  Did you compile this patch?

Thanks,

                Ilya
