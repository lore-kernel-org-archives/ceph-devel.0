From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: don't return -ESTALE if there's still an open file
Date: Thu, 14 May 2020 08:10:09 -0400
Message-ID: <8497fe9a11ac1837813ee5f14b6ebae8fa6bf707.camel@kernel.org>
References: <20200514111453.GA99187@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200514111453.GA99187@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 2020-05-14 at 12:14 +0100, Luis Henriques wrote:
> Similarly to commit 03f219041fdb ("ceph: check i_nlink while converting
> a file handle to dentry"), this fixes another corner case with
> name_to_handle_at/open_by_handle_at.  The issue has been detected by
> xfstest generic/467, when doing:
> 
>  - name_to_handle_at("/cephfs/myfile")
>  - open("/cephfs/myfile")
>  - unlink("/cephfs/myfile")
>  - open_by_handle_at()
> 
> The call to open_by_handle_at should not fail because the file still
> exists and we do have a valid handle to it.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/export.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> index 79dc06881e78..8556df9d94d0 100644
> --- a/fs/ceph/export.c
> +++ b/fs/ceph/export.c
> @@ -171,12 +171,21 @@ struct inode *ceph_lookup_inode(struct super_block *sb, u64 ino)
>  
>  static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
>  {
> +	struct ceph_inode_info *ci;
>  	struct inode *inode = __lookup_inode(sb, ino);
> +
>  	if (IS_ERR(inode))
>  		return ERR_CAST(inode);
>  	if (inode->i_nlink == 0) {
> -		iput(inode);
> -		return ERR_PTR(-ESTALE);
> +		bool is_open;
> +		ci = ceph_inode(inode);
> +		spin_lock(&ci->i_ceph_lock);
> +		is_open = __ceph_is_file_opened(ci);
> +		spin_unlock(&ci->i_ceph_lock);
> +		if (!is_open) {
> +			iput(inode);
> +			return ERR_PTR(-ESTALE);
> +		}
>  	}
>  	return d_obtain_alias(inode);
>  }

Thanks Luis. Out of curiousity, is there any reason we shouldn't ignore
the i_nlink value here? Does anything obviously break if we do?

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
