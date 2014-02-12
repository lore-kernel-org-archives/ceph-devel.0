From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 2/5] ceph: remove zero-size xattr
Date: Tue, 11 Feb 2014 18:43:52 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402111843090.20749@cobra.newdream.net>
References: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com> <1392096612-11481-2-git-send-email-zheng.z.yan@intel.com> <52FA37F1.2050903@ieee.org> <CAAM7YAkrZ=r5qYHw8iwUHALa49DvjwABPwBd--izMv-CvH2OVQ@mail.gmail.com> <52FA5D08.6060108@ieee.org>
 <52FADE57.50107@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40606 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbaBLCnx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Feb 2014 21:43:53 -0500
In-Reply-To: <52FADE57.50107@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: Alex Elder <elder@ieee.org>, "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 12 Feb 2014, Yan, Zheng wrote:
> On 02/12/2014 01:25 AM, Alex Elder wrote:
> > On 02/11/2014 09:10 AM, Yan, Zheng wrote:
> >> On Tue, Feb 11, 2014 at 10:47 PM, Alex Elder <elder@ieee.org> wrote:
> >>> On 02/10/2014 11:30 PM, Yan, Zheng wrote:
> >>>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> >>>
> >>> You really need to explain better under what circumstances
> >>> a zero-size xattr is getting removed.
> >>>
> >>> But apparently it's only when you're updating an xattr
> >>> (not building it up from a blob from storage).
> >>>
> >>> Why are you doing this?  Why can't an xattr exist with
> >>> an empty value?
> >>
> >> That is how other FS behave, at least for ext* and btrfs.
> > 
> > I haven't tested this, I'm just glancing through code.
> > But it looks to me like a zero-length value is OK, but
> > a null value pointer means it should be deleted.  Note
> > in btrfs_setxattr(), for example, the same bit of code
> > I referenced before:
> > 
> >         if (size == 0)
> >                 value = "";  /* empty EA, do not remove */
> > 
> > And ext4 seems to delete for a null value, but handle
> > an xattr whose value *length* is zero.  Same with XFS.
> > 
> > So again, I haven't verified through testing, but my
> > reading of the code (though rusty) still seems to show
> > that an attribute can have an empty (zero-size) value.
> 
> You are right, Thanks. how about below patch?
> 
> ---
> >From f11d5da84230e4993333a063019bad68c67b50d4 Mon Sep 17 00:00:00 2001
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> Date: Tue, 11 Feb 2014 13:04:19 +0800
> Subject: [PATCH 2/5] ceph: remove xattr when null value is given to setxattr()
> 
> For the setxattr request, introduce a new flag CEPH_XATTR_REMOVE
> to distinguish null value case from the zero-length value case.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/xattr.c              | 16 ++++++++++++++--
>  include/linux/ceph/ceph_fs.h |  5 +++--
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 28f9793..f6becf6 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -12,6 +12,9 @@
>  #define XATTR_CEPH_PREFIX "ceph."
>  #define XATTR_CEPH_PREFIX_LEN (sizeof (XATTR_CEPH_PREFIX) - 1)
>  
> +static int __remove_xattr(struct ceph_inode_info *ci,
> +			  struct ceph_inode_xattr *xattr);
> +
>  /*
>   * List of handlers for synthetic system.* attributes. Other
>   * attributes are handled directly.
> @@ -359,6 +362,12 @@ static int __set_xattr(struct ceph_inode_info *ci,
>  			kfree(val);
>  			return err;
>  		}
> +		if (update_xattr < 0) {
> +			if (xattr)
> +				__remove_xattr(ci, xattr);
> +			kfree(name);
> +			return 0;
> +		}
>  	}
>  
>  	if (!xattr) {
> @@ -862,6 +871,9 @@ static int ceph_sync_setxattr(struct dentry *dentry, const char *name,
>  
>  	dout("setxattr value=%.*s\n", (int)size, value);
>  
> +	if (!value)
> +		flags |= CEPH_XATTR_REMOVE;
> +
>  	/* do request */
>  	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SETXATTR,

How about just turning this into a REMOVEXATTR request in the !value case?  

sage

>  				       USE_AUTH_MDS);
> @@ -965,8 +977,8 @@ retry:
>  		goto retry;
>  	}
>  
> -	err = __set_xattr(ci, newname, name_len, newval,
> -			  val_len, flags, 1, &xattr);
> +	err = __set_xattr(ci, newname, name_len, newval, val_len,
> +			  flags, val ? 1 : -1, &xattr);
>  
>  	if (!err) {
>  		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_XATTR_EXCL);
> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
> index 2623cff..25bfb0e 100644
> --- a/include/linux/ceph/ceph_fs.h
> +++ b/include/linux/ceph/ceph_fs.h
> @@ -373,8 +373,9 @@ extern const char *ceph_mds_op_name(int op);
>  /*
>   * Ceph setxattr request flags.
>   */
> -#define CEPH_XATTR_CREATE  1
> -#define CEPH_XATTR_REPLACE 2
> +#define CEPH_XATTR_CREATE  (1 << 0)
> +#define CEPH_XATTR_REPLACE (1 << 1)
> +#define CEPH_XATTR_REMOVE  (1 << 31)
>  
>  union ceph_mds_request_args {
>  	struct {
> -- 
> 1.8.5.3
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> > 
> > 					-Alex
> > 
> >> Regards
> >> Yan, Zheng
> >>
> >>>
> >>> Looking at generic_setxattr() in "fs/xattr.c" we see:
> >>>         if (size == 0)
> >>>                 value = "";  /* empty EA, do not remove */
> >>>
> >>> The code you have below looks OK, but it seems that you
> >>> shouldn't be doing this.
> >>>
> >>> Am I missing something?
> >>>
> >>>                                         -Alex
> >>>
> >>>> ---
> >>>>  fs/ceph/xattr.c | 9 +++++++++
> >>>>  1 file changed, 9 insertions(+)
> >>>>
> >>>> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> >>>> index 28f9793..6ed0e5a 100644
> >>>> --- a/fs/ceph/xattr.c
> >>>> +++ b/fs/ceph/xattr.c
> >>>> @@ -12,6 +12,9 @@
> >>>>  #define XATTR_CEPH_PREFIX "ceph."
> >>>>  #define XATTR_CEPH_PREFIX_LEN (sizeof (XATTR_CEPH_PREFIX) - 1)
> >>>>
> >>>> +static int __remove_xattr(struct ceph_inode_info *ci,
> >>>> +                       struct ceph_inode_xattr *xattr);
> >>>> +
> >>>>  /*
> >>>>   * List of handlers for synthetic system.* attributes. Other
> >>>>   * attributes are handled directly.
> >>>> @@ -359,6 +362,12 @@ static int __set_xattr(struct ceph_inode_info *ci,
> >>>>                       kfree(val);
> >>>>                       return err;
> >>>>               }
> >>>> +             if (!val_len) {
> >>>> +                     if (xattr)
> >>>> +                             __remove_xattr(ci, xattr);
> >>>> +                     kfree(name);
> >>>> +                     return 0;
> >>>> +             }
> >>>>       }
> >>>>
> >>>>       if (!xattr) {
> >>>>
> >>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
