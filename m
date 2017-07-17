From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: potential NULL dereference in ceph_msg_data_create()
Date: Mon, 17 Jul 2017 15:17:34 +0200
Message-ID: <CAOi1vP9ekX47XqJXmsc0CAEmgtLmqDXReUipL+GpAJpWnvufBQ@mail.gmail.com>
References: <20170717081335.3hhaj2k2frpq7gfa@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170717081335.3hhaj2k2frpq7gfa@mwanda>
Sender: netdev-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alex Elder <elder@inktank.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, "David S. Miller" <davem@davemloft.net>, Ceph Development <ceph-devel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Mon, Jul 17, 2017 at 10:13 AM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:
> If kmem_cache_zalloc() returns NULL then the INIT_LIST_HEAD(&data->links);
> will Oops.  The callers aren't really prepared for NULL returns so it
> doesn't make a lot of difference in real life.
>
> Fixes: 5240d9f95dfe ("libceph: replace message data pointer with list")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 0c31035bbfee..b7cc615d42ef 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -3203,8 +3203,10 @@ static struct ceph_msg_data *ceph_msg_data_create(enum ceph_msg_data_type type)
>                 return NULL;
>
>         data = kmem_cache_zalloc(ceph_msg_data_cache, GFP_NOFS);
> -       if (data)
> -               data->type = type;
> +       if (!data)
> +               return NULL;
> +
> +       data->type = type;
>         INIT_LIST_HEAD(&data->links);
>
>         return data;

Applied.

Thanks,

                Ilya
