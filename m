From: Sage Weil <sage@newdream.net>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 16 Feb 2011 16:50:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com> <1297893011.25491.124.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57219 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873Ab1BQAtj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Feb 2011 19:49:39 -0500
In-Reply-To: <1297893011.25491.124.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 16 Feb 2011, Jim Schutt wrote:
> On Wed, 2011-02-16 at 14:40 -0700, Gregory Farnum wrote:
> > On Wednesday, February 16, 2011 at 1:25 PM, Jim Schutt wrote:
> > > Hi,
> > >
> > > I've been testing v0.24.3 w/ 64 clients against
> > > 1 mon, 1 mds, 96 osds. Under heavy write load I
> > > see:
> > >  [WRN] map e7 wrongly marked me down or wrong addr
> > >
> > > I was able to sort through the logs and discover that when
> > > this happens I have large gaps (10 seconds or more) in osd
> > > heatbeat processing. In those heartbeat gaps I've discovered
> > > long periods (5-15 seconds) where an osd logs nothing, even
> > > though I am running with debug osd/filestore/journal = 20.
> > >
> > > Is this a known issue?
> > 
> > You're running on btrfs? 
> 
> Yep.

Are the cosd log files on the same btrfs volume as the btrfs data, or 
elsewhere?  The heartbeat thread takes some pains to avoid any locks that 
may be contented and do avoid any disk io, so in theory a btrfs stall 
shouldn't affect anything.  We may have missed something.. do you have a 
log showing this in action?

sage


> 
> > We've come across some issues involving very long sync times that I believe manifest like this. Sage is looking into them, although it's delayed at the moment thanks to FAST 11. :)
> 
> OK, great.
> 
> -- Jim
> 
> > -Greg
> > 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
