From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Performance test on Ceph cluster
Date: Wed, 07 Mar 2012 12:23:55 +0100
Message-ID: <4352803.opIYE8Xzll@pc10>
References: <loom.20120222T102830-526@post.gmane.org> <loom.20120224T062854-915@post.gmane.org> <CAORUGqCJY3Q8uDJLoTeoHPiu9_YpOmE07_ivp28z4L9u0ieRxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:41480 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092Ab2CGLYC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 7 Mar 2012 06:24:02 -0500
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id 93F6B10C866
	for <ceph-devel@vger.kernel.org>; Wed,  7 Mar 2012 12:24:00 +0100 (CET)
In-Reply-To: <CAORUGqCJY3Q8uDJLoTeoHPiu9_YpOmE07_ivp28z4L9u0ieRxg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Freitag, 24. Februar 2012, 10:51:10 schrieb Tommi Virtanen:
> On Fri, Feb 24, 2012 at 00:58, madhusudhana
> <madhusudhana.u.acharya@gmail.com> wrote:
> > 4. If you don't mind, can you please give me a bit of insight on cluster
> > network, what it is and how i can configure one for my ceph cluster ?
> > Will there be a significant performance improvement with this ?
> 
> When a client submits a write to Ceph, it needs to be replicated
> (usually to two replicas). If all the ceph servers have two network
> interfaces, and you have two separate networks you connect the servers
> to, you can make the replication traffic go over the second interface,
> and thus you'll have more available bandwidth between the cluster and
> the clients in the first one.

That sounds really interesting, any pointers on how that can be configured?

As far as I can see, this is going to me I will have to assign to IP addresses 
to each node, one for internal traffic, one for external...

Regards,
	Guido
