From: Sage Weil <sage@newdream.net>
Subject: Re: hdparm -W redux, bug in _check_disk_write_cache for RHEL6?
Date: Tue, 21 Jul 2015 06:54:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507210646120.8878@cobra.newdream.net>
References: <CABZ+qq=NDjKsQfqshVTzoPoC7PW2MPW1Q8MgvvmJfNGqhp0feQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50648 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932175AbbGUNyY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 09:54:24 -0400
In-Reply-To: <CABZ+qq=NDjKsQfqshVTzoPoC7PW2MPW1Q8MgvvmJfNGqhp0feQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, rwheeler@redhat.com

On Tue, 21 Jul 2015, Dan van der Ster wrote:
> Hi,
> 
> Following the sf.net corruption report I've been checking our config
> w.r.t data consistency. AFAIK the two main recommendations are:
> 
>   1) don't mount FileStores with nobarrier
>   2) disable write-caching (hdparm -W 0 /dev/sdX) when using block dev
> journals and your kernel is < 2.6.33
> 
> Obviously we don't do (1) because that would be crazy, but for (2) we
> didn't disable yet write-caching, probably because we didn't notice
> the doc.
> 
> But my lame excuse is that apparently _check_disk_write_cache in
> FileJournal.cc doesn't print a warning when it should, because hdparm
> -W doesn't always work on partitions rather than whole block devices.
> See:
> 
> GOOD: ceph 0.94.2, kernel 3.10.0-229.7.2.el7.x86_64, hdparm v9.43:
> 
>    10 journal _open_block_device: ignoring osd journal size. We'll use
> the entire block device (size: 21474836480)
>    20 journal _check_disk_write_cache: disk write cache is on, but
> your kernel is new enough to handle it correctly.
> (fn:/var/lib/ceph/osd/ceph-96/journal)
>     1 journal _open /var/lib/ceph/osd/ceph-96/journal fd 20:
> 21474836480 bytes, block size 4096 bytes, directio = 1, aio = 1
> 
> 
> BAD: ceph 0.94.2, kernel 2.6.32-431.29.2.el6.x86_64, hdparm v9.43:
> 
>    10 journal _open_block_device: ignoring osd journal size. We'll use
> the entire block device (size: 21474836480)
>     1 journal _open /var/lib/ceph/osd/ceph-56/journal fd 19:
> 21474836480 bytes, block size 4096 bytes, directio = 1, aio = 1
> 
> 
> In other words, running hammer on EL6, _check_disk_write_cache exits
> without printing anything, but actually it should log the scary
> "WARNING: disk write cache is ON".
> 
> I guess it's because of this:
> 
> GOOD # uname -r && hdparm -W /dev/sda && hdparm -W /dev/sda1
> 3.10.0-229.7.2.el7.x86_64
> 
> /dev/sda1:
>  write-caching =  1 (on)
> 
> /dev/sda:
>  write-caching =  1 (on)
> 
> 
> BAD # uname -r && hdparm -W /dev/sda && hdparm -W /dev/sda1
> 2.6.32-431.23.3.el6.x86_64
> 
> /dev/sda:
>  write-caching =  1 (on)
> 
> /dev/sda1:
>  HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
> 
> 
> (in both cases /dev/sda is an INTEL SSDSC2BA20).
> 
> So a few questions to end this:
>   1) What was the magic patch in 2.6.33 which made write-caching safe?

The specific behavior is that we want fsync or fdatasync to flush the 
write cache on the underlying device.  Unfortunately I've lost track of 
which commit led me to the magic 2.6.33 number.  However, this reference 
seems to confirm that 2.6.33 is a safe upper bound:

	http://monolight.cc/2011/06/barriers-caches-filesystems/

>   2) What's the recommended recourse here: hopefully Red Hat
> backported the necessary to their 2.6.32 kernel, but if not should we
> fix _check_disk_write_cache and make some publicity for people to
> check their configs?

I have no doubt that any and all patches related to flushing caches on 
fsync are part of the el6 kernel.

What's embarassing is that hdparm fails on kernels old enough to fail the 
test :).  The fix is probably to strip off the partition number (ideally 
using the helpers in blkdev.cc so that it works even for weirdly-named 
devices) and run hdparm on that.

sage


> 
> Best Regards,
> 
> Dan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
