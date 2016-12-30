From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] ceph: fix spelling mistake: "enabing" -> "enabling"
Date: Fri, 30 Dec 2016 11:30:45 +0800
Message-ID: <CAAM7YAkua4k0KO4KtN95fJi1kZBbv+B=F+UNbCK9p9NqMkkHyA@mail.gmail.com>
References: <20161229201932.27115-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161229201932.27115-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Fri, Dec 30, 2016 at 4:19 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> trivial fix to spelling mistake in debug message
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/ceph/cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> index 5bc5d37..4e7421c 100644
> --- a/fs/ceph/cache.c
> +++ b/fs/ceph/cache.c
> @@ -234,7 +234,7 @@ void ceph_fscache_file_set_cookie(struct inode *inode, struct file *filp)
>                 fscache_enable_cookie(ci->fscache, ceph_fscache_can_enable,
>                                 inode);
>                 if (fscache_cookie_enabled(ci->fscache)) {
> -                       dout("fscache_file_set_cookie %p %p enabing cache\n",
> +                       dout("fscache_file_set_cookie %p %p enabling cache\n",
>                              inode, filp);
>                 }
>         }
> --
> 2.10.2

Applied, thanks

Yan, Zheng

>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
