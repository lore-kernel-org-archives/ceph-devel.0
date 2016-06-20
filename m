From: Sage Weil <sage@newdream.net>
Subject: Re: determining client and server on a connection
Date: Mon, 20 Jun 2016 12:38:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606201237560.21827@piezo.us.to>
References: <1466421669.4297.13.camel@redhat.com>  <alpine.DEB.2.11.1606201219360.21827@piezo.us.to> <1466426078.4297.24.camel@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1439330543-1466426316=:21827"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from batalion.com ([64.111.99.127]:55390 "EHLO localhost.localdomain"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752277AbcFTMkJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 20 Jun 2016 08:40:09 -0400
In-Reply-To: <1466426078.4297.24.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1439330543-1466426316=:21827
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 20 Jun 2016, Jeff Layton wrote:
> On Mon, 2016-06-20 at 12:21 +0000, Sage Weil wrote:
> > On Mon, 20 Jun 2016, Jeff Layton wrote:
> > > Hi! I'm just getting started working with ceph, and decided to tackle
> > > fixing up the wireshark dissector which isn't working properly when you
> > > use the kernel's fs client.
> > > 
> > > This page says that the server always sends its banner first:
> > > 
> > >     http://docs.ceph.com/docs/master/dev/network-protocol/?highlight=protocol
> > > 
> > > ...but that's not true with the Linux kernel client. The client and
> > > server send their banners and addresses concurrently, and the client
> > > often gets there first. The wireshark dissector relies on the server
> > > sending its banner first however, so it quickly mixes the two up and
> > > things go south from there.
> > > 
> > > Given the way the protocol works, the only way I can see to reliably
> > > determine client and server is to read enough bytes to get to the
> > > client's address when the server sends it, and see whether it matches
> > > the receiver's address/port.
> > 
> > I'm not sure I follow.  The client is the one initiating the connection 
> > and the server is the one accepting.  Does wireshark not let you tell 
> > that?
> > 
> 
> I don't think so, at least not that I can tell. I'll double-check
> though.
> 
> > The addrs are exchanged so that each end can learn what their 
> > effective address is, but this is a bit of a hack and not really 
> > ideal--hoping to reduce our reliance on this (or drop it entirely) 
> > with msgr2.
> > 
> 
> Good.
> 
> If we do need something along those lines, it would be best to make
> each peer send the same thing. Right now, the server sends its address
> and then the address of the client, but the client only sends its own
> address.
> 
> An impartial observer that doesn't see the socket connection has no way
> to know which end is going to send what. If we had the client and
> server both send both addresses (or neither) then that makes things
> _much_ simpler for the dissector.

Let's maybe change teh msgr2 banner to be 'ceph accept %llx %llx' and 
'ceph connect %llx %llx' or similar so that we don't have this problem 
there?

sage

> > > Is there a simpler way to do this that I'm missing?
> > > 
> > > Also, it looks like this shouldn't be a problem for the msgr2 protocol
> > > since the initial exchange doesn't involve sending addresses. Is that
> > > the case?
> > 
> > It's true that it doesn't include the addr exchange.  It doesn't have any 
> > other explicit indication in the data flow that tells you who is the 
> > client vs server, though, either...
> 
> If we can avoid sending addresses at all in the initial negotiation,
> then I think that takes care of the problem.
> 
> -- 
> Jeff Layton <jlayton@redhat.com>
> 
> 
--8323329-1439330543-1466426316=:21827--
