From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v3 4/8] ceph: add a new flag to indicate whether parent is
 locked
Date: Sat, 4 Feb 2017 11:16:10 +0800
Message-ID: <AA245BF2-C788-4AF1-B2B2-10A76FEE30B5@redhat.com>
References: <20170201114914.20808-1-jlayton@redhat.com>
 <20170203180404.31930-1-jlayton@redhat.com>
 <20170203180404.31930-5-jlayton@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753393AbdBDDQQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 3 Feb 2017 22:16:16 -0500
In-Reply-To: <20170203180404.31930-5-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, idryomov@gmail.com


> On 4 Feb 2017, at 02:04, Jeff Layton <jlayton@redhat.com> wrote:
> 
> struct ceph_mds_request has an r_locked_dir pointer, which is set to
> indicate the parent inode and that its i_rwsem is locked.  In some
> critical places, we need to be able to indicate the parent inode to the
> request handling code, even when its i_rwsem may not be locked.
> 
> Most of the code that operates on r_locked_dir doesn't require that the
> i_rwsem be locked. We only really need it to handle manipulation of the
> dcache. The rest (filling of the inode, updating dentry leases, etc.)
> already has its own locking.
> 
> Add a new r_req_flags bit that indicates whether the parent is locked
> when doing the request, and rename the pointer to "r_parent". For now,
> all the places that set r_parent also set this flag, but that will
> change in a later patch.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
> fs/ceph/dir.c        | 21 ++++++++++++++-------
> fs/ceph/export.c     |  3 ++-
> fs/ceph/file.c       |  3 ++-
> fs/ceph/inode.c      | 17 ++++++++++-------
> fs/ceph/mds_client.c | 24 ++++++++++++------------
> fs/ceph/mds_client.h |  3 ++-
> 6 files changed, 42 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 5fb86d71220e..c8562b8a8c7e 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -752,7 +752,8 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
> 		mask |= CEPH_CAP_XATTR_SHARED;
> 	req->r_args.getattr.mask = cpu_to_le32(mask);
> 
> -	req->r_locked_dir = dir;
> +	req->r_parent = dir;
> +	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
> 	err = ceph_mdsc_do_request(mdsc, NULL, req);
> 	err = ceph_handle_snapdir(req, dentry, err);
> 	dentry = ceph_finish_lookup(req, dentry, err);
> @@ -813,7 +814,8 @@ static int ceph_mknod(struct inode *dir, struct dentry *dentry,
> 	}
> 	req->r_dentry = dget(dentry);
> 	req->r_num_caps = 2;
> -	req->r_locked_dir = dir;
> +	req->r_parent = dir;
> +	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
> 	req->r_args.mknod.mode = cpu_to_le32(mode);
> 	req->r_args.mknod.rdev = cpu_to_le32(rdev);
> 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED;
> @@ -864,7 +866,8 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
> 		ceph_mdsc_put_request(req);
> 		goto out;
> 	}
> -	req->r_locked_dir = dir;
> +	req->r_parent = dir;
> +	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
> 	req->r_dentry = dget(dentry);
> 	req->r_num_caps = 2;
> 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED;
> @@ -913,7 +916,8 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
> 
> 	req->r_dentry = dget(dentry);
> 	req->r_num_caps = 2;
> -	req->r_locked_dir = dir;
> +	req->r_parent = dir;
> +	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
> 	req->r_args.mkdir.mode = cpu_to_le32(mode);
> 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED;
> 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
> @@ -957,7 +961,8 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
> 	req->r_dentry = dget(dentry);
> 	req->r_num_caps = 2;
> 	req->r_old_dentry = dget(old_dentry);
> -	req->r_locked_dir = dir;
> +	req->r_parent = dir;
> +	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
> 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED;
> 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
> 	/* release LINK_SHARED on source inode (mds will lock it) */
> @@ -1023,7 +1028,8 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
> 	}
> 	req->r_dentry = dget(dentry);
> 	req->r_num_caps = 2;
> -	req->r_locked_dir = dir;
> +	req->r_parent = dir;
> +	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
> 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED;
> 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
> 	req->r_inode_drop = drop_caps_for_unlink(inode);
> @@ -1066,7 +1072,8 @@ static int ceph_rename(struct inode *old_dir, struct dentry *old_dentry,
> 	req->r_num_caps = 2;
> 	req->r_old_dentry = dget(old_dentry);
> 	req->r_old_dentry_dir = old_dir;
> -	req->r_locked_dir = new_dir;
> +	req->r_parent = new_dir;
> +	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
> 	req->r_old_dentry_drop = CEPH_CAP_FILE_SHARED;
> 	req->r_old_dentry_unless = CEPH_CAP_FILE_EXCL;
> 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED;
> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> index 180bbef760f2..e8f11fa565c5 100644
> --- a/fs/ceph/export.c
> +++ b/fs/ceph/export.c
> @@ -207,7 +207,8 @@ static int ceph_get_name(struct dentry *parent, char *name,
> 	req->r_inode = d_inode(child);
> 	ihold(d_inode(child));
> 	req->r_ino2 = ceph_vino(d_inode(parent));
> -	req->r_locked_dir = d_inode(parent);
> +	req->r_parent = d_inode(parent);
> +	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
> 	req->r_num_caps = 2;
> 	err = ceph_mdsc_do_request(mdsc, NULL, req);
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 19419eb87f38..a91239c4b31c 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -310,7 +310,8 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
>                mask |= CEPH_CAP_XATTR_SHARED;
>        req->r_args.open.mask = cpu_to_le32(mask);
> 
> -	req->r_locked_dir = dir;           /* caller holds dir->i_mutex */
> +	req->r_parent = dir;
> +	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
> 	err = ceph_mdsc_do_request(mdsc,
> 				   (flags & (O_CREAT|O_TRUNC)) ? dir : NULL,
> 				   req);
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index e54ba03d3df7..b4b61da03dbf 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1122,13 +1122,13 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
> 
> 	if (!rinfo->head->is_target && !rinfo->head->is_dentry) {
> 		dout("fill_trace reply is empty!\n");
> -		if (rinfo->head->result == 0 && req->r_locked_dir)
> +		if (rinfo->head->result == 0 && req->r_parent)
> 			ceph_invalidate_dir_request(req);
> 		return 0;
> 	}
> 
> 	if (rinfo->head->is_dentry) {
> -		struct inode *dir = req->r_locked_dir;
> +		struct inode *dir = req->r_parent;
> 
> 		if (dir) {
> 			err = fill_inode(dir, NULL,
> @@ -1216,7 +1216,9 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
> 	 * ignore null lease/binding on snapdir ENOENT, or else we
> 	 * will have trouble splicing in the virtual snapdir later
> 	 */
> -	if (rinfo->head->is_dentry && req->r_locked_dir &&
> +	if (rinfo->head->is_dentry &&
> +            !test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&

why adding the !ABORTED check back. I think previous patch add:

if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
  goto done;

> +	    test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
> 	    (rinfo->head->is_target || strncmp(req->r_dentry->d_name.name,
> 					       fsc->mount_options->snapdir_name,
> 					       req->r_dentry->d_name.len))) {
> @@ -1225,7 +1227,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
> 		 * mknod symlink mkdir  : null -> new inode
> 		 * unlink               : linked -> null
> 		 */
> -		struct inode *dir = req->r_locked_dir;
> +		struct inode *dir = req->r_parent;
> 		struct dentry *dn = req->r_dentry;
> 		bool have_dir_cap, have_lease;
> 
> @@ -1319,10 +1321,11 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
> 			update_dentry_lease(dn, rinfo->dlease, session,
> 					    req->r_request_started);
> 		dout(" final dn %p\n", dn);
> -	} else if (req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
> -		   req->r_op == CEPH_MDS_OP_MKSNAP) {
> +	} else if ((req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
> +		    req->r_op == CEPH_MDS_OP_MKSNAP) &&
> +		   !test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {

same here

> 		struct dentry *dn = req->r_dentry;
> -		struct inode *dir = req->r_locked_dir;
> +		struct inode *dir = req->r_parent;
> 
> 		/* fill out a snapdir LOOKUPSNAP dentry */
> 		BUG_ON(!dn);
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index ccf75a3260e8..52521f339745 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -547,8 +547,8 @@ void ceph_mdsc_release_request(struct kref *kref)
> 		ceph_put_cap_refs(ceph_inode(req->r_inode), CEPH_CAP_PIN);
> 		iput(req->r_inode);
> 	}
> -	if (req->r_locked_dir)
> -		ceph_put_cap_refs(ceph_inode(req->r_locked_dir), CEPH_CAP_PIN);
> +	if (req->r_parent)
> +		ceph_put_cap_refs(ceph_inode(req->r_parent), CEPH_CAP_PIN);
> 	iput(req->r_target_inode);
> 	if (req->r_dentry)
> 		dput(req->r_dentry);
> @@ -735,7 +735,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
> 
> 		rcu_read_lock();
> 		parent = req->r_dentry->d_parent;
> -		dir = req->r_locked_dir ? : d_inode_rcu(parent);
> +		dir = req->r_parent ? : d_inode_rcu(parent);
> 
> 		if (!dir || dir->i_sb != mdsc->fsc->sb) {
> 			/*  not this fs or parent went negative */
> @@ -1894,7 +1894,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_client *mdsc,
> 	int ret;
> 
> 	ret = set_request_path_attr(req->r_inode, req->r_dentry,
> -			      req->r_locked_dir, req->r_path1, req->r_ino1.ino,
> +			      req->r_parent, req->r_path1, req->r_ino1.ino,
> 			      &path1, &pathlen1, &ino1, &freepath1);
> 	if (ret < 0) {
> 		msg = ERR_PTR(ret);
> @@ -1956,7 +1956,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_client *mdsc,
> 		      mds, req->r_inode_drop, req->r_inode_unless, 0);
> 	if (req->r_dentry_drop)
> 		releases += ceph_encode_dentry_release(&p, req->r_dentry,
> -				req->r_locked_dir, mds, req->r_dentry_drop,
> +				req->r_parent, mds, req->r_dentry_drop,
> 				req->r_dentry_unless);
> 	if (req->r_old_dentry_drop)
> 		releases += ceph_encode_dentry_release(&p, req->r_old_dentry,
> @@ -2095,14 +2095,14 @@ static int __prepare_send_request(struct ceph_mds_client *mdsc,
> 	rhead->oldest_client_tid = cpu_to_le64(__get_oldest_tid(mdsc));
> 	if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags))
> 		flags |= CEPH_MDS_FLAG_REPLAY;
> -	if (req->r_locked_dir)
> +	if (req->r_parent)
> 		flags |= CEPH_MDS_FLAG_WANT_DENTRY;
> 	rhead->flags = cpu_to_le32(flags);
> 	rhead->num_fwd = req->r_num_fwd;
> 	rhead->num_retry = req->r_attempts - 1;
> 	rhead->ino = 0;
> 
> -	dout(" r_locked_dir = %p\n", req->r_locked_dir);
> +	dout(" r_parent = %p\n", req->r_parent);
> 	return 0;
> }
> 
> @@ -2282,11 +2282,11 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
> 
> 	dout("do_request on %p\n", req);
> 
> -	/* take CAP_PIN refs for r_inode, r_locked_dir, r_old_dentry */
> +	/* take CAP_PIN refs for r_inode, r_parent, r_old_dentry */
> 	if (req->r_inode)
> 		ceph_get_cap_refs(ceph_inode(req->r_inode), CEPH_CAP_PIN);
> -	if (req->r_locked_dir)
> -		ceph_get_cap_refs(ceph_inode(req->r_locked_dir), CEPH_CAP_PIN);
> +	if (req->r_parent)
> +		ceph_get_cap_refs(ceph_inode(req->r_parent), CEPH_CAP_PIN);
> 	if (req->r_old_dentry_dir)
> 		ceph_get_cap_refs(ceph_inode(req->r_old_dentry_dir),
> 				  CEPH_CAP_PIN);
> @@ -2336,7 +2336,7 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
> 		set_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags);
> 		mutex_unlock(&req->r_fill_mutex);
> 
> -		if (req->r_locked_dir &&
> +		if (req->r_parent &&
> 		    (req->r_op & CEPH_MDS_OP_WRITE))
> 			ceph_invalidate_dir_request(req);
> 	} else {
> @@ -2355,7 +2355,7 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
>  */
> void ceph_invalidate_dir_request(struct ceph_mds_request *req)
> {
> -	struct inode *inode = req->r_locked_dir;
> +	struct inode *inode = req->r_parent;
> 
> 	dout("invalidate_dir_request %p (complete, lease(s))\n", inode);
> 
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 409b0e3c3b7a..ac0475a2daa7 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -202,7 +202,7 @@ struct ceph_mds_request {
> 	char *r_path1, *r_path2;
> 	struct ceph_vino r_ino1, r_ino2;
> 
> -	struct inode *r_locked_dir; /* dir (if any) i_mutex locked by vfs */
> +	struct inode *r_parent;		    /* parent dir inode */
> 	struct inode *r_target_inode;       /* resulting inode */
> 
> #define CEPH_MDS_R_DIRECT_IS_HASH	(1) /* r_direct_hash is valid */
> @@ -211,6 +211,7 @@ struct ceph_mds_request {
> #define CEPH_MDS_R_GOT_SAFE		(4) /* got a safe reply */
> #define CEPH_MDS_R_GOT_RESULT		(5) /* got a result */
> #define CEPH_MDS_R_DID_PREPOPULATE	(6) /* prepopulated readdir */
> +#define CEPH_MDS_R_PARENT_LOCKED	(7) /* is r_parent->i_rwsem wlocked? */
> 	unsigned long	r_req_flags;
> 
> 	struct mutex r_fill_mutex;
> -- 
> 2.9.3
> 

