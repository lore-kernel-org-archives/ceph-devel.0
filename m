From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH 2/2] ceph: use d_invalidate() to invalidate aliases
Date: Tue, 03 Sep 2013 08:48:50 -0500
Message-ID: <5225E8C2.9020202@linaro.org>
References: <1378106394-14481-1-git-send-email-zheng.z.yan@intel.com> <1378106394-14481-2-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:38115 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932911Ab3ICNsp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Sep 2013 09:48:45 -0400
Received: by mail-ie0-f182.google.com with SMTP id aq17so10548403iec.27
        for <ceph-devel@vger.kernel.org>; Tue, 03 Sep 2013 06:48:45 -0700 (PDT)
In-Reply-To: <1378106394-14481-2-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

On 09/02/2013 02:19 AM, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> d_invalidate() is the standard VFS method to invalidate dentry.
> compare to d_delete(), it also try shrinking children dentries.

I'm less familiar with this code than rbd and the osd client,
so you probably want another reviewer.
I have one comment though, below.

> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/caps.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 7b451eb..13976c3 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -2346,10 +2346,10 @@ static void invalidate_aliases(struct inode *inode)
>  	d_prune_aliases(inode);
>  	/*
>  	 * For non-directory inode, d_find_alias() only returns
> -	 * connected dentry. After calling d_delete(), the dentry
> -	 * become disconnected.
> +	 * connected dentry. After calling d_invalidate(), the
> +	 * dentry become disconnected.
>  	 *
> -	 * For directory inode, d_find_alias() only can return
> +	 * For directory inode, d_find_alias() can return
>  	 * disconnected dentry. But directory inode should have
>  	 * one alias at most.
>  	 */
> @@ -2358,7 +2358,7 @@ static void invalidate_aliases(struct inode *inode)
>  			dput(dn);
>  			break;
>  		}
> -		d_delete(dn);
> +		d_invalidate(dn);

Unlike d_delete(), d_invalidate() can return an error, and in
particular will return an error if there are other dentries
reachable from the one being invalidated.  Do you need to check
for and handle an error here?

					-Alex

>  		if (prev)
>  			dput(prev);
>  		prev = dn;
> 

