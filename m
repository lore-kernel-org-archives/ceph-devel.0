From: Martin Millnert <martin@millnert.se>
Subject: Re: OSD public / cluster network isolation using VRF:s
Date: Mon, 07 Dec 2015 14:41:03 +0100
Message-ID: <1449495663.29564.118.camel@millnert.se>
References: <1449173601.2291.84.camel@millnert.se>
	 <422901884.211767.1449176599032.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
	 <alpine.DEB.2.00.1512031326331.19170@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncis.millnert.se ([185.19.66.196]:44780 "EHLO mail.millnert.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbbLGNlF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Dec 2015 08:41:05 -0500
In-Reply-To: <alpine.DEB.2.00.1512031326331.19170@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "wido@42on.com" <wido@42on.com>, Ceph Development <ceph-devel@vger.kernel.org>

Sage,

thanks for your feedback, please see below:

On Thu, 2015-12-03 at 13:30 -0800, Sage Weil wrote:
> On Thu, 3 Dec 2015, wido@42on.com wrote:
> > Why all the trouble and complexity? I personally always try to avoid the 
> > two networks and run with one. Also in large L3 envs.
> > 
> > I like the idea that one machine has one IP I have to monitor.
> > 
> > I would rethink about what a cluster network really adds. Imho it only 
> > adds complexity.
> 
> FWIW I tend to agree.  There are probably some network deployments where 
> it makes sense, but for most people I think it just adds complexity.  
> Maybe it makes it easy to utilize dual interfaces, but my guess is you're 
> better off bonding them if you can.

I'll add to the response to Wido that in our case it's not separated
physical interfaces. (While providing good QoS, you would lose statmux
gains and redundancy). ToR <-> host in our case is bonded or
equivalent. 

> Note that on a largish cluster the public/client traffic is all 
> north-south, while the backend traffic is also mostly north-south to the 
> top-of-rack and then east-west.  I.e., within the rack, almost everything 
> is north-south, and client and replication traffic don't look that 
> different.

This problem domain is one of the larger challenges. I worry about
network timeouts for critical cluster traffic in one of the clusters due
to hosts having 2x1GbE. I.e. in our case I want to
prioritize/guarantee/reserve a minimum amount of bandwidth for cluster
health traffic primarily, and secondarily cluster replication. Client
write replication should then be least prioritized.

To support this I need our network equipment to perform the CoS job, and
in order to do that at some level in the stack I need to be able to
classify traffic. And furthermore, I'd like to do this with as little
added state as possible.

/Martin

