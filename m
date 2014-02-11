From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 4/5] ceph: add missing init_acl() for mkdir() and atomic_open()
Date: Tue, 11 Feb 2014 11:45:29 -0600
Message-ID: <52FA61B9.8070705@ieee.org>
References: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com> <1392096612-11481-4-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:46532 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbaBKRp2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Feb 2014 12:45:28 -0500
Received: by mail-ig0-f182.google.com with SMTP id uy17so9232777igb.3
        for <ceph-devel@vger.kernel.org>; Tue, 11 Feb 2014 09:45:28 -0800 (PST)
In-Reply-To: <1392096612-11481-4-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel@vger.kernel.org
Cc: sage@inktank.com

On 02/10/2014 11:30 PM, Yan, Zheng wrote:

This looks OK to me but you should get another
opinion, I haven't really given it as thorough a
review as I normally do.

Reviewed-by: Alex Elder <elder@linaro.org>

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

Do symlinks have ACLs?  (I don't know, I just notice that
ceph_symlink() doesn't call ceph_init_acl() on the symlink.)

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

This seems OK but I have to admit I don't know this path
through the code and I don't have time to really dig into
it right now.

>  		}
>  		err = finish_open(file, dentry, ceph_open, opened);
> 

