From: Sage Weil <sage@inktank.com>
Subject: Re: pg balancing
Date: Tue, 14 May 2013 08:25:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305140824410.22973@cobra.newdream.net>
References: <alpine.DEB.2.00.1305131730380.10961@cobra.newdream.net> <90541911-BA54-4683-AF2B-34FBFC5ED264@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58795 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376Ab3ENPZS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 May 2013 11:25:18 -0400
In-Reply-To: <90541911-BA54-4683-AF2B-34FBFC5ED264@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "jaschut@sandia.gov" <jaschut@sandia.gov>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 14 May 2013, Chen, Xiaoxi wrote:
> from which release can we get this?

That function has been there since 0.30something I think, although we 
fixed some major bug sometime around argonaut.  But it's largely unused 
and undocumented, so testing is encouraged!  :)

sage

> 
> ???? iPhone
> 
> ? 2013-5-14?8:36?"Sage Weil" <sage@inktank.com> ???
> 
> > Hi Jim-
> > 
> > You mentioned the other day your concerns about the uniformity of the PG 
> > and data distribution.  There are several ways to attack it (including 
> > increasing the number of PGs), but one that we haven't tested much yet is 
> > the 'reweight-by-utilization' function in the monitor.
> > 
> > The idea is that there will always be some statistical variance in the 
> > distribution and a non-zero probability of having outlier OSDs with too 
> > many PG.  We adjust for this by taking nodes that are substantially above 
> > the mean down by some adjustment factor in an automated way.
> > 
> > ceph osd reweight-by-utilization MIN
> > 
> > where MIN is the minimum relative utilization at which we will start 
> > adjusting down.  It is always > 100 (100% of the mean), and defaults to 
> > 120.  After it adjusts the reweights, you should see the result in 'ceph 
> > osd tree' output
> > 
> > Have you played with this at all on your cluster?  I'd be very interested 
> > in how well this does/does not improve things for you.
> > 
> > Thanks!
> > sage
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
