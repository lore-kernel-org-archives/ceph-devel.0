From: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>
Subject: Re: Slow ceph fs performance
Date: Thu, 27 Sep 2012 11:16:20 -0400
Message-ID: <201209271516.q8RFGKwu023698@ayesha.phys.virginia.edu>
References: <201209262054.q8QKsfwx007341@ayesha.phys.virginia.edu>
Reply-To: bryan@Virginia.EDU
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ayesha.phys.Virginia.EDU ([128.143.102.43]:57829 "EHLO
	ayesha.phys.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733Ab2I0PQV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 11:16:21 -0400
Received: from ayesha.phys.virginia.edu (localhost [127.0.0.1])
	by ayesha.phys.virginia.edu (8.14.4/8.14.4) with ESMTP id q8RFGKwu023698
	for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 11:16:20 -0400
In-reply-to: Your message of "Wed, 26 Sep 2012 16:54:41 EDT."
             <201209262054.q8QKsfwx007341@ayesha.phys.virginia.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks,

	I'm still struggling to get decent performance out of
cephfs.  I've played around with journal size and location,
but I/O rates to the mounted ceph filesystem always hover in
the range of 2-6 MB/sec while rsyncing a large directory tree
onto the ceph fs.  In contrast, using rsync over ssh to copy
the same tree on to the same RAID array on one of the OSDs gives
a rate of about 34 MB/sec.

	Here's a time/sequence plot from wireshark showing
what the traffic looks like from the client's perspective
while rsyncing onto the ceph fs:

http://ayesha.phys.virginia.edu/~bryan/time-sequence-ceph-2.png

As you can see, most of the time is spent in long
waits between bursts of packets.  Using a small journal file
instead of a whole SSD seems to slightly reduce the delays,
but not by much.  What other tunable parameters should I be 
trying?

	Looking at outgoing network rates on the client
with iptraf, I see the following while rsyncing over ssh:

	Rate: ~300Mb/s, ~8k packets/s --> ~40kb/packet

While rsyncing to the ceph fs, I see:

	Rate: ~50Mb/s, ~1k packets/s --> ~50kb/packet

(i.e., the average packet size is about the same, but
about eight times fewer packets are being sent per unit
time.)

	Looking at ops in flight on one of the OSDs,
using "ceph --admin-daemon /var/run/ceph/ceph-osd.1.asok
dump_ops_in_flight", I see:

{ "num_ops": 3,
  "ops": [
        { "description": "pg_log(0.8 epoch 12 query_epoch 12)",
          "received_at": "2012-09-27 10:54:08.070493",
          "age": "66.673834",
          "flag_point": "delayed"},
        { "description": "pg_log(1.7 epoch 12 query_epoch 12)",
          "received_at": "2012-09-27 10:54:08.070715",
          "age": "66.673612",
          "flag_point": "delayed"},
        { "description": "pg_log(2.6 epoch 12 query_epoch 12)",
          "received_at": "2012-09-27 10:54:08.070750",
          "age": "66.673577",
          "flag_point": "delayed"}]}

	Thanks for any advice.

					Bryan



bkw1a@ayesha.phys.virginia.edu said:
> Hi folks,
> 	I'm seeing reasonable performance when I run rados benchmarks, but really
> slow I/O when reading or writing  from a mounted ceph filesystem.  The rados
> benchmarks show about 150 MB/s for both read and write, but when I go to a
> client machine with a mounted ceph filesystem and try to rsync a large (60 GB)
> directory tree onto the ceph fs, I'm getting rates of only 2-5 MB/s.

> 	The OSDs and MDSs are all running 64-bit CentOS 6.3 with the stock CentOS
> 2.6.32 kernel.  The client is also 64-bit CentOS 6.3, but it's running the
> "elrepo" 3.5.4 kernel. There are four OSDs, each with a hardware RAID 5 array
> and an SSD for the OSD journal.  The primary network is a gigabit network, and
> the OSD, MDS and MON  machines have a dedicated backend gigabit network on a
> second network interface.

> 	Locally on the OSD, "hdparm -t -T" reports read rates  of ~350 MB/s, and
> bonnie++ shows:

> Version  1.96       ------Sequential Output------ --Sequential Input-
> --Random- Concurrency   1     -Per Chr- --Block-- -Rewrite- -Per Chr-
> --Block-- --Seeks-- Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec
> %CP K/sec %CP  /sec %CP osd-local    23800M  1037  99 316048  92 131023  19
> 2272  98 312781  21 521.0  24 Latency             13103us     183ms     123ms
>  15316us     100ms   75899us Version  1.96       ------Sequential Create------
> --------Random Create-------- osd-local           -Create-- --Read---
> -Delete-- -Create-- --Read--- -Delete--
>               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec
> %CP
>                  16 16817  55 +++++ +++ 28786  77 23890  78 +++++ +++ 27128
> 75 Latency             21549us     105us     134us     902us      12us
> 104us

> 	While rsyncing the files, the ceph logs show lots of warnings of the form:

> [WRN] : slow request 91.848407 seconds old, received at 2012-09-26
> 09:30:52.252449: osd_op(client.5310.1:56400 1000026eda0.00001ec8 [write
> 2093056~4096] 0.aa047db8 snapc 1=[]) currently waiting for sub ops

> 	Snooping on traffic with wireshark shows bursts of  activity separated by
> long periods (30-60 sec) of idle time.

> 	My first thought was that I was seeing a kind of  "bufferbloat". The SSDs are
> 120 GB, so they could easily contain  enough data to take a long time to dump.
>  I changed to using a  journal file, limited to 1 GB, but I still see the same
> slow behavior.

> 	Any advice about how to go about debugging this would be appreciated.

> 					Thanks,
> 					Bryan



