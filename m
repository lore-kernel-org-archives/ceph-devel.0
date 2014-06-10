From: Craig Lewis <clewis@centraldesktop.com>
Subject: I have PGs that I can't deep-scrub
Date: Tue, 10 Jun 2014 14:18:46 -0700
Message-ID: <CADHZLBa3z-7k28iL2SArQ+KYyBF0aUZEiAbASika8OEevpLk+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36075 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbaFJVTI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jun 2014 17:19:08 -0400
Received: by mail-wi0-f169.google.com with SMTP id hi2so4408561wib.2
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jun 2014 14:19:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Users <ceph-users@lists.ceph.com>, Ceph Devel <ceph-devel@vger.kernel.org>

Every time I deep-scrub one PG, all of the OSDs responsible get kicked
out of the cluster.  I've deep-scrubbed this PG 4 times now, and it
fails the same way every time.  OSD logs are linked at the bottom.

What can I do to get this deep-scrub to complete cleanly?

This is the first time I've deep-scrubbed these PGs since Sage helped
me recover from some OSD problems
(http://t53277.file-systems-ceph-development.file-systemstalk.info/70-osd-are-down-and-not-coming-up-t53277.html)

I can trigger the issue easily in this cluster, but have not been able
to re-create in other clusters.






The PG stats for this PG say that last_deep_scrub and deep_scrub_stamp
are 48009'1904117 2014-05-21 07:28:01.315996 respectively.  This PG is
owned by OSDs [11,0]

This is a secondary cluster, so I stopped all external I/O on it.  I
set nodeep-scrub, and restarted both OSDs with:
  debug osd = 5/5
  debug filestore = 5/5
  debug journal = 1
  debug monc = 20/20

then I ran a deep-scrub on this PG.

2014-06-10 10:47:50.881783 mon.0 [INF] pgmap v8832020: 2560 pgs: 2555
active+clean, 5 active+clean+scrubbing; 27701 GB data, 56218 GB used,
77870 GB / 130 TB avail
2014-06-10 10:47:54.039829 mon.0 [INF] pgmap v8832021: 2560 pgs: 2554
active+clean, 5 active+clean+scrubbing, 1 active+clean+scrubbing+deep;
27701 GB data, 56218 GB used, 77870 GB / 130 TB avail


At 10:49:09, I see ceph-osd for both 11 and 0 spike to 100% CPU
(100.3% +/- 1.0%).  Prior to this, they were both using ~30% CPU.  It
might've started a few seconds sooner, I'm watching top.

I forgot to watch IO stat until 10:56.  At this point, both OSDs are
reading.  iostat reports that they're both doing ~100
transactions/sec, reading ~1 MiBps, 0 writes.


At 11:01:26, iostat reports that both osds are no longer consuming any
disk I/O.  They both go for > 30 seconds with 0 transactions, and 0
kiB read/write.  There are small bumps of 2 transactions/sec for one
second, then it's back to 0.


At 11:02:41, the primary OSD gets kicked out by the monitors:
2014-06-10 11:02:41.168443 mon.0 [INF] pgmap v8832125: 2560 pgs: 2555
active+clean, 4 active+clean+scrubbing, 1 active+clean+scrubbing+deep;
27701 GB data, 56218 GB used, 77870 GB / 130 TB avail; 1996 B/s rd, 2
op/s
2014-06-10 11:02:57.801047 mon.0 [INF] osd.11 marked down after no pg
stats for 903.825187seconds
2014-06-10 11:02:57.823115 mon.0 [INF] osdmap e58834: 36 osds: 35 up, 36 in

Both ceph-osd processes (11 and 0) continue to use 100% CPU (same range).


At ~11:10, I see that osd.11 has resumed reading from disk at the
original levels (~100 tps, ~1MiBps read, 0 MiBps write).  Since it's
down, but doing something, I let it run.

Both the osd.11 and osd.0 repeat this pattern.  Reading for a while at
~1 MiBps, then nothing.  The duty cycle seems about 50%, with a 20
minute period, but I haven't timed anything.  CPU usage remains at
100%, regardless of whether IO is happening or not.


At 12:24:15, osd.11 rejoins the cluster:
2014-06-10 12:24:15.294646 mon.0 [INF] osd.11 10.193.0.7:6804/7100 boot
2014-06-10 12:24:15.294725 mon.0 [INF] osdmap e58838: 36 osds: 35 up, 36 in
2014-06-10 12:24:15.343869 mon.0 [INF] pgmap v8832827: 2560 pgs: 1
stale+active+clean+scrubbing+deep, 2266 active+clean, 5
stale+active+clean, 287 active+degraded, 1 active+clean+scrubbing;
27701 GB data, 56218 GB used, 77870 GB / 130 TB avail; 15650 B/s rd,
18 op/s; 3617854/61758142 objects degraded (5.858%)


osd.0's CPU usage drops back to normal when osd.11 rejoins the
cluster.  The PG stats have not changed.   The last_deep_scrub and
deep_scrub_stamp are still 48009'1904117 2014-05-21 07:28:01.315996
respectively.


This time, osd.0 did not get kicked out by the monitors.  In previous
attempts, osd.0 was kicked out 5-10 minutes after osd.11.  When that
happens, osd.0 rejoins the cluster after osd.11.


I have several more PGs exhibiting the same behavior.  At least 3 that
I know of, and many more that I haven't attempted to deep-scrub.






ceph -v: ceph version 0.72.2 (a913ded2ff138aefb8cb84d347d72164099cfd60)
ceph.conf: https://cd.centraldesktop.com/p/eAAAAAAADvxuAAAAAHJRUk4
ceph-osd.11.log (5.7 MiB):
https://cd.centraldesktop.com/p/eAAAAAAADvxyAAAAABPwaeM
ceph-osd.0.log (6.3 MiB):
https://cd.centraldesktop.com/p/eAAAAAAADvx0AAAAADWEGng
ceph pg 40.11e query: https://cd.centraldesktop.com/p/eAAAAAAADvxvAAAAAAylTW0

(the pg query was collected at 13:24, after the above events)




Things that probably don't matter:
The OSD partitions were created using ceph-disk-prepare --dmcrypt.
