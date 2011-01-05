From: John Leach <john@brightbox.co.uk>
Subject: Re: osd memory usage with lots of objects
Date: Wed, 05 Jan 2011 00:39:29 +0000
Message-ID: <1294187969.2654.57.camel@dogen>
References: <1294178282.2654.5.camel@dogen>
	 <AANLkTinztXbJGg_dFC9aLs_qRPtkE6TCr_DS0ezm6HYf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-AXzDYT1D5H8WCw263Hge"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp201.iad.emailsrvr.com ([207.97.245.201]:58839 "EHLO
	smtp201.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab1AEAjd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jan 2011 19:39:33 -0500
In-Reply-To: <AANLkTinztXbJGg_dFC9aLs_qRPtkE6TCr_DS0ezm6HYf@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org


--=-AXzDYT1D5H8WCw263Hge
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-01-04 at 14:28 -0800, Gregory Farnum wrote:
> On Tue, Jan 4, 2011 at 1:58 PM, John Leach <john@brightbox.co.uk> wrote:
> > Hi,
> >
> > I've got a 3 node test cluster (3 mons, 3 osds) with about 24,000,000
> > very small objects across 2400 pools (written directly with librados,
> > this isn't a ceph filesystem).
> >
> > The cosd processes have steadily grown in ram size and have finally
> > exhausted ram and are getting killed by the oom killer (the nodes have
> > 6gig RAM and no swap).
> >
> > When I start them back up they just very quickly increase in ram size
> > again and get killed.
> >
> > Is this expected?
> No, it's definitely not. :/

excellent news (much better than it being expected!)

> 
> > Do the osds require a certain amount of resident
> > memory relative to the data size (or perhaps number of objects)?
> Well, there's a small amount of memory overhead per-PG and per-pool,
> but the data size and number of objects shouldn't impact it. And I
> presume you haven't been changing your pgnum as you go?

I haven't touched the pg_nums on this cluster that I recall (it's been
up a couple of weeks but has nearly exclusively been used for writing
this test data).

> 
> So, some questions:
> 1) How far through startup do your OSDs get before crashing? Does
> peering complete (I'd expect no)? Can you show us the output of "ceph
> -w" during your attempted startup?

2011-01-05 00:17:58.532524   mon e1: 3 mons at {0=10.135.211.78:6789/0,1=10.61.136.222:6789/0,2=10.202.105.222:6789/0}
2011-01-05 00:22:53.325264   osd e10659: 3 osds: 3 up, 3 in
2011-01-05 00:22:53.383272    pg v151295: 20936 pgs: 1 creating, 2 peering, 10352 crashed+peering, 3052 active+clean+degraded, 7053 degraded+peering, 476 crashed+degraded+peering; 24130 MB data, 266 GB used, 332 GB / 630 GB avail; 12489924/49420044 degraded (25.273%)
2011-01-05 00:22:53.422433   log 2011-01-05 00:22:53.325027 mon0 10.135.211.78:6789/0 4 : [INF] osd0 10.135.211.78:6801/31836 boot
2011-01-05 00:24:47.301186    pg v151296: 20936 pgs: 1 creating, 2 peering, 10352 crashed+peering, 3052 active+clean+degraded, 7053 degraded+peering, 476 crashed+degraded+peering; 24130 MB data, 266 GB used, 332 GB / 630 GB avail; 12489924/49420044 degraded (25.273%)

<cosd crashes here>

2011-01-05 00:25:52.422340   log 2011-01-05 00:25:52.189259 mon0 10.135.211.78:6789/0 5 : [INF] osd0 10.135.211.78:6801/31836 failed (by osd2 10.61.136.222:6800/915)
2011-01-05 00:25:57.265635   log 2011-01-05 00:25:57.121870 mon0 10.135.211.78:6789/0 6 : [INF] osd0 10.135.211.78:6801/31836 failed (by osd2 10.61.136.222:6800/915)
2011-01-05 00:26:02.341805   osd e10660: 3 osds: 2 up, 3 in
2011-01-05 00:26:02.362526   log 2011-01-05 00:26:02.127627 mon0 10.135.211.78:6789/0 7 : [INF] osd0 10.135.211.78:6801/31836 failed (by osd2 10.61.136.222:6800/915)
2011-01-05 00:26:02.470942    pg v151297: 20936 pgs: 1 creating, 2 peering, 10352 crashed+peering, 3052 active+clean+degraded, 7053 degraded+peering, 476 crashed+degraded+peering; 24130 MB data, 266 GB used, 332 GB / 630 GB avail; 12489924/49420044 degraded (25.273%)
2011-01-05 00:26:12.578266    pg v151298: 20936 pgs: 1 creating, 2 peering, 3393 crashed+peering, 3052 active+clean+degraded, 7053 degraded+peering, 7435 crashed+degraded+peering; 24130 MB data, 266 GB used, 332 GB / 630 GB avail; 20728862/49420044 degraded (41.944%)


> 2) Assuming you've built them with tcmalloc, can you enable memory
> profiling before you try and start it up, and post the results
> somewhere? (http://ceph.newdream.net/wiki/Memory_Profiling will get
> you started)

done. attached pprof output from last heap profile before cosd was
killed.

Watching the process carefully, I noticed that it doesn't grow in size
steadily.  It slowly grows to around 2gig (say over a 10 minute period)
then suddenly inflates to 5.5gig in perhaps less than a minute.

> 
> 
> > Can you offer any guidance on planning for ram usage?
> Our target is under a few hundred megabytes. In the past whenever
> we've seen usage higher than this during normal operation we've had
> serious memory leaks. 6GB is way past what the memory requirements
> should ever be, though of course the more RAM you have the more
> file/object data can be cached in-memory which can provide some nice
> boosts in read bandwidth.
> 
> That said, we haven't been very careful about memory usage in our
> peering code and this may be the cause of your problems with starting
> up again. But it wouldn't explain why they ran out of memory to begin
> with.

I was investigating a crash of the osd at the time (definitely not an
oom kill, got a core dump) so that probably started it all off.

John.

p.s: thanks for the help with tcmalloc profiling on irc :)


--=-AXzDYT1D5H8WCw263Hge
Content-Type: application/x-gzip; name="osd.0.0017.heap.pprof.txt.gz"
Content-Disposition: attachment; filename="osd.0.0017.heap.pprof.txt.gz"
Content-Transfer-Encoding: base64

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
CTUNcfoAAA==


--=-AXzDYT1D5H8WCw263Hge--

