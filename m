From: Michael Chapman <michael.chapman@anu.edu.au>
Subject: Re: mon not marking dead osds down and slow streaming write performance
Date: Sat, 22 Dec 2012 18:34:04 +1100
Message-ID: <CABf87X=qV1uVRi8=N1tjh7gbXpb=Uk07hqwyXOR2SAFHtE-jfA@mail.gmail.com>
References: <CABf87Xk54Q-SP2258MsXDVKAo2TgjOw8xds2f9W=XxmgdSRFTA@mail.gmail.com>
	<alpine.DEB.2.00.1212201046050.16508@cobra.newdream.net>
	<CABf87XmB9qgusXdSgfPD9qnDtMuCyFtWk_tyX8h8=fSZGs6=Ag@mail.gmail.com>
	<alpine.DEB.2.00.1212201633590.16508@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:41279 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab2LVHeG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 22 Dec 2012 02:34:06 -0500
Received: by mail-qc0-f173.google.com with SMTP id b12so3000858qca.32
        for <ceph-devel@vger.kernel.org>; Fri, 21 Dec 2012 23:34:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212201633590.16508@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Dec 21, 2012 at 11:37 AM, Sage Weil <sage@inktank.com> wrote:
> On Fri, 21 Dec 2012, Michael Chapman wrote:
>> I'll remove them properly. Thanks for your help. Do you have any
>> suggestions on the second (mon IO) issue I'm seeing?
>
> Whoops, missed it:
>
>> >> A second issue I have been having is that my reads+writes are very
>> >> bursty, going from 8MB/s to 200MB/s when doing a dd from a physical
>> >> client over 10GbE. It seems to be waiting on the mon most of the time,
>> >> and iostat shows long io wait times for the disk the mon is using. I
>> >> can also see it writing ~40MB/s constantly to disk in iotop, though I
>> >> don't know if this is random or sequential. I see a lot of waiting for
>> >> sub ops which I thought might be a result of the io wait.
>> >>
>> >> Is that a normal amount of activity for a mon process? Should I be
>> >> running the mon processes off more than just a single sata disk to
>> >> keep up with ~30 OSD processes?
>
> Is the ceph-mon daemon running on its own disk (or /), separate from the
> osds?  My first guess is that this is could be a sync(2) issue.

It's on /
Is that going to be bad? My first thought was that maybe too much
logging was bringing it down but there's very little iops in the log
directory during use.

> ceph-mon daemon is running on teh same host as some of the osds?  If you
> have an older kernel (pre-3.0), or you are running argonaut and have an
> old glibc, there is no syncfs(2) syscall, and multiple osds can drag
> each other down by doing lots of commits.  That often leads to the
> bursty writes.

We're running 12.04 so we should have a new enough kernel (3.2), and ceph 0.55.1

I originally had the osds and mons on the same hosts but removed all
the OSDs on one mon host and 2 of the three mons in the cluster to try
to isolate why it's running so slow. It's currently one blade with a
single raid 1 pair and 12 cores hosting a single mon, and a few blades
with attached disks running OSD processes.

>
> Having the osd journals stored as files also contributes.  Using a
> separate partition (or, idealy, part of an SSD or caching raid array)
> helps quite a bit.
>
> In general, 30 osds is very small, and should cause no significant monitor
> load.  But the monitor is doing lots of fsync(), which can interfere with
> other workloads if its on the same disk.

That was what I thought. I might try rebuilding from scratch and see
if it still underperforms. What is confusing me is that the number of
iops we see in the osdmap directory isn't actually that high, and yet
iostat shows ~100-200ms iowait when we start to utilise the cluster.
I'd put it down to faulty hardware but it was the same across all
three mons. Should a single sata disk be able to handle the load of
one mon or should I be looking at SAS/SSD options?

>
> sage



-- 
Michael Chapman
Cloud Computing Services
ANU Supercomputer Facility
Room 318, Leonard Huxley Building (#56), Mills Road
The Australian National University
Canberra ACT 0200 Australia
Tel: +61 2 6125 7106
Web: http://nci.org.au
