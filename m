From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH][TRIVIAL] ceph: Free the previous caps if alloc failed.
Date: Tue, 25 Jun 2013 08:27:19 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306250825470.2998@cobra.newdream.net>
References: <201306251527405618532@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43489 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505Ab3FYP1U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jun 2013 11:27:20 -0400
In-Reply-To: <201306251527405618532@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I think in this case we don't want to drop other caps.  This basically 
means we weren't able to maintain the desired level of reserves, but we 
will continue to try to fill it periodically, and not reaching the desired 
point is not a reason to throw out what we have.  You'll note that the one 
caller ignores the return value..

sage


On Tue, 25 Jun 2013, majianpeng wrote:

> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  fs/ceph/caps.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index da0f9b8..626b0ec 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -203,6 +203,11 @@ out_alloc_count:
>  	/* we didn't manage to reserve as much as we needed */
>  	pr_warning("reserve caps ctx=%p ENOMEM need=%d got=%d\n",
>  		   ctx, need, have);
> +	if (alloc) {
> +		struct ceph_cap *tmp;
> +		list_for_each_entry_safe(cap, tmp, &newcaps, caps_item)
> +			kmem_cache_free(ceph_cap_cachep, cap);
> +	}
>  	return ret;
>  }
>  
> -- 
> 1.8.1.2
> 
