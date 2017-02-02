From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v2 02/13] ceph: move r_aborted flag into r_req_flags
Date: Thu, 2 Feb 2017 16:06:47 +0800
Message-ID: <D89A9727-739A-418D-83D2-B54462AE4692@redhat.com>
References: <20170130161942.16537-1-jlayton@redhat.com>
 <20170201114914.20808-1-jlayton@redhat.com>
 <20170201114914.20808-3-jlayton@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbdBBIGx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 2 Feb 2017 03:06:53 -0500
In-Reply-To: <20170201114914.20808-3-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, idryomov@gmail.com


> On 1 Feb 2017, at 19:49, Jeff Layton <jlayton@redhat.com> wrote:
> 
> ...and simplify the handling of it in ceph_fill_trace.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
> fs/ceph/inode.c      | 17 +++++++++--------
> fs/ceph/mds_client.c |  8 ++++----
> fs/ceph/mds_client.h |  2 +-
> 3 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 4926265f4223..bd2e94a78057 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1233,8 +1233,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
> 
> 		err = fill_inode(in, req->r_locked_page, &rinfo->targeti, NULL,
> 				session, req->r_request_started,
> -				(!req->r_aborted && rinfo->head->result == 0) ?
> -				req->r_fmode : -1,
> +				(!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&
> +				rinfo->head->result == 0) ?  req->r_fmode : -1,
> 				&req->r_caps_reservation);
> 		if (err < 0) {
> 			pr_err("fill_inode badness %p %llx.%llx\n",
> @@ -1243,12 +1243,14 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
> 		}
> 	}
> 
> +	if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
> +		goto done;
> +

This seems wrong. If we got the reply, we should update inode’s caps even request is aborted.
Otherwise, MDS can hang at revoking the dropped caps.

> 	/*
> 	 * ignore null lease/binding on snapdir ENOENT, or else we
> 	 * will have trouble splicing in the virtual snapdir later
> 	 */
> -	if (rinfo->head->is_dentry && !req->r_aborted &&
> -	    req->r_locked_dir &&
> +	if (rinfo->head->is_dentry && req->r_locked_dir &&
> 	    (rinfo->head->is_target || strncmp(req->r_dentry->d_name.name,
> 					       fsc->mount_options->snapdir_name,
> 					       req->r_dentry->d_name.len))) {
> @@ -1351,9 +1353,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
> 			update_dentry_lease(dn, rinfo->dlease, session,
> 					    req->r_request_started);
> 		dout(" final dn %p\n", dn);
> -	} else if (!req->r_aborted &&
> -		   (req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
> -		    req->r_op == CEPH_MDS_OP_MKSNAP)) {
> +	} else if (req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
> +		   req->r_op == CEPH_MDS_OP_MKSNAP) {
> 		struct dentry *dn = req->r_dentry;
> 		struct inode *dir = req->r_locked_dir;
> 
> @@ -1478,7 +1479,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
> 	u32 fpos_offset;
> 	struct ceph_readdir_cache_control cache_ctl = {};
> 
> -	if (req->r_aborted)
> +	if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
> 		return readdir_prepopulate_inodes_only(req, session);
> 
> 	if (rinfo->hash_order && req->r_path2) {
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 1f2ef02832d9..a5156b6a0aed 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2115,7 +2115,7 @@ static int __do_request(struct ceph_mds_client *mdsc,
> 	int err = 0;
> 
> 	if (req->r_err || req->r_got_result) {
> -		if (req->r_aborted)
> +		if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
> 			__unregister_request(mdsc, req);
> 		goto out;
> 	}
> @@ -2331,7 +2331,7 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
> 		 */
> 		mutex_lock(&req->r_fill_mutex);
> 		req->r_err = err;
> -		req->r_aborted = true;
> +		set_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags);
> 		mutex_unlock(&req->r_fill_mutex);
> 
> 		if (req->r_locked_dir &&
> @@ -2538,7 +2538,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
> 	}
> out_err:
> 	mutex_lock(&mdsc->mutex);
> -	if (!req->r_aborted) {
> +	if (!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
> 		if (err) {
> 			req->r_err = err;
> 		} else {
> @@ -2587,7 +2587,7 @@ static void handle_forward(struct ceph_mds_client *mdsc,
> 		goto out;  /* dup reply? */
> 	}
> 
> -	if (req->r_aborted) {
> +	if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
> 		dout("forward tid %llu aborted, unregistering\n", tid);
> 		__unregister_request(mdsc, req);
> 	} else if (fwd_seq <= req->r_num_fwd) {
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index a58cacccc986..3da20955d5e6 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -206,6 +206,7 @@ struct ceph_mds_request {
> 	struct inode *r_target_inode;       /* resulting inode */
> 
> #define CEPH_MDS_R_DIRECT_IS_HASH	(1) /* r_direct_hash is valid */
> +#define CEPH_MDS_R_ABORTED		(2) /* call was aborted */
> 	unsigned long	r_req_flags;
> 
> 	struct mutex r_fill_mutex;
> @@ -236,7 +237,6 @@ struct ceph_mds_request {
> 	struct ceph_mds_reply_info_parsed r_reply_info;
> 	struct page *r_locked_page;
> 	int r_err;
> -	bool r_aborted;
> 
> 	unsigned long r_timeout;  /* optional.  jiffies, 0 is "wait forever" */
> 	unsigned long r_started;  /* start time to measure timeout against */
> -- 
> 2.9.3
> 

