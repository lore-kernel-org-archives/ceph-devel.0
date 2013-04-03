From: Sage Weil <sage@inktank.com>
Subject: Re: Trouble getting a new file system to start, for v0.59 and
 newer
Date: Wed, 3 Apr 2013 11:25:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304031123540.15431@cobra.newdream.net>
References: <515C4EC4.5040602@sandia.gov> <alpine.DEB.2.00.1304030857480.12367@cobra.newdream.net> <515C6232.4070204@sandia.gov> <CAPYLRzgT47iTKuv-YCQWfU_4O=prrkEByp9KAftj2jFMktve5Q@mail.gmail.com> <CAPYLRzhzQp3xsf_QzzYYJo9RAj_sBV1THs2PJUhk1QRe9XB42w@mail.gmail.com>
 <515C6DD1.2050702@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59065 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762912Ab3DCSZS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Apr 2013 14:25:18 -0400
In-Reply-To: <515C6DD1.2050702@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <greg@inktank.com>, Joao Eduardo Luis <joao.luis@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 3 Apr 2013, Jim Schutt wrote:
> On 04/03/2013 11:49 AM, Gregory Farnum wrote:
> > On Wed, Apr 3, 2013 at 10:14 AM, Gregory Farnum <greg@inktank.com> wrote:
> >> On Wed, Apr 3, 2013 at 10:09 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> >>> Hi Sage,
> >>>
> >>> On 04/03/2013 09:58 AM, Sage Weil wrote:
> >>>> Hi Jim,
> >>>>
> >>>> What happens if you change 'osd mon ack timeout = 300' (from the
> >>>> default of 30)?  I suspect part of the problem is that the mons are just
> >>>> slow enough that the osd's resend the same thing again and it snowballs
> >>>> into more work for the monitor.
> >>>
> >>> Thanks, that helped.  My OSDs aren't reconnecting to the mon any more,
> >>> and the new filesystem started up as expected.
> >>>
> >>> Hmmm, it occurs to me that I upgraded my mon hosts to 10 GbE NICs at
> >>> about the same time I started testing v0.59.  Perhaps before the upgrade
> >>> I was running right at the edge of that timeout.  After the NIC upgrade
> >>> the PGStat messages come flooding in at startup, and they bunch up
> >>> enough that working through the backlog pushed me over the timeout cliff?
> >>>
> >>> Is there any downside to using a large 'osd mon ack timeout', assuming I
> >>> run more than one mon?  If so, I expect I'll work my way back from
> >>> 'osd mon ack timeout = 300' to see how big it needs to be to stay reliable
> >>> for my configuration.
> >>
> >> It's a timeout, so the generic downsides to larger timeouts ? if the
> >> monitor actually has gone away it's going to take the OSDs more time
> >> to connect to somebody else for their updates and reports. This will
> >> probably be most apparent if they're trying to peer and can't make
> >> progress until they get acks from the monitors, but the one they're
> >> connected to has died.
> >>
> >>
> >>> Sorry for the noise about paxos.  At least it was useful
> >>> to help Joao find that debug log message that was more expensive
> >>> than expected....
> >>
> >> It's not noise ? the reason this timeout is causing problems now is
> >> that the monitor disk commits are taking so long that it looks like
> >> they've failed. Which is bad. :/ So thanks for reporting it!
> > 
> > Sorry, guess I forgot some of the history since this piece at least is
> > resolved now. I'm surprised if 30-second timeouts are causing issues
> > without those overloads you were seeing; have you seen this issue
> > without your high debugging levels and without the bad PG commits (due
> > to debugging)?
> 
> I think so, because that's why I started with higher debugging
> levels.
> 
> But, as it turns out, I'm just in the process of returning to my
> testing of next, with all my debugging back to 0.  So, I'll try
> the default timeout of 30 seconds first.  If I have trouble starting
> up a new file system, I'll turn up the timeout and try again, without
> any extra debugging.  Either way, I'll let you know what happens.

I would be curious to hear roughly what value between 30 and 300 is 
sufficient, if you can experiment just a bit.  We probably want to adjust 
the default.

Perhaps more importantly, we'll need to look at the performance of the pg 
stat updates on the mon.  There is a refactor due in that code that should 
improve life, but it's slated for dumpling.

sage

> 
> -- Jim
> 
> > -Greg
> > Software Engineer #42 @ http://inktank.com | http://ceph.com
> > 
> > 
> 
> 
> 
