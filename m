From: Sage Weil <sage@inktank.com>
Subject: Re: ceph: Check PagePrivate(page) before dereference, page->private
Date: Fri, 25 May 2012 09:24:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205250916410.29205@cobra.newdream.net>
References: <4FBF4DB7.9050707@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52398 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246Ab2EYQYW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 May 2012 12:24:22 -0400
In-Reply-To: <4FBF4DB7.9050707@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Hi Yan,

On Fri, 25 May 2012, Yan, Zheng wrote:
> I got lots of NULL pointer dereference Oops when compiling kernel on ceph.
> The bug is because the kernel page migration routine replaces some pages
> in the page cache with new pages, these new pages' private can be non-zero.
> 
> Signed-off-by: Zheng Yan <zheng.z.yan@intel.com>
> ---
>  fs/ceph/addr.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 173b1d2..1f180b1 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -984,7 +984,10 @@ retry_locked:
>  	BUG_ON(!ci->i_snap_realm);
>  	down_read(&mdsc->snap_rwsem);
>  	BUG_ON(!ci->i_snap_realm->cached_context);
> -	snapc = (void *)page->private;
> +	if (PagePrivate(page))
> +		snapc = (void *)page->private;
> +	else
> +		snapc = NULL;
>  	if (snapc && snapc != ci->i_head_snapc) {
>  		/*
>  		 * this page is already dirty in another (older) snap
> -- 

This looks right for this case.  What I'm less sure about is whether it's 
sufficient.  I take it the migration only happens on clean pages?  (Unless 
->migrate is implemented?)

Before we were assuming private == NULL on any clean page, independent of 
PG_private.  For example, ceph_invalidatepage() and ceph_releasepage() 
have BUG_ONs that are probably wrong.  writepage_nounlock() has a sanity 
check that should probably be strengthened/guarded with a PagePrivate() 
check, too.

sage
