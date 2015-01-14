From: Jan Kara <jack-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 11/12] fs: don't reassign dirty inodes to
 default_backing_dev_info
Date: Wed, 14 Jan 2015 14:59:14 +0100
Message-ID: <20150114135914.GL10215@quack.suse.cz>
References: <1421228561-16857-1-git-send-email-hch@lst.de>
 <1421228561-16857-12-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421228561-16857-12-git-send-email-hch-jcswGhMUV9g@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Jens Axboe <axboe-b10kYP2dOMg@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Wed 14-01-15 10:42:40, Christoph Hellwig wrote:
> If we have dirty inodes we need to call the filesystem for it, even if the
> device has been removed and the filesystem will error out early.  The
> current code does that by reassining all dirty inodes to the default
> backing_dev_info when a bdi is unlinked, but that's pretty pointless given
> that the bdi must always outlive the super block.
> 
> Instead of stopping writeback at unregister time and moving inodes to the
> default bdi just keep the current bdi alive until it is destroyed.  The
> containing objects of the bdi ensure this doesn't happen until all
> writeback has finished by erroring out.
> 
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> Reviewed-by: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
  Looks good. You can add:
Reviewed-by: Jan Kara <jack-AlSwsSmVLrQ@public.gmane.org>

One nit below:


> ---
>  mm/backing-dev.c | 91 +++++++++++++++-----------------------------------------
>  1 file changed, 24 insertions(+), 67 deletions(-)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 52e0c76..3ebba25 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
...
> @@ -471,37 +445,20 @@ void bdi_destroy(struct backing_dev_info *bdi)
>  {
>  	int i;
>  
> -	/*
> -	 * Splice our entries to the default_backing_dev_info.  This
> -	 * condition shouldn't happen.  @wb must be empty at this point and
> -	 * dirty inodes on it might cause other issues.  This workaround is
> -	 * added by ce5f8e779519 ("writeback: splice dirty inode entries to
> -	 * default bdi on bdi_destroy()") without root-causing the issue.
> -	 *
> -	 * http://lkml.kernel.org/g/1253038617-30204-11-git-send-email-jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
> -	 * http://thread.gmane.org/gmane.linux.file-systems/35341/focus=35350
> -	 *
> -	 * We should probably add WARN_ON() to find out whether it still
> -	 * happens and track it down if so.
> -	 */
> -	if (bdi_has_dirty_io(bdi)) {
> -		struct bdi_writeback *dst = &default_backing_dev_info.wb;
> -
> -		bdi_lock_two(&bdi->wb, dst);
> -		list_splice(&bdi->wb.b_dirty, &dst->b_dirty);
> -		list_splice(&bdi->wb.b_io, &dst->b_io);
> -		list_splice(&bdi->wb.b_more_io, &dst->b_more_io);
> -		spin_unlock(&bdi->wb.list_lock);
> -		spin_unlock(&dst->list_lock);
> -	}
> -
> -	bdi_unregister(bdi);
> +	bdi_wb_shutdown(bdi);
>  
> +	WARN_ON(!list_empty(&bdi->work_list));
> +	WARN_ON(delayed_work_pending(&bdi->wb.dwork));
>  	WARN_ON(delayed_work_pending(&bdi->wb.dwork));
  You have the warning twice here...

								Honza
-- 
Jan Kara <jack-AlSwsSmVLrQ@public.gmane.org>
SUSE Labs, CR
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
