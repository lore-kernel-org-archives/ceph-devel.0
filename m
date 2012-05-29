From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: check PG_Private flag before accessing page->private
Date: Mon, 28 May 2012 20:56:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205282055490.29306@cobra.newdream.net>
References: <1338187470-28060-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47979 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892Ab2E2D4s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 May 2012 23:56:48 -0400
In-Reply-To: <1338187470-28060-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 28 May 2012, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> I got lots of NULL pointer dereference Oops when compiling kernel on ceph.
> The bug is because the kernel page migration routine replaces some pages
> in the page cache with new pages, these new pages' private can be non-zero.

Thanks, this looks good!  I've applied this to the testing branch... if 
all goes well it'll get included in the pull this week.

sage

> 
> Signed-off-by: Zheng Yan <zheng.z.yan@intel.com>
> ---
>  fs/ceph/addr.c |   21 ++++++++++++---------
>  1 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 173b1d2..8b67304e 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -54,7 +54,12 @@
>  	(CONGESTION_ON_THRESH(congestion_kb) -				\
>  	 (CONGESTION_ON_THRESH(congestion_kb) >> 2))
>  
> -
> +static inline struct ceph_snap_context *page_snap_context(struct page *page)
> +{
> +	if (PagePrivate(page))
> +		return (void *)page->private;
> +	return NULL;
> +}
>  
>  /*
>   * Dirty a page.  Optimistically adjust accounting, on the assumption
> @@ -142,10 +147,9 @@ static void ceph_invalidatepage(struct page *page, unsigned long offset)
>  {
>  	struct inode *inode;
>  	struct ceph_inode_info *ci;
> -	struct ceph_snap_context *snapc = (void *)page->private;
> +	struct ceph_snap_context *snapc = page_snap_context(page);
>  
>  	BUG_ON(!PageLocked(page));
> -	BUG_ON(!page->private);
>  	BUG_ON(!PagePrivate(page));
>  	BUG_ON(!page->mapping);
>  
> @@ -182,7 +186,6 @@ static int ceph_releasepage(struct page *page, gfp_t g)
>  	struct inode *inode = page->mapping ? page->mapping->host : NULL;
>  	dout("%p releasepage %p idx %lu\n", inode, page, page->index);
>  	WARN_ON(PageDirty(page));
> -	WARN_ON(page->private);
>  	WARN_ON(PagePrivate(page));
>  	return 0;
>  }
> @@ -443,7 +446,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
>  	osdc = &fsc->client->osdc;
>  
>  	/* verify this is a writeable snap context */
> -	snapc = (void *)page->private;
> +	snapc = page_snap_context(page);
>  	if (snapc == NULL) {
>  		dout("writepage %p page %p not dirty?\n", inode, page);
>  		goto out;
> @@ -451,7 +454,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
>  	oldest = get_oldest_context(inode, &snap_size);
>  	if (snapc->seq > oldest->seq) {
>  		dout("writepage %p page %p snapc %p not writeable - noop\n",
> -		     inode, page, (void *)page->private);
> +		     inode, page, snapc);
>  		/* we should only noop if called by kswapd */
>  		WARN_ON((current->flags & PF_MEMALLOC) == 0);
>  		ceph_put_snap_context(oldest);
> @@ -591,7 +594,7 @@ static void writepages_finish(struct ceph_osd_request *req,
>  			clear_bdi_congested(&fsc->backing_dev_info,
>  					    BLK_RW_ASYNC);
>  
> -		ceph_put_snap_context((void *)page->private);
> +		ceph_put_snap_context(page_snap_context(page));
>  		page->private = 0;
>  		ClearPagePrivate(page);
>  		dout("unlocking %d %p\n", i, page);
> @@ -795,7 +798,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>  			}
>  
>  			/* only if matching snap context */
> -			pgsnapc = (void *)page->private;
> +			pgsnapc = page_snap_context(page);
>  			if (pgsnapc->seq > snapc->seq) {
>  				dout("page snapc %p %lld > oldest %p %lld\n",
>  				     pgsnapc, pgsnapc->seq, snapc, snapc->seq);
> @@ -984,7 +987,7 @@ static int ceph_update_writeable_page(struct file *file,
>  	BUG_ON(!ci->i_snap_realm);
>  	down_read(&mdsc->snap_rwsem);
>  	BUG_ON(!ci->i_snap_realm->cached_context);
> -	snapc = (void *)page->private;
> +	snapc = page_snap_context(page);
>  	if (snapc && snapc != ci->i_head_snapc) {
>  		/*
>  		 * this page is already dirty in another (older) snap
> -- 
> 1.7.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
