From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [PATCH] ceph: fix recursively call between ceph_set_acl and
 __ceph_setattr
Date: Wed, 19 Apr 2017 10:02:27 +0100
Message-ID: <20170419090227.f4bze7qbhyuqrnlg@hermes.olymp>
References: <20170419033347.45857-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46321 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1761350AbdDSJCa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 19 Apr 2017 05:02:30 -0400
Content-Disposition: inline
In-Reply-To: <20170419033347.45857-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org, jlayton@redhat.com

On Wed, Apr 19, 2017 at 11:33:47AM +0800, Yan, Zheng wrote:
> ceph_set_acl() calls __ceph_setattr() if the setacl operation needs
> to modify inode's i_mode. __ceph_setattr() updates inode's i_mode,
> then calls posix_acl_chmod().
> 
> The problem is that __ceph_setattr() calls posix_acl_chmod() before
> sending the setattr request. The get_acl() call in posix_acl_chmod()
> can trigger a getxattr request. The reply of the getxattr request
> can restore inode's i_mode to it's old value. The set_acl() call in
> posix_acl_chmod() sees old value of inode's i_mode, so it calls
> __ceph_setattr() again.
> 
> Link: http://tracker.ceph.com/issues/19688
> Reported-by: Jerry Lee <leisurelysw24@gmail.com>
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>

FWIW I was able to reproduce the issue, so feel free to add my

Tested-by: Luis Henriques <lhenriques@suse.com>

Cheers,
--
Luís

> ---
>  fs/ceph/acl.c   |  4 ++--
>  fs/ceph/inode.c | 24 +++++++++++-------------
>  fs/ceph/super.h |  3 ++-
>  3 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
> index 987044b..bc985e0 100644
> --- a/fs/ceph/acl.c
> +++ b/fs/ceph/acl.c
> @@ -133,7 +133,7 @@ int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type)
>  	if (new_mode != old_mode) {
>  		newattrs.ia_mode = new_mode;
>  		newattrs.ia_valid = ATTR_MODE;
> -		ret = __ceph_setattr(inode, &newattrs);
> +		ret = __ceph_setattr(inode, &newattrs, false);
>  		if (ret)
>  			goto out_free;
>  	}
> @@ -143,7 +143,7 @@ int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type)
>  		if (new_mode != old_mode) {
>  			newattrs.ia_mode = old_mode;
>  			newattrs.ia_valid = ATTR_MODE;
> -			__ceph_setattr(inode, &newattrs);
> +                       __ceph_setattr(inode, &newattrs, false);
>  		}
>  		goto out_free;
>  	}
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index efee88c..4aa23c6 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1885,7 +1885,7 @@ static const struct inode_operations ceph_symlink_iops = {
>  	.listxattr = ceph_listxattr,
>  };
>  
> -int __ceph_setattr(struct inode *inode, struct iattr *attr)
> +int __ceph_setattr(struct inode *inode, struct iattr *attr, bool update_acl)
>  {
>  	struct ceph_inode_info *ci = ceph_inode(inode);
>  	const unsigned int ia_valid = attr->ia_valid;
> @@ -2078,11 +2078,6 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
>  	if (inode_dirty_flags)
>  		__mark_inode_dirty(inode, inode_dirty_flags);
>  
> -	if (ia_valid & ATTR_MODE) {
> -		err = posix_acl_chmod(inode, attr->ia_mode);
> -		if (err)
> -			goto out_put;
> -	}
>  
>  	if (mask) {
>  		req->r_inode = inode;
> @@ -2096,13 +2091,16 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
>  	     ceph_cap_string(dirtied), mask);
>  
>  	ceph_mdsc_put_request(req);
> -	if (mask & CEPH_SETATTR_SIZE)
> -		__ceph_do_pending_vmtruncate(inode);
> -	ceph_free_cap_flush(prealloc_cf);
> -	return err;
> -out_put:
> -	ceph_mdsc_put_request(req);
>  	ceph_free_cap_flush(prealloc_cf);
> +
> +	if (err >= 0) {
> +		if (update_acl && (ia_valid & ATTR_MODE)) {
> +			err = posix_acl_chmod(inode, attr->ia_mode);
> +		}
> +		if (mask & CEPH_SETATTR_SIZE) {
> +			__ceph_do_pending_vmtruncate(inode);
> +		}
> +	}
>  	return err;
>  }
>  
> @@ -2121,7 +2119,7 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
>  	if (err != 0)
>  		return err;
>  
> -	return __ceph_setattr(inode, attr);
> +       return __ceph_setattr(inode, attr, true);
>  }
>  
>  /*
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 7334ee8..bc7769c 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -809,7 +809,8 @@ static inline int ceph_do_getattr(struct inode *inode, int mask, bool force)
>  	return __ceph_do_getattr(inode, NULL, mask, force);
>  }
>  extern int ceph_permission(struct inode *inode, int mask);
> -extern int __ceph_setattr(struct inode *inode, struct iattr *attr);
> +extern int __ceph_setattr(struct inode *inode, struct iattr *attr,
> +                         bool update_acl);
>  extern int ceph_setattr(struct dentry *dentry, struct iattr *attr);
>  extern int ceph_getattr(const struct path *path, struct kstat *stat,
>  			u32 request_mask, unsigned int flags);
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
