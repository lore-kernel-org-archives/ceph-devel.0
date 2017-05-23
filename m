From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: NULL deref on crush_decode() error path
Date: Tue, 23 May 2017 18:23:24 +0200
Message-ID: <CAOi1vP98DgHKtYTXHaerz7PeooQYhM_9Ph2bVOQuHONRfGrbXg@mail.gmail.com>
References: <20170523142430.GA28152@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170523142430.GA28152@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, May 23, 2017 at 4:25 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> If there is not enough space then ceph_decode_32_safe() does a goto bad.
> We need to return an error code in that situation.  The current code
> returns ERR_PTR(0) which is NULL.  The callers are not expecting that
> and it results in a NULL dereference.
>
> Fixes: f24e9980eb86 ("ceph: OSD client")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index ffe9e904d4d1..55e3a477f92d 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -317,6 +317,7 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
>                 u32 yes;
>                 struct crush_rule *r;
>
> +               err = -EINVAL;
>                 ceph_decode_32_safe(p, end, yes, bad);
>                 if (!yes) {
>                         dout("crush_decode NO rule %d off %x %p to %p\n",

Applied.

Thanks,

                Ilya
