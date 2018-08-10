From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH net-next] crush: fix using plain integer as NULL warning
Date: Fri, 10 Aug 2018 12:59:43 +0200
Message-ID: <CAOi1vP-Vg8qoMe12OzTOwVaGgzU4GP2wBdhGyEV67Rd4edKVFw@mail.gmail.com>
References: <20180808115257.6088-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808115257.6088-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yuehaibing@huawei.com
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, netdev <netdev@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Aug 8, 2018 at 1:53 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes the following sparse warning:
> net/ceph/crush/mapper.c:517:76: warning: Using plain integer as NULL pointer
> net/ceph/crush/mapper.c:728:68: warning: Using plain integer as NULL pointer
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/ceph/crush/mapper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
> index 417df67..3f323ed 100644
> --- a/net/ceph/crush/mapper.c
> +++ b/net/ceph/crush/mapper.c
> @@ -514,7 +514,7 @@ static int crush_choose_firstn(const struct crush_map *map,
>                                                 in, work->work[-1-in->id],
>                                                 x, r,
>                                                 (choose_args ?
> -                                                &choose_args[-1-in->id] : 0),
> +                                                &choose_args[-1-in->id] : NULL),
>                                                 outpos);
>                                 if (item >= map->max_devices) {
>                                         dprintk("   bad item %d\n", item);
> @@ -725,7 +725,7 @@ static void crush_choose_indep(const struct crush_map *map,
>                                         in, work->work[-1-in->id],
>                                         x, r,
>                                         (choose_args ?
> -                                        &choose_args[-1-in->id] : 0),
> +                                        &choose_args[-1-in->id] : NULL),
>                                         outpos);
>                                 if (item >= map->max_devices) {
>                                         dprintk("   bad item %d\n", item);

Applied.

Thanks,

                Ilya
