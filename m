From: Sage Weil <sage@inktank.com>
Subject: Re: mon disk access pattern
Date: Fri, 15 Jun 2012 09:30:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206150930110.4551@cobra.newdream.net>
References: <4FDACD90.2080807@profihost.ag> <4FDB05A7.3080202@widodh.nl>
 <4FDB1DCC.6090701@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50046 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261Ab2FOQa5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 12:30:57 -0400
In-Reply-To: <4FDB1DCC.6090701@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 15 Jun 2012, Mark Nelson wrote:
> On 06/15/2012 04:51 AM, Wido den Hollander wrote:
> > Hi,
> > 
> > On 15-06-12 07:52, Stefan Priebe - Profihost AG wrote:
> > > Hello list,
> > > 
> > > i read somewhere that the mon has "special" disk access patterns - even
> > > though it does not write much data.
> > 
> > "special"? Where did you read that? The monitor has about 1 ~ 2GB of
> > storage.
> > 
> > So if your monitor has something like 4GB ~ 8GB of RAM, your kernel
> > should cache almost all your monitor data.
> > 
> 
> I think at some point someone mentioned to me that the mon can cause a lot of
> syncs, so running them on the OSDs without syncfs might be detrimental.  For
> the majority of our internal performance testing I've kept them off the OSDs
> just to be sure.

Right.  The only thing interesting about the mon access pattern is that it 
calls fsync() a lot when healthy, and will call syncfs() or sync() during 
recovery.

sage
