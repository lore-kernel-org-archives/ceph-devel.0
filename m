From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: bufferlist allocation optimization ideas
Date: Mon, 10 Aug 2015 16:27:03 -0400 (EDT)
Message-ID: <853447999.3469406.1439238423535.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.00.1508101208510.26854@cobra.newdream.net> <90559C83A9C7FA45B5846C975DFA612DDB53476107@ABGEX73E.FSC.NET> <alpine.DEB.2.00.1508101239290.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:48157 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbbHJU1H convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Aug 2015 16:27:07 -0400
In-Reply-To: <alpine.DEB.2.00.1508101239290.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Piotr =?utf-8?Q?Da=C5=82ek?= <Piotr.Dalek@ts.fujitsu.com>, ceph-devel@vger.kernel.org

We explored a number of these ideas.  We have a few branches that might=
 be picked over.

Having said that, our feeling was that the generality to span shared an=
d non-shared cases transparently has cost in the unmarked case.  Other =
aspects of the buffer indirection are essential (e.g., Accelio originat=
ed buffers, etc).  We see a large contribution from ptr::release in per=
f.  One of the main aspirations we had was to identify code paths which=
 would never share buffers, and not pay for sharing in those paths.

To the degree that bufferlist is frequently used as a kind of flexible =
string class, while other code uses it as a smart tailq of iovec or str=
uct uio, there is client code with disjoint assumptions.  As mentioned,=
 shared vs. non-shared code paths are similarly disjoint.  I'm not cert=
ain what the consequent here is.  Ceph code gets a lot of simplificatio=
n from this idiom, but it is not minimalist.

We found ways, as Piotr suggested, to avoid allocations of groups of ob=
jects related to a message, and this had a lot of impact.  We're trying=
 to merge some of that soon.

Matt

----- Original Message -----
=46rom: "Sage Weil" <sweil@redhat.com>
To: "Piotr Da=C5=82ek" <Piotr.Dalek@ts.fujitsu.com>
Cc: ceph-devel@vger.kernel.org
Sent: Monday, August 10, 2015 3:39:56 PM
Subject: RE: bufferlist allocation optimization ideas

On Mon, 10 Aug 2015, Da?ek, Piotr wrote:
> This is pretty much low-level approach, what I was actually wondering=
 is=20
> whether we can reduce amount of memory (de)allocations on higher leve=
l,=20
> like improving the message lifecycle logic (from receiving to perform=
ing=20
> actual operation and finishing it), so it wouldn't involve so many=20
> allocations and deallocations. Reducing memory allocation on low leve=
l=20
> will help, no doubts about this, but we can probably improve on highe=
r=20
> level and don't risk breaking more than we need.

Yes, definitely!  I think we should pursue both...

sage


>=20
>=20
> With best regards / Pozdrawiam
> Piotr Da?ek
>=20
>=20
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > owner@vger.kernel.org] On Behalf Of Sage Weil
> > Sent: Monday, August 10, 2015 9:20 PM
> > To: ceph-devel@vger.kernel.org
> > Subject: bufferlist allocation optimization ideas
> >=20
> > Currently putting something in a bufferlist invovles 3 allocations:
> >=20
> >  1. raw buffer (posix_memalign, or new char[])  =C3=82=C2=A0 2. buf=
fer::raw=C3=82(this holds
> > the refcount.=C3=82=C2=A0 lifecycle matches the
> >     raw buffer exactly)
> > =C2=A0=C3=82=C2=A0 3. bufferlist's STL list<> node, which embeds bu=
ffer::ptr
> >=20
> > --- combine buffer and buffer::raw ---
> >=20
> > This should be a pretty simple patch, and turns 2 allocations into =
one.  Most
> > buffers are constructed/allocated via buffer::create_*() methods.  =
Those
> > each look something like
> >=20
> >   buffer::raw* buffer::create(unsigned len) {
> >     return new raw_char(len);
> >   }
> >=20
> > where raw_char::raw_char() allocates the actual buffer.  Instead, a=
llocate
> > sizeof(raw_char_combined) + len, and use the right magic C++ syntax=
 to call
> > the constructor on that memory.  Something like
> >=20
> >   raw_char_combined *foo =3D new (ptr) raw_char_combined(ptr);
> >=20
> > where the raw_char_combined constructor is smart enough to figure o=
ut
> > that data goes at ptr + sizeof(*this).
> >=20
> > That takes us from 3 -> 2 allocations.
> >=20
> > An open question is whether this is always a good idea, or whether =
there are
> > cases where 2 allocates are better, e.g. when len is exactly one pa=
ge, and
> > we're better off with a mempool allocation for raw and page separat=
ely.  Or
> > maybe for very large buffers?  I'm really not sure what would be be=
tter...
> >=20
> >=20
> > --- make bufferlist use boost::intrusive::list ---
> >=20
> > Most buffers exist in only one list, so the indirection through the=
 ptr is mostly
> > wasted.
> >=20
> > 1. embed a boost::intrustive::list node into buffer::ptr.  (Note th=
at doing just
> > this buys us nothing... we are just allocating ptr's and using the =
intrusive node
> > instead the list<> node with an embedded ptr.)
> >=20
> > 2. embed a ptr in buffer::raw (or raw_char_combined)
> >=20
> > When adding a buffer to the bufferlist, we use the raw_char_combine=
d's
> > embedded ptr if it is available.  Otherwise, we allocate one as bef=
ore.
> >=20
> > This would need some careful adjustment of hte common append() path=
s,
> > since they currently are all ptr-based.  One way to make this work =
well might
> > be to embed N ptr's in raw_char_combined, on the assumption that th=
e
> > refcount for a buffer is never more than 2 or 3.  Only in extreme c=
ases will we
> > need to explicitly allocate ptr's.
> >=20
> >=20
> > Thoughts?
> > sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
