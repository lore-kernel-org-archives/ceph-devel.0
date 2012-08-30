From: Sage Weil <sage@inktank.com>
Subject: Re: CephFS mount delay
Date: Thu, 30 Aug 2012 13:15:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208301314370.8588@cobra.newdream.net>
References: <CAPrxi5_g2Nfa4AHAUkCx4LRybtDfKqwQuAH7ziVizmgq5oTJwg@mail.gmail.com> <alpine.DEB.2.00.1208301233260.8588@cobra.newdream.net> <CAPrxi59tZRzv4KG=_U375Vqg7tb5h3nLe6za0L0_B17V5mGw=w@mail.gmail.com> <CAPYLRzhh4390wjuZkEuEqs0=3SBX729kEou5NkqmVbBaJWG_rQ@mail.gmail.com>
 <CAPrxi5_G1cQ9XK9dnOP0Sgda_PYNQmj9TyqdO7D+Y7TXoYvuOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42340 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab2H3UPP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 16:15:15 -0400
In-Reply-To: <CAPrxi5_G1cQ9XK9dnOP0Sgda_PYNQmj9TyqdO7D+Y7TXoYvuOQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

I see that Server::handle_client_session is calling mdlog->flush(), so 
it's a bit odd.  Can you generate a log with 'debug ms = 1' on the client 
(and maybe mds) side?  

s

On Thu, 30 Aug 2012, Noah Watkins wrote:

> On Thu, Aug 30, 2012 at 1:06 PM, Gregory Farnum <greg@inktank.com> wrote:
> > On Thu, Aug 30, 2012 at 12:55 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> >> Using a tick interval of 1 drops the cost down to 3 seconds, but still
> >> a long time for running many unit tests that use fresh mounts.
> >
> > Are you using ceph-fuse or the kernel client? And how many of each daemon type?
> 
> I'm using the C api, and there are 3 mon, 3 mds, 1 osd.
> 
> > That said; I'm seeing broadly similar numbers ? with one of each
> > daemon (but otherwise the vstart defaults) "time sudo ceph-fuse mnt"
> > reports 3.1 seconds.
> 
> 
