From: Sage Weil <sage@inktank.com>
Subject: Re: [patch] ceph: divide by zero bug in __validate_layout()
Date: Mon, 20 Aug 2012 15:33:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208201532410.32470@cobra.newdream.net>
References: <20120818155638.GC22424@elgon.mountain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36881 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289Ab2HTWd3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Aug 2012 18:33:29 -0400
In-Reply-To: <20120818155638.GC22424@elgon.mountain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi Dan,

I've applied a slightly different fix to the ceph tree that just skips the 
mod if stripe_unit is 0 but doesn't return EINVAL, since passing 0 is 
valid (it means 'do not change').

Thanks!
sage


On Sat, 18 Aug 2012, Dan Carpenter wrote:

> If "l->stripe_unit" is zero the the mod on the next line will cause a
> divide by zero bug.  This comes from the copy_from_user() in
> ceph_ioctl_set_layout_policy()
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> index 8e3fb69..81ec22b 100644
> --- a/fs/ceph/ioctl.c
> +++ b/fs/ceph/ioctl.c
> @@ -42,6 +42,7 @@ static long __validate_layout(struct ceph_mds_client *mdsc,
>  	/* validate striping parameters */
>  	if ((l->object_size & ~PAGE_MASK) ||
>  	    (l->stripe_unit & ~PAGE_MASK) ||
> +	    (l->stripe_unit == 0) ||
>  	    ((unsigned)l->object_size % (unsigned)l->stripe_unit))
>  		return -EINVAL;
>  
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
