From: Sage Weil <sage@inktank.com>
Subject: Re: bug in rbd rename command?
Date: Fri, 19 Apr 2013 13:33:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304191332560.13036@cobra.newdream.net>
References: <5170F217.9020105@profihost.ag> <5171A883.2040006@inktank.com> <5171A917.6040704@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33612 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab3DSUdP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 16:33:15 -0400
In-Reply-To: <5171A917.6040704@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Dan Mick <dan.mick@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I think we can make the --dest-pool default to --pool instead of rbd...  
that's easy enough, right?

sage

On Fri, 19 Apr 2013, Stefan Priebe wrote:

> Am 19.04.2013 22:26, schrieb Dan Mick:
> > It's arguable, but we wanted to treat source and destination pools
> > separately in general.
> > 
> > Note that you can also specify images as POOLNAME/a and POOLNAME/b.
> Sure i know that. But then -p does not make sense at all. Nobody want to use:
> rbd -p POOLFORA rename a POOLFORB/b
> 
> Wouldn't it be constant to expand this for b? I mean renaming from poola to
> poolb isn't supported anyway ;-)
> 
> Greets,
> Stefan
> 
> > On 04/19/2013 12:28 AM, Stefan Priebe - Profihost AG wrote:
> > > Hi,
> > > 
> > > if i issue rbd -p POOLNAME ... rename a b
> > > 
> > > It uses the POOL for a but not for b.
> > > 
> > > Output is then:
> > > rbd: mv/rename across pools not supported
> > > source pool: vmstorssd1 dest pool: rbd
> > > 
> > > Shouldn't it use the pool provided by -p for both?
> > > 
> > > Stefan
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
