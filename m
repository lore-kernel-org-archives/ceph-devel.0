From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] ceph: fix memory leak in async readpages
Date: Wed, 28 Sep 2011 11:34:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109281133330.13650@cobra.newdream.net>
References: <20110928181954.GA18512@rd.bbc.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53101 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102Ab1I1Sej (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2011 14:34:39 -0400
In-Reply-To: <20110928181954.GA18512@rd.bbc.co.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Flynn <davidf@rd.bbc.co.uk>
Cc: ceph-devel@vger.kernel.org

Can I add your Signed-off-by: on that?  

I'll send this upstream with the other patches so it'll hopefully make 
3.1...

Thanks!
sage


On Wed, 28 Sep 2011, David Flynn wrote:

> The finish_read callback introduced in 63c90314546c1cec1f220f6ab24ea
> fails to release the page list allocated in start_read.
> ---
>  fs/ceph/addr.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index e06a322..4144caf 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -261,6 +261,7 @@ static void finish_read(struct ceph_osd_request *req, struct ceph_msg *msg)
>  		unlock_page(page);
>  		page_cache_release(page);
>  	}
> +	kfree(req->r_pages);
>  }
>  
>  /*
> -- 
> 1.7.4.1
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
