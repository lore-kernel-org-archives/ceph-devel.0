From: "wido@42on.com" <wido@42on.com>
Subject: Re: OSD public / cluster network isolation using VRF:s
Date: Thu, 3 Dec 2015 22:03:19 +0100
Message-ID: <422901884.211767.1449176599032.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
References: <1449173601.2291.84.camel@millnert.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:52033 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839AbbLCVDW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 16:03:22 -0500
In-Reply-To: <1449173601.2291.84.camel@millnert.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Millnert <martin@millnert.se>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



> Op 3 dec. 2015 om 21:14 heeft Martin Millnert <martin@millnert.se> het volgende geschreven:
> 
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

Why all the trouble and complexity? I personally always try to avoid the two networks and run with one. Also in large L3 envs.

I like the idea that one machine has one IP I have to monitor.

I would rethink about what a cluster network really adds. Imho it only adds complexity.


> This would work for a process such as the 'mon', which only lives in the
> public network.
> 
> But it doesn't work for the OSD, which uses separate sockets for public
> and cluster networks.
> 
> There is however a real simple solution:
> 1. Use something similar to 
>   setsockopt(sockfd, SOL_SOCKET, SO_MARK, puborclust_val, sizeof(one))
>   (untested)
> 2. set up "ip rule" for outbound traffic to select an appropriate route
> table based on the MARK value of "puborclust_val" above.
> 
> AFAIK BSD doesn't have SO_MARK specifically, but this is a quite simple
> option that adds a lot of utility for us, and, I imagine others.
> 
> I'm willing to write it and test it too. But before doing that, I'm
> interested in feedback. Would obviously prefer it to be merged.
> 
> Regards,
> Martin Millnert
> 
> [1] https://lwn.net/Articles/632522/
> [2] https://www.kernel.org/doc/Documentation/networking/vrf.txt
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
