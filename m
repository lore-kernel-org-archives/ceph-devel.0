From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] ceph: fix readpage from fscache
Date: Fri, 04 Aug 2017 05:56:28 -0400
Message-ID: <1501840588.4725.0.camel@redhat.com>
References: <20170804035146.47341-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:38013 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdHDJ4a (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Aug 2017 05:56:30 -0400
Received: by mail-qt0-f173.google.com with SMTP id t37so6110528qtg.5
        for <ceph-devel@vger.kernel.org>; Fri, 04 Aug 2017 02:56:30 -0700 (PDT)
In-Reply-To: <20170804035146.47341-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org

On Fri, 2017-08-04 at 11:51 +0800, Yan, Zheng wrote:
> ceph_readpage() unlocks page prematurely prematurely in the case
> that page is reading from fscache. Caller of readpage expects that
> page is uptodate when it get unlocked. So page shoule get locked
> by completion callback of fscache_read_or_alloc_pages()
> 
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/addr.c  | 26 +++++++++++++++++---------
>  fs/ceph/cache.c | 12 +++---------
>  2 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 1b303f0..fc35627 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -189,7 +189,7 @@ static int ceph_releasepage(struct page *page, gfp_t g)
>  /*
>   * read a single page, without unlocking it.
>   */
> -static int readpage_nounlock(struct file *filp, struct page *page)
> +static int ceph_do_readpage(struct file *filp, struct page *page)
>  {
>  	struct inode *inode = file_inode(filp);
>  	struct ceph_inode_info *ci = ceph_inode(inode);
> @@ -218,8 +218,10 @@ static int readpage_nounlock(struct file *filp, struct page *page)
>  	}
>  
>  	err = ceph_readpage_from_fscache(inode, page);
> -	if (err == 0)
> +	if (err == 0) {
> +		err = -EINPROGRESS;
>  		goto out;
> +	}
>  
>  	dout("readpage inode %p file %p page %p index %lu\n",
>  	     inode, filp, page, page->index);
> @@ -249,8 +251,11 @@ static int readpage_nounlock(struct file *filp, struct page *page)
>  
>  static int ceph_readpage(struct file *filp, struct page *page)
>  {
> -	int r = readpage_nounlock(filp, page);
> -	unlock_page(page);
> +	int r = ceph_do_readpage(filp, page);
> +	if (r != -EINPROGRESS)
> +		unlock_page(page);
> +	else
> +		r = 0;
>  	return r;
>  }
>  
> @@ -1216,7 +1221,7 @@ static int ceph_update_writeable_page(struct file *file,
>  			goto retry_locked;
>  		r = writepage_nounlock(page, NULL);
>  		if (r < 0)
> -			goto fail_nosnap;
> +			goto fail_unlock;
>  		goto retry_locked;
>  	}
>  
> @@ -1244,11 +1249,14 @@ static int ceph_update_writeable_page(struct file *file,
>  	}
>  
>  	/* we need to read it. */
> -	r = readpage_nounlock(file, page);
> -	if (r < 0)
> -		goto fail_nosnap;
> +	r = ceph_do_readpage(file, page);
> +	if (r < 0) {
> +		if (r == -EINPROGRESS)
> +			return -EAGAIN;
> +		goto fail_unlock;
> +	}
>  	goto retry_locked;
> -fail_nosnap:
> +fail_unlock:
>  	unlock_page(page);
>  	return r;
>  }
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> index fd11728..337f886 100644
> --- a/fs/ceph/cache.c
> +++ b/fs/ceph/cache.c
> @@ -297,13 +297,7 @@ void ceph_fscache_file_set_cookie(struct inode *inode, struct file *filp)
>  	}
>  }
>  
> -static void ceph_vfs_readpage_complete(struct page *page, void *data, int error)
> -{
> -	if (!error)
> -		SetPageUptodate(page);
> -}
> -
> -static void ceph_vfs_readpage_complete_unlock(struct page *page, void *data, int error)
> +static void ceph_readpage_from_fscache_complete(struct page *page, void *data, int error)
>  {
>  	if (!error)
>  		SetPageUptodate(page);
> @@ -331,7 +325,7 @@ int ceph_readpage_from_fscache(struct inode *inode, struct page *page)
>  		return -ENOBUFS;
>  
>  	ret = fscache_read_or_alloc_page(ci->fscache, page,
> -					 ceph_vfs_readpage_complete, NULL,
> +					 ceph_readpage_from_fscache_complete, NULL,
>  					 GFP_KERNEL);
>  
>  	switch (ret) {
> @@ -360,7 +354,7 @@ int ceph_readpages_from_fscache(struct inode *inode,
>  		return -ENOBUFS;
>  
>  	ret = fscache_read_or_alloc_pages(ci->fscache, mapping, pages, nr_pages,
> -					  ceph_vfs_readpage_complete_unlock,
> +					  ceph_readpage_from_fscache_complete,
>  					  NULL, mapping_gfp_mask(mapping));
>  
>  	switch (ret) {

Reviewed-by: Jeff Layton <jlayton@redhat.com>
