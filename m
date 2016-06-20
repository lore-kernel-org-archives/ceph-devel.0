From: Jeff Layton <jlayton@redhat.com>
Subject: Re: determining client and server on a connection
Date: Mon, 20 Jun 2016 08:34:38 -0400
Message-ID: <1466426078.4297.24.camel@redhat.com>
References: <1466421669.4297.13.camel@redhat.com>
	 <alpine.DEB.2.11.1606201219360.21827@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36375 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632AbcFTOWk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jun 2016 10:22:40 -0400
Received: by mail-yw0-f180.google.com with SMTP id b72so13521731ywa.3
        for <ceph-devel@vger.kernel.org>; Mon, 20 Jun 2016 07:22:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606201219360.21827@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 2016-06-20 at 12:21 +0000, Sage Weil wrote:
> On Mon, 20 Jun 2016, Jeff Layton wrote:
> > Hi! I'm just getting started working with ceph, and decided to tack=
le
> > fixing up the wireshark dissector which isn't working properly when=
 you
> > use the kernel's fs client.
> >=C2=A0
> > This page says that the server always sends its banner first:
> >=C2=A0
> >=C2=A0=C2=A0=C2=A0=C2=A0 http://docs.ceph.com/docs/master/dev/networ=
k-protocol/?highlight=3Dprotocol
> >=C2=A0
> > ...but that's not true with the Linux kernel client. The client and
> > server send their banners and addresses concurrently, and the clien=
t
> > often gets there first. The wireshark dissector relies on the serve=
r
> > sending its banner first however, so it quickly mixes the two up an=
d
> > things go south from there.
> >=C2=A0
> > Given the way the protocol works, the only way I can see to reliabl=
y
> > determine client and server is to read enough bytes to get to the
> > client's address when the server sends it, and see whether it match=
es
> > the receiver's address/port.
>=20
> I'm not sure I follow.=C2=A0 The client is the one initiating the con=
nection=C2=A0
> and the server is the one accepting.=C2=A0 Does wireshark not let you=
 tell=C2=A0
> that?
>=20

I don't think so, at least not that I can tell. I'll double-check
though.

> The addrs are exchanged so that each end can learn what their=C2=A0
> effective address is, but this is a bit of a hack and not really=C2=A0
> ideal--hoping to reduce our reliance on this (or drop it entirely)=C2=
=A0
> with msgr2.
>=20

Good.

If we do need something along those lines, it would be best to make
each peer send the same thing. Right now, the server sends its address
and then the address of the client, but the client only sends its own
address.

An impartial observer that doesn't see the socket connection has no way
to know which end is going to send what. If we had the client and
server both send both addresses (or neither) then that makes things
_much_ simpler for the dissector.

> > Is there a simpler way to do this that I'm missing?
> >=C2=A0
> > Also, it looks like this shouldn't be a problem for the msgr2 proto=
col
> > since the initial exchange doesn't involve sending addresses. Is th=
at
> > the case?
>=20
> It's true that it doesn't include the addr exchange.=C2=A0 It doesn't=
 have any=C2=A0
> other explicit indication in the data flow that tells you who is the=C2=
=A0
> client vs server, though, either...

If we can avoid sending addresses at all in the initial negotiation,
then I think that takes care of the problem.

--=20
Jeff Layton <jlayton@redhat.com>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
