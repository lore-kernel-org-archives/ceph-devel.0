From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC PATCH] ceph: fix directories inode i_blkbits initialization
Date: Tue, 23 Jul 2019 13:18:31 -0400
Message-ID: <c657b0d65acd5e8bc9d5d726d68e2ad1fff38b51.camel@kernel.org>
References: <20190723155020.17338-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723155020.17338-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, 2019-07-23 at 16:50 +0100, Luis Henriques wrote:
> When filling an inode with info from the MDS, i_blkbits is being
> initialized using fl_stripe_unit, which contains the stripe unit in
> bytes.  Unfortunately, this doesn't make sense for directories as they
> have fl_stripe_unit set to '0'.  This means that i_blkbits will be set
> to 0xff, causing an UBSAN undefined behaviour in i_blocksize():
> 
>   UBSAN: Undefined behaviour in ./include/linux/fs.h:731:12
>   shift exponent 255 is too large for 32-bit type 'int'
> 
> Fix this by initializing i_blkbits to CEPH_BLOCK_SHIFT if fl_stripe_unit
> is zero.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/inode.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Hi Jeff,
> 
> To be honest, I'm not sure CEPH_BLOCK_SHIFT is the right value to use
> here, but for sure the one currently being used isn't correct if the
> inode is a directory.  Using stripe units seems to be a bug that has
> been there since the beginning, but it definitely became bigger problem
> after commit 69448867abcb ("fs: shave 8 bytes off of struct inode").
> 
> This fix could also be moved into the 'switch' statement later in that
> function, in the S_IFDIR case, similar to commit 5ba72e607cdb ("ceph:
> set special inode's blocksize to page size").  Let me know which version
> you would prefer.
> 

What happens with (e.g.) named pipes or symlinks? Do those inodes also
get this bogus value? Assuming that they do, I'd probably prefer this
patch since it'd fix things for all inode types, not just directories.

> Cheers,
> --
> Luis
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 791f84a13bb8..0e6d6db848b7 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -800,7 +800,12 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
>  
>  	/* update inode */
>  	inode->i_rdev = le32_to_cpu(info->rdev);
> -	inode->i_blkbits = fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
> +	/* directories have fl_stripe_unit set to zero */
> +	if (le32_to_cpu(info->layout.fl_stripe_unit))
> +		inode->i_blkbits =
> +			fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
> +	else
> +		inode->i_blkbits = CEPH_BLOCK_SHIFT;
>  
>  	__ceph_update_quota(ci, iinfo->max_bytes, iinfo->max_files);
>  


-- 
Jeff Layton <jlayton@kernel.org>
