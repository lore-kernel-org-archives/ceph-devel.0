From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: WriteBack Throttle kill the performace of the disk
Date: Tue, 14 Oct 2014 07:19:52 -0500
Message-ID: <543D14E8.4030901@redhat.com>
References: <CALZt5jzUduePJzgH+-NJ=7WckxioCbUZvxvnCFM8VBxHxXt4dg@mail.gmail.com>	<543BD3B9.2000600@redhat.com>	<CAPYLRzh5vrv2e2QPe=Cf9FgVbhSWn5wgWs_SCGLOmvhQsnda3A@mail.gmail.com> <CALZt5jxKCyf0eWRQt2w04bQ2aEN4vj4i-01TVCNiS-WqWZB1KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:41037 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932126AbaJNMTw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Oct 2014 08:19:52 -0400
Received: by mail-ig0-f171.google.com with SMTP id h15so14248757igd.10
        for <ceph-devel@vger.kernel.org>; Tue, 14 Oct 2014 05:19:51 -0700 (PDT)
In-Reply-To: <CALZt5jxKCyf0eWRQt2w04bQ2aEN4vj4i-01TVCNiS-WqWZB1KQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nicheal <zay11022@gmail.com>, Gregory Farnum <greg@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 10/14/2014 12:15 AM, Nicheal wrote:
> Yes, Greg.
> But Unix based system always have a parameter dirty_ratio to prevent
> the system memory from being exhausted. If Journal speed is so fast
> while backing store cannot catch up with Journal, then the backing
> store write will be blocked by the hard limitation of system dirty
> pages. The problem here may be that system call, sync(), cannot return
> since the system always has lots of dirty pages. Consequently, 1)
> FileStore::sync_entry() will be timeout and then ceph_osd_daemon
> abort.  2) Even if the thread is not timed out, Since the Journal
> committed point cannot be updated so that the Journal will be blocked,
> waiting for the sync() return and update Journal committed point.
> So the Throttle is added to solve the above problems, right?

Greg or Sam can correct me if I'm wrong, but I always thought of the 
wbthrottle code as being more an attempt to smooth out spikes in write 
throughput to prevent the journal from getting too far ahead of the 
backing store.  IE have more frequent, shorter flush periods rather than 
less frequent longer ones.  For Ceph that is's probably a reasonable 
idea since you want all of the OSDs behaving as consistently as possible 
to prevent hitting the max outstanding client IOs/Bytes on the client 
and starving other ready OSDs.  I'm not sure it's worked out in practice 
as well as it might have in theory, though I'm not sure we've really 
investigated what's going on enough to be sure.

> However, in my tested ARM ceph cluster(3nodes, 9osds, 3osds/node), it
> will cause problem (SSD as journal, and HDD as data disk, fio 4k
> ramdom write iodepth 64):
>      WritebackThrottle enable: Based on blktrace, we trace the back-end
> hdd io behaviour. Because of frequently calling fdatasync() in
> Writeback Throttle, it cause every back-end hdd spent more time to
> finish one io. This causes the total sync time longer. For example,
> default sync_max_interval is 5 seconds, total dirty data in 5 seconds
> is 10M. If I disable WritebackThrottle, 10M dirty data will be sync to
> disk within 4 second, So cat /proc/meminfo, the dirty data of my
> system is always clean(near zero). However, If I enable
> WritebackThrottle, fdatasync() slows down the sync process. Thus, it
> seems 8-9M random io will be sync to the disk within 5s. Thus the
> dirty data is always growing to the critical point (system
> up-limitation), and then sync_entry() is always timed out. So I means,
> in my case, disabling WritebackThrottle, I may always have 600 IOPS.
> If enabling WritebackThrottle, IOPS always drop to 200 since fdatasync
> cause back-end HDD disk overloaded.

We never did a blktrace investigation, but we did see pretty bad 
performance with the default wbthrottle code when it was first 
implemented.  We ended up raising the throttles pretty considerably in 
dumpling RC2.  It would be interesting to repeat this test on an Intel 
system.

>     So I would like that we can dynamically throttle the IOPS in
> FileStore. We cannot know the average sync() speed of the back-end
> Store since different disk own different IO performance. However, we
> can trace the average write speed in FileStore and Journal, Also, we
> can know, whether start_sync() is return and finished. Thus, If this
> time, Journal is writing so fast that the back-end cannot catch up the
> Journal(e.g. 1000IOPS/s). We cannot Throttle the Journal speed(e.g.
> 800IOPS/s) in next operation interval(the interval maybe 1 to 5
> seconds, in the third second, Thottle become 1000*e^-x where x is the
> tick interval, ), if in this interval, Journal write reach the
> limitation, the following submitting write should waiting in OSD
> waiting queue.So in this way, Journal may provide a boosting IO, but
> finally, back-end sync() will return and catch up with Journal become
> we always slow down the Journal speed after several seconds.
>

I will wait for Sam's input, but it seems reasonable to me.  Perhaps you 
might write it up as a blueprint for CDS?

Mark
