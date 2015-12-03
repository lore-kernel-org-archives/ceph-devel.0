From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: OSD public / cluster network isolation using VRF:s
Date: Thu, 3 Dec 2015 13:25:42 -0800
Message-ID: <CAJ4mKGZvgaEtLF=EX0t_74KS4-yxFMmR4oJUUx7YZhpXb-9EeQ@mail.gmail.com>
References: <1449173601.2291.84.camel@millnert.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34991 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbbLCVZn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 16:25:43 -0500
Received: by wmuu63 with SMTP id u63so38613635wmu.0
        for <ceph-devel@vger.kernel.org>; Thu, 03 Dec 2015 13:25:42 -0800 (PST)
In-Reply-To: <1449173601.2291.84.camel@millnert.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Millnert <martin@millnert.se>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Dec 3, 2015 at 12:13 PM, Martin Millnert <martin@millnert.se> wrote:
> Hi,
>
> we're deploying Ceph on Linux for multiple purposes.
> We want to build network isolation in our L3 DC network using VRF:s.
>
> In the case of Ceph this means that we are separating the Ceph public
> network from the Ceph cluster network, in this manner, into separate
> network routing domains (for those who do not know what a VRF is).
>
> Furthermore, we're also running (per-VRF) dynamically routed L3 all the
> way to the hosts (OSPF from ToR switch), and need to separate route
> tables on the hosts properly. This is done using "ip rule" today.
> We use VLANs to separate the VRF:s from each other between ToR and
> hosts, so there is no problem to determine which VRF an incoming packet
> to a host belongs to (iif $dev).
>
> The problem is selecting the proper route table for outbound packets
> from the host.
>
> There is current work in progress for a redesign [1] of the old VRF [2]
> design in the Linux Kernel. At least in the new design, there is an
> intended way of placing processes within a VRF such that, similar to
> network namespaces, the processes are unaware that they are in fact
> living within a VRF.
>
> This would work for a process such as the 'mon', which only lives in the
> public network.
>
> But it doesn't work for the OSD, which uses separate sockets for public
> and cluster networks.
>
> There is however a real simple solution:
> 1. Use something similar to
>    setsockopt(sockfd, SOL_SOCKET, SO_MARK, puborclust_val, sizeof(one))
>    (untested)
> 2. set up "ip rule" for outbound traffic to select an appropriate route
> table based on the MARK value of "puborclust_val" above.
>
> AFAIK BSD doesn't have SO_MARK specifically, but this is a quite simple
> option that adds a lot of utility for us, and, I imagine others.
>
> I'm willing to write it and test it too. But before doing that, I'm
> interested in feedback. Would obviously prefer it to be merged.

I'm probably just being dense here, but I don't quite understand what
all this is trying to accomplish. It looks like it's essentially
trying to set up VLANs (with different rules) over a single physical
network interface, that is still represented to userspace as a single
device with a single IP. Is that right?

What's the point of doing that with Ceph?
-Greg
