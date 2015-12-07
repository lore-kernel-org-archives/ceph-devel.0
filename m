From: Martin Millnert <martin@millnert.se>
Subject: Re: OSD public / cluster network isolation using VRF:s
Date: Mon, 07 Dec 2015 14:36:09 +0100
Message-ID: <1449495369.29564.113.camel@millnert.se>
References: <1449173601.2291.84.camel@millnert.se>
	 <CAJ4mKGZvgaEtLF=EX0t_74KS4-yxFMmR4oJUUx7YZhpXb-9EeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncis.millnert.se ([185.19.66.196]:44741 "EHLO mail.millnert.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102AbbLGNgK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Dec 2015 08:36:10 -0500
In-Reply-To: <CAJ4mKGZvgaEtLF=EX0t_74KS4-yxFMmR4oJUUx7YZhpXb-9EeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Greg,

see below.

On Thu, 2015-12-03 at 13:25 -0800, Gregory Farnum wrote:
> On Thu, Dec 3, 2015 at 12:13 PM, Martin Millnert <martin@millnert.se> wrote:
> > Hi,
> >
> > we're deploying Ceph on Linux for multiple purposes.
> > We want to build network isolation in our L3 DC network using VRF:s.
> >
> > In the case of Ceph this means that we are separating the Ceph public
> > network from the Ceph cluster network, in this manner, into separate
> > network routing domains (for those who do not know what a VRF is).
> >
> > Furthermore, we're also running (per-VRF) dynamically routed L3 all the
> > way to the hosts (OSPF from ToR switch), and need to separate route
> > tables on the hosts properly. This is done using "ip rule" today.
> > We use VLANs to separate the VRF:s from each other between ToR and
> > hosts, so there is no problem to determine which VRF an incoming packet
> > to a host belongs to (iif $dev).
> >
> > The problem is selecting the proper route table for outbound packets
> > from the host.
> >
> > There is current work in progress for a redesign [1] of the old VRF [2]
> > design in the Linux Kernel. At least in the new design, there is an
> > intended way of placing processes within a VRF such that, similar to
> > network namespaces, the processes are unaware that they are in fact
> > living within a VRF.
> >
> > This would work for a process such as the 'mon', which only lives in the
> > public network.
> >
> > But it doesn't work for the OSD, which uses separate sockets for public
> > and cluster networks.
> >
> > There is however a real simple solution:
> > 1. Use something similar to
> >    setsockopt(sockfd, SOL_SOCKET, SO_MARK, puborclust_val, sizeof(one))
> >    (untested)
> > 2. set up "ip rule" for outbound traffic to select an appropriate route
> > table based on the MARK value of "puborclust_val" above.
> >
> > AFAIK BSD doesn't have SO_MARK specifically, but this is a quite simple
> > option that adds a lot of utility for us, and, I imagine others.
> >
> > I'm willing to write it and test it too. But before doing that, I'm
> > interested in feedback. Would obviously prefer it to be merged.
> 
> I'm probably just being dense here, but I don't quite understand what
> all this is trying to accomplish. It looks like it's essentially
> trying to set up VLANs (with different rules) over a single physical
> network interface, that is still represented to userspace as a single
> device with a single IP. Is that right?

That's almost what it is, with two differences:
 1) there are separated route tables per VLAN,
 2) Each VLAN interface (public, cluster) has its own address. 

With separate route tables,  there's a general problem of picking the
correct table on outbound connections.

> What's the point of doing that with Ceph?

Classification & prioritization of ceph network traffic. In our case,
prioritization of cluster traffic over client traffic. See my email to
Wido.

/Martin

