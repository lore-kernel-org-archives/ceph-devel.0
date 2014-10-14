From: Nicheal <zay11022@gmail.com>
Subject: Re: WriteBack Throttle kill the performace of the disk
Date: Tue, 14 Oct 2014 13:15:14 +0800
Message-ID: <CALZt5jxKCyf0eWRQt2w04bQ2aEN4vj4i-01TVCNiS-WqWZB1KQ@mail.gmail.com>
References: <CALZt5jzUduePJzgH+-NJ=7WckxioCbUZvxvnCFM8VBxHxXt4dg@mail.gmail.com>
	<543BD3B9.2000600@redhat.com>
	<CAPYLRzh5vrv2e2QPe=Cf9FgVbhSWn5wgWs_SCGLOmvhQsnda3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:55361 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbaJNFPP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Oct 2014 01:15:15 -0400
Received: by mail-oi0-f45.google.com with SMTP id i138so15383640oig.4
        for <ceph-devel@vger.kernel.org>; Mon, 13 Oct 2014 22:15:14 -0700 (PDT)
In-Reply-To: <CAPYLRzh5vrv2e2QPe=Cf9FgVbhSWn5wgWs_SCGLOmvhQsnda3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Yes, Greg.
But Unix based system always have a parameter dirty_ratio to prevent
the system memory from being exhausted. If Journal speed is so fast
while backing store cannot catch up with Journal, then the backing
store write will be blocked by the hard limitation of system dirty
pages. The problem here may be that system call, sync(), cannot return
since the system always has lots of dirty pages. Consequently, 1)
FileStore::sync_entry() will be timeout and then ceph_osd_daemon
abort.  2) Even if the thread is not timed out, Since the Journal
committed point cannot be updated so that the Journal will be blocked,
waiting for the sync() return and update Journal committed point.
So the Throttle is added to solve the above problems, right?
However, in my tested ARM ceph cluster(3nodes, 9osds, 3osds/node), it
will cause problem (SSD as journal, and HDD as data disk, fio 4k
ramdom write iodepth 64):
    WritebackThrottle enable: Based on blktrace, we trace the back-end
hdd io behaviour. Because of frequently calling fdatasync() in
Writeback Throttle, it cause every back-end hdd spent more time to
finish one io. This causes the total sync time longer. For example,
default sync_max_interval is 5 seconds, total dirty data in 5 seconds
is 10M. If I disable WritebackThrottle, 10M dirty data will be sync to
disk within 4 second, So cat /proc/meminfo, the dirty data of my
system is always clean(near zero). However, If I enable
WritebackThrottle, fdatasync() slows down the sync process. Thus, it
seems 8-9M random io will be sync to the disk within 5s. Thus the
dirty data is always growing to the critical point (system
up-limitation), and then sync_entry() is always timed out. So I means,
in my case, disabling WritebackThrottle, I may always have 600 IOPS.
If enabling WritebackThrottle, IOPS always drop to 200 since fdatasync
cause back-end HDD disk overloaded.
   So I would like that we can dynamically throttle the IOPS in
FileStore. We cannot know the average sync() speed of the back-end
Store since different disk own different IO performance. However, we
can trace the average write speed in FileStore and Journal, Also, we
can know, whether start_sync() is return and finished. Thus, If this
time, Journal is writing so fast that the back-end cannot catch up the
Journal(e.g. 1000IOPS/s). We cannot Throttle the Journal speed(e.g.
800IOPS/s) in next operation interval(the interval maybe 1 to 5
seconds, in the third second, Thottle become 1000*e^-x where x is the
tick interval, ), if in this interval, Journal write reach the
limitation, the following submitting write should waiting in OSD
waiting queue.So in this way, Journal may provide a boosting IO, but
finally, back-end sync() will return and catch up with Journal become
we always slow down the Journal speed after several seconds.
