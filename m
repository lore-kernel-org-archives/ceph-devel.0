From: Sage Weil <sage@newdream.net>
Subject: Re: [IANA #826907] Application for a Port Number and/or Service Name
 "ceph" (Completed) (fwd)
Date: Mon, 13 Jul 2015 06:13:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507130612170.20547@cobra.newdream.net>
References: <alpine.DEB.2.00.1507101406390.20547@cobra.newdream.net> <55A03DE0.2070900@42on.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48822 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbbGMNNx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jul 2015 09:13:53 -0400
In-Reply-To: <55A03DE0.2070900@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 10 Jul 2015, Wido den Hollander wrote:
> On 07/10/2015 11:08 PM, Sage Weil wrote:
> > It's official!  We have a new port number for the monitor:
> > 
> > 	3300	(that's CE4h, or 0xCE4).
> > 
> > Sometime in the next cycle we'll need to make a transition plan to move 
> > from 6789.
> > 
> 
> Very nice! We should be clear though that nothing will break for
> existing users.
> 
> The new default will become 3300, but every mon has IP+Port in the
> monmap, so it won't hit them. Just to make sure people aren't afraid to
> upgrade their Ceph cluster.

Yeah.  Probably the MonClient will try both 3300 and 6789 when the port 
isn't explicitly specified.  We may need to delay actually using 3300 for 
another release cycle so that the clients know about the new port before 
we start using it.

sage
