From: Stefan Priebe <s.priebe@profihost.ag>
Subject: slow backfilling / remapping
Date: Sat, 01 Dec 2012 20:56:31 +0100
Message-ID: <50BA60EF.6050701@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:56470 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab2LAT43 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 1 Dec 2012 14:56:29 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

today i was trying to look what happens if i remove an osd.

I've executed:
ceph osd 21 out

Cluster Details:
- XFS FS for OSDs
- Software version: latest next from today 12/01/2012
- 6 Nodes with 4 OSDs only SSDs each

I have just 8 GB of data so i thought removing an OSD should be VERY fast.

Here are parts of the logs whole process tooked 15 minutes.

2012-12-01 20:06:02.607191 mon.0 [INF] pgmap v59693: 7632 pgs: 7348 
active+clean, 266 active+remapped+wait_backfill, 12 
active+remapped+backfilling, 6 active+recovering; 7880 MB data, 18812 MB 
used, 4428 GB / 4446 GB avail; 180/4303 degraded (4.183%)

2012-12-01 20:16:11.284705 mon.0 [INF] pgmap v60000: 7632 pgs: 7562 
active+clean, 65 active+remapped+wait_backfill, 5 
active+remapped+backfilling; 7880 MB data, 18981 MB used, 4428 GB / 4446 
GB avail; 44/4178 degraded (1.053%)

2012-12-01 20:22:35.829481 mon.0 [INF] pgmap v60182: 7632 pgs: 7628 
active+clean, 4 active+remapped+backfilling; 7880 MB data, 19029 MB 
used, 4428 GB / 4446 GB avail; 3/4137 degraded (0.073%)
2012-12-01 20:22:37.052136 mon.0 [INF] pgmap v60183: 7632 pgs: 7632 
active+clean; 7880 MB data, 19033 MB used, 4428 GB / 4446 GB avail

Greets,
Stefan
