From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: backing_dev_info cleanups & lifetime rule fixes V2
Date: Mon, 2 Feb 2015 09:06:35 +0100
Message-ID: <20150202080635.GB9851@lst.de>
References: <1421228561-16857-1-git-send-email-hch@lst.de> <54BEC3C2.7080906@fb.com> <20150201063116.GP29656@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150201063116.GP29656-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Al Viro <viro-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
Cc: Jens Axboe <axboe-b10kYP2dOMg@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Sun, Feb 01, 2015 at 06:31:16AM +0000, Al Viro wrote:
> And at that point we finally can make sb_lock and super_blocks static in
> fs/super.c.  Do you want that in your tree, or would you rather have it
> done via vfs.git during the merge window after your tree goes in?  It's
> as trivial as this:
> 
> Make super_blocks and sb_lock static
> 
> The only user outside of fs/super.c is gone now
> 
> Signed-off-by: Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>

I'd say merge it through the block tree..

Acked-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
