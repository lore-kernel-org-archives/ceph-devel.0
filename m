From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 5/5] ceph: fix ceph_set_acl()
Date: Tue, 11 Feb 2014 12:06:25 -0600
Message-ID: <52FA66A1.9010806@ieee.org>
References: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com> <1392096612-11481-5-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44592 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaBKSGZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Feb 2014 13:06:25 -0500
Received: by mail-ie0-f174.google.com with SMTP id tp5so4783561ieb.33
        for <ceph-devel@vger.kernel.org>; Tue, 11 Feb 2014 10:06:25 -0800 (PST)
In-Reply-To: <1392096612-11481-5-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel@vger.kernel.org
Cc: sage@inktank.com

On 02/10/2014 11:30 PM, Yan, Zheng wrote:
> If acl is equivalent to file mode permission bits, ceph_set_acl()
> needs to remove any existing acl xattr. Use __ceph_setxattr() to
> handle both setting and removing acl xattr cases, it doesn't return
> -ENODATA when there is no acl xattr.

This looks good, however (continuing with our other
discussion) I assume that __set_xattr() will use a
null value rather than 0 value_len to determine whether
to remove the xattr.

And I'll continue to suggest better descriptions.  (I
realize English is not your native language but I
really think the description is important, to be
able to verify the code change matches what the
developer intended it to do.)  The problem here is
that ceph_set_acl() could return -ENODATA if it
attempted to remove a non-existent ACL attribute,
and that shouldn't happen.   (Right?)

Reviewed-by: Alex Elder <elder@linaro.org>

PS  Note that ceph_set_acl() can be made static, and its
    only caller, ceph_init_acl() has its return value
    ignored in all cases.  So in some respects this change
    not matter much.

> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/acl.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
> index 4c2d452..accc9f2 100644
> --- a/fs/ceph/acl.c
> +++ b/fs/ceph/acl.c
> @@ -160,11 +160,7 @@ int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type)
>  			goto out_dput;
>  	}
>  
> -	if (value)
> -		ret = __ceph_setxattr(dentry, name, value, size, 0);
> -	else
> -		ret = __ceph_removexattr(dentry, name);
> -
> +	ret = __ceph_setxattr(dentry, name, value, size, 0);
>  	if (ret) {
>  		if (new_mode != old_mode) {
>  			newattrs.ia_mode = old_mode;
> 

