From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] fs: ceph: new helper: file_inode(file)
Date: Tue, 10 Dec 2013 21:53:05 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312102152210.18451@cobra.newdream.net>
References: <52A7FCD7.2080809@huawei.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32790 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab3LKFxF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Dec 2013 00:53:05 -0500
In-Reply-To: <52A7FCD7.2080809@huawei.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Libo Chen <clbchenlibo.chen@huawei.com>
Cc: majianpeng <majianpeng@gmail.com>, yunchuanwen@ubuntukylin.com, liwang@ubuntukylin.com, zheng.z.yan@intel.com, ceph-devel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Li Zefan <lizefan@huawei.com>, milosz@adfin.com

Applied, thanks!

On Wed, 11 Dec 2013, Libo Chen wrote:

> 
> Signed-off-by: Libo Chen <clbchenlibo.chen@huawei.com>
> ---
>  fs/ceph/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 3de8982..7549bd6 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1018,7 +1018,7 @@ static long ceph_fallocate(struct file *file, int mode,
>  				loff_t offset, loff_t length)
>  {
>  	struct ceph_file_info *fi = file->private_data;
> -	struct inode *inode = file->f_dentry->d_inode;
> +	struct inode *inode = file_inode(file);
>  	struct ceph_inode_info *ci = ceph_inode(inode);
>  	struct ceph_osd_client *osdc =
>  		&ceph_inode_to_client(inode)->client->osdc;
> -- 
> 1.8.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
