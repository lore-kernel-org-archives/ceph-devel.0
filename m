From: Mike Ryan <mike.ryan@inktank.com>
Subject: messaging/IO/radosbench results
Date: Mon, 10 Sep 2012 13:15:39 -0700
Message-ID: <20120910201539.GA5733@splice>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34829 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab2IJUPo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Sep 2012 16:15:44 -0400
Received: by pbbrr13 with SMTP id rr13so2984132pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Sep 2012 13:15:44 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

*Disclaimer*: these results are an investigation into potential
bottlenecks in RADOS. The test setup is wholly unrealistic, and these
numbers SHOULD NOT be used as an indication of the performance of OSDs,
messaging, RADOS, or ceph in general.


Executive summary: rados bench has some internal bottleneck. Once that's
cleared up, we're still having some issues saturating a single
connection to an OSD. Having 2-3 connection in parallel alleviates that
(either by having > 1 OSD or having multiple bencher clients).


I've run three separate tests: msbench, smalliobench, and rados bench.
In all cases I was trying to determine where bottleneck(s) exist. All
the tests were run on a machine with 192 GB of RAM. The backing stores
for all OSDs and journals are RAMdisks. The stores are running XFS.

smalliobench: I ran tests varying the number of OSDs and bencher
clients. In all cases, the number of PG's per OSD is 100.

OSD     Bencher     Throughput (mbyte/sec)
1       1           510
1       2           800
1       3           850
2       1           640
2       2           660
2       3           670
3       1           780
3       2           820
3       3           870
4       1           850
4       2           970
4       3           990

Note: these numbers are fairly fuzzy. I eyeballed them and they're only
really accurate to about 10 mbyte/sec. The small IO bencher was run with
100 ops in flight, 4 mbyte io's, 4 mbyte files.

msbench: ran tests trying to determine max throughput of raw messaging
layer. Varied the number of concurrently connected msbench clients and
measured aggregate throughput. Take-away: a messaging client can very
consistently push 400-500 mbytes/sec through a single socket.

Clients     Throughput (mbyte/sec)
1           520
2           880
3           1300
4           1900

Finally, rados bench, which seems to have its own bottleneck. Running
varying numbers of these, each client seems to get 250 mbyte/sec up till
the aggregate rate is around 1000 mbyte/sec (appx line speed as measured
by iperf). These were run on a pool with 100 PGs/OSD.

Clients     Throughput (mbyte/sec)
1           250
2           500
3           750
4           1000 (very fuzzy, probably 1000 +/- 75)
5           1000, seems to level out here
