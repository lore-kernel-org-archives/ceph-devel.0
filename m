From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 2/5] ceph: remove zero-size xattr
Date: Tue, 11 Feb 2014 08:47:13 -0600
Message-ID: <52FA37F1.2050903@ieee.org>
References: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com> <1392096612-11481-2-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:59234 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaBKOrN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Feb 2014 09:47:13 -0500
Received: by mail-ie0-f175.google.com with SMTP id ar20so4538975iec.34
        for <ceph-devel@vger.kernel.org>; Tue, 11 Feb 2014 06:47:12 -0800 (PST)
In-Reply-To: <1392096612-11481-2-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel@vger.kernel.org
Cc: sage@inktank.com

On 02/10/2014 11:30 PM, Yan, Zheng wrote:
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>

You really need to explain better under what circumstances
a zero-size xattr is getting removed.

But apparently it's only when you're updating an xattr
(not building it up from a blob from storage).

Why are you doing this?  Why can't an xattr exist with
an empty value?

Looking at generic_setxattr() in "fs/xattr.c" we see:
        if (size == 0)
                value = "";  /* empty EA, do not remove */

The code you have below looks OK, but it seems that you
shouldn't be doing this.

Am I missing something?

					-Alex

> ---
>  fs/ceph/xattr.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 28f9793..6ed0e5a 100644
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
> +		if (!val_len) {
> +			if (xattr)
> +				__remove_xattr(ci, xattr);
> +			kfree(name);
> +			return 0;
> +		}
>  	}
>  
>  	if (!xattr) {
> 

