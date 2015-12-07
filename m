From: Sage Weil <sage@newdream.net>
Subject: Re: OSD public / cluster network isolation using VRF:s
Date: Mon, 7 Dec 2015 06:10:56 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512070608030.25269@cobra.newdream.net>
References: <1449173601.2291.84.camel@millnert.se> <422901884.211767.1449176599032.JavaMail.open-xchange@ox03.mail.pcextreme.nl> <alpine.DEB.2.00.1512031326331.19170@cobra.newdream.net> <1449495663.29564.118.camel@millnert.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54852 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457AbbLGOK5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Dec 2015 09:10:57 -0500
In-Reply-To: <1449495663.29564.118.camel@millnert.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Millnert <martin@millnert.se>
Cc: "wido@42on.com" <wido@42on.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 7 Dec 2015, Martin Millnert wrote:
> > Note that on a largish cluster the public/client traffic is all 
> > north-south, while the backend traffic is also mostly north-south to the 
> > top-of-rack and then east-west.  I.e., within the rack, almost everything 
> > is north-south, and client and replication traffic don't look that 
> > different.
> 
> This problem domain is one of the larger challenges. I worry about
> network timeouts for critical cluster traffic in one of the clusters due
> to hosts having 2x1GbE. I.e. in our case I want to
> prioritize/guarantee/reserve a minimum amount of bandwidth for cluster
> health traffic primarily, and secondarily cluster replication. Client
> write replication should then be least prioritized.

One word of caution here: the health traffic should really be the 
same path and class of service as the inter-osd traffic, or else it 
will not identify failures.  e.g., if the health traffic is prioritized, 
and lower-priority traffic is starved/dropped, we won't notice.
 
> To support this I need our network equipment to perform the CoS job, and
> in order to do that at some level in the stack I need to be able to
> classify traffic. And furthermore, I'd like to do this with as little
> added state as possible.

I seem to recall a conversation a year or so ago about tagging 
stream/sockets so that the network layer could do this.  I don't think 
we got anywhere, though...

sage

