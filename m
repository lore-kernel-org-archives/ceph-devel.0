From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 2/3] ceph: redirty page when writepage_nounlock() skips
 unwritable page
Date: Tue, 23 May 2017 06:33:06 -0400
Message-ID: <1495535586.2946.1.camel@redhat.com>
References: <20170523095439.63347-1-zyan@redhat.com>
         <20170523095439.63347-2-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36760 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbdEWKdI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 May 2017 06:33:08 -0400
Received: by mail-qt0-f175.google.com with SMTP id f55so123467530qta.3
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 03:33:08 -0700 (PDT)
In-Reply-To: <20170523095439.63347-2-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org
Cc: dan.carpenter@oracle.com

On Tue, 2017-05-23 at 17:54 +0800, Yan, Zheng wrote:
> Ceph needs to flush dirty page in the order in which in which snap
> context they belong to. Dirty pages belong to older snap context
> should be flushed earlier. writepage_nounlock() can not flush a
> page, it should redirty the page.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/addr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index ff25239..1880125 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -551,8 +551,9 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
>  		dout("writepage %p page %p snapc %p not writeable - noop\n",
>  		     inode, page, snapc);
>  		/* we should only noop if called by kswapd */
> -		WARN_ON((current->flags & PF_MEMALLOC) == 0);
> +		WARN_ON(!(current->flags & PF_MEMALLOC));
>  		ceph_put_snap_context(oldest);
> +		redirty_page_for_writepage(wbc, page);
>  		goto out;
>  	}
>  	ceph_put_snap_context(oldest);

Reviewed-by: Jeff Layton <jlayton@redhat.com>
