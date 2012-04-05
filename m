From: Sage Weil <sage@newdream.net>
Subject: Re: pg in creating state can't be removed?
Date: Thu, 5 Apr 2012 08:20:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204050819110.2059@cobra.newdream.net>
References: <CANExM-N3DQsBzG+sLoj8x3Gs4tAdRGOXu=n0Evr5yfEfq1jF=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39453 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226Ab2DEPUX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 11:20:23 -0400
In-Reply-To: <CANExM-N3DQsBzG+sLoj8x3Gs4tAdRGOXu=n0Evr5yfEfq1jF=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 5 Apr 2012, Henry C Chang wrote:
> Hi folks,
> 
> I created a pool without adding any osds to it in the crushmap. As
> expected, all pgs remains in creating state since no osds take care of
> them.
> 
> However, I do expect that this pool should be able to be removed.
> Currently, removing such a pool hangs forever as the pg removal has to
> wait until the pg have been created. Does my expectation make sense?

Yeah.  I seem to remember the pg removal code cleaning up stuff in the 
monitor's PGMap, but I'm also pretty sure this scenario was never tested.  

Do you see where it is waiting for PG creation?  I don't think it should 
need to do that, since it's going to be thrown out anyway. 

sage
