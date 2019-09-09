From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v3] ceph: allow object copies across different
 filesystems in the same cluster
Date: Mon, 09 Sep 2019 11:57:23 -0400
Message-ID: <58db3e32a1406b5758b1fa43e5e845cd050cf499.camel@kernel.org>
References: <20190909154854.23839-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190909154854.23839-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Mon, 2019-09-09 at 16:48 +0100, Luis Henriques wrote:
> OSDs are able to perform object copies across different pools.  Thus,
> there's no need to prevent copy_file_range from doing remote copies if the
> source and destination superblocks are different.  Only return -EXDEV if
> they have different fsid (the cluster ID).
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/file.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> Hi,
> 
> Here's the changelog:
> 
> * since v2
> 
> - single dout() in error path
> 
> * since v1:
> 
> - Dropped have_fsid checks on client structs
> - Use %pU to print the fsid instead of raw hex strings (%*ph)
> - Fixed 'To:' field in email so that this time the patch hits vger
> 
> Cheers,
> --
> Luis
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 685a03cc4b77..846cf5aea85e 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1904,6 +1904,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>  	struct ceph_inode_info *src_ci = ceph_inode(src_inode);
>  	struct ceph_inode_info *dst_ci = ceph_inode(dst_inode);
>  	struct ceph_cap_flush *prealloc_cf;
> +	struct ceph_fs_client *src_fsc = ceph_inode_to_client(src_inode);
>  	struct ceph_object_locator src_oloc, dst_oloc;
>  	struct ceph_object_id src_oid, dst_oid;
>  	loff_t endoff = 0, size;
> @@ -1915,8 +1916,16 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>  
>  	if (src_inode == dst_inode)
>  		return -EINVAL;
> -	if (src_inode->i_sb != dst_inode->i_sb)
> -		return -EXDEV;
> +	if (src_inode->i_sb != dst_inode->i_sb) {
> +		struct ceph_fs_client *dst_fsc = ceph_inode_to_client(dst_inode);
> +
> +		if (ceph_fsid_compare(&src_fsc->client->fsid,
> +				      &dst_fsc->client->fsid)) {
> +			dout("Copying files across clusters: src: %pU dst: %pU\n",
> +			     &src_fsc->client->fsid, &dst_fsc->client->fsid);
> +			return -EXDEV;
> +		}
> +	}
>  	if (ceph_snap(dst_inode) != CEPH_NOSNAP)
>  		return -EROFS;
>  
> @@ -1928,7 +1937,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>  	 * efficient).
>  	 */
>  
> -	if (ceph_test_mount_opt(ceph_inode_to_client(src_inode), NOCOPYFROM))
> +	if (ceph_test_mount_opt(src_fsc, NOCOPYFROM))
>  		return -EOPNOTSUPP;
>  
>  	if ((src_ci->i_layout.stripe_unit != dst_ci->i_layout.stripe_unit) ||
> @@ -2044,7 +2053,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>  				dst_ci->i_vino.ino, dst_objnum);
>  		/* Do an object remote copy */
>  		err = ceph_osdc_copy_from(
> -			&ceph_inode_to_client(src_inode)->client->osdc,
> +			&src_fsc->client->osdc,
>  			src_ci->i_vino.snap, 0,
>  			&src_oid, &src_oloc,
>  			CEPH_OSD_OP_FLAG_FADVISE_SEQUENTIAL |

Thanks Luis. Merged into testing branch.
-- 
Jeff Layton <jlayton@kernel.org>
