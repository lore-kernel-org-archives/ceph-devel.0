From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] ceph: refactor readpage_nounlock() to make the logic clearer
Date: Wed, 28 May 2014 17:08:41 +0800
Message-ID: <CAAM7YAnsYL3ZGXuOj-R9OsB+e3DDOH8qaF0eQw2gjdANmJZESQ@mail.gmail.com>
References: <1401260798-28541-1-git-send-email-zhenzhang.zhang@huawei.com>
	<53858BC3.8070604@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:39981 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbaE1JIm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 May 2014 05:08:42 -0400
Received: by mail-ob0-f173.google.com with SMTP id wm4so10551693obc.32
        for <ceph-devel@vger.kernel.org>; Wed, 28 May 2014 02:08:41 -0700 (PDT)
In-Reply-To: <53858BC3.8070604@huawei.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhang Zhen <zhenzhang.zhang@huawei.com>
Cc: Sage Weil <sage@inktank.com>, Alex Elder <elder@ieee.org>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, May 28, 2014 at 3:09 PM, Zhang Zhen <zhenzhang.zhang@huawei.com> wrote:
> If the return value of ceph_osdc_readpages() is not negative,
> it is certainly greater than or equal to zero.
>
> Remove the useless condition judgment and redundant braces.
>
> Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>
> ---
>  fs/ceph/addr.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index b53278c..6aa2e3f 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -211,18 +211,15 @@ static int readpage_nounlock(struct file *filp, struct page *page)
>                 SetPageError(page);
>                 ceph_fscache_readpage_cancel(inode, page);
>                 goto out;
> -       } else {
> -               if (err < PAGE_CACHE_SIZE) {
> -               /* zero fill remainder of page */
> -                       zero_user_segment(page, err, PAGE_CACHE_SIZE);
> -               } else {
> -                       flush_dcache_page(page);
> -               }
>         }
> -       SetPageUptodate(page);
> +       if (err < PAGE_CACHE_SIZE)
> +               /* zero fill remainder of page */
> +               zero_user_segment(page, err, PAGE_CACHE_SIZE);
> +       else
> +               flush_dcache_page(page);
>
> -       if (err >= 0)
> -               ceph_readpage_to_fscache(inode, page);
> +       SetPageUptodate(page);
> +       ceph_readpage_to_fscache(inode, page);
>
>  out:
>         return err < 0 ? err : 0;
> --

Added to testing branch of ceph-client

Thanks
Yan, Zheng


> 1.8.1.2
>
>
> .
>
>
>
>
