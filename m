From: Josh Pieper <jjp@pobox.com>
Subject: Re: 0.40 OSD - Address family not supported by protocol
Date: Sat, 14 Jan 2012 13:33:39 -0500
Message-ID: <20120114183339.GO4585@rcn.com>
References: <20120114145550.GN4585@rcn.com>
 <Pine.LNX.4.64.1201140923530.2935@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:27573 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756432Ab2ANSdl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Jan 2012 13:33:41 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1201140923530.2935@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Sage Weil wrote:
> Hi Josh,
> 
> On Sat, 14 Jan 2012, Josh Pieper wrote:
> > I just upgraded our test cluster to 0.40, and immediately after
> > starting up get asserts in all the OSDs.  I've inlined a relevant
> > backtrace below, is there anything else that would be useful for
> > debugging?
> 
> Are you coming from 0.39 or something older?

I was upgrading from 0.39.

> You might try reverting 4728f4f8e09878c583c65cd882e031d37f8d903e and see 
> if that does it..
> 
> Can you reproduce it with --debug-osd 10 and --debug-ms 10?

Unfortunately, I cannot appear to reproduce the problem any more.
Re-upgrading to 0.40 now shows no problem, I've tried to explore the
range of things I may have done, but with no luck. I had to trash my
journals in order to downgrade, so there is some amount of state that
was lost which may be related to my inability to reproduce now?

For what it is worth, I believe the problem may have been caused by
something the 0.40 versions were sending.  As I was downgrading back
to 0.39, the downgraded 0.39 version kept dying with the same error as
long as one of the 0.40 versions was still up.

I did not know of the ms debugging when I was first investigating, but
looking through my old data, I have a trace with OSD debug set to 20
of the 0.39 version dying of the fault:

http://joshp.no-ip.com:8080/20120114-osd-family-error.log.bz2

-Josh
