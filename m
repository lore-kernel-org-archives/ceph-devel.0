From: Mike Dawson <mike.dawson@cloudapt.com>
Subject: Deep-Scrub and High Read Latency with QEMU/RBD
Date: Fri, 30 Aug 2013 12:03:06 -0400
Message-ID: <5220C23A.8010709@cloudapt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:59106 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756260Ab3H3QDL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Aug 2013 12:03:11 -0400
Received: by mail-ie0-f178.google.com with SMTP id f4so3749821iea.9
        for <ceph-devel@vger.kernel.org>; Fri, 30 Aug 2013 09:03:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We've been struggling with an issue of spikes of high i/o latency with 
qemu/rbd guests. As we've been chasing this bug, we've greatly improved 
the methods we use to monitor our infrastructure.

It appears that our RBD performance chokes in two situations:

- Deep-Scrub
- Backfill/recovery

In this email, I want to focus on deep-scrub. Graphing '% Util' from 
'iostat -x' on my hosts with OSDs, I can see Deep-Scrub take my disks 
from around 10% utilized to complete saturation during a scrub.

RBD writeback cache appears to cover the issue nicely, but occasionally 
suffers drops in performance (presumably when it flushes). But, reads 
appear to suffer greatly, with multiple seconds of 0B/s of reads 
accomplished (see log fragment below). If I make the assumption that 
deep-scrub isn't intended to create massive spindle contention, this 
appears to be a problem. What should happen here?

Looking at the settings around deep-scrub, I don't see an obvious way to 
say "don't saturate my drives". Are there any setting in Ceph or 
otherwise (readahead?) that might lower the burden of deep-scrub?

If not, perhaps reads could be remapped to avoid waiting on saturated 
disks during scrub.

Any ideas?

2013-08-30 15:47:20.166149 mon.0 [INF] pgmap v9853931: 20672 pgs: 20665 
active+clean, 7 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64556 GB / 174 TB avail; 0B/s rd, 5058KB/s wr, 217op/s
2013-08-30 15:47:21.945948 mon.0 [INF] pgmap v9853932: 20672 pgs: 20665 
active+clean, 7 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64556 GB / 174 TB avail; 0B/s rd, 5553KB/s wr, 229op/s
2013-08-30 15:47:23.205843 mon.0 [INF] pgmap v9853933: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64556 GB / 174 TB avail; 0B/s rd, 6580KB/s wr, 246op/s
2013-08-30 15:47:24.843308 mon.0 [INF] pgmap v9853934: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64556 GB / 174 TB avail; 0B/s rd, 3795KB/s wr, 224op/s
2013-08-30 15:47:25.862722 mon.0 [INF] pgmap v9853935: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64556 GB / 174 TB avail; 1414B/s rd, 3799KB/s wr, 181op/s
2013-08-30 15:47:26.887516 mon.0 [INF] pgmap v9853936: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64556 GB / 174 TB avail; 1541B/s rd, 8138KB/s wr, 160op/s
2013-08-30 15:47:27.933629 mon.0 [INF] pgmap v9853937: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64556 GB / 174 TB avail; 0B/s rd, 14458KB/s wr, 304op/s
2013-08-30 15:47:29.127847 mon.0 [INF] pgmap v9853938: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64556 GB / 174 TB avail; 0B/s rd, 15300KB/s wr, 345op/s
2013-08-30 15:47:30.344837 mon.0 [INF] pgmap v9853939: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64556 GB / 174 TB avail; 0B/s rd, 13128KB/s wr, 218op/s
2013-08-30 15:47:31.380089 mon.0 [INF] pgmap v9853940: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64556 GB / 174 TB avail; 0B/s rd, 13299KB/s wr, 241op/s
2013-08-30 15:47:32.388303 mon.0 [INF] pgmap v9853941: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64556 GB / 174 TB avail; 4951B/s rd, 8147KB/s wr, 192op/s
2013-08-30 15:47:33.858382 mon.0 [INF] pgmap v9853942: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64556 GB / 174 TB avail; 7029B/s rd, 3254KB/s wr, 190op/s
2013-08-30 15:47:35.279691 mon.0 [INF] pgmap v9853943: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64555 GB / 174 TB avail; 1651B/s rd, 2476KB/s wr, 207op/s
2013-08-30 15:47:36.309078 mon.0 [INF] pgmap v9853944: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64555 GB / 174 TB avail; 0B/s rd, 3788KB/s wr, 239op/s
2013-08-30 15:47:38.120343 mon.0 [INF] pgmap v9853945: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64555 GB / 174 TB avail; 0B/s rd, 4671KB/s wr, 239op/s
2013-08-30 15:47:39.546980 mon.0 [INF] pgmap v9853946: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64555 GB / 174 TB avail; 0B/s rd, 13487KB/s wr, 444op/s
2013-08-30 15:47:40.561203 mon.0 [INF] pgmap v9853947: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64555 GB / 174 TB avail; 0B/s rd, 15265KB/s wr, 489op/s
2013-08-30 15:47:41.794355 mon.0 [INF] pgmap v9853948: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64555 GB / 174 TB avail; 0B/s rd, 7157KB/s wr, 240op/s
2013-08-30 15:47:44.661000 mon.0 [INF] pgmap v9853949: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64555 GB / 174 TB avail; 0B/s rd, 4543KB/s wr, 204op/s
2013-08-30 15:47:45.672198 mon.0 [INF] pgmap v9853950: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64555 GB / 174 TB avail; 0B/s rd, 3537KB/s wr, 221op/s
2013-08-30 15:47:47.202776 mon.0 [INF] pgmap v9853951: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64555 GB / 174 TB avail; 0B/s rd, 5127KB/s wr, 312op/s
2013-08-30 15:47:50.656948 mon.0 [INF] pgmap v9853952: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64555 GB / 174 TB avail; 32835B/s rd, 4996KB/s wr, 246op/s
2013-08-30 15:47:53.165529 mon.0 [INF] pgmap v9853953: 20672 pgs: 20664 
active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used, 
64555 GB / 174 TB avail; 33446B/s rd, 12064KB/s wr, 361op/s


-- 
Thanks,

Mike Dawson
Co-Founder & Director of Cloud Architecture
Cloudapt LLC
