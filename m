From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 1/2] ceph: Fix return value of encode_fh function
Date: Tue, 5 Oct 2010 10:02:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010051001480.21681@cobra.newdream.net>
References: <1286274822-27738-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38652 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab0JERAO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Oct 2010 13:00:14 -0400
In-Reply-To: <1286274822-27738-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: ceph-devel@vger.kernel.org

Aneesh,

I'll add these to my tree (unless you want to send them separately?).

Thanks!
sage


On Tue, 5 Oct 2010, Aneesh Kumar K.V wrote:

> encode_fh function should return 255 on error as done by other file
> system to indicate EOVERFLOW. Also max_len is in sizeof(u32) units
> and not in bytes.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  fs/ceph/export.c |   16 +++++++++-------
>  1 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> index 4480cb1..387c582 100644
> --- a/fs/ceph/export.c
> +++ b/fs/ceph/export.c
> @@ -42,32 +42,34 @@ struct ceph_nfs_confh {
>  static int ceph_encode_fh(struct dentry *dentry, u32 *rawfh, int *max_len,
>  			  int connectable)
>  {
> +	int type;
>  	struct ceph_nfs_fh *fh = (void *)rawfh;
>  	struct ceph_nfs_confh *cfh = (void *)rawfh;
>  	struct dentry *parent = dentry->d_parent;
>  	struct inode *inode = dentry->d_inode;
> -	int type;
> +	int connected_handle_length = sizeof(*cfh)/4;
> +	int handle_length = sizeof(*fh)/4;
>  
>  	/* don't re-export snaps */
>  	if (ceph_snap(inode) != CEPH_NOSNAP)
>  		return -EINVAL;
>  
> -	if (*max_len >= sizeof(*cfh)) {
> +	if (*max_len >= connected_handle_length) {
>  		dout("encode_fh %p connectable\n", dentry);
>  		cfh->ino = ceph_ino(dentry->d_inode);
>  		cfh->parent_ino = ceph_ino(parent->d_inode);
>  		cfh->parent_name_hash = parent->d_name.hash;
> -		*max_len = sizeof(*cfh);
> +		*max_len = connected_handle_length;
>  		type = 2;
> -	} else if (*max_len > sizeof(*fh)) {
> +	} else if (*max_len >= handle_length) {
>  		if (connectable)
> -			return -ENOSPC;
> +			return 255;
>  		dout("encode_fh %p\n", dentry);
>  		fh->ino = ceph_ino(dentry->d_inode);
> -		*max_len = sizeof(*fh);
> +		*max_len = handle_length;
>  		type = 1;
>  	} else {
> -		return -ENOSPC;
> +		return 255;
>  	}
>  	return type;
>  }
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
