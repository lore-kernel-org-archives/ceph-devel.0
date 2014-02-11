From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 3/5] ceph: fix ceph_removexattr()
Date: Tue, 11 Feb 2014 08:50:46 -0600
Message-ID: <52FA38C6.6060203@ieee.org>
References: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com> <1392096612-11481-3-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:53527 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaBKOup (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Feb 2014 09:50:45 -0500
Received: by mail-ie0-f176.google.com with SMTP id tp5so4407948ieb.7
        for <ceph-devel@vger.kernel.org>; Tue, 11 Feb 2014 06:50:45 -0800 (PST)
In-Reply-To: <1392096612-11481-3-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel@vger.kernel.org
Cc: sage@inktank.com

On 02/10/2014 11:30 PM, Yan, Zheng wrote:
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>

You need a better explanation than "fix."

We have the ENODATA thing (versus ENOATTR), but again
what you have is fine.

> ---
>  fs/ceph/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 6ed0e5a..79f9c12 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -463,7 +463,7 @@ static int __remove_xattr(struct ceph_inode_info *ci,
>  			  struct ceph_inode_xattr *xattr)
>  {
>  	if (!xattr)
> -		return -EOPNOTSUPP;
> +		return -ENODATA;

It seems like this could be a void function, and the (one) caller
could check for null before making the call.

Either way though, this looks good.

Reviewed-by: Alex Elder <elder@linaro.org>


>  
>  	rb_erase(&xattr->node, &ci->i_xattrs.index);
>  
> 

