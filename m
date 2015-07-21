From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: hdparm -W redux, bug in _check_disk_write_cache for RHEL6?
Date: Tue, 21 Jul 2015 17:20:55 +0300
Message-ID: <CAOi1vP-dFaquVYvSSVX_L3P8R6fFz0M5taUXG6bjzUO2tiMwjQ@mail.gmail.com>
References: <CABZ+qq=NDjKsQfqshVTzoPoC7PW2MPW1Q8MgvvmJfNGqhp0feQ@mail.gmail.com>
	<alpine.DEB.2.00.1507210646120.8878@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33786 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbbGUOU5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 10:20:57 -0400
Received: by wgmn9 with SMTP id n9so157987547wgm.0
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2015 07:20:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1507210646120.8878@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Dan van der Ster <dan@vanderster.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Ric Wheeler <rwheeler@redhat.com>

On Tue, Jul 21, 2015 at 4:54 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 21 Jul 2015, Dan van der Ster wrote:
>> Hi,
>>
>> Following the sf.net corruption report I've been checking our config
>> w.r.t data consistency. AFAIK the two main recommendations are:
>>
>>   1) don't mount FileStores with nobarrier
>>   2) disable write-caching (hdparm -W 0 /dev/sdX) when using block dev
>> journals and your kernel is < 2.6.33
>>
>> Obviously we don't do (1) because that would be crazy, but for (2) we
>> didn't disable yet write-caching, probably because we didn't notice
>> the doc.
>>
>> But my lame excuse is that apparently _check_disk_write_cache in
>> FileJournal.cc doesn't print a warning when it should, because hdparm
>> -W doesn't always work on partitions rather than whole block devices.
>> See:
>>
>> GOOD: ceph 0.94.2, kernel 3.10.0-229.7.2.el7.x86_64, hdparm v9.43:
>>
>>    10 journal _open_block_device: ignoring osd journal size. We'll use
>> the entire block device (size: 21474836480)
>>    20 journal _check_disk_write_cache: disk write cache is on, but
>> your kernel is new enough to handle it correctly.
>> (fn:/var/lib/ceph/osd/ceph-96/journal)
>>     1 journal _open /var/lib/ceph/osd/ceph-96/journal fd 20:
>> 21474836480 bytes, block size 4096 bytes, directio = 1, aio = 1
>>
>>
>> BAD: ceph 0.94.2, kernel 2.6.32-431.29.2.el6.x86_64, hdparm v9.43:
>>
>>    10 journal _open_block_device: ignoring osd journal size. We'll use
>> the entire block device (size: 21474836480)
>>     1 journal _open /var/lib/ceph/osd/ceph-56/journal fd 19:
>> 21474836480 bytes, block size 4096 bytes, directio = 1, aio = 1
>>
>>
>> In other words, running hammer on EL6, _check_disk_write_cache exits
>> without printing anything, but actually it should log the scary
>> "WARNING: disk write cache is ON".
>>
>> I guess it's because of this:
>>
>> GOOD # uname -r && hdparm -W /dev/sda && hdparm -W /dev/sda1
>> 3.10.0-229.7.2.el7.x86_64
>>
>> /dev/sda1:
>>  write-caching =  1 (on)
>>
>> /dev/sda:
>>  write-caching =  1 (on)
>>
>>
>> BAD # uname -r && hdparm -W /dev/sda && hdparm -W /dev/sda1
>> 2.6.32-431.23.3.el6.x86_64
>>
>> /dev/sda:
>>  write-caching =  1 (on)
>>
>> /dev/sda1:
>>  HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
>>
>>
>> (in both cases /dev/sda is an INTEL SSDSC2BA20).
>>
>> So a few questions to end this:
>>   1) What was the magic patch in 2.6.33 which made write-caching safe?
>
> The specific behavior is that we want fsync or fdatasync to flush the
> write cache on the underlying device.  Unfortunately I've lost track of
> which commit led me to the magic 2.6.33 number.  However, this reference
> seems to confirm that 2.6.33 is a safe upper bound:
>
>         http://monolight.cc/2011/06/barriers-caches-filesystems/

This one, I think:

commit ab0a9735e06914ce4d2a94ffa41497dbc142fe7f
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Oct 29 14:14:04 2009 +0100

    blkdev: flush disk cache on ->fsync

    Currently there is no barrier support in the block device code.  That
    means we cannot guarantee any sort of data integerity when using the
    block device node with dis kwrite caches enabled.  Using the raw block
    device node is a typical use case for virtualization (and I assume
    databases, too).  This patch changes block_fsync to issue a cache flush
    and thus make fsync on block device nodes actually useful.

    Note that in mainline we would also need to add such code to the
    ->aio_write method for O_SYNC handling, but assuming that Jan's patch
    series for the O_SYNC rewrite goes in it will also call into ->fsync
    for 2.6.32.

    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Jens Axboe <jens.axboe@oracle.com>

>
>>   2) What's the recommended recourse here: hopefully Red Hat
>> backported the necessary to their 2.6.32 kernel, but if not should we
>> fix _check_disk_write_cache and make some publicity for people to
>> check their configs?
>
> I have no doubt that any and all patches related to flushing caches on
> fsync are part of the el6 kernel.
>
> What's embarassing is that hdparm fails on kernels old enough to fail the
> test :).  The fix is probably to strip off the partition number (ideally
> using the helpers in blkdev.cc so that it works even for weirdly-named
> devices) and run hdparm on that.

We should look into using libblkid for this and nuking blkdev.cc.  rbd
unmap supports unmap by partition and already relies on libblkid to do
the partition -> whole disk thing.  I can't remember if that function
is old enough to be in el6 base, I can take a stab at this if it is...

Thanks,

                Ilya
