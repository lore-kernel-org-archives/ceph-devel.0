From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: OSDMap partitioning
Date: Mon, 18 Apr 2016 16:02:01 -0400 (EDT)
Message-ID: <387701643.14364473.1461009721370.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.11.1604180945280.4797@cpach.fuggernut.com> <20160418174305.GA22875@ultraspiritum.redhat.com> <alpine.DEB.2.11.1604181423420.4797@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:43576 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbcDRUCD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 16:02:03 -0400
In-Reply-To: <alpine.DEB.2.11.1604181423420.4797@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "Adam C. Emerson" <aemerson@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi,

----- Original Message -----

> > Second, I've always been working under the assumption that placement
> > is a function of workload as well as hardware. At least there's a lot
> > of interesting space in the 'placement function choice'/'workload
> > optimization' intersection.

A lot of the CohortFS work after incorporating Ceph was indeed about adapting
Ceph abstractions to provide first-class support for workload and tenant isolation,
it is for me difficult to imagine not needing this in a system that addresses the
problems Ceph does, at the intended scale.

> 
> Hmm, this is true.  I've been assuming the workload-informed placement
> would be a tier, not something within a pool.  The fundamental rados
> property is that the map is enough to find your data... by it's *name*.
> The moment the placement depends on who wrote 'foo' (and not the name of
> 'foo') that doesn't work.

Tiers are great, but they represent another compositional primitive, not
an alternative to an ability to fundamentally construct the data/server
aggregate 

In addition to workload, there is isolation.  While geopolitical/regulatory
scale segregation is important in cloud, more fine-grained isolation of
all different kinds is important for policy contorl within data centers.

I'm restricting myself to just a few points in this discussion for now, I
am transiting an airport.

Regards,

Matt

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
