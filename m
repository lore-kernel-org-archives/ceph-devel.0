From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 1/3] ceph: remove outdated frag information
Date: Sat, 21 Sep 2013 20:50:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309212049540.19555@cobra.newdream.net>
References: <1379717080-15626-1-git-send-email-zheng.z.yan@intel.com> <1379717080-15626-2-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43853 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab3IVDuB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Sep 2013 23:50:01 -0400
In-Reply-To: <1379717080-15626-2-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

On Sat, 21 Sep 2013, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> If directory fragments change, fill_inode() inserts new frags into
> the fragtree, but it does not remove outdated frags from the fragtree.
> This patch fixes it.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/inode.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 8549a48..cf12ea6 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -577,6 +577,8 @@ static int fill_inode(struct inode *inode,
>  	int issued = 0, implemented;
>  	struct timespec mtime, atime, ctime;
>  	u32 nsplits;
> +	struct ceph_inode_frag *frag;
> +	struct rb_node *rb_node;
>  	struct ceph_buffer *xattr_blob = NULL;
>  	int err = 0;
>  	int queue_trunc = 0;
> @@ -751,15 +753,37 @@ no_change:
>  	/* FIXME: move me up, if/when version reflects fragtree changes */
>  	nsplits = le32_to_cpu(info->fragtree.nsplits);
>  	mutex_lock(&ci->i_fragtree_mutex);
> +	rb_node = rb_first(&ci->i_fragtree);
>  	for (i = 0; i < nsplits; i++) {
>  		u32 id = le32_to_cpu(info->fragtree.splits[i].frag);
> -		struct ceph_inode_frag *frag = __get_or_create_frag(ci, id);
> -
> -		if (IS_ERR(frag))
> -			continue;
> +		frag = NULL;
> +		while (rb_node) {
> +			frag = rb_entry(rb_node, struct ceph_inode_frag, node);
> +			if (ceph_frag_compare(frag->frag, id) >= 0) {
> +				if (frag->frag != id)
> +					frag = NULL;
> +				else
> +					rb_node = rb_next(rb_node);
> +				break;
> +			}
> +			rb_node = rb_next(rb_node);
> +			rb_erase(&frag->node, &ci->i_fragtree);
> +			kfree(frag);
> +		}
> +		if (!frag) {
> +			frag = __get_or_create_frag(ci, id);
> +			if (IS_ERR(frag))
> +				continue;
> +		}
>  		frag->split_by = le32_to_cpu(info->fragtree.splits[i].by);
>  		dout(" frag %x split by %d\n", frag->frag, frag->split_by);
>  	}
> +	while (rb_node) {
> +		frag = rb_entry(rb_node, struct ceph_inode_frag, node);
> +		rb_node = rb_next(rb_node);
> +		rb_erase(&frag->node, &ci->i_fragtree);
> +		kfree(frag);
> +	}
>  	mutex_unlock(&ci->i_fragtree_mutex);
>  
>  	/* were we issued a capability? */
> -- 
> 1.8.1.4
> 
> 
