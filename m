From: Sage Weil <sage@inktank.com>
Subject: Re: OSD crashed today in os/JournalingObjectStore.cc
Date: Fri, 7 Dec 2012 03:02:58 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212070301330.17681@cobra.newdream.net>
References: <50BF1A43.4060605@profihost.ag> <alpine.DEB.2.00.1212050639480.17270@cobra.newdream.net> <BC8B71E3-1BE1-49ED-B578-34A0CBACAB98@profihost.ag> <alpine.DEB.2.00.1212051534530.14332@cobra.newdream.net> <50C0677B.4090400@profihost.ag>
 <alpine.DEB.2.00.1212061634520.22833@cobra.newdream.net> <50C19F8F.10902@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59836 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232Ab2LGLC7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Dec 2012 06:02:59 -0500
In-Reply-To: <50C19F8F.10902@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 7 Dec 2012, Stefan Priebe - Profihost AG wrote:
> Hi Sage,
> 
> thanks for patching this. I'm not sure whether i can test this. I've moved my
> systems to first productional tests and i can't create a downtime or loss of
> data again ;-)
> 
> How stable are these fixes?

Only tested on my laptop.  :)  

I'll put them through our qa first, and make sure our stress tests 
can trigger the old failure.

Thanks!
sage


> 
> Am 07.12.2012 01:38, schrieb Sage Weil:
> > Hi Stefan,
> > 
> > I've pushed a few patches to wip-filestore2 that simplify and fix this
> > code.  Can you give it a go?
> > 
> > Thanks!
> > sage
> 
> Greets,
> Stefan
> 
> 
