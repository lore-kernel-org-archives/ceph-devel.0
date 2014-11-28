From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [patch] ceph: do_sync is never initialized
Date: Fri, 28 Nov 2014 21:25:38 +0400
Message-ID: <CALFYKtB4e=TbBQVkHUOW5wAC+-103n_UXnuMtW=ZjZYGsy0LHg@mail.gmail.com>
References: <20141128083334.GB10252@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20141128083334.GB10252@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sage Weil <sage@inktank.com>, =?UTF-8?B?6ams5bu65pyL?= <majianpeng@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Fri, Nov 28, 2014 at 11:33 AM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:
> Probably this code was syncing a lot more often then intended because
> the do_sync variable wasn't set to zero.
>
> Fixes: c62988ec0910 ('ceph: avoid meaningless calling ceph_caps_revoking if sync_mode == WB_SYNC_ALL.')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Static checker stuff.  Not tested.  It's surprising that GCC doesn't
> catch this.
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 18c06bb..481529b 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -673,7 +673,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>         int rc = 0;
>         unsigned wsize = 1 << inode->i_blkbits;
>         struct ceph_osd_request *req = NULL;
> -       int do_sync;
> +       int do_sync = 0;
>         u64 truncate_size, snap_size;
>         u32 truncate_seq;

Applied, also added a stable tag for 3.11+.

Thanks,

                Ilya
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
