From: Martin Millnert <martin@millnert.se>
Subject: Re: OSD public / cluster network isolation using VRF:s
Date: Mon, 07 Dec 2015 16:50:14 +0100
Message-ID: <1449503414.29564.163.camel@millnert.se>
References: <1449173601.2291.84.camel@millnert.se>
	 <422901884.211767.1449176599032.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
	 <alpine.DEB.2.00.1512031326331.19170@cobra.newdream.net>
	 <1449495663.29564.118.camel@millnert.se>
	 <alpine.DEB.2.00.1512070608030.25269@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncis.millnert.se ([185.19.66.196]:45618 "EHLO mail.millnert.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755937AbbLGPuU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Dec 2015 10:50:20 -0500
In-Reply-To: <alpine.DEB.2.00.1512070608030.25269@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "wido@42on.com" <wido@42on.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 2015-12-07 at 06:10 -0800, Sage Weil wrote:
> On Mon, 7 Dec 2015, Martin Millnert wrote:
> > > Note that on a largish cluster the public/client traffic is all 
> > > north-south, while the backend traffic is also mostly north-south to the 
> > > top-of-rack and then east-west.  I.e., within the rack, almost everything 
> > > is north-south, and client and replication traffic don't look that 
> > > different.
> > 
> > This problem domain is one of the larger challenges. I worry about
> > network timeouts for critical cluster traffic in one of the clusters due
> > to hosts having 2x1GbE. I.e. in our case I want to
> > prioritize/guarantee/reserve a minimum amount of bandwidth for cluster
> > health traffic primarily, and secondarily cluster replication. Client
> > write replication should then be least prioritized.
> 
> One word of caution here: the health traffic should really be the 
> same path and class of service as the inter-osd traffic, or else it 
> will not identify failures. 

Indeed - complete starvation is never good. We're considering reserving
parts of the bandwidth (Where the class of service implementation in the
networking gear does the job of spending unallocated bandwidth, etc, as
per the whole packet scheduling logic.
TX time slots never go idle if there are non-empty queues.)

Something like: 
 1) "Reserve 5% bandwith to 'osd-mon'
 2) "Reserve 40% bandwidth to 'osd-osd' (repairs when unhealthy)"
 3) "Reserve 30% bandwidth to 'osd-osd' (other)"
 4) "Reserve 25% bandwidth to 'client-osd' traffic"

Our goal is that client traffic *should* lose some packets here and
there when there is more load towards a host than it has bandwidth for,
a little bit more often than it happens to more critical traffic. Health
takes precedence over function, but not on an "all or nothing" basis. I
suppose 2 and 3 may be impossible to distinguish.

But most important of all is, the way I understand Ceph-under-stress,
that we want to actively avoid start flipping OSD's up/down and ending
up with an oscillating/unstable cluster, that starts to move data
around, simply because a host is under pressure (i.e. 100 nodes writing
to 1, and similar scenarios).

> e.g., if the health traffic is prioritized, 
> and lower-priority traffic is starved/dropped, we won't notice.

To truly notice drops - we need information from the network layer,
either host stack side (where we can have it per-socket) or from the
network side, i.e. the switches etc, right?
We'll monitor the different hardware queues in our network devices.
Socket statistics can be received at a host-wide scale from the Linux
network stack, and well, per socket given some modifications to Ceph I
suppose (I push netstat's statistics into influxdb).
(I'm rusty on how/what per-socket metrics can be logged today in vanilla
kernel and assume we need application support.)

The bigger overarching issue for us is what happens under stress in
different situations and how to maximize time spent in state "normal" of
the cluster.

> > To support this I need our network equipment to perform the CoS job, and
> > in order to do that at some level in the stack I need to be able to
> > classify traffic. And furthermore, I'd like to do this with as little
> > added state as possible.
> 
> I seem to recall a conversation a year or so ago about tagging 
> stream/sockets so that the network layer could do this.  I don't think 
> we got anywhere, though...

It'd be interesting to look into what were the ideas back then - I'll
take a look over the archives.

Thanks,
Martin

