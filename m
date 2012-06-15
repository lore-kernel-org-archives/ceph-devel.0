From: Sage Weil <sage@inktank.com>
Subject: Re: RBD speed vs threads
Date: Fri, 15 Jun 2012 09:33:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206150931440.4551@cobra.newdream.net>
References: <4FDACEAA.8080306@profihost.ag> <4FDB24A0.8000401@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38503 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261Ab2FOQd7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 12:33:59 -0400
In-Reply-To: <4FDB24A0.8000401@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 15 Jun 2012, Mark Nelson wrote:
> On 06/15/2012 12:56 AM, Stefan Priebe - Profihost AG wrote:
> > Hello list,
> > 
> > i still don't understand why the speed of the rados bench depends so
> > heavily on the threads.
> > 
> > Right now i get around 100MB/s per thread. So 1 thread is 100MB/s, 4
> > Threads 400MB/s and 16 threads results an about 1100MB/s.
> > 
> > So 1100MB/s is great but i still don't get why 1 thread gets "only"
> > 100MB/s.

The one other thing worth mentioning here is that "thread" is really a 
misnomer.  Rados bench is actually dispatching it's IO asynchronously from 
a single thread, and the -t option is really controlling the number of 
IO's in flight.  That is more or less what you get if you have N threads 
doing a single synchronous IO each, which is why the option is called 
that.

sage


> > 
> > Total time run: 30.037374
> > Total writes made: 8326
> > Write size: 4194304
> > Bandwidth (MB/sec): 1108.752
> > 
> > Stddev Bandwidth: 47.5612
> > Max bandwidth (MB/sec): 1152
> > Min bandwidth (MB/sec): 948
> > Average Latency: 0.0577107
> > Stddev Latency: 0.020784
> > Max latency: 0.382413
> > Min latency: 0.026057
> > 
> > Stefan
> 
> Hi Stefan,
> 
> Let me preface this by saying that I haven't specifically read through the
> rados bench code.  Having said that, the basic idea here is that you have a
> pipeline where a request is sent from the client to an OSD.  If you specify
> "-t 1", the client will only send a single request at a time, which means that
> the entire process is serial and you are entirely latency bound.  Now think
> about what happens when the client sends the request.  Before client gets an
> acknowledgement, the request must:
> 
> 1) Go through client side processing.
> 2) Travel over the IP network to the destination OSD.
> 3) Go through all of the queue processing code on the OSD.
> 4a) Write the data to the journal (Or the faster of the journal/data disk when
> using btrfs.  Note: The journal writes may stall if the data disk is too slow
> and the journal has gotten sufficiently ahead of it)
> 4b) Complete replication to other OSDs based on the pool's replication level
> and the placement group the data gets put in. (basically steps 1,2,3,4a and 5
> all over again with the OSD as the client).
> 5) Send the Ack back to the client over the IP network
> 
> If only one request is sent at a time, most of the hardware will sit idle
> while the request is making it's way through the pipeline.  If you have
> multiple concurrent requests, the OSD(s) can better utilize all of the
> hardware (ie some requests can be coming in over the network, while others can
> be writing to disk, while others can be replicating).
> 
> You can probably imagine that once you have multiple OSDs on multiple Nodes,
> having concurrent requests in flight help you even more.
> 
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
