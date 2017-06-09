From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] removing cluster name support
Date: Fri, 9 Jun 2017 16:07:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706091602210.3646@piezo.novalocal>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54185 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbdFIQHS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jun 2017 12:07:18 -0400
In-Reply-To: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

On Thu, 8 Jun 2017, Sage Weil wrote:
> Questions:
> 
>  - Does anybody on the list use a non-default cluster name?
>  - If so, do you have a reason not to switch back to 'ceph'?

It sounds like the answer is "yes," but not for daemons. Several users use 
it on the client side to connect to multiple clusters from the same host.

Nobody is colocating multiple daemons from different clusters on the same 
host.  Some have in the past but stopped.  If they choose to in the 
future, they can customize the systemd units themselves.

The rbd-mirror daemon has a similar requirement to talk to multiple 
clusters as a client.

This makes me conclude our current path is fine:

 - leave existing --cluster infrastructure in place in the ceph code, but
 - remove support for deploying daemons with custom cluster names from the 
deployment tools.

This neatly avoids the systemd limitations for all but the most 
adventuresome admins and avoid the more common case of an admin falling 
into the "oh, I can name my cluster? cool! [...] oh, i have to add 
--cluster rover to every command? ick!" trap.

sage
