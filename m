From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 1/2] ceph: check rinfo->dir_dir before dereferencing
 it.
Date: Mon, 30 Sep 2013 14:55:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309301453180.12714@cobra.newdream.net>
References: <1380371685-11577-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57633 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755859Ab3I3VzN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Sep 2013 17:55:13 -0400
In-Reply-To: <1380371685-11577-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, dan.carpenter@oracle.com

Hi Yan,

I squashed these two patches into the commits they fix.  master and 
testing branches are updated+rebased.

NOTE: I've been treating these branches as a patch queue and rebase as 
needed.  If anyone is using the ceph-client.git tree as a basis for 
development and is disrupted by this, let me know!

sage



On Sat, 28 Sep 2013, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 49d4de0..6f0a35c 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1288,7 +1288,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
>  	u64 r_readdir_offset = req->r_readdir_offset;
>  	u32 frag = le32_to_cpu(rhead->args.readdir.frag);
>  
> -	if (le32_to_cpu(rinfo->dir_dir->frag) != frag) {
> +	if (rinfo->dir_dir &&
> +	    le32_to_cpu(rinfo->dir_dir->frag) != frag) {
>  		dout("readdir_prepopulate got new frag %x -> %x\n",
>  		     frag, le32_to_cpu(rinfo->dir_dir->frag));
>  		frag = le32_to_cpu(rinfo->dir_dir->frag);
> -- 
> 1.8.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
