From: Jerker Nyberg <jerker@Update.UU.SE>
Subject: Re: distributed cluster
Date: Wed, 30 May 2012 13:47:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205300925290.358@Psilocybe.Update.UU.SE>
References: <Pine.LNX.4.64.1205281117360.358@Psilocybe.Update.UU.SE>
 <CADvuQREnjHmnjOKimy2+FCrJ0yc2zGh6v4gtUtovX=jVDazRsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from Psilocybe.Update.UU.SE ([130.238.19.25]:57179 "EHLO
	Psilocybe.Update.UU.SE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab2E3Lrz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 07:47:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by Psilocybe.Update.UU.SE (Postfix) with ESMTP id 7FD3730080
	for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 13:47:53 +0200 (CEST)
In-Reply-To: <CADvuQREnjHmnjOKimy2+FCrJ0yc2zGh6v4gtUtovX=jVDazRsQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Tue, 29 May 2012, Tommi Virtanen wrote:

> For example: with data replicated over data centers A, B, C, connected
> at 1Gb/s, the fastest all of A will ever handle writes is 0.5Gb/s --
> it'll need to replicate everything to B and C, over that single pipe.
>
> I am aware of a few people building multi-dc Ceph clusters. Some have
> shared their network latency, bandwidth and availability numbers with
> me (confidentially), and at first glance their wide-area network
> performs better than many single-dc networks. They are far above a 1
> gigabit interconnect.

We have currently a mixed 1 Gbit/s and 10 Gbit/s metropolitan network with 
0.5 ms latency between the sites - usually two router hops and a couple of 
switches. Latency in a site over a single router/switch and a few switches 
is 0.1-0.2 ms. Normal ethernet.

If bandwidth is a limiting factor it should not be to hard to bond 
multiple 10 Gbit/s ethernet between the sites that have been upgraded to 
10 Gbit/s.


> I would really recommend you embark on a project like this only if you
> are able to understand the Ceph replication model, and do the math for
> yourself and figure out what your expected service levels for Ceph
> operations would be. (Naturally, Inktank Professional Services will
> help you in your endeavors, though their first response should be
> "that's not a recommended setup".)

I am aware of the replication model. It, together with potentially 
seamless reliability and scalability, makes Ceph interesting.


> The Ceph Distributed File System is not considered production ready yet.

I am waiting as fast as I can for it to be production ready. :-)

Good luck to you all.

--jerker
