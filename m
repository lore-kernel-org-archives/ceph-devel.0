From: Sage Weil <sweil@redhat.com>
Subject: Re: [PATCH] ceph: move ceph_find_inode() outside the s_mutex
Date: Thu, 18 Sep 2014 22:21:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409182221000.18018@cobra.newdream.net>
References: <1410919069-12326-1-git-send-email-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40565 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756520AbaISFVQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Sep 2014 01:21:16 -0400
In-Reply-To: <1410919069-12326-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 17 Sep 2014, Yan, Zheng wrote:
> ceph_find_inode() may wait on freeing inode, using it inside the s_mutex
> may cause deadlock. (the freeing inode is waiting for OSD read reply, but
> dispatch thread is blocked by the s_mutex)
> 
> Signed-off-by: Yan, Zheng <zyan@redhat.com>

Reviewed-by: Sage Weil <sage@redhat.com>

> ---
>  fs/ceph/caps.c       | 11 ++++++-----
>  fs/ceph/mds_client.c |  7 ++++---
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 6d1cd45..b3b0a91 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -3045,6 +3045,12 @@ void ceph_handle_caps(struct ceph_mds_session *session,
>  		}
>  	}
>  
> +	/* lookup ino */
> +	inode = ceph_find_inode(sb, vino);
> +	ci = ceph_inode(inode);
> +	dout(" op %s ino %llx.%llx inode %p\n", ceph_cap_op_name(op), vino.ino,
> +	     vino.snap, inode);
> +
>  	mutex_lock(&session->s_mutex);
>  	session->s_seq++;
>  	dout(" mds%d seq %lld cap seq %u\n", session->s_mds, session->s_seq,
> @@ -3053,11 +3059,6 @@ void ceph_handle_caps(struct ceph_mds_session *session,
>  	if (op == CEPH_CAP_OP_IMPORT)
>  		ceph_add_cap_releases(mdsc, session);
>  
> -	/* lookup ino */
> -	inode = ceph_find_inode(sb, vino);
> -	ci = ceph_inode(inode);
> -	dout(" op %s ino %llx.%llx inode %p\n", ceph_cap_op_name(op), vino.ino,
> -	     vino.snap, inode);
>  	if (!inode) {
>  		dout(" i don't have ino %llx\n", vino.ino);
>  
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 80d9f07..c27e204 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2947,14 +2947,15 @@ static void handle_lease(struct ceph_mds_client *mdsc,
>  	if (dname.len != get_unaligned_le32(h+1))
>  		goto bad;
>  
> -	mutex_lock(&session->s_mutex);
> -	session->s_seq++;
> -
>  	/* lookup inode */
>  	inode = ceph_find_inode(sb, vino);
>  	dout("handle_lease %s, ino %llx %p %.*s\n",
>  	     ceph_lease_op_name(h->action), vino.ino, inode,
>  	     dname.len, dname.name);
> +
> +	mutex_lock(&session->s_mutex);
> +	session->s_seq++;
> +
>  	if (inode == NULL) {
>  		dout("handle_lease no inode %llx\n", vino.ino);
>  		goto release;
> -- 
> 1.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
