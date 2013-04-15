From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 3/4] ceph: fix symlink inode operations
Date: Mon, 15 Apr 2013 11:15:22 -0500
Message-ID: <516C279A.7030107@inktank.com>
References: <1365754273-14088-1-git-send-email-zheng.z.yan@intel.com> <1365754273-14088-5-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:43113 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab3DOQPX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 12:15:23 -0400
Received: by mail-ie0-f178.google.com with SMTP id bn7so5919899ieb.37
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 09:15:23 -0700 (PDT)
In-Reply-To: <1365754273-14088-5-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com

On 04/12/2013 03:11 AM, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> add getattr/setattr and xattrs related methods.

Looks good.

Reviewed-by: Alex Elder <elder@inktank.com>

> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 5d730d4..d5cad38 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1523,6 +1523,12 @@ static void *ceph_sym_follow_link(struct dentry *dentry, struct nameidata *nd)
>  static const struct inode_operations ceph_symlink_iops = {
>  	.readlink = generic_readlink,
>  	.follow_link = ceph_sym_follow_link,
> +	.setattr = ceph_setattr,
> +	.getattr = ceph_getattr,
> +	.setxattr = ceph_setxattr,
> +	.getxattr = ceph_getxattr,
> +	.listxattr = ceph_listxattr,
> +	.removexattr = ceph_removexattr,
>  };
>  
>  /*
> 

