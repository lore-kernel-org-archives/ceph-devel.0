From: Sage Weil <sage@newdream.net>
Subject: Re: OSD public / cluster network isolation using VRF:s
Date: Thu, 3 Dec 2015 13:30:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512031326331.19170@cobra.newdream.net>
References: <1449173601.2291.84.camel@millnert.se> <422901884.211767.1449176599032.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36481 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbbLCVaV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 16:30:21 -0500
In-Reply-To: <422901884.211767.1449176599032.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "wido@42on.com" <wido@42on.com>
Cc: Martin Millnert <martin@millnert.se>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 3 Dec 2015, wido@42on.com wrote:
> Why all the trouble and complexity? I personally always try to avoid the 
> two networks and run with one. Also in large L3 envs.
> 
> I like the idea that one machine has one IP I have to monitor.
> 
> I would rethink about what a cluster network really adds. Imho it only 
> adds complexity.

FWIW I tend to agree.  There are probably some network deployments where 
it makes sense, but for most people I think it just adds complexity.  
Maybe it makes it easy to utilize dual interfaces, but my guess is you're 
better off bonding them if you can.

Note that on a largish cluster the public/client traffic is all 
north-south, while the backend traffic is also mostly north-south to the 
top-of-rack and then east-west.  I.e., within the rack, almost everything 
is north-south, and client and replication traffic don't look that 
different.

sage
