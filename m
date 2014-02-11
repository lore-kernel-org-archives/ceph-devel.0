From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 1/5] ceph: properly handle XATTR_CREATE and XATTR_REPLACE
Date: Tue, 11 Feb 2014 08:36:57 -0600
Message-ID: <52FA3589.1030608@ieee.org>
References: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36428 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbaBKOg5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Feb 2014 09:36:57 -0500
Received: by mail-ig0-f174.google.com with SMTP id hl1so8877684igb.1
        for <ceph-devel@vger.kernel.org>; Tue, 11 Feb 2014 06:36:56 -0800 (PST)
In-Reply-To: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel@vger.kernel.org
Cc: sage@inktank.com

On 02/10/2014 11:30 PM, Yan, Zheng wrote:
> return -EEXIST if XATTR_CREATE is set and xattr alread exists.
> return -ENODATA if XATTR_REPLACE is set but xattr does not exist.

(I have a set of changes to this source file that I never
got in; I'll see if I can dig them up and post them for
review too, as long as the file is getting some attention.)

My man page says this second case should return ENOATTR,
and although that has the same numeric value as ENODATA,
that could someday change.

That being said, I see "fs/xattr.c uses ENODATA, so I
suppose what you've got is fine.  (Maybe somebody should
fix the man page to resolve the discrepancy.)

I have one other comment at the end--basically that you're
fixing a bug in addition to what you've mentioned above.
Please at least mention that in your explanation.

Otherwise this looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/xattr.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 898b656..28f9793 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -319,8 +319,7 @@ static struct ceph_vxattr *ceph_match_vxattr(struct inode *inode,
>  static int __set_xattr(struct ceph_inode_info *ci,
>  			   const char *name, int name_len,
>  			   const char *val, int val_len,
> -			   int dirty,
> -			   int should_free_name, int should_free_val,
> +			   int flags, int update_xattr,
>  			   struct ceph_inode_xattr **newxattr)
>  {
>  	struct rb_node **p;
> @@ -349,12 +348,25 @@ static int __set_xattr(struct ceph_inode_info *ci,
>  		xattr = NULL;
>  	}
>  
> +	if (update_xattr) {
> +		int err = 0;
> +		if (xattr && (flags & XATTR_CREATE))
> +			err = -EEXIST;
> +		else if (!xattr && (flags & XATTR_REPLACE))
> +			err = -ENODATA;
> +		if (err) {
> +			kfree(name);
> +			kfree(val);
> +			return err;
> +		}
> +	}
> +
>  	if (!xattr) {
>  		new = 1;
>  		xattr = *newxattr;
>  		xattr->name = name;
>  		xattr->name_len = name_len;
> -		xattr->should_free_name = should_free_name;
> +		xattr->should_free_name = update_xattr;
>  
>  		ci->i_xattrs.count++;
>  		dout("__set_xattr count=%d\n", ci->i_xattrs.count);
> @@ -364,7 +376,7 @@ static int __set_xattr(struct ceph_inode_info *ci,
>  		if (xattr->should_free_val)
>  			kfree((void *)xattr->val);
>  
> -		if (should_free_name) {
> +		if (update_xattr) {
>  			kfree((void *)name);
>  			name = xattr->name;
>  		}
> @@ -379,8 +391,8 @@ static int __set_xattr(struct ceph_inode_info *ci,
>  		xattr->val = "";
>  
>  	xattr->val_len = val_len;
> -	xattr->dirty = dirty;
> -	xattr->should_free_val = (val && should_free_val);
> +	xattr->dirty = update_xattr;
> +	xattr->should_free_val = (val && update_xattr);
>  
>  	if (new) {
>  		rb_link_node(&xattr->node, parent, p);
> @@ -588,7 +600,7 @@ start:
>  			p += len;
>  
>  			err = __set_xattr(ci, name, namelen, val, len,
> -					  0, 0, 0, &xattrs[numattr]);
> +					  0, 0, &xattrs[numattr]);
>  
>  			if (err < 0)
>  				goto bad;
> @@ -892,7 +904,7 @@ int __ceph_setxattr(struct dentry *dentry, const char *name,
>  	struct ceph_inode_info *ci = ceph_inode(inode);
>  	int issued;
>  	int err;
> -	int dirty;
> +	int dirty = 0;
>  	int name_len = strlen(name);
>  	int val_len = size;
>  	char *newname = NULL;
> @@ -954,11 +966,13 @@ retry:
>  	}
>  
>  	err = __set_xattr(ci, newname, name_len, newval,
> -			  val_len, 1, 1, 1, &xattr);
> +			  val_len, flags, 1, &xattr);
>  

The following is a good change (only mark ceph inode dirty
if __set_xattr() succeeds), but it is a change of behavior
that should be called attention to in the explanation at the
top of this patch (and possibly separated into its own patch).

> -	dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_XATTR_EXCL);
> -	ci->i_xattrs.dirty = true;
> -	inode->i_ctime = CURRENT_TIME;
> +	if (!err) {
> +		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_XATTR_EXCL);
> +		ci->i_xattrs.dirty = true;
> +		inode->i_ctime = CURRENT_TIME;
> +	}
>  
>  	spin_unlock(&ci->i_ceph_lock);
>  	if (dirty)
> 

