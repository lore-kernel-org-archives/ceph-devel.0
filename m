From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Slow ceph fs performance
Date: Wed, 26 Sep 2012 10:26:15 -0500
Message-ID: <50631E97.5050100@inktank.com>
References: <201209261450.q8QEo40b029136@ayesha.phys.virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:65146 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab2IZP0U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Sep 2012 11:26:20 -0400
Received: by ieak13 with SMTP id k13so1718831iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Sep 2012 08:26:20 -0700 (PDT)
In-Reply-To: <201209261450.q8QEo40b029136@ayesha.phys.virginia.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: bryan@Virginia.EDU
Cc: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>, ceph-devel@vger.kernel.org

On 09/26/2012 09:50 AM, Bryan K. Wright wrote:
> Hi folks,

Hi Bryan!

>
> 	I'm seeing reasonable performance when I run rados
> benchmarks, but really slow I/O when reading or writing
> from a mounted ceph filesystem.  The rados benchmarks
> show about 150 MB/s for both read and write, but when I
> go to a client machine with a mounted ceph filesystem
> and try to rsync a large (60 GB) directory tree onto
> the ceph fs, I'm getting rates of only 2-5 MB/s.

Was the rados benchmark run from the same client machine that the 
filesystem is being mounted on?  Also, what object size did you use for 
rados bench?  Does the directory tree have a lot of small files or a few 
very large ones?

>
> 	The OSDs and MDSs are all running 64-bit CentOS 6.3
> with the stock CentOS 2.6.32 kernel.  The client is also
> 64-bit CentOS 6.3, but it's running the "elrepo" 3.5.4 kernel.
> There are four OSDs, each with a hardware RAID 5 array
> and an SSD for the OSD journal.  The primary network
> is a gigabit network, and the OSD, MDS and MON
> machines have a dedicated backend gigabit network on a
> second network interface.
>
> 	Locally on the OSD, "hdparm -t -T" reports read rates
> of ~350 MB/s, and bonnie++ shows:
>
> Version  1.96       ------Sequential Output------ --Sequential Input- --Random-
> Concurrency   1     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> osd-local    23800M  1037  99 316048  92 131023  19  2272  98 312781  21 521.0  24
> Latency             13103us     183ms     123ms   15316us     100ms   75899us
> Version  1.96       ------Sequential Create------ --------Random Create--------
> osd-local           -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
>                files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>                   16 16817  55 +++++ +++ 28786  77 23890  78 +++++ +++ 27128  75
> Latency             21549us     105us     134us     902us      12us     104us
>
>
> 	While rsyncing the files, the ceph logs show lots
> of warnings of the form:
>
> [WRN] : slow request 91.848407 seconds old, received at 2012-09-26 09:30:52.252449: osd_op(client.5310.1:56400 1000026eda0.00001ec8 [write 2093056~4096] 0.aa047db8 snapc 1=[]) currently waiting for sub ops
>
> 	Snooping on traffic with wireshark shows bursts of
> activity separated by long periods (30-60 sec) of idle time.
>

My guess here is that if there is a lot of small IO happening, your SSD 
journal is handling it well and probably writing data really quickly, 
while your spinning disk raid5 probably can't sustain anywhere near the 
required IOPs to keep up.  So you get a burst of network traffic and the 
journal writes it to the SSD quickly until it is filled up, then the OSD 
stalls while it waits for the raid5 to write data out.  Whenever the 
journal flushes, a new burst of traffic comes in and the process repeats.

> 	My first thought was that I was seeing a kind of
> "bufferbloat". The SSDs are 120 GB, so they could easily contain
> enough data to take a long time to dump.  I changed to using a
> journal file, limited to 1 GB, but I still see the same slow
> behavior.
>
> 	Any advice about how to go about debugging this would
> be appreciated.

It'd probably be useful to look at the write sizes going to disk. 
Increasing debugging levels in the Ceph logs will give you that, but it 
can be a lot to parse.  You can also use something like iostat or 
collectl to see what the per-second average write sizes are.

>
> 					Thanks,
> 					Bryan
>

Mark
