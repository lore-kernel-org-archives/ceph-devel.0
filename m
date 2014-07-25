From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] ceph: remove redundant memset(0)
Date: Fri, 25 Jul 2014 07:47:13 -0500
Message-ID: <53D251D1.6010700@ieee.org>
References: <1406280364-30198-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:39825 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbaGYMrN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jul 2014 08:47:13 -0400
Received: by mail-ie0-f173.google.com with SMTP id tr6so3611333ieb.18
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jul 2014 05:47:12 -0700 (PDT)
In-Reply-To: <1406280364-30198-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org
Cc: Yan Zheng <zheng.z.yan@intel.com>

On 07/25/2014 04:26 AM, Ilya Dryomov wrote:
> xattrs array of pointers is allocated with kcalloc() - no need to
> memset() it to 0 right after that.
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  fs/ceph/xattr.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index c9c2b887381e..f89698cdbc41 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -597,7 +597,7 @@ start:
>  		err = -ENOMEM;
>  		if (!xattrs)
>  			goto bad_lock;
> -		memset(xattrs, 0, numattr*sizeof(struct ceph_xattr *));
> +
>  		for (i = 0; i < numattr; i++) {
>  			xattrs[i] = kmalloc(sizeof(struct ceph_inode_xattr),
>  					    GFP_NOFS);
> 

