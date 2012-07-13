From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] ceph: fix potential double free
Date: Fri, 13 Jul 2012 09:36:57 -0500
Message-ID: <50003289.5010805@inktank.com>
References: <20120713142839.23587.58658.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54353 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430Ab2GMOg7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jul 2012 10:36:59 -0400
Received: by yenl2 with SMTP id l2so3616739yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jul 2012 07:36:58 -0700 (PDT)
In-Reply-To: <20120713142839.23587.58658.stgit@localhost.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ceph-devel@vger.kernel.org

On 07/13/2012 09:28 AM, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> We re-run the loop but we don't re-set the attrs pointer back to NULL.

It looks to me like we're OK here without this.

At the top of the loop, the if condition either holds or it does not.
- If it does not, we don't touch "xattrs" again, before returning "err".
- If the condition holds, the next time "xattrs" is touched is when its
  value is assigned the result of a kcalloc() call.

That being said, I really do prefer to have pointers get invalidated
after their freed, so I'll happily add your change...

Reviewed-by: Alex Elder <elder@inktank.com>

> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  fs/ceph/xattr.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 785cb30..2c2ae5b 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -457,6 +457,7 @@ start:
>  			for (i = 0; i < numattr; i++)
>  				kfree(xattrs[i]);
>  			kfree(xattrs);
> +			xattrs = NULL;
>  			goto start;
>  		}
>  		err = -EIO;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


