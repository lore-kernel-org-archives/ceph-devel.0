From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [RFC PATCH 2/2] ceph: quota: fix quota subdir mounts
Date: Sat, 02 Mar 2019 19:34:36 -0500
Message-ID: <8f2993854b7c6c8b03571200f0c117ca5e0f5cb7.camel@redhat.com>
References: <20190301175752.17808-1-lhenriques@suse.com>
         <20190301175752.17808-3-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190301175752.17808-3-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Hendrik Peyerl <hpeyerl@plusline.net>
List-Id: ceph-devel.vger.kernel.org

On Fri, 2019-03-01 at 17:57 +0000, Luis Henriques wrote:
> The CephFS kernel client doesn't enforce quotas that are set in a
> directory that isn't visible in the mount point.  For example, given the
> path '/dir1/dir2', if quotas are set in 'dir1' and the mount is done in with
> 
>   mount -t ceph <server>:<port>:/dir1/ /mnt
> 
> then the client can't access the 'dir1' inode from the quota realm dir2
> belongs to.
> 
> This patch fixes this by simply doing an MDS LOOKUPINO Op and grabbing a
> reference to it (so that it doesn't disappear again).  This also requires an
> extra field in ceph_snap_realm so that we know we have to release that
> reference when destroying the realm.
> 
> Links: https://tracker.ceph.com/issues/3848

This bug looks unrelated to the patch description. Are you sure it's
correct?

> Reported-by: Hendrik Peyerl <hpeyerl@plusline.net>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/caps.c  |  2 +-
>  fs/ceph/quota.c | 30 +++++++++++++++++++++++++++---
>  fs/ceph/snap.c  |  3 +++
>  fs/ceph/super.h |  2 ++
>  4 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index bba28a5034ba..e79994ff53d6 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1035,7 +1035,7 @@ static void drop_inode_snap_realm(struct ceph_inode_info *ci)
>  	list_del_init(&ci->i_snap_realm_item);
>  	ci->i_snap_realm_counter++;
>  	ci->i_snap_realm = NULL;
> -	if (realm->ino == ci->i_vino.ino)
> +	if ((realm->ino == ci->i_vino.ino) && !realm->own_inode)
>  		realm->inode = NULL;
>  	spin_unlock(&realm->inodes_with_caps_lock);
>  	ceph_put_snap_realm(ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc,
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index 9455d3aef0c3..f6b972d222e4 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -22,7 +22,16 @@ void ceph_adjust_quota_realms_count(struct inode *inode, bool inc)
>  static inline bool ceph_has_realms_with_quotas(struct inode *inode)
>  {
>  	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
> -	return atomic64_read(&mdsc->quotarealms_count) > 0;
> +	struct super_block *sb = mdsc->fsc->sb;
> +
> +	if (atomic64_read(&mdsc->quotarealms_count) > 0)
> +		return true;
> +	/* if root is the real CephFS root, we don't have quota realms */
> +	if (sb->s_root->d_inode &&
> +	    (sb->s_root->d_inode->i_ino == CEPH_INO_ROOT))
> +		return false;
> +	/* otherwise, we can't know for sure */
> +	return true;
>  }
>  
>  void ceph_handle_quota(struct ceph_mds_client *mdsc,
> @@ -166,6 +175,7 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
>  		return false;
>  
>  	down_read(&mdsc->snap_rwsem);
> +restart:
>  	realm = ceph_inode(inode)->i_snap_realm;
>  	if (realm)
>  		ceph_get_snap_realm(mdsc, realm);
> @@ -176,8 +186,22 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
>  		spin_lock(&realm->inodes_with_caps_lock);
>  		in = realm->inode ? igrab(realm->inode) : NULL;
>  		spin_unlock(&realm->inodes_with_caps_lock);
> -		if (!in)
> -			break;
> +		if (!in) {
> +			up_read(&mdsc->snap_rwsem);
> +			in = ceph_lookup_inode(inode->i_sb, realm->ino);
> +			down_read(&mdsc->snap_rwsem);
> +			if (IS_ERR(in)) {
> +				pr_warn("Can't lookup inode %llx (err: %ld)\n",
> +					realm->ino, PTR_ERR(in));
> +				break;
> +			}
> +			spin_lock(&realm->inodes_with_caps_lock);
> +			realm->inode = in;
> +			realm->own_inode = true;
> +			spin_unlock(&realm->inodes_with_caps_lock);
> +			ceph_put_snap_realm(mdsc, realm);
> +			goto restart;
> +		}
>  
>  		ci = ceph_inode(in);
>  		spin_lock(&ci->i_ceph_lock);
> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> index f74193da0e09..c84ed8e8526a 100644
> --- a/fs/ceph/snap.c
> +++ b/fs/ceph/snap.c
> @@ -117,6 +117,7 @@ static struct ceph_snap_realm *ceph_create_snap_realm(
>  
>  	atomic_set(&realm->nref, 1);    /* for caller */
>  	realm->ino = ino;
> +	realm->own_inode = false;
>  	INIT_LIST_HEAD(&realm->children);
>  	INIT_LIST_HEAD(&realm->child_item);
>  	INIT_LIST_HEAD(&realm->empty_item);
> @@ -184,6 +185,8 @@ static void __destroy_snap_realm(struct ceph_mds_client *mdsc,
>  	kfree(realm->prior_parent_snaps);
>  	kfree(realm->snaps);
>  	ceph_put_snap_context(realm->cached_context);
> +	if (realm->own_inode && realm->inode)
> +		iput(realm->inode);
>  	kfree(realm);
>  }
>  
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index ce51e98b08ec..3f0d74d2150f 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -764,6 +764,8 @@ struct ceph_snap_realm {
>  	atomic_t nref;
>  	struct rb_node node;
>  
> +	bool own_inode;     /* true if we hold a ref to the inode */
> +
>  	u64 created, seq;
>  	u64 parent_ino;
>  	u64 parent_since;   /* snapid when our current parent became so */

-- 
Jeff Layton <jlayton@redhat.com>
