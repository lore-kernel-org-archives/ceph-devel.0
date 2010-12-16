From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 2/2] ceph: mark user pages dirty on direct-io reads
Date: Wed, 15 Dec 2010 21:18:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012152115140.13669@cobra.newdream.net>
References: <1292474959-2834-1-git-send-email-sage@newdream.net>
 <1292474959-2834-2-git-send-email-sage@newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37355 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab0LPFN1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Dec 2010 00:13:27 -0500
In-Reply-To: <1292474959-2834-2-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Henry C Chang <henry_c_chang@tcloudcomputing.com>

On Wed, 15 Dec 2010, Sage Weil wrote:
> From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
> 
> For read operation, we have to set the argument _write_ of get_user_pages
> to 1 since we will write data to pages. Also, we need to SetPageDirty before
> releasing these pages.

I made one small change from your version (see below).

That aside, I have no idea if this patch is the right thing to do.  I 
thought the page bits were mainly important for the page cache... what do 
we accomplish by marking user pages dirty this way?

sage

>
> Signed-off-by: Henry C Chang <henry_c_chang@tcloudcomputing.com>
> Signed-off-by: Sage Weil <sage@newdream.net>
> ---
>  fs/ceph/file.c               |    4 ++--
>  include/linux/ceph/libceph.h |    3 ++-
>  net/ceph/pagevec.c           |    6 +++---
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index e860d8f..e0f136d 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -384,7 +384,7 @@ static ssize_t ceph_sync_read(struct file *file, char __user *data,
>  
>  	if (file->f_flags & O_DIRECT) {
>  		num_pages = calc_pages_for((unsigned long)data, len);
> -		pages = ceph_get_direct_page_vector(data, num_pages);
> +		pages = ceph_get_direct_page_vector(data, num_pages, true);
>  	} else {
>  		num_pages = calc_pages_for(off, len);
>  		pages = ceph_alloc_page_vector(num_pages, GFP_NOFS);
> @@ -522,7 +522,7 @@ more:
>  		return -ENOMEM;
>  
>  	if (file->f_flags & O_DIRECT) {
> -		pages = ceph_get_direct_page_vector(data, num_pages);
> +		pages = ceph_get_direct_page_vector(data, num_pages, false);
>  		if (IS_ERR(pages)) {
>  			ret = PTR_ERR(pages);
>  			goto out;
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index 9e76d35..11992e8 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -227,7 +227,8 @@ extern int ceph_open_session(struct ceph_client *client);
>  extern void ceph_release_page_vector(struct page **pages, int num_pages);
>  
>  extern struct page **ceph_get_direct_page_vector(const char __user *data,
> -						 int num_pages);
> +						 int num_pages,
> +						 bool write_page);
>  extern void ceph_put_page_vector(struct page **pages, int num_pages);
>  extern void ceph_release_page_vector(struct page **pages, int num_pages);
>  extern struct page **ceph_alloc_page_vector(int num_pages, gfp_t flags);
> diff --git a/net/ceph/pagevec.c b/net/ceph/pagevec.c
> index ac34fee..128d5ba 100644
> --- a/net/ceph/pagevec.c
> +++ b/net/ceph/pagevec.c
> @@ -13,18 +13,18 @@
>   * build a vector of user pages
>   */
>  struct page **ceph_get_direct_page_vector(const char __user *data,
> -					  int num_pages)
> +					  int num_pages, bool write_page)
>  {
>  	struct page **pages;
>  	int rc;
>  
> -	pages = kmalloc(sizeof(*pages) * num_pages, GFP_NOFS);
> +	pages = kzalloc(sizeof(*pages) * num_pages, GFP_NOFS);
>  	if (!pages)
>  		return ERR_PTR(-ENOMEM);
>  
>  	down_read(&current->mm->mmap_sem);
>  	rc = get_user_pages(current, current->mm, (unsigned long)data,
> -			    num_pages, 0, 0, pages, NULL);
> +			    num_pages, write_page, 0, pages, NULL);
>  	up_read(&current->mm->mmap_sem);
>  	if (rc < 0)

Your version had this as
	if (rc < num_pages)
but as far as I can see get_user_pages always returns either the full 
result, or nothing (the __get_user_pages fail path releases what it has so 
far).  Hmm, that actually means the kzalloc change isn't needed too, 
right?


>  		goto fail;
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
