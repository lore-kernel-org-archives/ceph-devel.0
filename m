From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 16 Feb 2011 14:50:11 -0700
Message-ID: <1297893011.25491.124.camel@sale659.sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:44597 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab1BPVuk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Feb 2011 16:50:40 -0500
In-Reply-To: <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Wed, 2011-02-16 at 14:40 -0700, Gregory Farnum wrote:
> On Wednesday, February 16, 2011 at 1:25 PM, Jim Schutt wrote:
> > Hi,
> >
> > I've been testing v0.24.3 w/ 64 clients against
> > 1 mon, 1 mds, 96 osds. Under heavy write load I
> > see:
> >  [WRN] map e7 wrongly marked me down or wrong addr
> >
> > I was able to sort through the logs and discover that when
> > this happens I have large gaps (10 seconds or more) in osd
> > heatbeat processing. In those heartbeat gaps I've discovered
> > long periods (5-15 seconds) where an osd logs nothing, even
> > though I am running with debug osd/filestore/journal = 20.
> >
> > Is this a known issue?
> 
> You're running on btrfs? 

Yep.

> We've come across some issues involving very long sync times that I believe manifest like this. Sage is looking into them, although it's delayed at the moment thanks to FAST 11. :)

OK, great.

-- Jim

> -Greg
> 



