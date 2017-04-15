From: Peter Maloney <peter.maloney@brockmann-consult.de>
Subject: another scrub bug? blocked for > 10240.948831 secs
Date: Sat, 15 Apr 2017 21:34:54 +0000
Message-ID: <94127293-3ba3-8bb8-db43-604b6a54eb55@brockmann-consult.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:56268 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754157AbdDOVeU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Apr 2017 17:34:20 -0400
Received: from [192.168.178.200] ([87.170.175.221]) by
 mrelayeu.kundenserver.de (mreue005 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0Lv6YQ-1bzKF12uji-010Os0 for <ceph-devel@vger.kernel.org>; Sat, 15 Apr
 2017 23:34:17 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Is this another scrub bug? Something just like this (1 or 2 requests
blocked forever until osd restart) happened about 5 times so far, each
time during recovery or some other thing I did myself to trigger it,
probably involving snapshots. This time I noticed that it says scrub in
the log. One other time it made a client block, but didn't seem to this
time. I didn't have the same issue in 10.2.3, but I don't know if I
generated the same load or whatever causes it back then.

ceph version 10.2.5 (c461ee19ecbc0c5c330aca20f7392c9a00730367)

If you want me to try 10.2.6 or 7 instead, I can do that, but no
guarantee I can reproduce it any time soon.


>  42392 GB used, 24643 GB / 67035 GB avail; 15917 kB/s rd, 147 MB/s wr,
> 1483 op/s
> 2017-04-15 03:53:57.301902 osd.5 10.3.0.132:6813/1085915 1991 :
> cluster [WRN] 1 slow requests, 1 included below; oldest blocked for >
> 5.372629 secs
> 2017-04-15 03:53:57.301905 osd.5 10.3.0.132:6813/1085915 1992 :
> cluster [WRN] slow request 5.372629 seconds old, received at
> 2017-04-15 03:53:51.929240: replica scrub(pg:
> 4.25,from:0'0,to:73551'5179474,epoch:73551,start:4:a4537100:::rbd_data.4bf687238e1f29.000000000001e5dc:0,end:4:a453818a:::rbd_data.4bf687238e1f29.0000000000017d8b:db18,chunky:1,deep:0,seed:4294967295,version:6)
> currently reached_pg
> 2017-04-15 03:53:57.312641 mon.0 10.3.0.131:6789/0 158090 : cluster
> [INF] pgmap v14652123: 896 pgs: 2 active+clean+scrubbing+deep, 5
> active+clean+scrubbing, 889 active+clean; 17900 GB data, 42392 GB
> used, 24643 GB / 67035 GB avail; 22124 kB/s rd, 191 MB/s wr, 2422 op/s
> ...
> 2017-04-15 03:53:57.419047 osd.8 10.3.0.133:6814/1124407 1725 :
> cluster [WRN] 1 slow requests, 1 included below; oldest blocked for >
> 5.489743 secs
> 2017-04-15 03:53:57.419052 osd.8 10.3.0.133:6814/1124407 1726 :
> cluster [WRN] slow request 5.489743 seconds old, received at
> 2017-04-15 03:53:51.929266: replica scrub(pg:
> 4.25,from:0'0,to:73551'5179474,epoch:73551,start:4:a4537100:::rbd_data.4bf687238e1f29.000000000001e5dc:0,end:4:a453818a:::rbd_data.4bf687238e1f29.0000000000017d8b:db18,chunky:1,deep:0,seed:4294967295,version:6)
> currently reached_pg
> ...
> 2017-04-15 06:44:32.969476 mon.0 10.3.0.131:6789/0 168432 : cluster
> [INF] pgmap v14662280: 896 pgs: 5 active+clean+scrubbing, 891
> active+clean; 18011 GB data, 42703 GB used, 24332 GB / 6703
> 5 GB avail; 2512 kB/s rd, 12321 kB/s wr, 1599 op/s
> 2017-04-15 06:44:32.878155 osd.8 10.3.0.133:6814/1124407 1747 :
> cluster [WRN] 1 slow requests, 1 included below; oldest blocked for >
> 10240.948831 secs
> 2017-04-15 06:44:32.878159 osd.8 10.3.0.133:6814/1124407 1748 :
> cluster [WRN] slow request 10240.948831 seconds old, received at
> 2017-04-15 03:53:51.929266: replica scrub(pg: 4.25,from:0'0,
> to:73551'5179474,epoch:73551,start:4:a4537100:::rbd_data.4bf687238e1f29.000000000001e5dc:0,end:4:a453818a:::rbd_data.4bf687238e1f29.0000000000017d8b:db18,chunky:1,deep:0,seed:4294967295,ver
> sion:6) currently reached_pg
> 2017-04-15 06:44:33.984306 mon.0 10.3.0.131:6789/0 168433 : cluster
> [INF] pgmap v14662281: 896 pgs: 5 active+clean+scrubbing, 891
> active+clean; 18011 GB data, 42703 GB used, 24332 GB / 6703
> 5 GB avail; 11675 kB/s rd, 29068 kB/s wr, 1847 op/s

