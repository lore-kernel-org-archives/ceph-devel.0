From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] ceph: fix reset_readdir()
Date: Fri, 28 Feb 2014 08:07:29 -0600
Message-ID: <53109821.50501@ieee.org>
References: <1393578791-19917-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:60724 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbaB1OHW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Feb 2014 09:07:22 -0500
Received: by mail-ie0-f177.google.com with SMTP id rl12so3385371iec.22
        for <ceph-devel@vger.kernel.org>; Fri, 28 Feb 2014 06:07:22 -0800 (PST)
In-Reply-To: <1393578791-19917-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel@vger.kernel.org

On 02/28/2014 03:13 AM, Yan, Zheng wrote:
> When changing readdir postion, fi->next_offset should be set to 0
> if the new postion is not in the first dirfrag.

Again, looks like this would have been a problem if any
fragment other than the first was being seeked to.

Looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/dir.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index a7eaf96..8ce8833 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -454,7 +454,7 @@ more:
>  	return 0;
>  }
>  
> -static void reset_readdir(struct ceph_file_info *fi)
> +static void reset_readdir(struct ceph_file_info *fi, unsigned frag)
>  {
>  	if (fi->last_readdir) {
>  		ceph_mdsc_put_request(fi->last_readdir);
> @@ -462,7 +462,10 @@ static void reset_readdir(struct ceph_file_info *fi)
>  	}
>  	kfree(fi->last_name);
>  	fi->last_name = NULL;
> -	fi->next_offset = 2;  /* compensate for . and .. */
> +	if (ceph_frag_is_leftmost(frag))
> +		fi->next_offset = 2;  /* compensate for . and .. */
> +	else
> +		fi->next_offset = 0;
>  	if (fi->dentry) {
>  		dput(fi->dentry);
>  		fi->dentry = NULL;
> @@ -507,7 +510,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
>  		    fpos_frag(offset) != fi->frag ||
>  		    fpos_off(offset) < fi->offset) {
>  			dout("dir_llseek dropping %p content\n", file);
> -			reset_readdir(fi);
> +			reset_readdir(fi, fpos_frag(offset));
>  		}
>  
>  		/* bump dir_release_count if we did a forward seek */
> 

