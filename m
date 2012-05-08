From: Sage Weil <sage@newdream.net>
Subject: performance on btrfs
Date: Mon, 7 May 2012 20:11:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205072003420.31186@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40092 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab2EHDLt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 May 2012 23:11:49 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id EF115BCB0D
	for <ceph-devel@vger.kernel.org>; Mon,  7 May 2012 20:11:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 677D6BCB02
	for <ceph-devel@vger.kernel.org>; Mon,  7 May 2012 20:11:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Looping everyone else in here on some simple write performance tests on 
top of btrfs.  4mb writes, journal on ssd.  Seekwatcher movies at

http://nhm.ceph.com/movies/btrfs-dd-experiment/

Four tests here.  Raw disk bw is around 135 MB/sec.

> >> a: cluster
> >>  - flusher on
> >>  - no vm tuning
> >>  - initially fast, then crazy slow, then ...
> >>  - commit/sync every ~5s

Super fast at first, then a long lull where we're waiting for btrfs snap 
to complete, but disk tput is like 15 MB/sec (from iostat).  But in the 
movie it looks like and sequential.. maybe the ios are too small or badly 
aligned/timed or something?  Need to look at the raw blktrace data to see 
where the seeks are.  This may be a problem in commit_transaction 
(fs/btrfs/transaction.c) doing the flushing inefficiently?

> >> b: much much later
> >>  - consistent 40 MB/sec

20 minutes later, same run... things settle into 40 MB/sec.  Can clearly 
see the funny gaps Yehuda was talking about

I suspect the seekiness there is appending to the pg logs?  Maybe we can 
verify that somehow?  Hopefully we can convince btrfs we don't care about 
fragmentation of those files (basically never read) and write them more 
efficiently.

> >> c:
> >>  - no ceph cluster, just a for loop:
> >> for f in `seq 1 10000` ; do dd if=/dev/zero of=$f bs=4M count=1 ; attr -s
> >> foo -V bar $f ; echo asdf >> foo.txt ; attr -s foo -V $f foo.txt ; done
> >>    and
> >> while true ; do sync ; sleep 5 ; done
> >>  - 20 MB dirty_bytes limit (so that VM does writeout quickly)
> >>  -> 60 MB/sec    (initially fast, though, more like 120 MB/sec)

Weird we don't see the seeks here.. maybe they're just closer than in b?  
Also, here i have one "log" (foo.txt) vs dozens of them (for each pg) in 
b.  This clearly points to improvements to be had in btrfs (it's not all 
our fault).  Should repeat this test on XFS.

> >> d:
> >>  - filestore flusher = false
> >>  - 20mb dirty_bytes
> >>  -> 55 MB/sec, slowly dropping

This is letting the VM do the writeout.  Presumably those dots are the pg 
logs again, but written out less politely.  Wonder why...


c and d aren't *too* far off, which suggests this is mostly a btrfs 
allocation issue.  But a vs b tells me there is also something 
unfortunately going on with how we throttle the io coming in and manage 
the flushing.  :/

Let's get a simple workload reproducer together here (either workloadgen 
or a simple script) that we can harass linux-btrfs@vger with?

sage
