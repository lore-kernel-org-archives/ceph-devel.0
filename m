From: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>
Subject: Re: Slow ceph fs performance
Date: Wed, 26 Sep 2012 16:54:41 -0400
Message-ID: <201209262054.q8QKsfwx007341@ayesha.phys.virginia.edu>
References: <50631E97.5050100@inktank.com>
Reply-To: bryan@Virginia.EDU
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ayesha.phys.Virginia.EDU ([128.143.102.43]:37205 "EHLO
	ayesha.phys.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645Ab2IZUyn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Sep 2012 16:54:43 -0400
In-reply-to: Your message of "Wed, 26 Sep 2012 10:26:15 CDT."
             <50631E97.5050100@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Mark,

	Thanks for your help.  Some answers to your questions
are below.

mark.nelson@inktank.com said:
> On 09/26/2012 09:50 AM, Bryan K. Wright wrote:
> Hi folks,
> Hi Bryan!
> >
> 	I'm seeing reasonable performance when I run rados
> benchmarks, but really slow I/O when reading or writing
> from a mounted ceph filesystem.  The rados benchmarks
> show about 150 MB/s for both read and write, but when I
> go to a client machine with a mounted ceph filesystem
> and try to rsync a large (60 GB) directory tree onto
> the ceph fs, I'm getting rates of only 2-5 MB/s.
> Was the rados benchmark run from the same client machine that the  filesystem
> is being mounted on?  Also, what object size did you use for  rados bench?
> Does the directory tree have a lot of small files or a few  very large ones?

	The rados benchmark was run on one of the OSD 
machines.  Read and write results looked like this (the
objects size was just the default, which seems to be 4kB):

# rados bench -p pbench 900 write
Total time run:         900.549729
Total writes made:      33819
Write size:             4194304
Bandwidth (MB/sec):     150.215 

Stddev Bandwidth:       16.2592
Max bandwidth (MB/sec): 212
Min bandwidth (MB/sec): 84
Average Latency:        0.426028
Stddev Latency:         0.24688
Max latency:            1.59936
Min latency:            0.06794

# rados bench -p pbench 900 seq
Total time run:        900.572788
Total reads made:     33676
Read size:            4194304
Bandwidth (MB/sec):    149.576 

Average Latency:       0.427844
Max latency:           1.48576
Min latency:           0.015371

	Regarding the rsync test, yes, the directory tree
was mostly small files.

> >
> 	The OSDs and MDSs are all running 64-bit CentOS 6.3
> with the stock CentOS 2.6.32 kernel.  The client is also
> 64-bit CentOS 6.3, but it's running the "elrepo" 3.5.4 kernel.
> There are four OSDs, each with a hardware RAID 5 array
> and an SSD for the OSD journal.  The primary network
> is a gigabit network, and the OSD, MDS and MON
> machines have a dedicated backend gigabit network on a
> second network interface. >
> 	Locally on the OSD, "hdparm -t -T" reports read rates
> of ~350 MB/s, and bonnie++ shows: >
> Version  1.96       ------Sequential Output------ --Sequential Input-
> --Random-
> Concurrency   1     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
> --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec
> %CP
> osd-local    23800M  1037  99 316048  92 131023  19  2272  98 312781  21 521.0
>  24
> Latency             13103us     183ms     123ms   15316us     100ms   75899us
> Version  1.96       ------Sequential Create------ --------Random
> Create--------
> osd-local           -Create-- --Read--- -Delete-- -Create-- --Read---
> -Delete--
>                files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec
> %CP
>                   16 16817  55 +++++ +++ 28786  77 23890  78 +++++ +++ 27128
> 75
> Latency             21549us     105us     134us     902us      12us     104us >
>  >
> 	While rsyncing the files, the ceph logs show lots
> of warnings of the form: >
> [WRN] : slow request 91.848407 seconds old, received at 2012-09-26
> 09:30:52.252449: osd_op(client.5310.1:56400 1000026eda0.00001ec8 [write
> 2093056~4096] 0.aa047db8 snapc 1=[]) currently waiting for sub ops >
> 	Snooping on traffic with wireshark shows bursts of
> activity separated by long periods (30-60 sec) of idle time. >

> My guess here is that if there is a lot of small IO happening, your SSD
> journal is handling it well and probably writing data really quickly,  while
> your spinning disk raid5 probably can't sustain anywhere near the  required
> IOPs to keep up.  So you get a burst of network traffic and the  journal
> writes it to the SSD quickly until it is filled up, then the OSD  stalls while
> it waits for the raid5 to write data out.  Whenever the  journal flushes, a
> new burst of traffic comes in and the process repeats.

	That sure sounds reasonable.  Maybe I can play some more
with the journal size and location to see how it affects the
speed and burstyness.

> 	My first thought was that I was seeing a kind of
> "bufferbloat". The SSDs are 120 GB, so they could easily contain
> enough data to take a long time to dump.  I changed to using a
> journal file, limited to 1 GB, but I still see the same slow
> behavior. >
> 	Any advice about how to go about debugging this would
> be appreciated.

> It'd probably be useful to look at the write sizes going to disk.  Increasing
> debugging levels in the Ceph logs will give you that, but it  can be a lot to
> parse.  You can also use something like iostat or  collectl to see what the
> per-second average write sizes are.

	I'll see what I can find out.  Here's a quick output
from iostat (on one of the OSD hosts) while an rsync was running:

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.23    0.00    0.20    0.21    0.00   99.36

Device:            tps   Blk_read/s   Blk_wrtn/s   Blk_read   Blk_wrtn
sdm               0.96         5.82        19.94    4523588   15495690
sdn               9.96         1.51      1080.91    1174143  839900311
sdb               0.00         0.00         0.00       2248          0
sdc               0.00         0.00         0.00       2248          0
sde               0.00         0.00         0.00       2248          0
sda               0.00         0.00         0.00       2248          0
sdf               0.00         0.00         0.00       2248          0
sdi               0.00         0.00         0.00       2248          0
sdl               0.00         0.00         0.00       2248          0
sdg               0.00         0.00         0.00       2248          0
sdj               0.00         0.00         0.00       2248          0
sdh               0.00         0.00         0.00       2248          0
sdd               0.00         0.00         0.00       2248          0
sdk               0.00         0.00         0.00       2248          0
dm-0              0.00         0.00         0.00       2616          0
dm-1              2.14         5.81        19.80    4512994   15387832
sdo              96.83       305.85      3156.74  237658672 2452896474
dm-2              0.00         0.00         0.00        800         48

	The relevant lines are "sdo", which is the RAID array where
the object store lives, and "sdn", which is the journal SSD.
	

> >
> 					Thanks,
> 					Bryan >

> Mark 




-- 
========================================================================
Bryan Wright              |"If you take cranberries and stew them like 
Physics Department        | applesauce, they taste much more like prunes
University of Virginia    | than rhubarb does."  --  Groucho 
Charlottesville, VA  22901|			
(434) 924-7218            |         bryan@virginia.edu
========================================================================


