From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] ceph: fix setting empty extended attribute
Date: Wed, 17 Dec 2014 09:14:35 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412170913500.1008@cobra.newdream.net>
References: <1418823755-25690-1-git-send-email-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60849 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbaLQROf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Dec 2014 12:14:35 -0500
In-Reply-To: <1418823755-25690-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 17 Dec 2014, Yan, Zheng wrote:
> make sure 'value' is not null. otherwise __ceph_setxattr will remove
> the extended attribute.
> 
> Signed-off-by: Yan, Zheng <zyan@redhat.com>

Reviewed-by: Sage Weil <sage@redhat.com>

Nice catch!  Can you make sure one of the tests in ceph.git/qa/workunits/* 
covers this case?

Thanks!
sage


> ---
>  fs/ceph/xattr.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 678b0d2..5a492ca 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -854,7 +854,7 @@ static int ceph_sync_setxattr(struct dentry *dentry, const char *name,
>  	struct ceph_pagelist *pagelist = NULL;
>  	int err;
>  
> -	if (value) {
> +	if (size > 0) {
>  		/* copy value into pagelist */
>  		pagelist = kmalloc(sizeof(*pagelist), GFP_NOFS);
>  		if (!pagelist)
> @@ -864,7 +864,7 @@ static int ceph_sync_setxattr(struct dentry *dentry, const char *name,
>  		err = ceph_pagelist_append(pagelist, value, size);
>  		if (err)
>  			goto out;
> -	} else {
> +	} else if (!value) {
>  		flags |= CEPH_XATTR_REMOVE;
>  	}
>  
> @@ -1001,6 +1001,9 @@ int ceph_setxattr(struct dentry *dentry, const char *name,
>  	if (!strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN))
>  		return generic_setxattr(dentry, name, value, size, flags);
>  
> +	if (size == 0)
> +		value = "";  /* empty EA, do not remove */
> +
>  	return __ceph_setxattr(dentry, name, value, size, flags);
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
