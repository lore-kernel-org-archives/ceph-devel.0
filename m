From: Sage Weil <sage@inktank.com>
Subject: Re: CephFS mount delay
Date: Thu, 30 Aug 2012 15:39:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208301538200.15643@cobra.newdream.net>
References: <CAPrxi5_g2Nfa4AHAUkCx4LRybtDfKqwQuAH7ziVizmgq5oTJwg@mail.gmail.com> <alpine.DEB.2.00.1208301233260.8588@cobra.newdream.net> <CAPrxi59tZRzv4KG=_U375Vqg7tb5h3nLe6za0L0_B17V5mGw=w@mail.gmail.com> <CAPYLRzhh4390wjuZkEuEqs0=3SBX729kEou5NkqmVbBaJWG_rQ@mail.gmail.com>
 <CAPrxi5_G1cQ9XK9dnOP0Sgda_PYNQmj9TyqdO7D+Y7TXoYvuOQ@mail.gmail.com> <alpine.DEB.2.00.1208301314370.8588@cobra.newdream.net> <CAPrxi58oZZ25BmcftEz+TgnHy70dPsHhivuFtXd6KkkF7NG8LQ@mail.gmail.com> <alpine.DEB.2.00.1208301339120.11149@cobra.newdream.net>
 <CAPrxi58zJQx4ersx2sQ=e0N9U1hxk5cKZmqBW1f9fONd-W-ToQ@mail.gmail.com> <CAPYLRzh6G+H1bA_G4GoSKxrZPt4wPxcDtih1W1xt2thCXTvuvg@mail.gmail.com> <CAPrxi591mVDbvPH4=S557ryOWibKZ5F3aKVeMdqu2QW9a7h53Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43232 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458Ab2H3Wj6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 18:39:58 -0400
In-Reply-To: <CAPrxi591mVDbvPH4=S557ryOWibKZ5F3aKVeMdqu2QW9a7h53Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 30 Aug 2012, Noah Watkins wrote:
> On Thu, Aug 30, 2012 at 3:17 PM, Gregory Farnum <greg@inktank.com> wrote:
> > On Thu, Aug 30, 2012 at 3:10 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> >> Ok, this patch sorta solves the problem. After a fresh restart of the
> >> daemons, the client hangs indefinitely (log urls attached for this
> >> case). If I kill the client and restart, I get a behavior similar to
> >> the original problem. Another client restart and everything is very
> >> fast. This easily reproducible.
> >
> > I'm not quite sure what scenario you're describing here ? let's see if
> > I understand correctly:
> > 1) Working cluster.
> > 2) Restart server daemons.
> > 3) Client just hangs. :(
> > 4) Restart client and it goes slow through the mount (once?).
> > 5) Restart client again and everything goes fast from then on.
> 
> Yeh, remove (4) -- there was some other fluke, I think. The following
> happens every time with the one line patch from Sage:
> 
> 2) Restart daemons
> 3) Client hangs in mount
> 4) Restart client and everything runs very fast from now on.
> 
> Without the patch, the client never hangs, but is consistently slow to mount.

I think this is just the mds reconnect delay; it's complete normal when 
the mds restarts and some of the clients also crashed that it has to wait 
for the full reconnect window to pass.

I pushed the fix to master!

sage

