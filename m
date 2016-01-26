From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [patch] ceph: checking for IS_ERR instead of NULL
Date: Tue, 26 Jan 2016 11:30:39 +0100
Message-ID: <CAOi1vP-kT4tA-vvjg5QD-h5zkUJFC+X5Hw07tFsnjfP8tww4PA@mail.gmail.com>
References: <20160126092444.GB15717@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160126092444.GB15717@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, Jan 26, 2016 at 10:24 AM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:
> ceph_osdc_alloc_request() returns NULL on error, it never returns error
> pointers.
>
> Fixes: 5be0389dac66 ('ceph: re-send AIO write request when getting -EOLDSNAP error')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index d37efdd..a52cf9b 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -698,8 +698,8 @@ static void ceph_aio_retry_work(struct work_struct *work)
>
>         req = ceph_osdc_alloc_request(orig_req->r_osdc, snapc, 2,
>                         false, GFP_NOFS);
> -       if (IS_ERR(req)) {
> -               ret = PTR_ERR(req);
> +       if (!req) {
> +               ret = -ENOMEM;
>                 req = orig_req;
>                 goto out;
>         }

Applied, thanks Dan.

Zheng, I have an related concern: where do you put snapc (refcount is
bumped a few lines above) if ceph_osdc_alloc_request() fails?  It looks
like it's leaked to me.

The BUG_ON(ret == -EOLDSNAPC) also seems a bit bogus, given that ret is
either -ENOMEM or ceph_osdc_start_request() retval.

                Ilya
