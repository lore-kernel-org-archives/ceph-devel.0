From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [PATCH v2] ceph: fix recursively call between ceph_set_acl and
 __ceph_setattr
Date: Wed, 19 Apr 2017 15:54:19 +0100
Message-ID: <20170419145419.4vxhno2geszcqv2v@hermes.olymp>
References: <20170419103622.52060-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59666 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935709AbdDSOyW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 19 Apr 2017 10:54:22 -0400
Content-Disposition: inline
In-Reply-To: <20170419103622.52060-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org, jlayton@redhat.com

On Wed, Apr 19, 2017 at 06:36:22PM +0800, Yan, Zheng wrote:
> ceph_set_acl() calls __ceph_setattr() if the setacl operation needs
> to modify inode's i_mode. __ceph_setattr() updates inode's i_mode,
> then calls posix_acl_chmod().
> 
> The problem is that __ceph_setattr() calls posix_acl_chmod() before
> sending the setattr request. The get_acl() call in posix_acl_chmod()
> can trigger a getxattr request. The reply of the getxattr request
> can restore inode's i_mode to its old value. The set_acl() call in
> posix_acl_chmod() sees old value of inode's i_mode, so it calls
> __ceph_setattr() again.
> 
> Link: http://tracker.ceph.com/issues/19688
> Reported-by: Jerry Lee <leisurelysw24@gmail.com>
> Tested-by: Luis Henriques <lhenriques@suse.com>
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>

An additional comment is that this should be tagged for stable kernels.

Cheers,
--
Luís

> ---
>  fs/ceph/inode.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index efee88c..976fd3a 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
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
> @@ -2096,13 +2091,13 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
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
> +		if (mask & CEPH_SETATTR_SIZE) {
> +			__ceph_do_pending_vmtruncate(inode);
> +		}
> +	}
>  	return err;
>  }
>  
> @@ -2121,7 +2116,12 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
>  	if (err != 0)
>  		return err;
>  
> -	return __ceph_setattr(inode, attr);
> +	err = __ceph_setattr(inode, attr);
> +
> +	if (err >= 0 && (attr->ia_valid & ATTR_MODE)) {
> +		err = posix_acl_chmod(inode, attr->ia_mode);
> +	}
> +	return err;
>  }
>  
>  /*
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
