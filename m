From: Sage Weil <sage@newdream.net>
Subject: Re: Ceph, make (22nd-sept unstable) fails, and slow write issues.
Date: Thu, 23 Sep 2010 22:20:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009232208240.2831@cobra.newdream.net>
References: <AANLkTim6p641hc8OWudCtSiagwi1rC6n9ymjbUBJxDLQ@mail.gmail.com>
 <AANLkTi=QA5n0pXNzFGtHYY7n0tb0TgwskDZVM-1H=RM0@mail.gmail.com>
 <AANLkTinPPeOwQ=DM4U+3OOF9iNUHLsPkeMtP8wGYj+2y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42494 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0IXFSM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Sep 2010 01:18:12 -0400
In-Reply-To: <AANLkTinPPeOwQ=DM4U+3OOF9iNUHLsPkeMtP8wGYj+2y@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: DongJin Lee <dongjin.lee@auckland.ac.nz>
Cc: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

On Fri, 24 Sep 2010, DongJin Lee wrote:
> > Wow, these levels seem oddly slow. What filesystem are those disks running?
> > What tool are you using to test IOPS, and what's your network setup?
> > If you can move the journal onto a separate device it will help.
> > -Greg
> >
> 
> I have changed the OSD to SSD (OCZ Vertex2)
> To simplify the problem, only one OSD is used,
> so now,  3 PCs  - 1OSD, 1MDS, 1MON (all similar spec, except the OSD's
> 1TB disk replaced with 60GB SSD), using btrfs
> all connected to 1G/s managed switch. Iperf gives about 980Mb/s
> 
> I ran dbench, on the OSD PC.
> Local vs /ceph
> 
> using dbench -t 10 100 -D /data/osd0/
> -  gives 150MB/s, good and as expected.
> 
> using dbench -t 10 100 -D /ceph
> -  gives 15MB/s

The dbench workload is metadata intensive, and most metadata (update) 
operations require a round trip to the MDS.  The client/mds protocol is 
pretty aggressive about issueing leases to the client, but that only goes 
so far.  Metadata performance will never be as fast as a local fs for a 
single process.

> Also, I often get errors from dbench while benchmarking (only when
> /ceph mounts, not elsewhere)
> 
> [323] unlink '/media/cephlocal/clients/client25/~dmtmp/WORD/CHAP10.DOC'
> failed - No such file or directory
>   52  cleanup  14 sec
>   39  cleanup  15 sec
> [323] unlink '/media/cephlocal/clients/client24/~dmtmp/WORDPRO/NEWS1_1.LWP'
> failed - No such file or directory
> [323] unlink '/media/cephlocal/clients/client91/~dmtmp/WORD/CHAP10.DOC'
> failed - No such file or directory
> [323] unlink '/media/cephlocal/clients/client27/~dmtmp/WORDPRO/RESULTS.XLS'
> failed - No such file or directory
> 
> and
> 
> [31] open /media/cephlocal/clients/client258/filler.001 failed for
> handle 9939 (No such file or directory)
> [31] open /media/cephlocal/clients/client220/filler.001 failed for
> handle 9939 (No such file or directory)
> [111] open /media/cephlocal/clients/client218/~dmtmp/WORD failed for
> handle 9943 (No such file or directory)
> [91] open /media/cephlocal/clients/client986/filler.004 failed for
> handle 9942 (No such file or directory)

What version of the client are you running?  I was hitting this (or a 
similar) problem with the dbench workload a couple weeks ago and it turned 
out to be a long standing bug in fs/namei.c that has finally (finally!) 
been fixed in 2.6.36-rc2 (2e2e88ea).  I hadn't seen it actually come up 
for over a year, so something must have changed with the kclient or MDS 
recently that made the bug happen, but in any case it's fixed now.

sage
