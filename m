From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] ceph: don't null-terminate xattr values
Date: Fri, 2 Mar 2012 11:27:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203021127370.6413@cobra.newdream.net>
References: <4F4D97B2.1060201@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51011 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab2CBT1u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 14:27:50 -0500
In-Reply-To: <4F4D97B2.1060201@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@newdream.net>


On Tue, 28 Feb 2012, Alex Elder wrote:

> For some reason, ceph_setxattr() allocates an extra byte in which a
> '\0' is stored past the end of an extended attribute value.  This is
> not needed, and is potentially misleading, so get rid of it.
> 
> Signed-off-by: Alex Elder <elder@dreamhost.com>
> ---
>  fs/ceph/xattr.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 9e6734e..b98b91d 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -730,11 +730,9 @@ int ceph_setxattr(struct dentry *dentry, const char
> *name,
>  		goto out;
> 
>  	if (val_len) {
> -		newval = kmalloc(val_len + 1, GFP_NOFS);
> +		newval = kmemdup(value, val_len, GFP_NOFS);
>  		if (!newval)
>  			goto out;
> -		memcpy(newval, value, val_len);
> -		newval[val_len] = '\0';
>  	}
> 
>  	xattr = kmalloc(sizeof(struct ceph_inode_xattr), GFP_NOFS);
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
