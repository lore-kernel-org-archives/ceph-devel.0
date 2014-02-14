From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 4/5] ceph: add missing init_acl() for mkdir() and atomic_open()
Date: Fri, 14 Feb 2014 07:08:27 -0600
Message-ID: <52FE154B.3050009@ieee.org>
References: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com> <1392096612-11481-4-git-send-email-zheng.z.yan@intel.com> <20140214054649.GA3488@x230> <52FDB3D1.200@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:50515 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbaBNNI1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Feb 2014 08:08:27 -0500
Received: by mail-ie0-f181.google.com with SMTP id to1so6846429ieb.26
        for <ceph-devel@vger.kernel.org>; Fri, 14 Feb 2014 05:08:27 -0800 (PST)
In-Reply-To: <52FDB3D1.200@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel@vger.kernel.org, sage@inktank.com

On 02/14/2014 12:12 AM, Yan, Zheng wrote:
> updated patch

This looks OK, but I just finished reviewing a separate patch that
seems to do this...  One or the other.  Provided you resolve that:

Reviewed-by: Alex Elder <elder@linaro.org>


> ---
> From 9c517a5af5af472a0bee9c900b7df400b10f3098 Mon Sep 17 00:00:00 2001
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> Date: Tue, 11 Feb 2014 12:55:05 +0800
> Subject: [PATCH 4/5] ceph: add missing init_acl() for mkdir() and
>  atomic_open()
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/dir.c  | 13 ++++++++-----
>  fs/ceph/file.c |  1 +
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 6da4df8..2e3b30d 100644
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
>  	return err;
>  }
> @@ -735,7 +734,9 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
>  	if (!err && !req->r_reply_info.head->is_dentry)
>  		err = ceph_handle_notrace_create(dir, dentry);
>  	ceph_mdsc_put_request(req);
> -	if (err)
> +	if (!err)
> +		ceph_init_acl(dentry, dentry->d_inode, dir);
> +	else
>  		d_drop(dentry);
>  	return err;
>  }
> @@ -776,7 +777,9 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
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
>  			*opened |= FILE_CREATED;
>  		}
>  		err = finish_open(file, dentry, ceph_open, opened);
> 

