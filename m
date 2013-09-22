From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 2/3] ceph: handle frag mismatch between readdir request
 and reply
Date: Sat, 21 Sep 2013 20:59:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309212059530.19555@cobra.newdream.net>
References: <1379717080-15626-1-git-send-email-zheng.z.yan@intel.com> <1379717080-15626-3-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43931 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab3IVD77 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Sep 2013 23:59:59 -0400
In-Reply-To: <1379717080-15626-3-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

On Sat, 21 Sep 2013, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> If client has outdated directory fragments information, it may request
> readdir an non-existent directory fragment. In this case, the MDS finds
> an approximate directory fragment and sends its contents back to the
> client. When receiving a reply with fragment that is different than the
> requested one, the client need to reset the 'readdir offset'.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/dir.c        | 11 ++++++++++-
>  fs/ceph/inode.c      | 15 +++++++++++++--
>  fs/ceph/mds_client.c |  3 +--
>  3 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 868b61d..2a0bcae 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -352,8 +352,18 @@ more:
>  		}
>  
>  		/* note next offset and last dentry name */
> +		rinfo = &req->r_reply_info;
> +		if (le32_to_cpu(rinfo->dir_dir->frag) != frag) {
> +			frag = le32_to_cpu(rinfo->dir_dir->frag);
> +			if (ceph_frag_is_leftmost(frag))
> +				fi->next_offset = 2;
> +			else
> +				fi->next_offset = 0;
> +			off = fi->next_offset;
> +		}
>  		fi->offset = fi->next_offset;
>  		fi->last_readdir = req;
> +		fi->frag = frag;
>  
>  		if (req->r_reply_info.dir_end) {
>  			kfree(fi->last_name);
> @@ -363,7 +373,6 @@ more:
>  			else
>  				fi->next_offset = 0;
>  		} else {
> -			rinfo = &req->r_reply_info;
>  			err = note_last_dentry(fi,
>  				       rinfo->dir_dname[rinfo->dir_nr-1],
>  				       rinfo->dir_dname_len[rinfo->dir_nr-1]);
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index cf12ea6..833a4d5 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1274,8 +1274,19 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
>  	int err = 0, i;
>  	struct inode *snapdir = NULL;
>  	struct ceph_mds_request_head *rhead = req->r_request->front.iov_base;
> -	u64 frag = le32_to_cpu(rhead->args.readdir.frag);
>  	struct ceph_dentry_info *di;
> +	u64 r_readdir_offset = req->r_readdir_offset;
> +	u32 frag = le32_to_cpu(rhead->args.readdir.frag);
> +
> +	if (le32_to_cpu(rinfo->dir_dir->frag) != frag) {
> +		dout("readdir_prepopulate got new frag %x -> %x\n",
> +		     frag, le32_to_cpu(rinfo->dir_dir->frag));
> +		frag = le32_to_cpu(rinfo->dir_dir->frag);
> +		if (ceph_frag_is_leftmost(frag))
> +			r_readdir_offset = 2;
> +		else
> +			r_readdir_offset = 0;
> +	}
>  
>  	if (req->r_aborted)
>  		return readdir_prepopulate_inodes_only(req, session);
> @@ -1339,7 +1350,7 @@ retry_lookup:
>  		}
>  
>  		di = dn->d_fsdata;
> -		di->offset = ceph_make_fpos(frag, i + req->r_readdir_offset);
> +		di->offset = ceph_make_fpos(frag, i + r_readdir_offset);
>  
>  		/* inode */
>  		if (dn->d_inode) {
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index b7bda5d..f51ab26 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2238,8 +2238,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
>  	err = ceph_fill_trace(mdsc->fsc->sb, req, req->r_session);
>  	if (err == 0) {
>  		if (result == 0 && (req->r_op == CEPH_MDS_OP_READDIR ||
> -				    req->r_op == CEPH_MDS_OP_LSSNAP) &&
> -		    rinfo->dir_nr)
> +				    req->r_op == CEPH_MDS_OP_LSSNAP))
>  			ceph_readdir_prepopulate(req, req->r_session);
>  		ceph_unreserve_caps(mdsc, &req->r_caps_reservation);
>  	}
> -- 
> 1.8.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
