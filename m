From: Martin Millnert <martin@millnert.se>
Subject: Re: OSD public / cluster network isolation using VRF:s
Date: Mon, 07 Dec 2015 14:31:48 +0100
Message-ID: <1449495108.29564.108.camel@millnert.se>
References: <1449173601.2291.84.camel@millnert.se>
	 <422901884.211767.1449176599032.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncis.millnert.se ([185.19.66.196]:44711 "EHLO mail.millnert.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755734AbbLGNbw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Dec 2015 08:31:52 -0500
In-Reply-To: <422901884.211767.1449176599032.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "wido@42on.com" <wido@42on.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Wido, 

thanks for your feedback.

On Thu, 2015-12-03 at 22:03 +0100, wido@42on.com wrote:
> 
> > Op 3 dec. 2015 om 21:14 heeft Martin Millnert <martin@millnert.se> het volgende geschreven:
> > 
> > Hi,
> > 
> > we're deploying Ceph on Linux for multiple purposes.
> > We want to build network isolation in our L3 DC network using VRF:s.
<snip>
> Why all the trouble and complexity? I personally always try to avoid
> the two networks and run with one. Also in large L3 envs.
> 
> I like the idea that one machine has one IP I have to monitor.
> 
> I would rethink about what a cluster network really adds. Imho it only
> adds complexity.

There is one main reason behind separation,  i.e. using cluster network:
simple network level traffic classification.

We have machines where we need to be able to guarantee a minimum amount
of osd-osd replication traffic on the network links (CoS). And it seems
like "nice-to-have" feature in general. 
An assumption here is that osd-osd "pinging" would happen on the cluster
network if configured.

A possible workaround I imagine would be if replication and osd-osd,
osd-mon traffic would receive different values in the ToS field than
client traffic. Not immediately obvious to me how one listening socket
would manage the distinction.  

/Martin

