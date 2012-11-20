From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 3/3] ceph: fix dentry reference leak in ceph_encode_fh().
Date: Tue, 20 Nov 2012 10:21:46 -0600
Message-ID: <50ABAE1A.2020203@inktank.com>
References: <1352666971-13551-1-git-send-email-tipecaml@gmail.com> <1352666971-13551-4-git-send-email-tipecaml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352666971-13551-4-git-send-email-tipecaml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyril Roelandt <tipecaml@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, sage@inktank.com, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 11/11/2012 02:49 PM, Cyril Roelandt wrote:
> dput() was not called in the error path.
> 
> Signed-off-by: Cyril Roelandt <tipecaml@gmail.com>

This looks good, thanks a lot.  I'll apply it.

Reviewed-by: Alex Elder <elder@inktank.com>

> ---
>  fs/ceph/export.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> index 9349bb3..ca3ab3f 100644
> --- a/fs/ceph/export.c
> +++ b/fs/ceph/export.c
> @@ -56,13 +56,15 @@ static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
>  	struct ceph_nfs_confh *cfh = (void *)rawfh;
>  	int connected_handle_length = sizeof(*cfh)/4;
>  	int handle_length = sizeof(*fh)/4;
> -	struct dentry *dentry = d_find_alias(inode);
> +	struct dentry *dentry;
>  	struct dentry *parent;
>  
>  	/* don't re-export snaps */
>  	if (ceph_snap(inode) != CEPH_NOSNAP)
>  		return -EINVAL;
>  
> +	dentry = d_find_alias(inode);
> +
>  	/* if we found an alias, generate a connectable fh */
>  	if (*max_len >= connected_handle_length && dentry) {
>  		dout("encode_fh %p connectable\n", dentry);
> 
