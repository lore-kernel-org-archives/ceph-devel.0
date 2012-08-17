From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: Fix oops when mounting cephfs with non-existing
 path
Date: Fri, 17 Aug 2012 08:54:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208170850380.26904@cobra.newdream.net>
References: <1345182959-6486-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46767 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab2HQPya (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 11:54:30 -0400
In-Reply-To: <1345182959-6486-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Hi Yan,

On Fri, 17 Aug 2012, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> req->r_locked_dir is NULL if the request was created by
> open_root_dentry(). ceph_fill_trace() lacks check for this case.
> It causes oops when mounting cephfs with non-existing path.

This is actually an MDS bug.  The problem is that the client is issuing a 
GETATTR request and isn't prepared to handle a dentry in the reply, but 
the MDS sees that there is a relative path in the request and behaves like 
this is a lookup.  We were distinguishing correctly between the two cases 
on success, but not on error.  I've pushed branch bug-2969 to ceph.git 
which fixes this for me.  Can you please test and verify it resolves 
the problem?

We may want to have a check like the below, but it should probably be 
accompanied by a pr_warning or WARN_ON() since it is a protocol error.  
Generally speaking, the client isn't allowed to ignore state the MDS has 
issued it (in this case, caps on the directory inode; lower down in 
fill_trace possibly a dentry lease) without messing up the protocol.

Thanks for looking at this!  Looking at your global_id patch next...

Thanks-
sage


http://tracker.newdream.net/issues/2959

> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/inode.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 9fff9f3..40e2ef1 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -992,6 +992,13 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
>  	if (rinfo->head->is_dentry) {
>  		struct inode *dir = req->r_locked_dir;
>  
> +		/*
> +		 * req->r_locked_dir is null if the request was created
> +		 * by open_root_dentry()
> +		 */
> +		if (!dir)
> +			return le32_to_cpu(rinfo->head->result);
> +
>  		err = fill_inode(dir, &rinfo->diri, rinfo->dirfrag,
>  				 session, req->r_request_started, -1,
>  				 &req->r_caps_reservation);
> -- 
> 1.7.11.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
