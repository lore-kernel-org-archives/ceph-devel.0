From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 07/12] fs: export inode_to_bdi and use it in favor of
 mapping->backing_dev_info
Date: Sun, 11 Jan 2015 13:16:51 -0500
Message-ID: <20150111181651.GN25319@htj.dyndns.org>
References: <1420739133-27514-1-git-send-email-hch@lst.de>
 <1420739133-27514-8-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1420739133-27514-8-git-send-email-hch-jcswGhMUV9g@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Jens Axboe <axboe-b10kYP2dOMg@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hello,

On Thu, Jan 08, 2015 at 06:45:28PM +0100, Christoph Hellwig wrote:
> Now that we got ri of the bdi abuse on character devices we can always use
                  ^^^
		  rid

> sb->s_bdi to get at the backing_dev_info for a file, except for the block
> device special case.  Export inode_to_bdi and replace uses of
> mapping->backing_dev_info with it to prepare for the removal of
> mapping->backing_dev_info.
>
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>

Ah, this is so much better.  Thanks a lot for doing this.  Just one
nit below.

> +struct backing_dev_info *inode_to_bdi(struct inode *inode)
>  {
>  	struct super_block *sb = inode->i_sb;
>  #ifdef CONFIG_BLOCK
> @@ -75,6 +75,7 @@ static inline struct backing_dev_info *inode_to_bdi(struct inode *inode)
>  #endif
>  	return sb->s_bdi;
>  }
> +EXPORT_SYMBOL_GPL(inode_to_bdi);

This is rather trivial.  Maybe we wanna make this an inline function?

 Reviewed-by: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

-- 
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
