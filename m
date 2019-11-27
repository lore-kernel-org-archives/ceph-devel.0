From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] fs: Fix page_mkwrite off-by-one errors
Date: Wed, 27 Nov 2019 07:49:54 -0800
Message-ID: <20191127154954.GT6219@magnolia>
References: <20191127151811.9229-1-agruenba@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191127151811.9229-1-agruenba@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Theodore Ts'o <tytso@mit.edu>, Sage Weil <sage@redhat.com>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod.at>, Chao Yu <chao@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Christoph Hellwig <hch@infradead.org>, Andreas Dilger <adilger.kernel@dilger.ca>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Wed, Nov 27, 2019 at 04:18:11PM +0100, Andreas Gruenbacher wrote:
> Fix a check in block_page_mkwrite meant to determine whether an offset
> is within the inode size.  This error has spread to several filesystems
> and to iomap_page_mkwrite, so fix those instances as well.

Seeing how this has gotten screwed up at least six times in the kernel,
maybe we need a static inline helper to do this for us?

> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

The iomap part looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

(I might just extract the iomap part and put it in the iomap tree if
someone doesn't merge this one before I get to it...)

--D

> 
> ---
> 
> This patch has a trivial conflict with commit "iomap: Fix overflow in
> iomap_page_mkwrite" in Darrick's iomap pull request for 5.5:
> 
>   https://lore.kernel.org/lkml/20191125190907.GN6219@magnolia/
> ---
>  fs/buffer.c            | 2 +-
>  fs/ceph/addr.c         | 2 +-
>  fs/ext4/inode.c        | 2 +-
>  fs/f2fs/file.c         | 2 +-
>  fs/iomap/buffered-io.c | 2 +-
>  fs/ubifs/file.c        | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 86a38b979323..152d391858d4 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2465,7 +2465,7 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
>  	lock_page(page);
>  	size = i_size_read(inode);
>  	if ((page->mapping != inode->i_mapping) ||
> -	    (page_offset(page) > size)) {
> +	    (page_offset(page) >= size)) {
>  		/* We overload EFAULT to mean page got truncated */
>  		ret = -EFAULT;
>  		goto out_unlock;
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 7ab616601141..9fa0729ece41 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1575,7 +1575,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
>  	do {
>  		lock_page(page);
>  
> -		if ((off > size) || (page->mapping != inode->i_mapping)) {
> +		if ((off >= size) || (page->mapping != inode->i_mapping)) {
>  			unlock_page(page);
>  			ret = VM_FAULT_NOPAGE;
>  			break;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 516faa280ced..6dd4efe2fb63 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -6224,7 +6224,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>  	lock_page(page);
>  	size = i_size_read(inode);
>  	/* Page got truncated from under us? */
> -	if (page->mapping != mapping || page_offset(page) > size) {
> +	if (page->mapping != mapping || page_offset(page) >= size) {
>  		unlock_page(page);
>  		ret = VM_FAULT_NOPAGE;
>  		goto out;
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 29bc0a542759..3436be01af45 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -71,7 +71,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  	down_read(&F2FS_I(inode)->i_mmap_sem);
>  	lock_page(page);
>  	if (unlikely(page->mapping != inode->i_mapping ||
> -			page_offset(page) > i_size_read(inode) ||
> +			page_offset(page) >= i_size_read(inode) ||
>  			!PageUptodate(page))) {
>  		unlock_page(page);
>  		err = -EFAULT;
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e25901ae3ff4..d454dbab5133 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1041,7 +1041,7 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
>  	lock_page(page);
>  	size = i_size_read(inode);
>  	if ((page->mapping != inode->i_mapping) ||
> -	    (page_offset(page) > size)) {
> +	    (page_offset(page) >= size)) {
>  		/* We overload EFAULT to mean page got truncated */
>  		ret = -EFAULT;
>  		goto out_unlock;
> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> index cd52585c8f4f..ca0148ec77e6 100644
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@ -1564,7 +1564,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fault *vmf)
>  
>  	lock_page(page);
>  	if (unlikely(page->mapping != inode->i_mapping ||
> -		     page_offset(page) > i_size_read(inode))) {
> +		     page_offset(page) >= i_size_read(inode))) {
>  		/* Page got truncated out from underneath us */
>  		goto sigbus;
>  	}
> -- 
> 2.20.1
> 

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
