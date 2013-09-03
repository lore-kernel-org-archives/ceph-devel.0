From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH 1/2] ceph: remove ceph_lookup_inode()
Date: Tue, 03 Sep 2013 08:40:31 -0500
Message-ID: <5225E6CF.2060306@linaro.org>
References: <1378106394-14481-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:55295 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932966Ab3ICNkZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Sep 2013 09:40:25 -0400
Received: by mail-ie0-f176.google.com with SMTP id s9so9781158iec.7
        for <ceph-devel@vger.kernel.org>; Tue, 03 Sep 2013 06:40:25 -0700 (PDT)
In-Reply-To: <1378106394-14481-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

On 09/02/2013 02:19 AM, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> commit 6f60f889 (ceph: fix freeing inode vs removing session caps race)
> introduced ceph_lookup_inode(). But there is already a ceph_find_inode()
> which provides similar function. So remove ceph_lookup_inode(), use
> ceph_find_inode() instead.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  fs/ceph/inode.c      | 8 --------
>  fs/ceph/mds_client.c | 2 +-
>  fs/ceph/super.h      | 2 --
>  3 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index eae41cd..8549a48 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -62,14 +62,6 @@ struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino)
>  	return inode;
>  }
>  
> -struct inode *ceph_lookup_inode(struct super_block *sb, struct ceph_vino vino)
> -{
> -	struct inode *inode;
> -	ino_t t = ceph_vino_to_ino(vino);
> -	inode = ilookup5_nowait(sb, t, ceph_ino_compare, &vino);
> -	return inode;
> -}
> -
>  /*
>   * get/constuct snapdir inode for a given directory
>   */
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 603786b..b7bda5d 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1054,7 +1054,7 @@ static void remove_session_caps(struct ceph_mds_session *session)
>  			vino = cap->ci->i_vino;
>  			spin_unlock(&session->s_cap_lock);
>  
> -			inode = ceph_lookup_inode(sb, vino);
> +			inode = ceph_find_inode(sb, vino);
>  			iput(inode);
>  
>  			spin_lock(&session->s_cap_lock);
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index bb23ef6..6014b0a 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -694,8 +694,6 @@ extern void ceph_destroy_inode(struct inode *inode);
>  
>  extern struct inode *ceph_get_inode(struct super_block *sb,
>  				    struct ceph_vino vino);
> -extern struct inode *ceph_lookup_inode(struct super_block *sb,
> -				       struct ceph_vino vino);
>  extern struct inode *ceph_get_snapdir(struct inode *parent);
>  extern int ceph_fill_file_size(struct inode *inode, int issued,
>  			       u32 truncate_seq, u64 truncate_size, u64 size);
> 

