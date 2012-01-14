From: Sage Weil <sage@newdream.net>
Subject: Re: 0.40 OSD - Address family not supported by protocol
Date: Sat, 14 Jan 2012 14:34:51 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201141433510.24825@cobra.newdream.net>
References: <20120114145550.GN4585@rcn.com> <Pine.LNX.4.64.1201140923530.2935@cobra.newdream.net>
 <20120114183339.GO4585@rcn.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43966 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739Ab2ANWez (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Jan 2012 17:34:55 -0500
In-Reply-To: <20120114183339.GO4585@rcn.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Pieper <jjp@pobox.com>
Cc: ceph-devel@vger.kernel.org

Hi Josh,

Can you attach one of your OSDmaps with the poison entries?  Between

	ceph osd getmap 149 -o /tmp/149
	ceph osd getmap 155 -o /tmp/155

I should see one of them.

Thanks!
sage


On Sat, 14 Jan 2012, Josh Pieper wrote:

> Sage Weil wrote:
> > Hi Josh,
> > 
> > On Sat, 14 Jan 2012, Josh Pieper wrote:
> > > I just upgraded our test cluster to 0.40, and immediately after
> > > starting up get asserts in all the OSDs.  I've inlined a relevant
> > > backtrace below, is there anything else that would be useful for
> > > debugging?
> > 
> > Are you coming from 0.39 or something older?
> 
> I was upgrading from 0.39.
> 
> > You might try reverting 4728f4f8e09878c583c65cd882e031d37f8d903e and see 
> > if that does it..
> > 
> > Can you reproduce it with --debug-osd 10 and --debug-ms 10?
> 
> Unfortunately, I cannot appear to reproduce the problem any more.
> Re-upgrading to 0.40 now shows no problem, I've tried to explore the
> range of things I may have done, but with no luck. I had to trash my
> journals in order to downgrade, so there is some amount of state that
> was lost which may be related to my inability to reproduce now?
> 
> For what it is worth, I believe the problem may have been caused by
> something the 0.40 versions were sending.  As I was downgrading back
> to 0.39, the downgraded 0.39 version kept dying with the same error as
> long as one of the 0.40 versions was still up.
> 
> I did not know of the ms debugging when I was first investigating, but
> looking through my old data, I have a trace with OSD debug set to 20
> of the 0.39 version dying of the fault:
> 
> http://joshp.no-ip.com:8080/20120114-osd-family-error.log.bz2
> 
> -Josh
> 
> 
