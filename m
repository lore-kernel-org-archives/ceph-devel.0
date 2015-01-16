From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 03/12] fs: introduce f_op->mmap_capabilities for nommu
 mmap support
Date: Thu, 15 Jan 2015 20:06:28 -0800
Message-ID: <20150116040628.GG9759@ld-irv-0074>
References: <1421228561-16857-1-git-send-email-hch@lst.de>
 <1421228561-16857-4-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421228561-16857-4-git-send-email-hch-jcswGhMUV9g@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Jens Axboe <axboe-b10kYP2dOMg@public.gmane.org>, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

+ dwmw2

On Wed, Jan 14, 2015 at 10:42:32AM +0100, Christoph Hellwig wrote:
> Since "BDI: Provide backing device capability information [try #3]" the
> backing_dev_info structure also provides flags for the kind of mmap
> operation available in a nommu environment, which is entirely unrelated
> to it's original purpose.
> 
> Introduce a new nommu-only file operation to provide this information to
> the nommu mmap code instead.  Splitting this from the backing_dev_info
> structure allows to remove lots of backing_dev_info instance that aren't
> otherwise needed, and entirely gets rid of the concept of providing a
> backing_dev_info for a character device.  It also removes the need for
> the mtd_inodefs filesystem.
> 
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> Reviewed-by: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  Documentation/nommu-mmap.txt                    |  8 +--
>  block/blk-core.c                                |  2 +-
>  drivers/char/mem.c                              | 64 ++++++++++----------
>  drivers/mtd/mtdchar.c                           | 72 ++++------------------
>  drivers/mtd/mtdconcat.c                         | 10 ----
>  drivers/mtd/mtdcore.c                           | 80 +++++++------------------
>  drivers/mtd/mtdpart.c                           |  1 -

There's a small conflict in mtdcore.c with some stuff I have queued up
for MTD in linux-next. Should be trivial to resolve later.

I don't have a test platform for nommu, and I'll admit I'm not too
familiar with this code, but it looks OK to me. So FWIW, for the MTD
parts:

Acked-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

>  drivers/staging/lustre/lustre/llite/llite_lib.c |  2 +-
>  fs/9p/v9fs.c                                    |  2 +-
>  fs/afs/volume.c                                 |  2 +-
>  fs/aio.c                                        | 14 +----
>  fs/btrfs/disk-io.c                              |  3 +-
>  fs/char_dev.c                                   | 24 --------
>  fs/cifs/connect.c                               |  2 +-
>  fs/coda/inode.c                                 |  2 +-
>  fs/configfs/configfs_internal.h                 |  2 -
>  fs/configfs/inode.c                             | 18 +-----
>  fs/configfs/mount.c                             | 11 +---
>  fs/ecryptfs/main.c                              |  2 +-
>  fs/exofs/super.c                                |  2 +-
>  fs/ncpfs/inode.c                                |  2 +-
>  fs/ramfs/file-nommu.c                           |  7 +++
>  fs/ramfs/inode.c                                | 22 +------
>  fs/romfs/mmap-nommu.c                           | 10 ++++
>  fs/ubifs/super.c                                |  2 +-
>  include/linux/backing-dev.h                     | 33 ++--------
>  include/linux/cdev.h                            |  2 -
>  include/linux/fs.h                              | 23 +++++++
>  include/linux/mtd/mtd.h                         |  2 +
>  mm/backing-dev.c                                |  7 +--
>  mm/nommu.c                                      | 69 ++++++++++-----------
>  security/security.c                             | 13 ++--
>  32 files changed, 169 insertions(+), 346 deletions(-)
[...]

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
