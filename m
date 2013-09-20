From: Sage Weil <sage@inktank.com>
Subject: Re: Object Write Latency
Date: Fri, 20 Sep 2013 08:34:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309200830040.25752@cobra.newdream.net>
References: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57655 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab3ITPeS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Sep 2013 11:34:18 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 20 Sep 2013, Andreas Joachim Peters wrote:
> Hi, 
> 
> 
> we made some benchmarks about object read/write latencies on the CERN ceph installation.
> 
> The cluster has 44 nodes and ~1k disks, all on 10GE and the pool configuration has 3 copies. 
> Client & Server is 0.67.
> 
> The latencies we observe (using tiny objects ... 5 bytes) on the idle pool:
> 
> write full object(sync) ~65-80ms
> append to object ~60-75ms
> set xattr object ~65-80ms
> lock object ~65-80ms
> stat object ~1ms

How are the individual OSDs configured?  Are they purely HDD's with a 
journal partition, or is there an SSD journal?  If it's pure HDD, this 
will be a signnificant source of latency.

That said, Dieter just recently pointed out to me that he's observing 
significant time in a request turnaround (single request, 1 request in 
flight) that is not be related to the storage backend.  I've been 
traveling this week and haven't had time to look into it yet.  Tracking 
this down should just be a matter of turning up the logs and looking 
carefully at the timestamps to see where things are being delayed.

> We seem to saturate the pools writing ~ 20k objects/s (= internally 60k/s).
> 
> Is there an easy explanation for 80 ms (quasi without payload) and a possible tuning to reduce that?
> I measured (append few bytes +fsync) on such a disk around 33ms which explains probably part of the latency.
> 
> Then I tried with the async API to see if there is a difference in the 
> measurement between wait_for_complete or wait_for_safe ... shouldn't 
> wait_for_complete be much shorter, but I get always comparable results 
> ...

If you are using XFS or ext4 on teh backend, the OSD is doing write-ahead 
journaling, which means that in reality the commit happens before the op 
is applied to the fs and is readable.  (The 'commit/ondisk' reply implies 
an ack so the OSD has some internal locking to maintain this illusion from 
the client's perspective.)

sage
