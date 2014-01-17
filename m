From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: trivial comment fix
Date: Thu, 16 Jan 2014 16:03:38 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1401161603250.16743@cobra.newdream.net>
References: <20140116224253.GB20521@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41672 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbaAQADi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jan 2014 19:03:38 -0500
In-Reply-To: <20140116224253.GB20521@fieldses.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: ceph-devel@vger.kernel.org

On Thu, 16 Jan 2014, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> "disconnected" is too easily confused with "DCACHE_DISCONNECTED".  I
> think "unhashed" is the more precise term here.

Good point.  Applied, thanks!
sage


> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/ceph/caps.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Just ran across this while wondering what d_find_alias callers do....
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 3c0a4bd..697f9d7 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -2350,11 +2350,11 @@ static void invalidate_aliases(struct inode *inode)
>  	d_prune_aliases(inode);
>  	/*
>  	 * For non-directory inode, d_find_alias() only returns
> -	 * connected dentry. After calling d_invalidate(), the
> -	 * dentry become disconnected.
> +	 * hashed dentry. After calling d_invalidate(), the
> +	 * dentry becomes unhashed.
>  	 *
>  	 * For directory inode, d_find_alias() can return
> -	 * disconnected dentry. But directory inode should have
> +	 * unhashed dentry. But directory inode should have
>  	 * one alias at most.
>  	 */
>  	while ((dn = d_find_alias(inode))) {
> -- 
> 1.7.9.5
> 
> 
