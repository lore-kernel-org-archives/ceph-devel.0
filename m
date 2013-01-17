From: Sage Weil <sage@inktank.com>
Subject: Re: Hit suicide timeout after adding new osd
Date: Thu, 17 Jan 2013 09:17:23 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80EFF.7020803@widodh.nl> <50F80FA0.5010504@profihost.ag> <50F819B8.4070004@widodh.nl> <50F81A9F.2090104@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33406 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483Ab3AQRRX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 12:17:23 -0500
In-Reply-To: <50F81A9F.2090104@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Wido den Hollander <wido@widodh.nl>, =?ISO-8859-15?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The fix for this is in v0.56.1, so I think you are seeing something else.

If this is something you can reproduce with 'debug osd = 10' or 20 and 
'debug ms = 1', that would be extremely helpful!

Thanks
sage

On Thu, 17 Jan 2013, Stefan Priebe wrote:

> Hi Sage,
> 
> Am 17.01.2013 16:33, schrieb Wido den Hollander:
> > Hi,
> > On 01/17/2013 03:50 PM, Stefan Priebe wrote:
> > > Hi,
> > > Am 17.01.2013 15:47, schrieb Wido den Hollander:
> > > > You might want to try building from 'next' yourself or fetch some new
> > > > packages from the RPM repos: http://eu.ceph.com/docs/master/install/rpm/
> > > 
> > > Should it be backported to bobtail branch as well?
> > > 
> > 
> > Don't think it's in there. I found the commit in the next branch:
> > https://github.com/ceph/ceph/commit/7e94f6f1a7b7a865433edacd6a521f6ea1170eac
> > 
> > Doesn't seem to be in 'bobtail'.
> > 
> > Wido
> 
> Was this forgotten? I mean a lot of people have posted about git suicide
> timeout with 0.56 oder 0.56.1 so it should be also in the bobtail branch?
> 
> Greets,
> Stefan
> 
> 
