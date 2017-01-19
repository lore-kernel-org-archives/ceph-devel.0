From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] ceph: update readpages osd request according to size of
 pages.
Date: Thu, 19 Jan 2017 07:39:21 -0500
Message-ID: <1484829561.2704.1.camel@redhat.com>
References: <20170119082423.44545-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f180.google.com ([209.85.213.180]:36180 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbdASNLK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jan 2017 08:11:10 -0500
Received: by mail-yb0-f180.google.com with SMTP id 123so17330986ybe.3
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jan 2017 05:11:10 -0800 (PST)
In-Reply-To: <20170119082423.44545-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com

On Thu, 2017-01-19 at 16:24 +0800, Yan, Zheng wrote:
> add_to_page_cache_lru() can fails, so the actual pages to read
> can be smaller than the initial size of osd request. We need to
> update osd request size in that case.
> 
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/addr.c        | 1 +
>  net/ceph/osd_client.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 3985256..4547bbf 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -391,6 +391,7 @@ static int start_read(struct inode *inode, struct list_head *page_list, int max)
>  			nr_pages = i;
>  			if (nr_pages > 0) {
>  				len = nr_pages << PAGE_SHIFT;
> +				osd_req_op_extent_update(req, 0, len);
>  				break;
>  			}
>  			goto out_pages;
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 842f049..3a2417b 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -672,7 +672,8 @@ void osd_req_op_extent_update(struct ceph_osd_request *osd_req,
>  	BUG_ON(length > previous);
>  
>  	op->extent.length = length;
> -	op->indata_len -= previous - length;
> +	if (op->op == CEPH_OSD_OP_WRITE || op->op == CEPH_OSD_OP_WRITEFULL)
> +		op->indata_len -= previous - length;
>  }
>  EXPORT_SYMBOL(osd_req_op_extent_update);
>  

Looks right, but this special casing of the request types at this layer
just seems so nasty. I guess it's unavoidable given the way the protocol
works, but I can't help feeling like it's a layering violation when I
look at it:
 
Reviewed-by: Jeff Layton <jlayton@redhat.com>
