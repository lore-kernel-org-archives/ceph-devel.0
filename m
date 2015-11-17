From: Tejun Heo <tj@kernel.org>
Subject: Re: request_queue use-after-free - inode_detach_wb()
Date: Tue, 17 Nov 2015 15:56:41 -0500
Message-ID: <20151117205641.GF22864@mtj.duckdns.org>
References: <CAOi1vP9igmg_jayELVDq_NYXUHtByZz5a4M5+CqCMMHUxF5ofA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOi1vP9igmg_jayELVDq_NYXUHtByZz5a4M5+CqCMMHUxF5ofA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Hello, Ilya.

On Mon, Nov 16, 2015 at 09:59:18PM +0100, Ilya Dryomov wrote:
...
> Looking at __blkdev_put(), the issue becomes clear: we are taking
> precautions to flush before calling out to ->release() because, at
> least according to the comment, ->release() can free queue; we are
> recording owner pointer because put_disk() may free both gendisk and
> queue, and then, after all that, we are calling bdput() which may
> touch the queue through wb_put() in inode_detach_wb().  (The fun part
> is wb_put() is supposed to be a noop for root wbs, but slab debugging
> interferes with that by poisoning wb->bdi pointer.)
> 
> 1514                  * dirty data before.
> 1515                  */
> 1516                 bdev_write_inode(bdev);
> 1517         }
> 1518         if (bdev->bd_contains == bdev) {
> 1519                 if (disk->fops->release)
> 1520                         disk->fops->release(disk, mode);
> 1521         }
> 1522         if (!bdev->bd_openers) {
> 1523                 struct module *owner = disk->fops->owner;
> 1524
> 1525                 disk_put_part(bdev->bd_part);
> 1526                 bdev->bd_part = NULL;
> 1527                 bdev->bd_disk = NULL;
> 1528                 if (bdev != bdev->bd_contains)
> 1529                         victim = bdev->bd_contains;
> 1530                 bdev->bd_contains = NULL;
> 1531
> 1532                 put_disk(disk); <-- may free q
> 1533                 module_put(owner);
> 1534         }
> 1535         mutex_unlock(&bdev->bd_mutex);
> 1536         bdput(bdev); <-- may touch q.backing_dev_info.wb

Ah, that's a sneaky bug.  Thanks a lot for chasing it down.  The
scenario sounds completely plausible to me.

> To reproduce, apply the attached patch (systemd-udevd condition is just
> a convenience: udev reacts to change events by getting the bdev which
> it then has to put), boot with slub_debug=,blkdev_queue and do:
> 
> $ sudo modprobe loop
> $ sudo losetup /dev/loop0 foo.img
> $ sudo dd if=/dev/urandom of=/dev/loop0 bs=1M count=1
> $ sudo losetup -d /dev/loop0
> $ sudo rmmod loop
> 
> (rmmod is key - it's the only way to get loop to do put_disk().  For
> rbd, it's just rbd map - dd - rbd unmap.)
> 
> In the past we used to reassign to default_backing_dev_info here, but
> it was nuked in b83ae6d42143 ("fs: remove mapping->backing_dev_info").

Woohoo, it wasn't me. :)

> Shortly after that cgroup-specific writebacks patches from Tejun got
> merged, adding inode::i_wb and inode_detach_wb() call.  The fix seems
> to be to detach the inode earlier, but I'm not familiar enough with
> cgroups code, so sending my findings instead of a patch.  Christoph,
> Tejun?

It's stinky that the bdi is going away while the inode is still there.
Yeah, blkdev inodes are special and created early but I think it makes
sense to keep the underlying structures (queue and bdi) around while
bdev is associated with it.  Would simply moving put_disk() after
bdput() work?

Thanks.

-- 
tejun
