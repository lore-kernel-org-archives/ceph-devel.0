From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: RBD speed vs threads
Date: Fri, 15 Jun 2012 22:28:51 +0200
Message-ID: <4FDB9B03.5010306@profihost.ag>
References: <4FDACEAA.8080306@profihost.ag> <4FDB24A0.8000401@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:53272 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757754Ab2FOU2v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 16:28:51 -0400
In-Reply-To: <4FDB24A0.8000401@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 15.06.2012 14:03, schrieb Mark Nelson:
> On 06/15/2012 12:56 AM, Stefan Priebe - Profihost AG wrote:
> Let me preface this by saying that I haven't specifically read through
> the rados bench code.  Having said that, the basic idea here is that you
> have a pipeline where a request is sent from the client to an OSD.  If
> you specify "-t 1", the client will only send a single request at a
> time, which means that the entire process is serial and you are entirely
> latency bound.  Now think about what happens when the client sends the
> request.  Before client gets an acknowledgement, the request must:
>
> 1) Go through client side processing.
> 2) Travel over the IP network to the destination OSD.
> 3) Go through all of the queue processing code on the OSD.
> 4a) Write the data to the journal (Or the faster of the journal/data
> disk when using btrfs.  Note: The journal writes may stall if the data
> disk is too slow and the journal has gotten sufficiently ahead of it)
> 4b) Complete replication to other OSDs based on the pool's replication
> level and the placement group the data gets put in. (basically steps
> 1,2,3,4a and 5 all over again with the OSD as the client).
> 5) Send the Ack back to the client over the IP network
>
> If only one request is sent at a time, most of the hardware will sit
> idle while the request is making it's way through the pipeline.  If you
> have multiple concurrent requests, the OSD(s) can better utilize all of
> the hardware (ie some requests can be coming in over the network, while
> others can be writing to disk, while others can be replicating).
>
> You can probably imagine that once you have multiple OSDs on multiple
> Nodes, having concurrent requests in flight help you even more.

Thanks for your explanation.

Stefan
