From: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>
Subject: Re: Slow ceph fs performance
Date: Thu, 27 Sep 2012 14:47:30 -0400
Message-ID: <201209271847.q8RIlUO6031265@ayesha.phys.virginia.edu>
References: <50631E97.5050100@inktank.com> <201209262054.q8QKsfwx007341@ayesha.phys.virginia.edu> <CAPYLRziRQxAd_TZZER3XeRpBj+W1xgnYgxphaR+wkMX0C3GbXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ayesha.phys.Virginia.EDU ([128.143.102.43]:36696 "EHLO
	ayesha.phys.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab2I0Src (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 14:47:32 -0400
In-reply-to: <CAPYLRziRQxAd_TZZER3XeRpBj+W1xgnYgxphaR+wkMX0C3GbXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org


greg@inktank.com said:
> >
>         The rados benchmark was run on one of the OSD
> machines.  Read and write results looked like this (the
> objects size was just the default, which seems to be 4kB):
> Actually, that's 4MB. ;) 

	Oops! My plea is that I was the victim of a 
man page bug:

       bench seconds mode [ -b objsize ] [ -t threads ]
              Benchmark  for  seconds.  The  mode  can  be  write or read. The
              default object size is 4 KB, and the default number of simulated
              threads (parallel writes) is 16.


> Can you run # rados bench -p pbench 900 write -t 256
> -b 4096 and see what that gets? It'll run 256 simultaneous 4KB writes. (You
> can also vary the number of simultaneous writes and see if that impacts it.)

	Here's the new benchmark output:

 Total time run:         900.880070
Total writes made:      537187
Write size:             4096
Bandwidth (MB/sec):     2.329 

Stddev Bandwidth:       2.57691
Max bandwidth (MB/sec): 12.6055
Min bandwidth (MB/sec): 0
Average Latency:        0.429315
Stddev Latency:         0.891734
Max latency:            19.7647
Min latency:            0.016743
	

> However, my suspicion is that you're limited by metadata throughput here. How
> large are your files? There might be some MDS or client tunables we can
> adjust, but rsync's workload is a known weak spot for CephFS. -Greg 

	The file size is generally small.  Here's the distribution:

http://ayesha.phys.virginia.edu/~bryan/filesize.png

The mean is about 2.5 MB.

						Bryan

-- 
========================================================================
Bryan Wright              |"If you take cranberries and stew them like 
Physics Department        | applesauce, they taste much more like prunes
University of Virginia    | than rhubarb does."  --  Groucho 
Charlottesville, VA  22901|			
(434) 924-7218            |         bryan@virginia.edu
========================================================================

