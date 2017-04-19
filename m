From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v2] ceph: fix recursively call between ceph_set_acl and
 __ceph_setattr
Date: Wed, 19 Apr 2017 06:40:41 -0400
Message-ID: <1492598441.2783.4.camel@redhat.com>
References: <20170419103622.52060-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35631 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762291AbdDSKkn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Apr 2017 06:40:43 -0400
Received: by mail-qt0-f173.google.com with SMTP id y33so15331083qta.2
        for <ceph-devel@vger.kernel.org>; Wed, 19 Apr 2017 03:40:43 -0700 (PDT)
In-Reply-To: <20170419103622.52060-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org

On Wed, 2017-04-19 at 18:36 +0800, Yan, Zheng wrote:
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

nit: Could drop some of the curly braces and nesting above:

if (err >= 0 && (mask & CEPH_SETATTR_SIZE))
	__ceph_do_pending_vmtruncate(inode);


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

Much better without the bool argument though :)

Reviewed-by: Jeff Layton <jlayton@redhat.com>
