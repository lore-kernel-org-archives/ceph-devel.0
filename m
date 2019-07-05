From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: use generic_delete_inode() for ->drop_inode
Date: Fri, 05 Jul 2019 12:33:10 -0400
Message-ID: <8d9232639f77b64aad91c8d7c4134a2f9c120ed6.camel@kernel.org>
References: <20190705161456.5138-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190705161456.5138-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Fri, 2019-07-05 at 17:14 +0100, Luis Henriques wrote:
> ceph_drop_inode() implementation is not any different from the generic
> function, thus there's no point in keeping it around.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/inode.c | 10 ----------
>  fs/ceph/super.c |  2 +-
>  fs/ceph/super.h |  1 -
>  3 files changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 761451f36e2d..211140e6ef9c 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -578,16 +578,6 @@ void ceph_destroy_inode(struct inode *inode)
>  	ceph_put_string(rcu_dereference_raw(ci->i_layout.pool_ns));
>  }
>  
> -int ceph_drop_inode(struct inode *inode)
> -{
> -	/*
> -	 * Positve dentry and corresponding inode are always accompanied
> -	 * in MDS reply. So no need to keep inode in the cache after
> -	 * dropping all its aliases.
> -	 */
> -	return 1;
> -}
> -
>  static inline blkcnt_t calc_inode_blocks(u64 size)
>  {
>  	return (size + (1<<9) - 1) >> 9;
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index d57fa60dcd43..b4a4772756cb 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -843,7 +843,7 @@ static const struct super_operations ceph_super_ops = {
>  	.destroy_inode	= ceph_destroy_inode,
>  	.free_inode	= ceph_free_inode,
>  	.write_inode    = ceph_write_inode,
> -	.drop_inode	= ceph_drop_inode,
> +	.drop_inode	= generic_delete_inode,
>  	.sync_fs        = ceph_sync_fs,
>  	.put_super	= ceph_put_super,
>  	.remount_fs	= ceph_remount,
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 5f27e1f7f2d6..622e6c96c960 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -878,7 +878,6 @@ extern const struct inode_operations ceph_file_iops;
>  extern struct inode *ceph_alloc_inode(struct super_block *sb);
>  extern void ceph_destroy_inode(struct inode *inode);
>  extern void ceph_free_inode(struct inode *inode);
> -extern int ceph_drop_inode(struct inode *inode);
>  
>  extern struct inode *ceph_get_inode(struct super_block *sb,
>  				    struct ceph_vino vino);

Merged into ceph-client/testing. We should be able to get this in for
5.3.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
