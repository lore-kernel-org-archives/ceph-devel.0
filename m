From: Sage Weil <sage@inktank.com>
Subject: Re: [EXTERNAL] Re: avoiding false detection of down OSDs
Date: Tue, 31 Jul 2012 11:40:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207311136130.3171@cobra.newdream.net>
References: <CAPYLRzjoaWkMkz4U+=rZQ+YMS76vkLf_KVZfbWmdLnPuCYadSw@mail.gmail.com> <50170EF0.5040004@sandia.gov> <CAPYLRzhH-MNPHhXbg36jkMGGdh3mtn+jqR5FQDzGta0y67UkPw@mail.gmail.com> <5017F4CC.9070308@sandia.gov>
 <CAPYLRzg6=xc0ib=Wdv96TzuCYWdw6zbUSVWvvYPPNp0_ExpW9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53999 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab2GaSkn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jul 2012 14:40:43 -0400
In-Reply-To: <CAPYLRzg6=xc0ib=Wdv96TzuCYWdw6zbUSVWvvYPPNp0_ExpW9g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Jim Schutt <jaschut@sandia.gov>, ceph-devel@vger.kernel.org

On Tue, 31 Jul 2012, Gregory Farnum wrote:
> On Tue, Jul 31, 2012 at 8:07 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> > On 07/30/2012 06:24 PM, Gregory Farnum wrote:
> >> Hmm. The concern is that if an OSD is stuck on disk swapping then it's
> >> going to be just as stuck for the monitors as the OSDs ? they're all
> >> using the same network in the basic case, etc. We want to be able to
> >> make that guess before the OSD is able to answer such questions.
> >> But I'll think on if we could try something else similar.
> >
> >
> > OK - thanks.
> >
> > Also, FWIW I've been running my Ceph servers with no swap,
> > and I've recently doubled the size of my storage cluster.
> > Is it possible to have map processing do a little memory
> > accounting and log it, or to provide some way to learn
> > that map processing is chewing up significant amounts of
> > memory?  Or maybe there's already a way to learn this that
> > I need to learn about?  I sometimes run into something that
> > shares some characteristics with what you describe, but is
> > primarily triggered by high client write load.  I'd like
> > to be able to confirm or deny it's the same basic issue
> > you've described.
> 
> I think that we've done all our diagnosis using profiling tools, but
> there's now a map cache and it probably wouldn't be too difficult to
> have it dump data via perfcounters if you poked around...anything like
> this exist yet, Sage?

Much of the bad behavior was triggered by #2860, fixes for which just went 
into the stable and master branches yesterday.  It's difficult to fully 
observe the bad behavior, though (lots of time spend in 
generate_past_intervals, reading old maps off disk).  With the fix, we 
pretty much only process maps during handle_osd_map.

Adding perfcounters in the methods that grab a map out of the cache or 
(more importantly) read it off disk will give you better visibility into 
that.  It should be pretty easy to instrument that (and I'll gladly 
take patches that implement that... :).  Without knowing more about what 
you're seeing, it's hard to say if its related, though.  This was 
triggered by long periods of unclean pgs and lots of data migration, not 
high load.

sage

