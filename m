From: Sage Weil <sweil@redhat.com>
Subject: Re: msgr2 protocol
Date: Tue, 13 Sep 2016 13:21:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609131316230.19761@piezo.us.to>
References: <CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com> <alpine.DEB.2.11.1606100649010.6221@cpach.fuggernut.com> <20160610190510.GA18999@degu.eng.arb.redhat.com> <alpine.DEB.2.11.1606101658530.6221@cpach.fuggernut.com>
 <20160611230503.GA18268@degu.eng.arb.redhat.com> <alpine.DEB.2.11.1606121950490.32559@cpach.fuggernut.com> <CACJqLyax_SXEZp3vA2_wR+CdwKOo2Re=SsK2xfXqmXjz9d8iNw@mail.gmail.com> <alpine.DEB.2.11.1609092112171.19761@piezo.us.to>
 <CACJqLyYwKZ5_1OHR_5=+mr=1ED2Nt34x4TB29j5dE1D+NjzFpg@mail.gmail.com> <CACJqLybA-cArcno2oS0AZx238hrV64PZyK9fFXdCBuVHKQQP3Q@mail.gmail.com> <alpine.DEB.2.11.1609111703430.19761@piezo.us.to> <CACJqLybGs1paSFu4zBEFW8dhYVBfDHSEzY3RwKGvDA03wdiF2A@mail.gmail.com>
 <alpine.DEB.2.11.1609121319270.19761@piezo.us.to> <CAJ4mKGZYTr4D1dXa8aEt9muNwrOA9DsxRzWVf0=zWH44VZ-Onw@mail.gmail.com> <CACJqLyZOh=scFqW2LyWMQ3h9LND0mXkaycs=38XfNjJKQwWryg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751633AbcIMNVx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Sep 2016 09:21:53 -0400
In-Reply-To: <CACJqLyZOh=scFqW2LyWMQ3h9LND0mXkaycs=38XfNjJKQwWryg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Marcus Watts <mwatts@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 13 Sep 2016, Haomai Wang wrote:
> On Tue, Sep 13, 2016 at 8:03 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> > On Mon, Sep 12, 2016 at 6:21 AM, Sage Weil <sweil@redhat.com> wrote:
> >> On Mon, 12 Sep 2016, Haomai Wang wrote:
> >>> This way is ok to me. So another change is double messenger
> >>> instances(to v1 and v2) or let each messenger support multi binding
> >>> addresses(this may need to refactor messenger interface).
> >>
> >> Yeah.  I'm guessing we'll want to have an entity_addrvec_t with address
> >> types mapped to different Messenger implementations (e.g., xio), so we'll
> >> wan to allow multiple instance eventually.  But we'll also just want to
> >> allow multiple binding (v1 + v2, or ipv4 + ipv6).  :/
> >
> > Hmm, is that really necessary? It seems a fair bit more complicated
> > and I'm not sure there's much payoff given the connection types.
> > Long-term the only doubled connection I can see being needed is the
> > client one; OSD cluster messengers will only be required to bind twice
> > during the initial upgrade period.
> >
> > Put another way, what's the advantage of supporting two different
> > protocols within one messenger? That just sounds like a disaster
> 
> I don't think this version upgrade will happen right now. I guess
> there will be a version to switch to async msgr, then we consider to
> upgrade msgr version really.
> 
> > waiting to happen, and not one worth risking for slightly reducing the
> > thread count on AsyncMessenger (especially with users coming from the
> > SimpleMessenger).
> 
> Maybe you like aonther msgr like asyncmessengerv2? instead of the same
> msgr type. From my view, msgrv2 will reduce packet per message and
> prepare for the other new features.

There are two sides to the problem: the server needs to multi-home at 
mulitiple addresses (v1 + v2, ipv4 + ipv6 + xio, etc).  Using separate 
Messenger instances doesn't seem like a big deal there.

On the connecting client side of things, we will regularly be presented 
with an entity_addrvec_t for a peer and want to connect.  Something needs 
to pick a preferred address and connect.  If it's multiple Messengers, 
then there needs to be some multiplexing layer that opens a Connection.  
(I think from there on out almost everything is con-handle based, so that 
shouldn't be a problem.)

For v1/v2 a single instance would do, but once we start talking about xio 
then clearly we need the multiplexing (on both ends), so that's probably 
the way to go.

Whether it's a fork of msg/async or a constructor argument that determines 
which version of the protocol to speak doesn't matter much to me.  We 
could even just make async pure v2 and leave simplemessenger for legacy 
clients... that's the least long term code maintenance...

sage
