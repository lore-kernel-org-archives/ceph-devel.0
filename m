From: Nicheal <zay11022@gmail.com>
Subject: Re: WriteBack Throttle kill the performace of the disk
Date: Wed, 15 Oct 2014 10:20:56 +0800
Message-ID: <CALZt5jyXHfd-Sim-rp8WRhC333yU3Ho3ZHjZ8TvR7Y0gzBKqNA@mail.gmail.com>
References: <CALZt5jzUduePJzgH+-NJ=7WckxioCbUZvxvnCFM8VBxHxXt4dg@mail.gmail.com>
	<543BD3B9.2000600@redhat.com>
	<CAPYLRzh5vrv2e2QPe=Cf9FgVbhSWn5wgWs_SCGLOmvhQsnda3A@mail.gmail.com>
	<CALZt5jxKCyf0eWRQt2w04bQ2aEN4vj4i-01TVCNiS-WqWZB1KQ@mail.gmail.com>
	<543D14E8.4030901@redhat.com>
	<alpine.DEB.2.00.1410140617320.31128@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:43696 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932579AbaJOCU4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Oct 2014 22:20:56 -0400
Received: by mail-oi0-f46.google.com with SMTP id h136so262314oig.5
        for <ceph-devel@vger.kernel.org>; Tue, 14 Oct 2014 19:20:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1410140617320.31128@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Mark Nelson <mark.nelson@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

2014-10-14 21:22 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Tue, 14 Oct 2014, Mark Nelson wrote:
>> On 10/14/2014 12:15 AM, Nicheal wrote:
>> > Yes, Greg.
>> > But Unix based system always have a parameter dirty_ratio to prevent
>> > the system memory from being exhausted. If Journal speed is so fast
>> > while backing store cannot catch up with Journal, then the backing
>> > store write will be blocked by the hard limitation of system dirty
>> > pages. The problem here may be that system call, sync(), cannot return
>> > since the system always has lots of dirty pages. Consequently, 1)
>> > FileStore::sync_entry() will be timeout and then ceph_osd_daemon
>> > abort.  2) Even if the thread is not timed out, Since the Journal
>> > committed point cannot be updated so that the Journal will be blocked,
>> > waiting for the sync() return and update Journal committed point.
>> > So the Throttle is added to solve the above problems, right?
>>
>> Greg or Sam can correct me if I'm wrong, but I always thought of the
>> wbthrottle code as being more an attempt to smooth out spikes in write
>> throughput to prevent the journal from getting too far ahead of the backing
>> store.  IE have more frequent, shorter flush periods rather than less frequent
>> longer ones.  For Ceph that is's probably a reasonable idea since you want all
>> of the OSDs behaving as consistently as possible to prevent hitting the max
>> outstanding client IOs/Bytes on the client and starving other ready OSDs.  I'm
>> not sure it's worked out in practice as well as it might have in theory,
>> though I'm not sure we've really investigated what's going on enough to be
>> sure.
>
> Right.  The fdatasync strategy means that the overall throughput is lower,
> but the latencies are much more consistent.  Without the throttling we had
> huge spikes, which is even more problematic.
>
>> > However, in my tested ARM ceph cluster(3nodes, 9osds, 3osds/node), it
>> > will cause problem (SSD as journal, and HDD as data disk, fio 4k
>> > ramdom write iodepth 64):
>> >      WritebackThrottle enable: Based on blktrace, we trace the back-end
>> > hdd io behaviour. Because of frequently calling fdatasync() in
>> > Writeback Throttle, it cause every back-end hdd spent more time to
>> > finish one io. This causes the total sync time longer. For example,
>> > default sync_max_interval is 5 seconds, total dirty data in 5 seconds
>> > is 10M. If I disable WritebackThrottle, 10M dirty data will be sync to
>> > disk within 4 second, So cat /proc/meminfo, the dirty data of my
>> > system is always clean(near zero). However, If I enable
>> > WritebackThrottle, fdatasync() slows down the sync process. Thus, it
>> > seems 8-9M random io will be sync to the disk within 5s. Thus the
>> > dirty data is always growing to the critical point (system
>> > up-limitation), and then sync_entry() is always timed out. So I means,
>> > in my case, disabling WritebackThrottle, I may always have 600 IOPS.
>> > If enabling WritebackThrottle, IOPS always drop to 200 since fdatasync
>> > cause back-end HDD disk overloaded.
>
> It is true.  One could probably disable wbthrottle and carefully tune the
> kernel dirty_ratio and dirty_bytes.  As I recall the problem though was
> that it was inode writeback that was expensive, and there were not good
> kernel knobs for limiting the dirty items in that cache. I would be very
> interested in hearing about successes in this area.
>
Yes, I also find that inode-writeback is definitely expensive. I try
to find out the reason and improve it but failed. Since it is quite
complex and different file-systems have different implementations to
manage its inode in VFS layer. Furthermore, the filesystem itself
maintains  journal for inodes to accelerate inode writeback and keep
inode writeback atomic. I am still find more useful materials in how
the filesystem (XFS, EXT4) works in its VFS and their strategies
maintain and writeback inodes based on their source code. If any one
can suggests more relative literature?

> Another promising direction is the batched fsync experiment that Dave
> Chinner did a few months back.  I'm not what the status is in
> getting that into mainline, though, so it's not helpful anytime soon.
>
>> >     So I would like that we can dynamically throttle the IOPS in
>> > FileStore. We cannot know the average sync() speed of the back-end
>> > Store since different disk own different IO performance. However, we
>> > can trace the average write speed in FileStore and Journal, Also, we
>> > can know, whether start_sync() is return and finished. Thus, If this
>> > time, Journal is writing so fast that the back-end cannot catch up the
>> > Journal(e.g. 1000IOPS/s). We cannot Throttle the Journal speed(e.g.
>> > 800IOPS/s) in next operation interval(the interval maybe 1 to 5
>> > seconds, in the third second, Thottle become 1000*e^-x where x is the
>> > tick interval, ), if in this interval, Journal write reach the
>> > limitation, the following submitting write should waiting in OSD
>> > waiting queue.So in this way, Journal may provide a boosting IO, but
>> > finally, back-end sync() will return and catch up with Journal become
>> > we always slow down the Journal speed after several seconds.
>
> Autotuning these parameters based on observed performance definitely
> sounds promising!
>
> sage
