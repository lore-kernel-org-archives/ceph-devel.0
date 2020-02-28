From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: using POOL FULL flag instead of OSDMAP FULL flag
Date: Fri, 28 Feb 2020 11:23:25 +0100
Message-ID: <CAOi1vP-K+e0N26qpthLcst8HLE-FAMGSE9XwBhj1dPBiLyN-iA@mail.gmail.com>
References: <20200228044518.20314-1-gmayyyha@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200228044518.20314-1-gmayyyha@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yanhu Cao <gmayyyha@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, "David S. Miller" <davem@davemloft.net>, kuba@kernel.org, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Feb 28, 2020 at 5:45 AM Yanhu Cao <gmayyyha@gmail.com> wrote:
>
> OSDMAP_FULL and OSDMAP_NEARFULL are deprecated since mimic.
>
> Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
> ---
>  fs/ceph/file.c                  |  6 ++++--
>  include/linux/ceph/osd_client.h |  2 ++
>  include/linux/ceph/osdmap.h     |  3 ++-
>  net/ceph/osd_client.c           | 23 +++++++++++++----------
>  4 files changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 7e0190b1f821..60ea1eed1b84 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1482,7 +1482,8 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
>         }
>
>         /* FIXME: not complete since it doesn't account for being at quota */
> -       if (ceph_osdmap_flag(&fsc->client->osdc, CEPH_OSDMAP_FULL)) {
> +       if (pool_flag(&fsc->client->osdc, ci->i_layout.pool_id,
> +                               CEPH_POOL_FLAG_FULL)) {
>                 err = -ENOSPC;
>                 goto out;
>         }
> @@ -1575,7 +1576,8 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
>         }
>
>         if (written >= 0) {
> -               if (ceph_osdmap_flag(&fsc->client->osdc, CEPH_OSDMAP_NEARFULL))
> +               if (pool_flag(&fsc->client->osdc, ci->i_layout.pool_id,
> +                                       CEPH_POOL_FLAG_NEARFULL))

Hi Yanhu,

Have you considered pre-mimic clusters here?  They are still supported
(and will continue to be supported for the foreseeable future).

Thanks,

                Ilya
