From: Dieter Kasper <d.kasper@kabelmail.de>
Subject: Re: messaging/IO/radosbench results
Date: Wed, 12 Sep 2012 22:08:04 +0200
Message-ID: <20120912200804.GA4993@oder.mch.fsc.net>
References: <20120910201539.GA5733@splice>
 <504E501E.5080108@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpa1.mediabeam.com ([194.25.41.13]:45142 "EHLO
	smtpa1.mediabeam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab2ILUI2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 16:08:28 -0400
Content-Disposition: inline
In-Reply-To: <504E501E.5080108@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Mike Ryan <mike.ryan@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Sep 10, 2012 at 10:39:58PM +0200, Mark Nelson wrote:
> On 09/10/2012 03:15 PM, Mike Ryan wrote:
> > *Disclaimer*: these results are an investigation into potential
> > bottlenecks in RADOS. 
I appreciate this investigation very much !

> > The test setup is wholly unrealistic, and these
> > numbers SHOULD NOT be used as an indication of the performance of OSDs,
> > messaging, RADOS, or ceph in general.
> >
> >
> > Executive summary: rados bench has some internal bottleneck. Once that's
> > cleared up, we're still having some issues saturating a single
> > connection to an OSD. Having 2-3 connection in parallel alleviates that
> > (either by having>  1 OSD or having multiple bencher clients).
> >
> >
> > I've run three separate tests: msbench, smalliobench, and rados bench.
> > In all cases I was trying to determine where bottleneck(s) exist. All
> > the tests were run on a machine with 192 GB of RAM. The backing stores
> > for all OSDs and journals are RAMdisks. The stores are running XFS.
> >
> > smalliobench: I ran tests varying the number of OSDs and bencher
> > clients. In all cases, the number of PG's per OSD is 100.
> >
> > OSD     Bencher     Throughput (mbyte/sec)
> > 1       1           510
> > 1       2           800
> > 1       3           850
> > 2       1           640
> > 2       2           660
> > 2       3           670
> > 3       1           780
> > 3       2           820
> > 3       3           870
> > 4       1           850
> > 4       2           970
> > 4       3           990
> >
> > Note: these numbers are fairly fuzzy. I eyeballed them and they're only
> > really accurate to about 10 mbyte/sec. The small IO bencher was run with
> > 100 ops in flight, 4 mbyte io's, 4 mbyte files.
> >
> > msbench: ran tests trying to determine max throughput of raw messaging
> > layer. Varied the number of concurrently connected msbench clients and
> > measured aggregate throughput. Take-away: a messaging client can very
> > consistently push 400-500 mbytes/sec through a single socket.
> >
> > Clients     Throughput (mbyte/sec)
> > 1           520
> > 2           880
> > 3           1300
> > 4           1900
> >
> > Finally, rados bench, which seems to have its own bottleneck. Running
> > varying numbers of these, each client seems to get 250 mbyte/sec up till
> > the aggregate rate is around 1000 mbyte/sec (appx line speed as measured
> > by iperf). These were run on a pool with 100 PGs/OSD.
> >
> > Clients     Throughput (mbyte/sec)
> > 1           250
> > 2           500
> > 3           750
> > 4           1000 (very fuzzy, probably 1000 +/- 75)
> > 5           1000, seems to level out here
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Hi guys,
> 
> Some background on all of this:
> 
> We've been doing some performance testing at Inktank and noticed that 
> performance with a single rados bench instance was plateauing at between 
> 600-700MB/s.  

4-nodes with 10GbE interconnect; journals in RAM-Disk; replica=2

# rados bench -p pbench 20 write
 Maintaining 16 concurrent writes of 4194304 bytes for at least 20 seconds.
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
     0       0         0         0         0         0         -         0
     1      16       288       272   1087.81      1088  0.051123 0.0571643
     2      16       579       563   1125.85      1164  0.045729 0.0561784
     3      16       863       847   1129.19      1136  0.042012 0.0560869
     4      16      1150      1134   1133.87      1148   0.05466 0.0559281
     5      16      1441      1425   1139.87      1164  0.036852 0.0556809
     6      16      1733      1717   1144.54      1168  0.054594 0.0556124
     7      16      2007      1991   1137.59      1096   0.04454 0.0556698
     8      16      2290      2274   1136.88      1132  0.046777 0.0560103
     9      16      2580      2564   1139.44      1160  0.073328 0.0559353
    10      16      2871      2855   1141.88      1164  0.034091 0.0558576
    11      16      3158      3142   1142.43      1148  0.250688 0.0558404
    12      16      3445      3429   1142.88      1148  0.046941 0.0558071
    13      16      3726      3710   1141.42      1124  0.054092    0.0559
    14      16      4014      3998   1142.17      1152   0.03531 0.0558533
    15      16      4298      4282   1141.75      1136  0.040005 0.0559383
    16      16      4582      4566   1141.39      1136  0.048431 0.0559162
    17      16      4859      4843   1139.42      1108  0.045805 0.0559891
    18      16      5145      5129   1139.66      1144  0.046805 0.0560177
    19      16      5422      5406   1137.99      1108  0.037295 0.0561341
2012-09-08 14:36:32.460311min lat: 0.029503 max lat: 0.47757 avg lat: 0.0561424
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
    20      16      5701      5685   1136.89      1116  0.041493 0.0561424
 Total time run:         20.197129
Total writes made:      5702
Write size:             4194304
Bandwidth (MB/sec):     1129.269

Stddev Bandwidth:       23.7487
Max bandwidth (MB/sec): 1168
Min bandwidth (MB/sec): 1088
Average Latency:        0.0564675
Stddev Latency:         0.0327582
Max latency:            0.47757
Min latency:            0.029503


Best Regards,
-Dieter

> Running multiple concurrent rados bench instances improves 
> performance, but only to a certain extent. The fastest throughput we've 
> seen so far is around 1160MB/s with 8 rados bench instances, 12 spinning 
> disks, and journals on SSDs.  This is true regardless of the underlying 
> filesystem on the OSDs, though some hit the limits faster than others. 
> Some of the raw data is available here:
> 
> https://docs.google.com/a/inktank.com/spreadsheet/ccc?key=0AnmmfpoQ1_94dDlmTHhvM19zd19tb05zbFVqZ2xSYXc#gid=0
> 
> To understand why we are plateauing, we wanted to investigate what 
> bottlenecks were present in rados bench and if there also were any 
> bottlenecks in the messenger code that might be limiting throughput. 
> Soon we should have a 36 drive setup in our SC847a chassis where we can 
> try to push things even further. :)
> 
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

