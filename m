From: Nicheal <zay11022@gmail.com>
Subject: Re: WriteBack Throttle kill the performace of the disk
Date: Wed, 15 Oct 2014 11:10:53 +0800
Message-ID: <CALZt5jzmH+ZcHQJv0WM+gdh4N8ZD-+6PEP7vvoUb4d7UOMDPWw@mail.gmail.com>
References: <CALZt5jzUduePJzgH+-NJ=7WckxioCbUZvxvnCFM8VBxHxXt4dg@mail.gmail.com>
	<543BD3B9.2000600@redhat.com>
	<CAPYLRzh5vrv2e2QPe=Cf9FgVbhSWn5wgWs_SCGLOmvhQsnda3A@mail.gmail.com>
	<CALZt5jxKCyf0eWRQt2w04bQ2aEN4vj4i-01TVCNiS-WqWZB1KQ@mail.gmail.com>
	<543D14E8.4030901@redhat.com>
	<543D1A33.9070605@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:53546 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755536AbaJODKy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Oct 2014 23:10:54 -0400
Received: by mail-oi0-f47.google.com with SMTP id a141so306116oig.6
        for <ceph-devel@vger.kernel.org>; Tue, 14 Oct 2014 20:10:53 -0700 (PDT)
In-Reply-To: <543D1A33.9070605@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 10/14/2014 02:19 PM, Mark Nelson wrote:
> On 10/14/2014 12:15 AM, Nicheal wrote:
>> Yes, Greg.
>> But Unix based system always have a parameter dirty_ratio to prevent
>> the system memory from being exhausted. If Journal speed is so fast
>> while backing store cannot catch up with Journal, then the backing
>> store write will be blocked by the hard limitation of system dirty
>> pages. The problem here may be that system call, sync(), cannot return
>> since the system always has lots of dirty pages. Consequently, 1)
>> FileStore::sync_entry() will be timeout and then ceph_osd_daemon
>> abort.  2) Even if the thread is not timed out, Since the Journal
>> committed point cannot be updated so that the Journal will be blocked,
>> waiting for the sync() return and update Journal committed point.
>> So the Throttle is added to solve the above problems, right?
>
> Greg or Sam can correct me if I'm wrong, but I always thought of the
> wbthrottle code as being more an attempt to smooth out spikes in write
> throughput to prevent the journal from getting too far ahead of the
> backing store.  IE have more frequent, shorter flush periods rather than
> less frequent longer ones.  For Ceph that is's probably a reasonable
> idea since you want all of the OSDs behaving as consistently as possible
> to prevent hitting the max outstanding client IOs/Bytes on the client
> and starving other ready OSDs.  I'm not sure it's worked out in practice
> as well as it might have in theory, though I'm not sure we've really
> investigated what's going on enough to be sure.
>

> I thought that as well. So in the case of a SSD-based OSD where the
> journal is on a partition #1 and the data on #2 you would disable
> wbthrottle, correct?
Yes, Wido. But it also depends, I don't know you environment, but I
can provide tips here:
    First of all, if you do large number of small io (e.g. 4k), the
bottleneck maybe your CPU, my xeon E3 1230 v2 can just support 2 SSD
OSD/node if I test 4k write.  So disabling wbthrottle can save your
cpu cost and improve performance.
    Secondly, if your cpu is not bottleneck (supposing you use a
powerful server 2*Xeon E5), then if you use SSD can provide power-loss
data protection, you can mount you SSD with nobarrier(If you don't
know the concept of filesystem writebarrier, please refer to
http://xfs.org/index.php/XFS_FAQ#Write_barrier_support) so that
fdatasync() would be quite efficient to smooth your IOPS.
    If you don't care how to improve the performance based on the ceph
source code, my suggestion is that try different tuning under your
environment and chose the better one.

> Since the journal is just as fast as the data partition.
