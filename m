From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH V6] ceph: use vfs __set_page_dirty_nobuffers interface
 instead of doing it inside filesystem
Date: Wed, 21 Aug 2013 08:35:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308210835050.1492@cobra.newdream.net>
References: <1377073654-6232-1-git-send-email-handai.szj@taobao.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44012 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab3HUPfb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Aug 2013 11:35:31 -0400
In-Reply-To: <1377073654-6232-1-git-send-email-handai.szj@taobao.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sha Zhengju <handai.szj@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, ukernel@gmail.com, mhocko@suse.cz, akpm@linux-foundation.org, Sha Zhengju <handai.szj@taobao.com>

On Wed, 21 Aug 2013, Sha Zhengju wrote:
> Following we will begin to add memcg dirty page accounting around
> __set_page_dirty_{buffers,nobuffers} in vfs layer, so we'd better use vfs interface to
> avoid exporting those details to filesystems.
> 
> Since vfs set_page_dirty() should be called under page lock, here we don't need elaborate
> codes to handle racy anymore, and two WARN_ON() are added to detect such exceptions.
> Thanks very much for Sage and Yan Zheng's coaching!
> 
> I tested it in a two server's ceph environment that one is client and the other is
> mds/osd/mon, and run the following fsx test from xfstests:
> 
>   ./fsx   1MB -N 50000 -p 10000 -l 1048576
>   ./fsx  10MB -N 50000 -p 10000 -l 10485760
>   ./fsx 100MB -N 50000 -p 10000 -l 104857600
> 
> The fsx does lots of mmap-read/mmap-write/truncate operations and the tests completed
> successfully without triggering any of WARN_ON.
> 
> Signed-off-by: Sha Zhengju <handai.szj@taobao.com>

Reviewed-by: Sage Weil <sage@inktank.com>

Would you like me to take this through the ceph tree?

Thanks-
sage


> ---
>  fs/ceph/addr.c |   42 ++++++++++++++----------------------------
>  1 file changed, 14 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index afb2fc2..01891f4 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -72,13 +72,15 @@ static int ceph_set_page_dirty(struct page *page)
>  	struct ceph_inode_info *ci;
>  	int undo = 0;
>  	struct ceph_snap_context *snapc;
> +	int ret;
>  
>  	if (unlikely(!mapping))
>  		return !TestSetPageDirty(page);
>  
> -	if (TestSetPageDirty(page)) {
> +	if (PageDirty(page)) {
>  		dout("%p set_page_dirty %p idx %lu -- already dirty\n",
>  		     mapping->host, page, page->index);
> +		BUG_ON(!PagePrivate(page));
>  		return 0;
>  	}
>  
> @@ -107,35 +109,19 @@ static int ceph_set_page_dirty(struct page *page)
>  	     snapc, snapc->seq, snapc->num_snaps);
>  	spin_unlock(&ci->i_ceph_lock);
>  
> -	/* now adjust page */
> -	spin_lock_irq(&mapping->tree_lock);
> -	if (page->mapping) {	/* Race with truncate? */
> -		WARN_ON_ONCE(!PageUptodate(page));
> -		account_page_dirtied(page, page->mapping);
> -		radix_tree_tag_set(&mapping->page_tree,
> -				page_index(page), PAGECACHE_TAG_DIRTY);
> -
> -		/*
> -		 * Reference snap context in page->private.  Also set
> -		 * PagePrivate so that we get invalidatepage callback.
> -		 */
> -		page->private = (unsigned long)snapc;
> -		SetPagePrivate(page);
> -	} else {
> -		dout("ANON set_page_dirty %p (raced truncate?)\n", page);
> -		undo = 1;
> -	}
> -
> -	spin_unlock_irq(&mapping->tree_lock);
> -
> -	if (undo)
> -		/* whoops, we failed to dirty the page */
> -		ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
> +	/*
> +	 * Reference snap context in page->private.  Also set
> +	 * PagePrivate so that we get invalidatepage callback.
> +	 */
> +	BUG_ON(PagePrivate(page));
> +	page->private = (unsigned long)snapc;
> +	SetPagePrivate(page);
>  
> -	__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
> +	ret = __set_page_dirty_nobuffers(page);
> +	WARN_ON(!PageLocked(page));
> +	WARN_ON(!page->mapping);
>  
> -	BUG_ON(!PageDirty(page));
> -	return 1;
> +	return ret;
>  }
>  
>  /*
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
