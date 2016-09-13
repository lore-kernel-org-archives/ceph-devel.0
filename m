From: Sage Weil <sweil@redhat.com>
Subject: Re: msgr2 protocol
Date: Tue, 13 Sep 2016 15:10:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609131506250.19761@piezo.us.to>
References: <CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com>                 <CAJ4mKGaWx8m4Zh_f6tQWe9ows77HHyMmv5y52Rr-5Q-ob_N1Yg@mail.gmail.com>                 <alpine.DEB.2.11.1606030912000.6221@cpach.fuggernut.com>                
 <CACJqLyZs9EdbnjSiazPzxD_R+yuwPT9BzDq-GmEyS55f_pYFdw@mail.gmail.com>                 <alpine.DEB.2.11.1606031333050.6221@cpach.fuggernut.com>                 <CAJ4mKGbyCiWbuwGxhGu_ohf7vxNqVqgf4XQQpQ7eg-tP-YO+gg@mail.gmail.com>                
 <alpine.DEB.2.11.1606100649010.6221@cpach.fuggernut.com>         <20160610190510.GA18999@degu.eng.arb.redhat.com>                 <alpine.DEB.2.11.1606101658530.6221@cpach.fuggernut.com>                 <20160611230503.GA18268@degu.eng.arb.redhat.com>    
             <alpine.DEB.2.11.1606121950490.32559@cpach.fuggernut.com>                 <CACJqLyax_SXEZp3vA2_wR+CdwKOo2Re=SsK2xfXqmXjz9d8iNw@mail.gmail.com>                 <alpine.DEB.2.11.1609092112171.19761@piezo.us.to>                
 <CACJqLyYwKZ5_1OHR_5=+mr=1ED2Nt34x4TB29j5dE1D+NjzFpg@mail.gmail.com>                 <CACJqLybA-cArcno2oS0AZx238hrV64PZyK9fFXdCBuVHKQQP3Q@mail.gmail.com>         <alpine.DEB.2.11.1609111703430.19761@piezo.us.to>         <1473765504.4740.14.camel@redhat.com>
         <alpine.DEB.2.11.1609131327350.19761@piezo.us.to> <1473778134.4740.44.camel@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1141036360-1473779454=:19761"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752971AbcIMPK4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Sep 2016 11:10:56 -0400
In-Reply-To: <1473778134.4740.44.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Haomai Wang <haomai@xsky.com>, Marcus Watts <mwatts@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1141036360-1473779454=:19761
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 13 Sep 2016, Jeff Layton wrote:
> On Tue, 2016-09-13 at 13:31 +0000, Sage Weil wrote:
> > On Tue, 13 Sep 2016, Jeff Layton wrote:
> > > On Sun, 2016-09-11 at 17:05 +0000, Sage Weil wrote:
> > > > On Sat, 10 Sep 2016, Haomai Wang wrote:
> > > > > About thing is v1/v2 compatible. I rethink the details:
> > > > > 
> > > > > 0. we need to define the new banner which must longer than before("ceph v027")
> > > > > 1. assume msgr v2 banner is "ceph v2 %64llx %64llx\n"
> > > > > 2. both in simle/async codes, server side must issue banner firstly
> > > > > 3. if server side supports v2 and client only supports v1, client will
> > > > > receive 9 bytes and do memcmp, then reject this connection via closing
> > > > > socket. So server side could retry the older version
> > > > > 4. if server side only supports v1 and client supports v2, client
> > > > > according banner to reply corresponding banner
> > > > > 
> > > > > This tricky design is based on the implementation fact "accept side
> > > > > issue the banner firstly" and "new banner is longer than old banner",
> > > > > and this way doesn't need to involve other dependences like mon port
> > > > > changes.
> > > > > 
> > > > > Does this way has problem?
> > > > 
> > > > I was thinking we avoid this problem and any hacky initial handshakes by 
> > > > speaking v2 on the new port and v1 on the old port.  Then the monmap has 
> > > > an entity_addrvec_t with both a v1 and v2 address (encoding with just the 
> > > > v1 address for old clients). Same for the OSDs.
> > > > 
> > > > The v1 handshake just isn't extensible (how do you tell a v2 client 
> > > > connecting that you speak both v1 and v2?).
> > > > 
> > > 
> > > Depending on port assignments for the protocol is pretty icky though.
> > > There may be valid reasons to use different ports in some environments
> > > and then that heuristic goes right out the window.
> > > 
> > > One thing that is really strange about both the old and new protocols
> > > is that they have the client and server sending the initial exchange
> > > concurrently, or have the server send it first.  While it may speed up
> > > the initial negotiation slightly, it makes it really hard to handle
> > > fallback to earlier protocol versions (as Haomai pointed out), as the
> > > client is responsible for handing reconnects.
> > > 
> > > Consider the case where we have a client that supports only v1 but a
> > > server that supports v1 and v2. Client connects and then server sends a
> > > v2 message. Client doesn't understand it and closes the connection and
> > > reconnects, only to end up in the same situation on the second attempt.
> > > 
> > > There's no way for the server to preserve the state from the initial
> > > connection attempt and handle the new connection with v1. Would it not
> > > make more sense to have the client connect and send its initial banner,
> > > and then let the server decide what sort of banner to send based on
> > > what the client sent?
> > 
> > This is why the v2 banner has the features values (%lx with supported and 
> > required bits).  Clients and servers (connecter and accepters, really, 
> > since servers talk to each other too) can concurrently announce what they 
> > support and require and then go from there.  It doesn't help with the v1 
> > transition, but the addrvec changes (entity_addr_t now has a type 
> > indicating which protocol is spoken, and multiple addrs can be listed for 
> > any server) along with a mon port change (which we have to do anyway to 
> > switch to our IANA assigned port) handle the v1 transition.
> > 
> 
> Ahh ok, I didn't realize ceph was squatting on a port! Ok, then if
> you're planning to switch to a new well-known port anyway, then a clean
> break like this makes more sense.
> 
> I'll confess though that I don't quite understand the whole point of
> the entity_addr_t's. What purpose does it serve to exchange network
> addresses here?

The main thing is that entity_addr_t contains a nonce to distinguish 
between difference incarnations of the same server on the same port.  When 
an OSD is marked down and comes back up, the nonce will be different, and 
its peers can tell they're talking to the new/current instance without any 
stale state (or whatever).  Currently we guard this at the messenger 
layer, so that if we're trying to connect to a particularly instance 
of osd.12 we will simply fail to connect if that port is occupied by 
someone else (e.g., a newer instance of osd.12 that we don't know about 
yet) so that we don't confuse them or ourselves.

> Is it simply to inform the peer of other ways that it
> can be reached?

With the addrvec changes anybody connecting to (this version of) you 
should already have a list of all your addresses...

> What happens if I pick up my laptop that's acting as a
> ceph client and wander onto a new network. Does anything break?

I'm sure something will break currently, but eventually I think we can 
shake these issues out... for clients, at least.  The servers all talk to 
each other so we assume there is no NAT gumming up the works.

> > Are there other reasons to do the client banner first?  
> 
> I think that's the main one.
> 
> The only other reason I can think of might be to guard against
> information disclosure to port scanners. If you require the client to
> send a banner first, then the server could drop the connection if it
> doesn't look right without ever sending anything.
> 
> That said, given that we're going to be using a IANA designated port in
> most cases, that's not going to be terribly useful. The port scanners
> would just send a bogus but legit-looking banner to that port.

Sounds good to me!
sage
--8323329-1141036360-1473779454=:19761--
