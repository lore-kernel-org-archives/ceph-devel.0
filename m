From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: use ktime_get_real_seconds()
Date: Wed, 20 Jun 2018 14:33:01 +0200
Message-ID: <CAOi1vP9Aa9xb2RD7ahE=jOj8nvOX936oVyp6rkKHV8tknF_1Kg@mail.gmail.com>
References: <1529488801-22093-1-git-send-email-allen.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529488801-22093-1-git-send-email-allen.lkml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: allen.lkml@gmail.com
Cc: netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Ceph Development <ceph-devel@vger.kernel.org>, y2038@lists.linaro.org
List-Id: ceph-devel.vger.kernel.org

On Wed, Jun 20, 2018 at 12:00 PM Allen Pais <allen.lkml@gmail.com> wrote:
>
> Use ktime_get_real_seconds() as get_seconds() is deprecated.
>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  net/ceph/auth_x.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
> index 2f4a1ba..99561c2 100644
> --- a/net/ceph/auth_x.c
> +++ b/net/ceph/auth_x.c
> @@ -154,7 +154,7 @@ static int process_one_ticket(struct ceph_auth_client *ac,
>         void **ptp;
>         struct ceph_crypto_key new_session_key = { 0 };
>         struct ceph_buffer *new_ticket_blob;
> -       unsigned long new_expires, new_renew_after;
> +       u32 new_expires, new_renew_after;
>         u64 new_secret_id;
>         int ret;
>
> @@ -191,9 +191,9 @@ static int process_one_ticket(struct ceph_auth_client *ac,
>
>         ceph_decode_timespec(&validity, dp);
>         dp += sizeof(struct ceph_timespec);
> -       new_expires = get_seconds() + validity.tv_sec;
> +       new_expires = (u32)ktime_get_real_seconds() + validity.tv_sec;

Why the change to u32 and this cast?  If the type has to change,
wouldn't time64_t make more sense?  ktime_get_real_seconds() returns
time64_t, after all.

Thanks,

                Ilya
