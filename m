From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 04/12] block_dev: only write bdev inode on close
Date: Sun, 11 Jan 2015 12:32:09 -0500
Message-ID: <20150111173209.GK25319@htj.dyndns.org>
References: <1420739133-27514-1-git-send-email-hch@lst.de>
 <1420739133-27514-5-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1420739133-27514-5-git-send-email-hch@lst.de>
Sender: owner-linux-mm@kvack.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@fb.com>, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hello,

On Thu, Jan 08, 2015 at 06:45:25PM +0100, Christoph Hellwig wrote:
> Since "bdi: reimplement bdev_inode_switch_bdi()" the block device code

018a17bdc865 ("bdi: reimplement bdev_inode_switch_bdi()") would be
better.

> writes out all dirty data whenever switching the backing_dev_info for
> a block device inode.  But a block device inode can only be dirtied
> when it is in use, which means we only have to write it out on the
> final blkdev_put, but not when doing a blkdev_get.
> @@ -1464,9 +1469,11 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
>  		WARN_ON_ONCE(bdev->bd_holders);
>  		sync_blockdev(bdev);
>  		kill_bdev(bdev);
> -		/* ->release can cause the old bdi to disappear,
> -		 * so must switch it out first
> +		/*
> +		 * ->release can cause the queue to disappaear, so flush all
                                                         ^^^^^
							 typo
> +		 * dirty data before.
>  		 */
> +		bdev_write_inode(bdev->bd_inode);

Is this an optimization or something necessary for the following
changes?  If latter, maybe it's a good idea to state why this is
necessary in the description?  Otherwise,

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
