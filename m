From: Sage Weil <sage@inktank.com>
Subject: Re: still crashing osds with next branch
Date: Wed, 20 Jun 2012 11:11:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206201110540.14284@cobra.newdream.net>
References: <4FE19FF2.2090302@profihost.ag> <4FE1D06A.1080906@profihost.ag>
 <4FE2062A.7060508@profihost.ag> <Pine.LNX.4.64.1206201034120.14284@cobra.newdream.net>
 <4FE21216.4050108@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50781 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab2FTSLN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 14:11:13 -0400
In-Reply-To: <4FE21216.4050108@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 20 Jun 2012, Stefan Priebe wrote:
> Am 20.06.2012 19:35, schrieb Sage Weil:
> > On Wed, 20 Jun 2012, Stefan Priebe wrote:
> > > Nobody an idea? Should i open up bugs in tracker?
> > 
> > Let's open up bugs.  If they are reproducible, debug osd = 20 logs would
> > be awesome!
> > 
> > Also, the crash you mentioned in your earlier email we did see:
> > 
> > 	http://tracker.newdream.net/issues/2599
> > 
> > If you have logs from that crash, those would also be helpful.
> 
> i can't reproduce but it happens pretty often. So i can switch to debug osd =
> 20 in general. What else do you need?

That will probably be enough, but if you get a core file, don't throw it 
away :)

thanks!
sage

