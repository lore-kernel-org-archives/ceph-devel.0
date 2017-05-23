From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 1/3] ceph: remove useless page->mapping check in
 writepage_nounlock()
Date: Tue, 23 May 2017 06:31:38 -0400
Message-ID: <1495535498.2946.0.camel@redhat.com>
References: <20170523095439.63347-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:34386 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdEWKbk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 May 2017 06:31:40 -0400
Received: by mail-qt0-f174.google.com with SMTP id c13so123605331qtc.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 03:31:40 -0700 (PDT)
In-Reply-To: <20170523095439.63347-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org
Cc: dan.carpenter@oracle.com

On Tue, 2017-05-23 at 17:54 +0800, Yan, Zheng wrote:
> Callers of writepage_nounlock() have already ensured non-null
> page->mapping.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/addr.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index f49d6630..ff25239 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -534,10 +534,6 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
>  
>  	dout("writepage %p idx %lu\n", page, page->index);
>  
> -	if (!page->mapping || !page->mapping->host) {
> -		dout("writepage %p - no mapping\n", page);
> -		return -EFAULT;
> -	}
>  	inode = page->mapping->host;
>  	ci = ceph_inode(inode);
>  	fsc = ceph_inode_to_client(inode);

Reviewed-by: Jeff Layton <jlayton@redhat.com>
