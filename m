From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 06/12] nilfs2: set up s_bdi like the generic mount_bdev
 code
Date: Wed, 14 Jan 2015 14:05:20 +0100
Message-ID: <20150114130520.GH10215@quack.suse.cz>
References: <1421228561-16857-1-git-send-email-hch@lst.de>
 <1421228561-16857-7-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1421228561-16857-7-git-send-email-hch@lst.de>
Sender: owner-linux-mm@kvack.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@fb.com>, David Howells <dhowells@redhat.com>, Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Wed 14-01-15 10:42:35, Christoph Hellwig wrote:
> mapping->backing_dev_info will go away, so don't rely on it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
> Reviewed-by: Tejun Heo <tj@kernel.org>
> ---
>  fs/nilfs2/super.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
> index 2e5b3ec..3d4bbac 100644
> --- a/fs/nilfs2/super.c
> +++ b/fs/nilfs2/super.c
> @@ -1077,8 +1076,7 @@ nilfs_fill_super(struct super_block *sb, void *data, int silent)
>  	sb->s_time_gran = 1;
>  	sb->s_max_links = NILFS_LINK_MAX;
>  
> -	bdi = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
> -	sb->s_bdi = bdi ? : &default_backing_dev_info;
> +	sb->s_bdi = &bdev_get_queue(sb->s_bdev)->backing_dev_info;
  Why don't you use blk_get_backing_dev_info() here? Otherwise the patch
looks fine. So you can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.cz>
SUSE Labs, CR

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
