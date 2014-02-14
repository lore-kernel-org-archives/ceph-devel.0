From: Guangliang Zhao <lucienchao@gmail.com>
Subject: Re: [PATCH 4/5] ceph: add missing init_acl() for mkdir() and
 atomic_open()
Date: Fri, 14 Feb 2014 13:46:49 +0800
Message-ID: <20140214054649.GA3488@x230>
References: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com>
 <1392096612-11481-4-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:49993 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbaBNFqz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Feb 2014 00:46:55 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so11454860pde.41
        for <ceph-devel@vger.kernel.org>; Thu, 13 Feb 2014 21:46:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1392096612-11481-4-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

On Tue, Feb 11, 2014 at 01:30:11PM +0800, Yan Zheng wrote:

This looks good, but there maybe some hiccups, see below.

The symlink also need ceph_init_acl() as Alex mentioned, I have
add it in the patch.

> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/dir.c  | 9 +++++----
>  fs/ceph/file.c | 1 +
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 6da4df8..3bbd0eb 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -695,9 +695,8 @@ static int ceph_mknod(struct inode *dir, struct dentry *dentry,
>  	ceph_mdsc_put_request(req);
>  
>  	if (!err)
> -		err = ceph_init_acl(dentry, dentry->d_inode, dir);
> -
> -	if (err)
> +		ceph_init_acl(dentry, dentry->d_inode, dir);
> +	else
>  		d_drop(dentry);

ceph_init_acl() may fail, we shoud take care of the return value.

>  	return err;
>  }
> @@ -776,7 +775,9 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
>  		err = ceph_handle_notrace_create(dir, dentry);
>  	ceph_mdsc_put_request(req);
>  out:
> -	if (err < 0)
> +	if (!err)
> +		ceph_init_acl(dentry, dentry->d_inode, dir);
> +	else
>  		d_drop(dentry);
>  	return err;
>  }
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index dfd2ce3..09c7afe 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -286,6 +286,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
>  	} else {
>  		dout("atomic_open finish_open on dn %p\n", dn);
>  		if (req->r_op == CEPH_MDS_OP_CREATE && req->r_reply_info.has_create_ino) {
> +			ceph_init_acl(dentry, dentry->d_inode, dir);

Same to above.

>  			*opened |= FILE_CREATED;
>  		}
>  		err = finish_open(file, dentry, ceph_open, opened);
> -- 
> 1.8.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Best regards,
Guangliang
