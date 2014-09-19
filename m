From: Sage Weil <sweil@redhat.com>
Subject: Re: [PATCH 2/3] ceph: use pagelist to present MDS request data
Date: Thu, 18 Sep 2014 22:06:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409182205490.18018@cobra.newdream.net>
References: <1410874759-11562-1-git-send-email-zyan@redhat.com> <1410874759-11562-2-git-send-email-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40485 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbaISFGG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Sep 2014 01:06:06 -0400
In-Reply-To: <1410874759-11562-2-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 16 Sep 2014, Yan, Zheng wrote:
> Current code uses page array to present MDS request data. Pages in the
> array are allocated/freed by caller of ceph_mdsc_do_request(). If request
> is interrupted, the pages can be freed while they are still being used by
> the request message.
> 
> The fix is use pagelist to present MDS request data. Pagelist is
> reference counted.
> 
> Signed-off-by: Yan, Zheng <zyan@redhat.com>

So much nicer!

Reviewed-by: Sage Weil <sage@redhat.com>

> ---
>  fs/ceph/mds_client.c | 14 +++++++++-----
>  fs/ceph/mds_client.h |  4 +---
>  fs/ceph/xattr.c      | 46 ++++++++++++++++------------------------------
>  3 files changed, 26 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 30d7338..80d9f07 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -542,6 +542,8 @@ void ceph_mdsc_release_request(struct kref *kref)
>  	}
>  	kfree(req->r_path1);
>  	kfree(req->r_path2);
> +	if (req->r_pagelist)
> +		ceph_pagelist_release(req->r_pagelist);
>  	put_request_session(req);
>  	ceph_unreserve_caps(req->r_mdsc, &req->r_caps_reservation);
>  	kfree(req);
> @@ -1847,13 +1849,15 @@ static struct ceph_msg *create_request_message(struct ceph_mds_client *mdsc,
>  	msg->front.iov_len = p - msg->front.iov_base;
>  	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
>  
> -	if (req->r_data_len) {
> -		/* outbound data set only by ceph_sync_setxattr() */
> -		BUG_ON(!req->r_pages);
> -		ceph_msg_data_add_pages(msg, req->r_pages, req->r_data_len, 0);
> +	if (req->r_pagelist) {
> +		struct ceph_pagelist *pagelist = req->r_pagelist;
> +		atomic_inc(&pagelist->refcnt);
> +		ceph_msg_data_add_pagelist(msg, pagelist);
> +		msg->hdr.data_len = cpu_to_le32(pagelist->length);
> +	} else {
> +		msg->hdr.data_len = 0;
>  	}
>  
> -	msg->hdr.data_len = cpu_to_le32(req->r_data_len);
>  	msg->hdr.data_off = cpu_to_le16(0);
>  
>  out_free2:
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index e00737c..23015f7 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -202,9 +202,7 @@ struct ceph_mds_request {
>  	bool r_direct_is_hash;  /* true if r_direct_hash is valid */
>  
>  	/* data payload is used for xattr ops */
> -	struct page **r_pages;
> -	int r_num_pages;
> -	int r_data_len;
> +	struct ceph_pagelist *r_pagelist;
>  
>  	/* what caps shall we drop? */
>  	int r_inode_drop, r_inode_unless;
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index eab3e2f..c7b18b2 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1,4 +1,5 @@
>  #include <linux/ceph/ceph_debug.h>
> +#include <linux/ceph/pagelist.h>
>  
>  #include "super.h"
>  #include "mds_client.h"
> @@ -852,28 +853,17 @@ static int ceph_sync_setxattr(struct dentry *dentry, const char *name,
>  	struct ceph_mds_request *req;
>  	struct ceph_mds_client *mdsc = fsc->mdsc;
>  	int err;
> -	int i, nr_pages;
> -	struct page **pages = NULL;
> -	void *kaddr;
> -
> -	/* copy value into some pages */
> -	nr_pages = calc_pages_for(0, size);
> -	if (nr_pages) {
> -		pages = kmalloc(sizeof(pages[0])*nr_pages, GFP_NOFS);
> -		if (!pages)
> -			return -ENOMEM;
> -		err = -ENOMEM;
> -		for (i = 0; i < nr_pages; i++) {
> -			pages[i] = __page_cache_alloc(GFP_NOFS);
> -			if (!pages[i]) {
> -				nr_pages = i;
> -				goto out;
> -			}
> -			kaddr = kmap(pages[i]);
> -			memcpy(kaddr, value + i*PAGE_CACHE_SIZE,
> -			       min(PAGE_CACHE_SIZE, size-i*PAGE_CACHE_SIZE));
> -		}
> -	}
> +	struct ceph_pagelist *pagelist;
> +
> +	/* copy value into pagelist */
> +	pagelist = kmalloc(sizeof(*pagelist), GFP_NOFS);
> +	if (!pagelist)
> +		return -ENOMEM;
> +
> +	ceph_pagelist_init(pagelist);
> +	err = ceph_pagelist_append(pagelist, value, size);
> +	if (err)
> +		goto out;
>  
>  	dout("setxattr value=%.*s\n", (int)size, value);
>  
> @@ -894,9 +884,8 @@ static int ceph_sync_setxattr(struct dentry *dentry, const char *name,
>  	req->r_args.setxattr.flags = cpu_to_le32(flags);
>  	req->r_path2 = kstrdup(name, GFP_NOFS);
>  
> -	req->r_pages = pages;
> -	req->r_num_pages = nr_pages;
> -	req->r_data_len = size;
> +	req->r_pagelist = pagelist;
> +	pagelist = NULL;
>  
>  	dout("xattr.ver (before): %lld\n", ci->i_xattrs.version);
>  	err = ceph_mdsc_do_request(mdsc, NULL, req);
> @@ -904,11 +893,8 @@ static int ceph_sync_setxattr(struct dentry *dentry, const char *name,
>  	dout("xattr.ver (after): %lld\n", ci->i_xattrs.version);
>  
>  out:
> -	if (pages) {
> -		for (i = 0; i < nr_pages; i++)
> -			__free_page(pages[i]);
> -		kfree(pages);
> -	}
> +	if (pagelist)
> +		ceph_pagelist_release(pagelist);
>  	return err;
>  }
>  
> -- 
> 1.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
