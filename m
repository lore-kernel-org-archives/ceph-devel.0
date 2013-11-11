From: Guangliang Zhao <lucienchao@gmail.com>
Subject: Re: [PATCH v4] ceph: add acl for cephfs
Date: Mon, 11 Nov 2013 12:34:53 +0800
Message-ID: <20131111043453.GB4394@x230>
References: <1383888233-3687-1-git-send-email-lucienchao@gmail.com>
 <527C8F97.9030300@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:56239 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab3KKEe7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Nov 2013 23:34:59 -0500
Received: by mail-pd0-f179.google.com with SMTP id y10so4639070pdj.24
        for <ceph-devel@vger.kernel.org>; Sun, 10 Nov 2013 20:34:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <527C8F97.9030300@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

On Fri, Nov 08, 2013 at 03:15:35PM +0800, Yan Zheng wrote:
> Hi,
> 
> thank you for working on this.
> 
> On 11/08/2013 01:23 PM, Guangliang Zhao wrote:
> > v4: check the validity before set/get_cached_acl()
> > 
> > v3: handle the attr change in ceph_set_acl()
> > 
> > v2: remove some redundant code in ceph_setattr()
> > 
> > Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
> > ---
> >  fs/ceph/Kconfig  |   13 +++
> >  fs/ceph/Makefile |    1 +
> >  fs/ceph/acl.c    |  326 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/ceph/dir.c    |    5 +
> >  fs/ceph/inode.c  |   14 +++
> >  fs/ceph/super.c  |    4 +
> >  fs/ceph/super.h  |   35 ++++++
> >  fs/ceph/xattr.c  |   60 ++++++++--
> >  8 files changed, 446 insertions(+), 12 deletions(-)
> >  create mode 100644 fs/ceph/acl.c
> > 
> > diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
> > index ac9a2ef..264e9bf 100644
> > --- a/fs/ceph/Kconfig
> > +++ b/fs/ceph/Kconfig
> > @@ -25,3 +25,16 @@ config CEPH_FSCACHE
> >  	  caching support for Ceph clients using FS-Cache
> >  
> >  endif
> > +
> > +config CEPH_FS_POSIX_ACL
> > +	bool "Ceph POSIX Access Control Lists"
> > +	depends on CEPH_FS
> > +	select FS_POSIX_ACL
> > +	help
> > +	  POSIX Access Control Lists (ACLs) support permissions for users and
> > +	  groups beyond the owner/group/world scheme.
> > +
> > +	  To learn more about Access Control Lists, visit the POSIX ACLs for
> > +	  Linux website <http://acl.bestbits.at/>.
> > +
> > +	  If you don't know what Access Control Lists are, say N
> > diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
> > index 32e3010..85a4230 100644
> > --- a/fs/ceph/Makefile
> > +++ b/fs/ceph/Makefile
> > @@ -10,3 +10,4 @@ ceph-y := super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
> >  	debugfs.o
> >  
> >  ceph-$(CONFIG_CEPH_FSCACHE) += cache.o
> > +ceph-$(CONFIG_CEPH_FS_POSIX_ACL) += acl.o
> > diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
> > new file mode 100644
> > index 0000000..a474626
> > --- /dev/null
> > +++ b/fs/ceph/acl.c
> > @@ -0,0 +1,326 @@
> > +/*
> > + * linux/fs/ceph/acl.c
> > + *
> > + * Copyright (C) 2013 Guangliang Zhao, <lucienchao@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public
> > + * License v2 as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public
> > + * License along with this program; if not, write to the
> > + * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
> > + * Boston, MA 021110-1307, USA.
> > + */
> > +
> > +#include <linux/ceph/ceph_debug.h>
> > +#include <linux/fs.h>
> > +#include <linux/string.h>
> > +#include <linux/xattr.h>
> > +#include <linux/posix_acl_xattr.h>
> > +#include <linux/posix_acl.h>
> > +#include <linux/sched.h>
> > +#include <linux/slab.h>
> > +
> > +#include "super.h"
> > +
> > +static inline void ceph_set_cached_acl(struct inode *inode,
> > +					int type, struct posix_acl *acl)
> > +{
> > +	struct ceph_inode_info *ci = ceph_inode(inode);
> > +	int issued;
> > +
> > +	spin_lock(&ci->i_ceph_lock);
> > +	issued = __ceph_caps_issued(ci, NULL);
> > +	if (issued & (CEPH_CAP_XATTR_EXCL | CEPH_CAP_XATTR_SHARED)) {
> > +		set_cached_acl(inode, type, acl);
> > +		ci->i_aclcache_gen = ci->i_rdcache_gen;
> > +	}
> > +	spin_unlock(&ci->i_ceph_lock);
> > +
> > +}
> > +
> > +static inline struct posix_acl *ceph_get_cached_acl(struct inode *inode,
> > +							int type)
> > +{
> > +	struct ceph_inode_info *ci = ceph_inode(inode);
> > +	struct posix_acl *acl = NULL;
> > +
> > +	spin_lock(&ci->i_ceph_lock);
> > +	if (ci->i_aclcache_gen == ci->i_rdcache_gen)
> > +		acl = get_cached_acl(inode, type);
> > +	spin_unlock(&ci->i_ceph_lock);
> > +
> > +	return acl;
> > +}
> 
> i_rdcache_gen is for Fc cap, it's incorrect to use it to validate xattrs. how about the incremental patch below.

It looks good to me.

> 
> ---
> diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
> index a474626..cfa47dc 100644
> --- a/fs/ceph/acl.c
> +++ b/fs/ceph/acl.c
> @@ -33,14 +33,10 @@ static inline void ceph_set_cached_acl(struct inode *inode,
>  					int type, struct posix_acl *acl)
>  {
>  	struct ceph_inode_info *ci = ceph_inode(inode);
> -	int issued;
>  
>  	spin_lock(&ci->i_ceph_lock);
> -	issued = __ceph_caps_issued(ci, NULL);
> -	if (issued & (CEPH_CAP_XATTR_EXCL | CEPH_CAP_XATTR_SHARED)) {
> +	if (__ceph_caps_issued_mask(ci, CEPH_CAP_XATTR_SHARED, 0))
>  		set_cached_acl(inode, type, acl);
> -		ci->i_aclcache_gen = ci->i_rdcache_gen;
> -	}
>  	spin_unlock(&ci->i_ceph_lock);
>  
>  }
> @@ -52,13 +48,18 @@ static inline struct posix_acl *ceph_get_cached_acl(struct inode *inode,
>  	struct posix_acl *acl = NULL;
>  
>  	spin_lock(&ci->i_ceph_lock);
> -	if (ci->i_aclcache_gen == ci->i_rdcache_gen)
> +	if (__ceph_caps_issued_mask(ci, CEPH_CAP_XATTR_SHARED, 0))
>  		acl = get_cached_acl(inode, type);
>  	spin_unlock(&ci->i_ceph_lock);
>  
>  	return acl;
>  }
>  
> +void ceph_forget_all_cached_acls(struct inode *inode)
> +{
> +	forget_all_cached_acls(inode);
> +}
> +
>  struct posix_acl *ceph_get_acl(struct inode *inode, int type)
>  {
>  	int size;
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 016bbd6..af39227 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -2459,6 +2459,7 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
>  				ceph_buffer_put(ci->i_xattrs.blob);
>  			ci->i_xattrs.blob = ceph_buffer_get(xattr_buf);
>  			ci->i_xattrs.version = version;
> +			ceph_forget_all_cached_acls(inode);
>  		}
>  	}
>  
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 1d3fa1f..cfc926e 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -364,10 +364,6 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
>  	ci->i_rdcache_gen = 0;
>  	ci->i_rdcache_revoking = 0;
>  
> -#ifdef CONFIG_CEPH_FS_POSIX_ACL
> -	ci->i_aclcache_gen = 0;
> -#endif
> -
>  	INIT_LIST_HEAD(&ci->i_unsafe_writes);
>  	INIT_LIST_HEAD(&ci->i_unsafe_dirops);
>  	spin_lock_init(&ci->i_unsafe_lock);
> @@ -682,6 +678,7 @@ static int fill_inode(struct inode *inode,
>  			memcpy(ci->i_xattrs.blob->vec.iov_base,
>  			       iinfo->xattr_data, iinfo->xattr_len);
>  		ci->i_xattrs.version = le64_to_cpu(info->xattr_version);
> +		ceph_forget_all_cached_acls(inode);
>  		xattr_blob = NULL;
>  	}
>  
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 879840c..6afc70e 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -332,11 +332,6 @@ struct ceph_inode_info {
>  	u32 i_fscache_gen; /* sequence, for delayed fscache validate */
>  	struct work_struct i_revalidate_work;
>  #endif
> -
> -#ifdef CONFIG_CEPH_FS_POSIX_ACL
> -	u32 i_aclcache_gen;
> -#endif
> -
>  	struct inode vfs_inode; /* at end */
>  };
>  
> @@ -747,6 +742,7 @@ extern const struct xattr_handler *ceph_xattr_handlers[];
>  struct posix_acl *ceph_get_acl(struct inode *, int);
>  int ceph_init_acl(struct dentry *, struct inode *, struct inode *);
>  int ceph_acl_chmod(struct dentry *, struct inode *);
> +void ceph_forget_all_cached_acls(struct inode *inode);
>  
>  #else
>  
> @@ -763,6 +759,10 @@ static inline int ceph_acl_chmod(struct dentry *dentry, struct inode *inode)
>  	return 0;
>  }
>  
> +static inline void ceph_forget_all_cached_acls(struct inode *inode)
> +{
> +}
> +
>  #endif
>  
>  /* caps.c */
> ---
> 
> 
> > +
> > +struct posix_acl *ceph_get_acl(struct inode *inode, int type)
> > +{
> > +	int size;
> > +	const char *name;
> > +	char *value = NULL;
> > +	struct posix_acl *acl;
> > +
> > +	if (!IS_POSIXACL(inode))
> > +		return NULL;
> > +
> > +	acl = ceph_get_cached_acl(inode, type);
> > +	if (acl != ACL_NOT_CACHED)
> > +		return acl;
> > +
> > +	switch (type) {
> > +	case ACL_TYPE_ACCESS:
> > +		name = POSIX_ACL_XATTR_ACCESS;
> > +		break;
> > +	case ACL_TYPE_DEFAULT:
> > +		name = POSIX_ACL_XATTR_DEFAULT;
> > +		break;
> > +	default:
> > +		BUG();
> > +	}
> > +
> > +	size = __ceph_getxattr(inode, name, "", 0);
> > +	if (size > 0) {
> > +		value = kzalloc(size, GFP_NOFS);
> > +		if (!value)
> > +			return ERR_PTR(-ENOMEM);
> > +		size = __ceph_getxattr(inode, name, value, size);
> > +	}
> > +
> > +	if (size > 0)
> > +		acl = posix_acl_from_xattr(&init_user_ns, value, size);
> > +	else if (size == -ERANGE || size == -ENODATA || size == 0)
> > +		acl = NULL;
> > +	else
> > +		acl = ERR_PTR(-EIO);
> > +
> > +	kfree(value);
> > +
> > +	if (!IS_ERR(acl))
> > +		ceph_set_cached_acl(inode, type, acl);
> > +
> > +	return acl;
> > +}
> > +
> > +static int ceph_set_acl(struct dentry *dentry, struct inode *inode,
> > +				struct posix_acl *acl, int type)
> > +{
> > +	int ret = 0, size = 0;
> > +	const char *name = NULL;
> > +	char *value = NULL;
> > +	struct iattr newattrs;
> > +	umode_t new_mode = inode->i_mode;
> > +
> > +	if (acl) {
> > +		ret = posix_acl_valid(acl);
> > +		if (ret < 0)
> > +			goto out;
> > +	}
> > +
> > +	switch (type) {
> > +	case ACL_TYPE_ACCESS:
> > +		name = POSIX_ACL_XATTR_ACCESS;
> > +		if (acl) {
> > +			ret = posix_acl_equiv_mode(acl, &new_mode);
> > +			if (ret < 0)
> > +				goto out;
> > +			if (ret == 0)
> > +				acl = NULL;
> > +		}
> > +		break;
> > +	case ACL_TYPE_DEFAULT:
> > +		if (!S_ISDIR(inode->i_mode)) {
> > +			ret = acl ? -EINVAL : 0;
> > +			goto out;
> > +		}
> > +		name = POSIX_ACL_XATTR_DEFAULT;
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	if (acl) {
> > +		size = posix_acl_xattr_size(acl->a_count);
> > +		value = kmalloc(size, GFP_NOFS);
> > +		if (!value) {
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +
> > +		ret = posix_acl_to_xattr(&init_user_ns, acl, value, size);
> > +		if (ret < 0)
> > +			goto out_free;
> > +	}
> > +
> > +	if (new_mode != inode->i_mode) {
> > +		newattrs.ia_mode = new_mode;
> > +		newattrs.ia_valid = ATTR_MODE;
> > +		ret = ceph_setattr(dentry, &newattrs);
> > +		if (ret)
> > +			goto out_free;
> > +	}
> > +
> > +	if (value)
> > +		ret = __ceph_setxattr(dentry, name, value, size, 0);
> > +	else
> > +		ret = __ceph_removexattr(dentry, name);
> > +
> > +	if (ret)
> > +		goto out_free;
> > +
> > +	ceph_set_cached_acl(inode, type, acl);
> > +
> > +out_free:
> > +	kfree(value);
> > +out:
> > +	return ret;
> > +}
> > +
> > +int ceph_init_acl(struct dentry *dentry, struct inode *inode, struct inode *dir)
> > +{
> > +	struct posix_acl *acl = NULL;
> > +	int ret = 0;
> > +
> > +	if (!S_ISLNK(inode->i_mode)) {
> > +		if (IS_POSIXACL(dir)) {
> > +			acl = ceph_get_acl(dir, ACL_TYPE_DEFAULT);
> > +			if (IS_ERR(acl)) {
> > +				ret = PTR_ERR(acl);
> > +				goto out;
> > +			}
> > +		}
> > +
> > +		if (!acl)
> > +			inode->i_mode &= ~current_umask();
> > +	}
> > +
> > +	if (IS_POSIXACL(dir) && acl) {
> > +		if (S_ISDIR(inode->i_mode)) {
> > +			ret = ceph_set_acl(dentry, inode, acl,
> > +						ACL_TYPE_DEFAULT);
> > +			if (ret)
> > +				goto out_release;
> > +		}
> > +		ret = posix_acl_create(&acl, GFP_NOFS, &inode->i_mode);
> > +		if (ret < 0)
> > +			goto out;
> > +		else if (ret > 0)
> > +			ret = ceph_set_acl(dentry, inode, acl, ACL_TYPE_ACCESS);
> > +		else
> > +			cache_no_acl(inode);
> > +	} else {
> > +		cache_no_acl(inode);
> > +	}
> > +
> > +out_release:
> > +	posix_acl_release(acl);
> > +out:
> > +	return ret;
> > +}
> > +
> > +int ceph_acl_chmod(struct dentry *dentry, struct inode *inode)
> > +{
> > +	struct posix_acl *acl;
> > +	int ret = 0;
> > +
> > +	if (S_ISLNK(inode->i_mode)) {
> > +		ret = -EOPNOTSUPP;
> > +		goto out;
> > +	}
> > +
> > +	if (!IS_POSIXACL(inode))
> > +		goto out;
> > +
> > +	acl = ceph_get_acl(inode, ACL_TYPE_ACCESS);
> > +	if (IS_ERR_OR_NULL(acl)) {
> > +		ret = PTR_ERR(acl);
> > +		goto out;
> > +	}
> > +
> > +	ret = posix_acl_chmod(&acl, GFP_KERNEL, inode->i_mode);
> > +	if (ret)
> > +		goto out;
> > +	ret = ceph_set_acl(dentry, inode, acl, ACL_TYPE_ACCESS);
> > +	posix_acl_release(acl);
> > +out:
> > +	return ret;
> > +}
> > +
> > +static int ceph_xattr_acl_get(struct dentry *dentry, const char *name,
> > +				void *value, size_t size, int type)
> > +{
> > +	struct posix_acl *acl;
> > +	int ret = 0;
> > +
> > +	if (!IS_POSIXACL(dentry->d_inode))
> > +		return -EOPNOTSUPP;
> > +
> > +	acl = ceph_get_acl(dentry->d_inode, type);
> > +	if (IS_ERR(acl))
> > +		return PTR_ERR(acl);
> > +	if (acl == NULL)
> > +		return -ENODATA;
> > +
> > +	ret = posix_acl_to_xattr(&init_user_ns, acl, value, size);
> > +	posix_acl_release(acl);
> > +
> > +	return ret;
> > +}
> > +
> > +static int ceph_xattr_acl_set(struct dentry *dentry, const char *name,
> > +			const void *value, size_t size, int flags, int type)
> > +{
> > +	int ret = 0;
> > +	struct posix_acl *acl = NULL;
> > +
> > +	if (!inode_owner_or_capable(dentry->d_inode)) {
> > +		ret = -EPERM;
> > +		goto out;
> > +	}
> > +
> > +	if (!IS_POSIXACL(dentry->d_inode)) {
> > +		ret = -EOPNOTSUPP;
> > +		goto out;
> > +	}
> > +
> > +	if (value) {
> > +		acl = posix_acl_from_xattr(&init_user_ns, value, size);
> > +		if (IS_ERR(acl)) {
> > +			ret = PTR_ERR(acl);
> > +			goto out;
> > +		}
> > +
> > +		if (acl) {
> > +			ret = posix_acl_valid(acl);
> > +			if (ret)
> > +				goto out_release;
> > +		}
> > +	}
> > +
> > +	ret = ceph_set_acl(dentry, dentry->d_inode, acl, type);
> > +
> > +out_release:
> > +	posix_acl_release(acl);
> > +out:
> > +	return ret;
> > +}
> > +
> > +const struct xattr_handler ceph_xattr_acl_default_handler = {
> > +	.prefix = POSIX_ACL_XATTR_DEFAULT,
> > +	.flags  = ACL_TYPE_DEFAULT,
> > +	.get    = ceph_xattr_acl_get,
> > +	.set    = ceph_xattr_acl_set,
> > +};
> > +
> > +const struct xattr_handler ceph_xattr_acl_access_handler = {
> > +	.prefix = POSIX_ACL_XATTR_ACCESS,
> > +	.flags  = ACL_TYPE_ACCESS,
> > +	.get    = ceph_xattr_acl_get,
> > +	.set    = ceph_xattr_acl_set,
> > +};
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index 2a0bcae..b629e9d 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -693,6 +693,10 @@ static int ceph_mknod(struct inode *dir, struct dentry *dentry,
> >  	if (!err && !req->r_reply_info.head->is_dentry)
> >  		err = ceph_handle_notrace_create(dir, dentry);
> >  	ceph_mdsc_put_request(req);
> > +
> > +	if (!err)
> > +		err = ceph_init_acl(dentry, dentry->d_inode, dir);
> > +
> >  	if (err)
> >  		d_drop(dentry);
> >  	return err;
> > @@ -1293,6 +1297,7 @@ const struct inode_operations ceph_dir_iops = {
> >  	.getxattr = ceph_getxattr,
> >  	.listxattr = ceph_listxattr,
> >  	.removexattr = ceph_removexattr,
> > +	.get_acl = ceph_get_acl,
> >  	.mknod = ceph_mknod,
> >  	.symlink = ceph_symlink,
> >  	.mkdir = ceph_mkdir,
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index 2ae1381..4021ef0 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -95,6 +95,7 @@ const struct inode_operations ceph_file_iops = {
> >  	.getxattr = ceph_getxattr,
> >  	.listxattr = ceph_listxattr,
> >  	.removexattr = ceph_removexattr,
> > +	.get_acl = ceph_get_acl,
> >  };
> >  
> >  
> > @@ -366,6 +367,10 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
> >  	ci->i_rdcache_gen = 0;
> >  	ci->i_rdcache_revoking = 0;
> >  
> > +#ifdef CONFIG_CEPH_FS_POSIX_ACL
> > +	ci->i_aclcache_gen = 0;
> > +#endif
> > +
> >  	INIT_LIST_HEAD(&ci->i_unsafe_writes);
> >  	INIT_LIST_HEAD(&ci->i_unsafe_dirops);
> >  	spin_lock_init(&ci->i_unsafe_lock);
> > @@ -1632,6 +1637,7 @@ static const struct inode_operations ceph_symlink_iops = {
> >  	.getxattr = ceph_getxattr,
> >  	.listxattr = ceph_listxattr,
> >  	.removexattr = ceph_removexattr,
> > +	.get_acl = ceph_get_acl,
> >  };
> >  
> >  /*
> > @@ -1705,6 +1711,7 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
> >  			dirtied |= CEPH_CAP_AUTH_EXCL;
> >  		} else if ((issued & CEPH_CAP_AUTH_SHARED) == 0 ||
> >  			   attr->ia_mode != inode->i_mode) {
> > +			inode->i_mode = attr->ia_mode;
> >  			req->r_args.setattr.mode = cpu_to_le32(attr->ia_mode);
> >  			mask |= CEPH_SETATTR_MODE;
> >  			release |= CEPH_CAP_AUTH_SHARED;
> > @@ -1820,6 +1827,12 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
> >  	if (inode_dirty_flags)
> >  		__mark_inode_dirty(inode, inode_dirty_flags);
> >  
> > +	if (ia_valid & ATTR_MODE) {
> > +		err = ceph_acl_chmod(dentry, inode);
> > +		if (err)
> > +			goto out_put;
> > +	}
> > +
> >  	if (mask) {
> >  		req->r_inode = inode;
> >  		ihold(inode);
> > @@ -1839,6 +1852,7 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
> >  	return err;
> >  out:
> >  	spin_unlock(&ci->i_ceph_lock);
> > +out_put:
> >  	ceph_mdsc_put_request(req);
> >  	return err;
> >  }
> > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > index e58bd4a..c6740e4 100644
> > --- a/fs/ceph/super.c
> > +++ b/fs/ceph/super.c
> > @@ -819,7 +819,11 @@ static int ceph_set_super(struct super_block *s, void *data)
> >  
> >  	s->s_flags = fsc->mount_options->sb_flags;
> >  	s->s_maxbytes = 1ULL << 40;  /* temp value until we get mdsmap */
> > +#ifdef CONFIG_CEPH_FS_POSIX_ACL
> > +	s->s_flags |= MS_POSIXACL;
> > +#endif
> >  
> > +	s->s_xattr = ceph_xattr_handlers;
> >  	s->s_fs_info = fsc;
> >  	fsc->sb = s;
> >  
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index 8de94b5..dbcd4d2 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -336,6 +336,10 @@ struct ceph_inode_info {
> >  	struct work_struct i_revalidate_work;
> >  #endif
> >  
> > +#ifdef CONFIG_CEPH_FS_POSIX_ACL
> > +	u32 i_aclcache_gen;
> > +#endif
> > +
> >  	struct inode vfs_inode; /* at end */
> >  };
> >  
> > @@ -725,6 +729,9 @@ extern int ceph_getattr(struct vfsmount *mnt, struct dentry *dentry,
> >  /* xattr.c */
> >  extern int ceph_setxattr(struct dentry *, const char *, const void *,
> >  			 size_t, int);
> > +int __ceph_setxattr(struct dentry *, const char *, const void *, size_t, int);
> > +ssize_t __ceph_getxattr(struct inode *, const char *, void *, size_t);
> > +int __ceph_removexattr(struct dentry *, const char *);
> >  extern ssize_t ceph_getxattr(struct dentry *, const char *, void *, size_t);
> >  extern ssize_t ceph_listxattr(struct dentry *, char *, size_t);
> >  extern int ceph_removexattr(struct dentry *, const char *);
> > @@ -733,6 +740,34 @@ extern void __ceph_destroy_xattrs(struct ceph_inode_info *ci);
> >  extern void __init ceph_xattr_init(void);
> >  extern void ceph_xattr_exit(void);
> >  
> > +/* acl.c */
> > +extern const struct xattr_handler ceph_xattr_acl_access_handler;
> > +extern const struct xattr_handler ceph_xattr_acl_default_handler;
> > +extern const struct xattr_handler *ceph_xattr_handlers[];
> > +
> > +#ifdef CONFIG_CEPH_FS_POSIX_ACL
> > +
> > +struct posix_acl *ceph_get_acl(struct inode *, int);
> > +int ceph_init_acl(struct dentry *, struct inode *, struct inode *);
> > +int ceph_acl_chmod(struct dentry *, struct inode *);
> > +
> > +#else
> > +
> > +#define ceph_get_acl NULL
> > +
> > +static inline int ceph_init_acl(struct dentry *dentry, struct inode *inode,
> > +				struct inode *dir)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline int ceph_acl_chmod(struct dentry *dentry, struct inode *inode)
> > +{
> > +	return 0;
> > +}
> > +
> > +#endif
> > +
> >  /* caps.c */
> >  extern const char *ceph_cap_string(int c);
> >  extern void ceph_handle_caps(struct ceph_mds_session *session,
> > diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> > index be661d8..c7581f3 100644
> > --- a/fs/ceph/xattr.c
> > +++ b/fs/ceph/xattr.c
> > @@ -11,11 +11,24 @@
> >  #define XATTR_CEPH_PREFIX "ceph."
> >  #define XATTR_CEPH_PREFIX_LEN (sizeof (XATTR_CEPH_PREFIX) - 1)
> >  
> > +/*
> > + * List of handlers for synthetic system.* attributes. Other
> > + * attributes are handled directly.
> > + */
> > +const struct xattr_handler *ceph_xattr_handlers[] = {
> > +#ifdef CONFIG_CEPH_FS_POSIX_ACL
> > +	&ceph_xattr_acl_access_handler,
> > +	&ceph_xattr_acl_default_handler,
> > +#endif
> > +	NULL,
> > +};
> > +
> >  static bool ceph_is_valid_xattr(const char *name)
> >  {
> >  	return !strncmp(name, XATTR_CEPH_PREFIX, XATTR_CEPH_PREFIX_LEN) ||
> >  	       !strncmp(name, XATTR_SECURITY_PREFIX,
> >  			XATTR_SECURITY_PREFIX_LEN) ||
> > +	       !strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN) ||
> >  	       !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN) ||
> >  	       !strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
> >  }
> > @@ -663,10 +676,9 @@ void __ceph_build_xattrs_blob(struct ceph_inode_info *ci)
> >  	}
> >  }
> >  
> > -ssize_t ceph_getxattr(struct dentry *dentry, const char *name, void *value,
> > +ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
> >  		      size_t size)
> >  {
> > -	struct inode *inode = dentry->d_inode;
> >  	struct ceph_inode_info *ci = ceph_inode(inode);
> >  	int err;
> >  	struct ceph_inode_xattr *xattr;
> > @@ -675,7 +687,6 @@ ssize_t ceph_getxattr(struct dentry *dentry, const char *name, void *value,
> >  	if (!ceph_is_valid_xattr(name))
> >  		return -ENODATA;
> >  
> > -
> >  	/* let's see if a virtual xattr was requested */
> >  	vxattr = ceph_match_vxattr(inode, name);
> >  	if (vxattr && !(vxattr->exists_cb && !vxattr->exists_cb(ci))) {
> > @@ -725,6 +736,15 @@ out:
> >  	return err;
> >  }
> >  
> > +ssize_t ceph_getxattr(struct dentry *dentry, const char *name, void *value,
> > +		      size_t size)
> > +{
> > +	if (!strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN))
> > +		return generic_getxattr(dentry, name, value, size);
> > +
> > +	return __ceph_getxattr(dentry->d_inode, name, value, size);
> > +}
> > +
> >  ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
> >  {
> >  	struct inode *inode = dentry->d_inode;
> > @@ -863,8 +883,8 @@ out:
> >  	return err;
> >  }
> >  
> > -int ceph_setxattr(struct dentry *dentry, const char *name,
> > -		  const void *value, size_t size, int flags)
> > +int __ceph_setxattr(struct dentry *dentry, const char *name,
> > +			const void *value, size_t size, int flags)
> >  {
> >  	struct inode *inode = dentry->d_inode;
> >  	struct ceph_vxattr *vxattr;
> > @@ -879,9 +899,6 @@ int ceph_setxattr(struct dentry *dentry, const char *name,
> >  	struct ceph_inode_xattr *xattr = NULL;
> >  	int required_blob_size;
> >  
> > -	if (ceph_snap(inode) != CEPH_NOSNAP)
> > -		return -EROFS;
> > -
> >  	if (!ceph_is_valid_xattr(name))
> >  		return -EOPNOTSUPP;
> >  
> > @@ -958,6 +975,18 @@ out:
> >  	return err;
> >  }
> >  
> > +int ceph_setxattr(struct dentry *dentry, const char *name,
> > +		  const void *value, size_t size, int flags)
> > +{
> > +	if (ceph_snap(dentry->d_inode) != CEPH_NOSNAP)
> > +		return -EROFS;
> > +
> > +	if (!strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN))
> > +		return generic_setxattr(dentry, name, value, size, flags);
> > +
> > +	return __ceph_setxattr(dentry, name, value, size, flags);
> > +}
> > +
> >  static int ceph_send_removexattr(struct dentry *dentry, const char *name)
> >  {
> >  	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
> > @@ -984,7 +1013,7 @@ static int ceph_send_removexattr(struct dentry *dentry, const char *name)
> >  	return err;
> >  }
> >  
> > -int ceph_removexattr(struct dentry *dentry, const char *name)
> > +int __ceph_removexattr(struct dentry *dentry, const char *name)
> >  {
> >  	struct inode *inode = dentry->d_inode;
> >  	struct ceph_vxattr *vxattr;
> > @@ -994,9 +1023,6 @@ int ceph_removexattr(struct dentry *dentry, const char *name)
> >  	int required_blob_size;
> >  	int dirty;
> >  
> > -	if (ceph_snap(inode) != CEPH_NOSNAP)
> > -		return -EROFS;
> > -
> >  	if (!ceph_is_valid_xattr(name))
> >  		return -EOPNOTSUPP;
> >  
> > @@ -1053,3 +1079,13 @@ out:
> >  	return err;
> >  }
> >  
> > +int ceph_removexattr(struct dentry *dentry, const char *name)
> > +{
> > +	if (ceph_snap(dentry->d_inode) != CEPH_NOSNAP)
> > +		return -EROFS;
> > +
> > +	if (!strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN))
> > +		return generic_removexattr(dentry, name);
> > +
> > +	return __ceph_removexattr(dentry, name);
> > +}
> > 
> 

-- 
Best regards,
Guangliang
