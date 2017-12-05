From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 1/2] ceph: use atomic64_t for
 ceph_inode_info::i_shared_gen
Date: Tue, 05 Dec 2017 06:11:58 -0500
Message-ID: <1512472318.4125.4.camel@redhat.com>
References: <20171205015135.12944-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36561 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753125AbdLELMB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Dec 2017 06:12:01 -0500
Received: by mail-qt0-f193.google.com with SMTP id a16so28216012qtj.3
        for <ceph-devel@vger.kernel.org>; Tue, 05 Dec 2017 03:12:01 -0800 (PST)
In-Reply-To: <20171205015135.12944-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org

On Tue, 2017-12-05 at 09:51 +0800, Yan, Zheng wrote:
> Avoid i_shared_gen overflow and allow accessing i_shared_gen without
> holding i_ceph_lock (prepare for later patch)
> 
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/caps.c  |  2 +-
>  fs/ceph/dir.c   | 16 ++++++++--------
>  fs/ceph/inode.c |  4 ++--
>  fs/ceph/super.h |  5 +++--
>  4 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 029cab713731..2b3c8b1c774c 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -498,7 +498,7 @@ static void __check_cap_issue(struct ceph_inode_info *ci, struct ceph_cap *cap,
>  	 */
>  	if ((issued & CEPH_CAP_FILE_SHARED) != (had & CEPH_CAP_FILE_SHARED)) {
>  		if (issued & CEPH_CAP_FILE_SHARED)
> -			ci->i_shared_gen++;
> +			atomic64_inc(&ci->i_shared_gen);
>  		if (S_ISDIR(ci->vfs_inode.i_mode)) {
>  			dout(" marking %p NOT complete\n", &ci->vfs_inode);
>  			__ceph_dir_clear_complete(ci);
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 64afa46b211f..0a23a4d9fde8 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -173,7 +173,7 @@ __dcache_find_get_entry(struct dentry *parent, u64 idx,
>   * the MDS if/when the directory is modified).
>   */
>  static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
> -			    u32 shared_gen)
> +			    long long shared_gen)
>  {
>  	struct ceph_file_info *fi = file->private_data;
>  	struct dentry *parent = file->f_path.dentry;
> @@ -184,7 +184,7 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
>  	u64 idx = 0;
>  	int err = 0;
>  
> -	dout("__dcache_readdir %p v%u at %llx\n", dir, shared_gen, ctx->pos);
> +	dout("__dcache_readdir %p v%llu at %llx\n", dir, (u64)shared_gen, ctx->pos);
>  
>  	/* search start position */
>  	if (ctx->pos > 2) {
> @@ -333,7 +333,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>  	    ceph_snap(inode) != CEPH_SNAPDIR &&
>  	    __ceph_dir_is_complete_ordered(ci) &&
>  	    __ceph_caps_issued_mask(ci, CEPH_CAP_FILE_SHARED, 1)) {
> -		u32 shared_gen = ci->i_shared_gen;
> +		long long shared_gen = atomic64_read(&ci->i_shared_gen);
>  		spin_unlock(&ci->i_ceph_lock);
>  		err = __dcache_readdir(file, ctx, shared_gen);
>  		if (err != -EAGAIN)
> @@ -751,7 +751,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
>  			spin_unlock(&ci->i_ceph_lock);
>  			dout(" dir %p complete, -ENOENT\n", dir);
>  			d_add(dentry, NULL);
> -			di->lease_shared_gen = ci->i_shared_gen;
> +			di->lease_shared_gen = atomic64_read(&ci->i_shared_gen);
>  			return NULL;
>  		}
>  		spin_unlock(&ci->i_ceph_lock);
> @@ -1191,12 +1191,12 @@ static int dir_lease_is_valid(struct inode *dir, struct dentry *dentry)
>  	int valid = 0;
>  
>  	spin_lock(&ci->i_ceph_lock);
> -	if (ci->i_shared_gen == di->lease_shared_gen)
> +	if (atomic64_read(&ci->i_shared_gen) == di->lease_shared_gen)
>  		valid = __ceph_caps_issued_mask(ci, CEPH_CAP_FILE_SHARED, 1);
>  	spin_unlock(&ci->i_ceph_lock);
> -	dout("dir_lease_is_valid dir %p v%u dentry %p v%u = %d\n",
> -	     dir, (unsigned)ci->i_shared_gen, dentry,
> -	     (unsigned)di->lease_shared_gen, valid);
> +	dout("dir_lease_is_valid dir %p v%llu dentry %p v%llu = %d\n",
> +	     dir, (u64)atomic64_read(&ci->i_shared_gen),
> +	     dentry, (u64)di->lease_shared_gen, valid);
>  	return valid;
>  }
>  
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 666ad10e2b85..a9de83f012bf 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -494,7 +494,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
>  	ci->i_wrbuffer_ref = 0;
>  	ci->i_wrbuffer_ref_head = 0;
>  	atomic_set(&ci->i_filelock_ref, 0);
> -	ci->i_shared_gen = 0;
> +	atomic64_set(&ci->i_shared_gen, 0);
>  	ci->i_rdcache_gen = 0;
>  	ci->i_rdcache_revoking = 0;
>  
> @@ -1041,7 +1041,7 @@ static void update_dentry_lease(struct dentry *dentry,
>  	if (ceph_snap(dir) != CEPH_NOSNAP)
>  		goto out_unlock;
>  
> -	di->lease_shared_gen = ceph_inode(dir)->i_shared_gen;
> +	di->lease_shared_gen = atomic64_read(&ceph_inode(dir)->i_shared_gen);
>  
>  	if (duration == 0)
>  		goto out_unlock;
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 2beeec07fa76..ec301fce2556 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -256,7 +256,8 @@ struct ceph_inode_xattr {
>   */
>  struct ceph_dentry_info {
>  	struct ceph_mds_session *lease_session;
> -	u32 lease_gen, lease_shared_gen;
> +	long long lease_shared_gen;
> +	u32 lease_gen;
>  	u32 lease_seq;
>  	unsigned long lease_renew_after, lease_renew_from;
>  	struct list_head lru;
> @@ -353,7 +354,7 @@ struct ceph_inode_info {
>  	int i_rd_ref, i_rdcache_ref, i_wr_ref, i_wb_ref;
>  	int i_wrbuffer_ref, i_wrbuffer_ref_head;
>  	atomic_t i_filelock_ref;
> -	u32 i_shared_gen;       /* increment each time we get FILE_SHARED */
> +	atomic64_t i_shared_gen;       /* increment each time we get FILE_SHARED */
>  	u32 i_rdcache_gen;      /* incremented each time we get FILE_CACHE. */
>  	u32 i_rdcache_revoking; /* RDCACHE gen to async invalidate, if any */
>  

Looks sane enough. Do we really think that i_shared_gen overflow is a
problem? Will we have the same problem with i_rdcache_gen?

Acked-by: Jeff Layton <jlayton@redhat.com>
