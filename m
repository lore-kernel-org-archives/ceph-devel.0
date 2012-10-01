From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Slow ceph fs performance
Date: Mon, 01 Oct 2012 11:43:05 -0500
Message-ID: <5069C819.7000004@inktank.com>
References: <201210011541.q91FfI4K017753@ayesha.phys.virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62565 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623Ab2JAQnG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Oct 2012 12:43:06 -0400
Received: by ieak13 with SMTP id k13so12587666iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Oct 2012 09:43:05 -0700 (PDT)
In-Reply-To: <201210011541.q91FfI4K017753@ayesha.phys.virginia.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: bryan@Virginia.EDU
Cc: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>, ceph-devel@vger.kernel.org

On 10/01/2012 10:41 AM, Bryan K. Wright wrote:
> Hi again,
>

Hello!

> 	I've fiddled around a lot with journal settings, so
> to make sure I'm comparing apples to apples, I went back and
> systematically re-ran the benchmark tests I've been running
> (and some more).  A long data dump follows, but the end result
> is that it does look like something fishy is going on for small
> file sizes.  For example, performance difference between 4MB
> and 4KB files in the rados write benchmark is a factor of 25 or
> more. Here are the details, with a recap of the configuration
> at the end.
>

Probably one of the most important things to think about when dealing 
with small IOs on spinning disks is how well the operating system / file 
system combine small writes into larger ones.  With spinning disks you 
get so few iops to work with that your throughput is almost entirely 
governed by seek behavior.  There are many possible reasons for slow 
performance, but this should always be something you keep in mind during 
your tests.

> 	I started out by remaking the underlying xfs filesystems
> on the OSD hosts, and then rerunning mkcephfs.  The journals
> are 120 GB SSDs.
>
> 	First, the rsync tests again:
>
> * Rsync of ~60 GB directory tree (mostly small files) from ceph client
>    to mounted cephfs goes at about 5.2 MB/s.
>

When you were doing this, what kind of results did collectl give you for 
average write sizes to the underlying OSD disks?

> * I then turned off ceph (service ceph -a stop) and did the same
>    rsync between the same two hosts, onto the same RAID array on
>    one of the OSD hosts, but using ssh this time.   This time it
>    goes at about 37 MB/s.
>
> This implies to me that the slowdown is somewhere in ceph, not in
> the RAID array or the network connectivity.
>

There's multiple issues potentially here.  Part of it might be how 
writes are coalesced by XFS in each scenario.  Part of it might also be 
overhead due to XFS metadata reads/writes.  You could probably get a 
better idea of both of these by running blktrace during the tests and 
making seekwatcher movies of the results.  You not only can look at the 
numbers of seeks, but also the kind (read/writes) and where on the disk 
they are going.  That, and some of the raw blktrace data can give you a 
lot of information about what is going on and whether or not seeks are 
related to metadata.

Beyond that, I do think you are correct in suspecting that there are 
some Ceph limitations as well.  Some things that may be interesting to try:

- 1 OSD per Disk
- Multiple OSDs on the RAID array.
- Increasing various thread counts
- Increasing various op and byte limits (such as 
journal_max_write_entries and journal_max_write_bytes).
- EXT4 or BTRFS under the OSDs.

> 	I then remade the xfs filessytems again, re-ran mkcephfs,
> restarted ceph and did some rados benchmarks.
>
> * rados bench -p pbench 900 write -t 256 -b 4096
> Total time run:         900.184096
> Total writes made:      1052511
> Write size:             4096
> Bandwidth (MB/sec):     4.567
>
> Stddev Bandwidth:       4.34241
> Max bandwidth (MB/sec): 23.1719
> Min bandwidth (MB/sec): 0
> Average Latency:        0.218949
> Stddev Latency:         0.566181
> Max latency:            9.92952
> Min latency:            0.001449
>

XFS does pretty poorly with RADOS bench at small IO sizes from what I've 
seen.  EXT4 and BTRFS tend to do better, but probably not more than 2-3 
times better.

>
> * rados bench -p pbench 900 write -t 256 (default 4MB size)
> Total time run:         900.816140
> Total writes made:      25263
> Write size:             4194304
> Bandwidth (MB/sec):     112.178
>
> Stddev Bandwidth:       27.1239
> Max bandwidth (MB/sec): 840
> Min bandwidth (MB/sec): 0
> Average Latency:        9.08281
> Stddev Latency:         0.505372
> Max latency:            9.31865
> Min latency:            0.818949
>

I imagine your Max throughput for 4MB IOs is being limited by the 
network here.  You may be able to get higher aggregate performance by 
running rados bench on multiple clients concurrently.

> 	I repeated each of these benchmarks three times, but saw
> similar results each time (a factor of 25 or more in speed between
> small and large object sizes).
>
> 	Next, I stopped ceph and took a look at local RAID
> performance as a function of file size using "iozone":
>
> http://ayesha.phys.virginia.edu/~bryan/iozone-write-local-raid.pdf
>
> Then I re-made the ceph filesystem and restarted ceph, and used
> iozone on the ceph client to look at the mounted ceph filesystem:
>
> http://ayesha.phys.virginia.edu/~bryan/iozone-write-cephfs.pdf
>

Do you happen to have the settings you used when you ran these tests?  I 
probably don't have time to try to repeat them now, but I can at least 
take a quick look at them.

> I'm not sure how to interpret the iozone performance numbers,
> but the distribution certainly looks much less uniform across
> different file and chunk sizes for the mounted ceph filesystem.
>

Indeed.  Some of that is to be expected just because of the increased 
complexity and number of ways that things can get backed up in a 
distributed system like Ceph.  Having said that, the trench in the 
middle of the Ceph distribution is interesting.  I wouldn't mind digging 
into that more.

I'm slightly confused by the labels on the graph.  They can't possibly 
mean that 2^16384 KB record sizes were tested.  Was that just up to 16MB 
records and 16GB files?  That would make a lot more sense.

> 	Finally, I took a look at the results of bonnie++
> benchmarks for I/O directly to the RAID array, or to the
> mounted ceph filesystem.
>
> * Looking at RAID array from one of the OSD hosts:
> Version  1.96       ------Sequential Output------ --Sequential Input- --Random-
> Concurrency   1     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> RAID on OSD  23800M  1155  99 318264  26 132959  19  2884  99 293464  20 535.4  23
> Latency              7354us   30955us     129ms    8220us     119ms   62188us
> Version  1.96       ------Sequential Create------ --------Random Create--------
> RAID on OSD         -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
>                files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>                   16 17680  58 +++++ +++ 26994  78 24715  81 +++++ +++ 26597  78
> Latency               113us     105us     153us     109us      15us      94us
>
> * Looking at the mounted ceph filesystem from the ceph client:
> Version  1.96       ------Sequential Output------ --Sequential Input- --Random-
> Concurrency   1     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> cephfs, client  16G  1101  95 114623   8 45713   2  2665  98 133537   3 882.0  14
> Latency             44515us   37018us    6437ms   12747us     469ms   60004us
> Version  1.96       ------Sequential Create------ --------Random Create--------
> cephfs, client      -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
>                files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>                   16   653   3 19886   9   601   3   746   3 +++++ +++   585   2
> Latency              1171ms    7467us     174ms     104ms      19us     228ms
>
> 	This seems to show about a factor of 3 difference in speed between
> writing to the mounted ceph filesystem and writing directly to the RAID
> array.

This might be a dumb question, but was the ceph version of this test on 
a single client on gigabit Ethernet?  If so, wouldn't that be the reason 
you are maxing out at like 114MB/s?

>
> 	While I was doing these, I kept an eye on the OSDs and MDSs
> with collectl and atop, but I didn't see anything that looked
> like an obvious problem.  The MDSs didn't see very high CPU, I/O
> or memory usage, for example.
>
> 	Finally, to recap the configuration:
>
> 3 MDS hosts
> 4 OSD hosts, each with a RAID array for object storage and an SSD journal
> xfs filesystems for the object stores
> gigabit network on the front end, and a separate back end gigabit network for the ceph hosts.
> 64-bit CentOS 6.3 and ceph 0.48.2 everywhere
> ceph servers running stock CentOS 2.6.32-279.9.1 kernel.
> client running "elrepo" 3.5.4-1 kernel.
>
> 						Bryan
>

Mark
