From: Sage Weil <sage@newdream.net>
Subject: Re: read/write on RADOS using external buffer
Date: Wed, 20 Oct 2010 09:53:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010200948040.3927@cobra.newdream.net>
References: <AANLkTikRnvWbsD5OD7a88hpHsm5N3hJteaisYkfjdY2H@mail.gmail.com>
 <Pine.LNX.4.64.1009141142250.8559@cobra.newdream.net>
 <20101019222727.GA1737@enoki.dokukino.com> <AANLkTinjo-cyALumDEHiw4NwwJS5E0v5_59X1w11iTog@mail.gmail.com>
 <Pine.LNX.4.64.1010192059070.21300@cobra.newdream.net>
 <AANLkTin0+n+e6Cb_WJcz5JA7xR_XG_K=2k0_bhSDuDRh@mail.gmail.com>
 <Pine.LNX.4.64.1010200821210.3927@cobra.newdream.net>
 <AANLkTi=GyJdFkRV5zo-v-74tn=YBKCBuZC9fdeg1fJCr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1368209974-1287593614=:3927"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40948 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221Ab0JTQuh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Oct 2010 12:50:37 -0400
In-Reply-To: <AANLkTi=GyJdFkRV5zo-v-74tn=YBKCBuZC9fdeg1fJCr@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Takuya ASADA <syuu@dokukino.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1368209974-1287593614=:3927
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 20 Oct 2010, Colin McCabe wrote:
> > SimpleMessenger will change no matter what, because the core problem th=
at
> > we're trying to solve is that it allocates a new buffer when a message =
is
> > being read off the wire. =A0See SimpleMessenger::read_message(). =A0Som=
ehow
> > that needs to discover and use the user provided buffer instead. =A0Tha=
t
> > will invariably involve a callback of some sort to find the user buffer=
=2E
> > And some means of yanking the buffer away to deal with the corner issue
> > above.
>=20
> I can see now that we're always allocating a new bufferlist in
> SimpleMessenger. I can see why we want this feature.
>=20
> I wish we didn't have to have a callback just to get the buffer we're
> trying to write into. It feels like that should somehow be grouped
> with the rest of the transaction data. Why can't we add it to
> Objector::Op's constructor, for example. There must be some obvious
> reason but I don't see it yet.

Well, we could push it into the Objecter.  We could also try to push it=20
all the way down into the messenger, my maintaining a map of <type,tid> to=
=20
buffer or something.  Mainly I want to avoid changing too much of the=20
intervening interfaces if we can avoid it.  That may be possible, though. =
=20
If the Objecter::read() is given a non-empty bufferlist* to read into, it=
=20
could advertise that buffer to the messenger and the messenger could=20
handle it all.

But the same problem comes up: we need to also have an interface to take=20
the buffer back, which will mean some interesting interaction with the=20
reader threads.

The kernel messenger avoids this, btw, because it is event driven: we wake=
=20
up when there is socket activity and do non-blocking reads/writes, so we=20
can lock the buffers while doing that IO.  The SimpleMessenger=20
implementation uses threads, and IIRC the pthread locking =20
and select/poll interfaces don't play well together.

sage
=20
--557981400-1368209974-1287593614=:3927--
