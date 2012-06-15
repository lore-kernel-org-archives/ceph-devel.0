From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: RBD speed vs threads
Date: Fri, 15 Jun 2012 07:03:44 -0500
Message-ID: <4FDB24A0.8000401@inktank.com>
References: <4FDACEAA.8080306@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60877 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab2FOMDs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 08:03:48 -0400
Received: by yhmm54 with SMTP id m54so2347701yhm.19
        for <ceph-devel@vger.kernel.org>; Fri, 15 Jun 2012 05:03:48 -0700 (PDT)
In-Reply-To: <4FDACEAA.8080306@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/15/2012 12:56 AM, Stefan Priebe - Profihost AG wrote:
> Hello list,
>
> i still don't understand why the speed of the rados bench depends so
> heavily on the threads.
>
> Right now i get around 100MB/s per thread. So 1 thread is 100MB/s, 4
> Threads 400MB/s and 16 threads results an about 1100MB/s.
>
> So 1100MB/s is great but i still don't get why 1 thread gets "only"
> 100MB/s.
>
> Total time run: 30.037374
> Total writes made: 8326
> Write size: 4194304
> Bandwidth (MB/sec): 1108.752
>
> Stddev Bandwidth: 47.5612
> Max bandwidth (MB/sec): 1152
> Min bandwidth (MB/sec): 948
> Average Latency: 0.0577107
> Stddev Latency: 0.020784
> Max latency: 0.382413
> Min latency: 0.026057
>
> Stefan

Hi Stefan,

Let me preface this by saying that I haven't specifically read through 
the rados bench code.  Having said that, the basic idea here is that you 
have a pipeline where a request is sent from the client to an OSD.  If 
you specify "-t 1", the client will only send a single request at a 
time, which means that the entire process is serial and you are entirely 
latency bound.  Now think about what happens when the client sends the 
request.  Before client gets an acknowledgement, the request must:

1) Go through client side processing.
2) Travel over the IP network to the destination OSD.
3) Go through all of the queue processing code on the OSD.
4a) Write the data to the journal (Or the faster of the journal/data 
disk when using btrfs.  Note: The journal writes may stall if the data 
disk is too slow and the journal has gotten sufficiently ahead of it)
4b) Complete replication to other OSDs based on the pool's replication 
level and the placement group the data gets put in. (basically steps 
1,2,3,4a and 5 all over again with the OSD as the client).
5) Send the Ack back to the client over the IP network

If only one request is sent at a time, most of the hardware will sit 
idle while the request is making it's way through the pipeline.  If you 
have multiple concurrent requests, the OSD(s) can better utilize all of 
the hardware (ie some requests can be coming in over the network, while 
others can be writing to disk, while others can be replicating).

You can probably imagine that once you have multiple OSDs on multiple 
Nodes, having concurrent requests in flight help you even more.

Mark
