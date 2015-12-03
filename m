From: Martin Millnert <martin@millnert.se>
Subject: OSD public / cluster network isolation using VRF:s
Date: Thu, 03 Dec 2015 21:13:21 +0100
Message-ID: <1449173601.2291.84.camel@millnert.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncis.millnert.se ([185.19.66.196]:50793 "EHLO mail.millnert.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753588AbbLCUNZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 15:13:25 -0500
Received: from pishuli (dynamic.1.9.c0255cb5b480.f46d4e0fc2a.cust.bredband2.com [31.208.64.196])
	by mail.millnert.se (Postfix) with ESMTPSA id ACE197FF44
	for <ceph-devel@vger.kernel.org>; Thu,  3 Dec 2015 21:14:22 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

we're deploying Ceph on Linux for multiple purposes.
We want to build network isolation in our L3 DC network using VRF:s.

In the case of Ceph this means that we are separating the Ceph public
network from the Ceph cluster network, in this manner, into separate
network routing domains (for those who do not know what a VRF is).

Furthermore, we're also running (per-VRF) dynamically routed L3 all the
way to the hosts (OSPF from ToR switch), and need to separate route
tables on the hosts properly. This is done using "ip rule" today.
We use VLANs to separate the VRF:s from each other between ToR and
hosts, so there is no problem to determine which VRF an incoming packet
to a host belongs to (iif $dev).

The problem is selecting the proper route table for outbound packets
from the host.

There is current work in progress for a redesign [1] of the old VRF [2]
design in the Linux Kernel. At least in the new design, there is an
intended way of placing processes within a VRF such that, similar to
network namespaces, the processes are unaware that they are in fact
living within a VRF.

This would work for a process such as the 'mon', which only lives in the
public network.

But it doesn't work for the OSD, which uses separate sockets for public
and cluster networks.

There is however a real simple solution:
1. Use something similar to 
   setsockopt(sockfd, SOL_SOCKET, SO_MARK, puborclust_val, sizeof(one))
   (untested)
2. set up "ip rule" for outbound traffic to select an appropriate route
table based on the MARK value of "puborclust_val" above.

AFAIK BSD doesn't have SO_MARK specifically, but this is a quite simple
option that adds a lot of utility for us, and, I imagine others.

I'm willing to write it and test it too. But before doing that, I'm
interested in feedback. Would obviously prefer it to be merged.

Regards,
Martin Millnert

[1] https://lwn.net/Articles/632522/
[2] https://www.kernel.org/doc/Documentation/networking/vrf.txt

