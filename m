From: Jeff Layton <jlayton@redhat.com>
Subject: Re: determining client and server on a connection
Date: Mon, 20 Jun 2016 08:46:06 -0400
Message-ID: <1466426766.4297.30.camel@redhat.com>
References: <1466421669.4297.13.camel@redhat.com>
	  <alpine.DEB.2.11.1606201219360.21827@piezo.us.to>
	 <1466426078.4297.24.camel@redhat.com>
	 <alpine.DEB.2.11.1606201237560.21827@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35245 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbcFTMz1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jun 2016 08:55:27 -0400
Received: by mail-yw0-f174.google.com with SMTP id l125so22177769ywb.2
        for <ceph-devel@vger.kernel.org>; Mon, 20 Jun 2016 05:53:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606201237560.21827@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 2016-06-20 at 12:38 +0000, Sage Weil wrote:
> On Mon, 20 Jun 2016, Jeff Layton wrote:
> > On Mon, 2016-06-20 at 12:21 +0000, Sage Weil wrote:
> > > On Mon, 20 Jun 2016, Jeff Layton wrote:
> > > > Hi! I'm just getting started working with ceph, and decided to =
tackle
> > > > fixing up the wireshark dissector which isn't working properly =
when you
> > > > use the kernel's fs client.
> > > >=C2=A0
> > > > This page says that the server always sends its banner first:
> > > >=C2=A0
> > > >=C2=A0=C2=A0=C2=A0=C2=A0 http://docs.ceph.com/docs/master/dev/ne=
twork-protocol/?highlight=3Dprotocol
> > > >=C2=A0
> > > > ...but that's not true with the Linux kernel client. The client=
 and
> > > > server send their banners and addresses concurrently, and the c=
lient
> > > > often gets there first. The wireshark dissector relies on the s=
erver
> > > > sending its banner first however, so it quickly mixes the two u=
p and
> > > > things go south from there.
> > > >=C2=A0
> > > > Given the way the protocol works, the only way I can see to rel=
iably
> > > > determine client and server is to read enough bytes to get to t=
he
> > > > client's address when the server sends it, and see whether it m=
atches
> > > > the receiver's address/port.
> > >=C2=A0
> > > I'm not sure I follow.=C2=A0 The client is the one initiating the=
 connection=C2=A0
> > > and the server is the one accepting.=C2=A0 Does wireshark not let=
 you tell=C2=A0
> > > that?
> > >=C2=A0
> >=C2=A0
> > I don't think so, at least not that I can tell. I'll double-check
> > though.
> >=C2=A0
> > > The addrs are exchanged so that each end can learn what their=C2=A0
> > > effective address is, but this is a bit of a hack and not really=C2=
=A0
> > > ideal--hoping to reduce our reliance on this (or drop it entirely=
)=C2=A0
> > > with msgr2.
> > >=C2=A0
> >=C2=A0
> > Good.
> >=C2=A0
> > If we do need something along those lines, it would be best to make
> > each peer send the same thing. Right now, the server sends its addr=
ess
> > and then the address of the client, but the client only sends its o=
wn
> > address.
> >=C2=A0
> > An impartial observer that doesn't see the socket connection has no=
 way
> > to know which end is going to send what. If we had the client and
> > server both send both addresses (or neither) then that makes things
> > _much_ simpler for the dissector.
>=20
> Let's maybe change teh msgr2 banner to be 'ceph accept %llx %llx' and=
=C2=A0
> 'ceph connect %llx %llx' or similar so that we don't have this proble=
m=C2=A0
> there?
>=20
> sage
>=20

Yeah, that'd be fine too.

OTOH, does the connector/acceptor distinction really make any
difference? The only time that wireshark cares is when it's dissecting
the initial negotiation, because the inital message lengths are
different.

I guess it might be nice to know just for informational purposes
though...

> > > > Is there a simpler way to do this that I'm missing?
> > > >=C2=A0
> > > > Also, it looks like this shouldn't be a problem for the msgr2 p=
rotocol
> > > > since the initial exchange doesn't involve sending addresses. I=
s that
> > > > the case?
> > >=C2=A0
> > > It's true that it doesn't include the addr exchange.=C2=A0 It doe=
sn't have any=C2=A0
> > > other explicit indication in the data flow that tells you who is =
the=C2=A0
> > > client vs server, though, either...
> >=C2=A0
> > If we can avoid sending addresses at all in the initial negotiation=
,
> > then I think that takes care of the problem.
> >=C2=A0
--=C2=A0
Jeff Layton <jlayton@redhat.com>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
