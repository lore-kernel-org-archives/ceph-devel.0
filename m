From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: messaging/IO/radosbench results
Date: Mon, 10 Sep 2012 15:39:58 -0500
Message-ID: <504E501E.5080108@inktank.com>
References: <20120910201539.GA5733@splice>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43421 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152Ab2IJUkB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Sep 2012 16:40:01 -0400
Received: by iahk25 with SMTP id k25so2143017iah.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Sep 2012 13:40:00 -0700 (PDT)
In-Reply-To: <20120910201539.GA5733@splice>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Ryan <mike.ryan@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 09/10/2012 03:15 PM, Mike Ryan wrote:
> *Disclaimer*: these results are an investigation into potential
> bottlenecks in RADOS. The test setup is wholly unrealistic, and these
> numbers SHOULD NOT be used as an indication of the performance of OSDs,
> messaging, RADOS, or ceph in general.
>
>
> Executive summary: rados bench has some internal bottleneck. Once that's
> cleared up, we're still having some issues saturating a single
> connection to an OSD. Having 2-3 connection in parallel alleviates that
> (either by having>  1 OSD or having multiple bencher clients).
>
>
> I've run three separate tests: msbench, smalliobench, and rados bench.
> In all cases I was trying to determine where bottleneck(s) exist. All
> the tests were run on a machine with 192 GB of RAM. The backing stores
> for all OSDs and journals are RAMdisks. The stores are running XFS.
>
> smalliobench: I ran tests varying the number of OSDs and bencher
> clients. In all cases, the number of PG's per OSD is 100.
>
> OSD     Bencher     Throughput (mbyte/sec)
> 1       1           510
> 1       2           800
> 1       3           850
> 2       1           640
> 2       2           660
> 2       3           670
> 3       1           780
> 3       2           820
> 3       3           870
> 4       1           850
> 4       2           970
> 4       3           990
>
> Note: these numbers are fairly fuzzy. I eyeballed them and they're only
> really accurate to about 10 mbyte/sec. The small IO bencher was run with
> 100 ops in flight, 4 mbyte io's, 4 mbyte files.
>
> msbench: ran tests trying to determine max throughput of raw messaging
> layer. Varied the number of concurrently connected msbench clients and
> measured aggregate throughput. Take-away: a messaging client can very
> consistently push 400-500 mbytes/sec through a single socket.
>
> Clients     Throughput (mbyte/sec)
> 1           520
> 2           880
> 3           1300
> 4           1900
>
> Finally, rados bench, which seems to have its own bottleneck. Running
> varying numbers of these, each client seems to get 250 mbyte/sec up till
> the aggregate rate is around 1000 mbyte/sec (appx line speed as measured
> by iperf). These were run on a pool with 100 PGs/OSD.
>
> Clients     Throughput (mbyte/sec)
> 1           250
> 2           500
> 3           750
> 4           1000 (very fuzzy, probably 1000 +/- 75)
> 5           1000, seems to level out here
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi guys,

Some background on all of this:

We've been doing some performance testing at Inktank and noticed that 
performance with a single rados bench instance was plateauing at between 
600-700MB/s.  Running multiple concurrent rados bench instances improves 
performance, but only to a certain extent. The fastest throughput we've 
seen so far is around 1160MB/s with 8 rados bench instances, 12 spinning 
disks, and journals on SSDs.  This is true regardless of the underlying 
filesystem on the OSDs, though some hit the limits faster than others. 
Some of the raw data is available here:

https://docs.google.com/a/inktank.com/spreadsheet/ccc?key=0AnmmfpoQ1_94dDlmTHhvM19zd19tb05zbFVqZ2xSYXc#gid=0

To understand why we are plateauing, we wanted to investigate what 
bottlenecks were present in rados bench and if there also were any 
bottlenecks in the messenger code that might be limiting throughput. 
Soon we should have a 36 drive setup in our SC847a chassis where we can 
try to push things even further. :)

Mark
