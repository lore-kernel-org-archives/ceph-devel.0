From: Sage Weil <sage@inktank.com>
Subject: Re: maintanance on osd host
Date: Tue, 26 Feb 2013 09:06:22 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302260904440.2730@cobra.newdream.net>
References: <512CCD19.7010509@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50025 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab3BZRGX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 12:06:23 -0500
In-Reply-To: <512CCD19.7010509@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 26 Feb 2013, Stefan Priebe - Profihost AG wrote:
> Hi list,
> 
> how can i do a short maintanance like a kernel upgrade on an osd host?
> Right now ceph starts to backfill immediatly if i say:
> ceph osd out 41
> ...
> 
> Without ceph osd out command all clients hang for the time ceph does not
> know that the host was rebootet.
> 
> I tried
> ceph osd set nodown and ceph osd set noout
> but this doesn't result in any difference

For a temporary event like this, you want the osd to be down (so that io 
can continue with remaining replicas) but NOT to mark it out (so that data 
doesn't get rebalanced).  The simplest way to do that is

 ceph osd set noout
 killall ceph-osd
 .. reboot ..

Just remember to do

 ceph osd unset noout

when you are done so that future osds that fail will get marked out on 
their own after the 5 minute (default) interval.

sage

