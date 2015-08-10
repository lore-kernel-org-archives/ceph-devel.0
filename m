From: =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: bufferlist allocation optimization ideas
Date: Mon, 10 Aug 2015 21:37:27 +0200
Message-ID: <90559C83A9C7FA45B5846C975DFA612DDB53476107@ABGEX73E.FSC.NET>
References: <alpine.DEB.2.00.1508101208510.26854@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:21491 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448AbbHJThb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Aug 2015 15:37:31 -0400
In-Reply-To: <alpine.DEB.2.00.1508101208510.26854@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is pretty much low-level approach, what I was actually wondering i=
s whether we can reduce amount of memory (de)allocations on higher leve=
l, like improving the message lifecycle logic (from receiving to perfor=
ming actual operation and finishing it), so it wouldn't involve so many=
 allocations and deallocations. Reducing memory allocation on low level=
 will help, no doubts about this, but we can probably improve on higher=
 level and don't risk breaking more than we need.


With best regards / Pozdrawiam
Piotr Da=B3ek


> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Monday, August 10, 2015 9:20 PM
> To: ceph-devel@vger.kernel.org
> Subject: bufferlist allocation optimization ideas
>=20
> Currently putting something in a bufferlist invovles 3 allocations:
>=20
>  1. raw buffer (posix_memalign, or new char[])  =C2=A0 2. buffer::raw=
=C2(this holds
> the refcount.=C2=A0 lifecycle matches the
>     raw buffer exactly)
> =A0=C2=A0 3. bufferlist's STL list<> node, which embeds buffer::ptr
>=20
> --- combine buffer and buffer::raw ---
>=20
> This should be a pretty simple patch, and turns 2 allocations into on=
e.  Most
> buffers are constructed/allocated via buffer::create_*() methods.  Th=
ose
> each look something like
>=20
>   buffer::raw* buffer::create(unsigned len) {
>     return new raw_char(len);
>   }
>=20
> where raw_char::raw_char() allocates the actual buffer.  Instead, all=
ocate
> sizeof(raw_char_combined) + len, and use the right magic C++ syntax t=
o call
> the constructor on that memory.  Something like
>=20
>   raw_char_combined *foo =3D new (ptr) raw_char_combined(ptr);
>=20
> where the raw_char_combined constructor is smart enough to figure out
> that data goes at ptr + sizeof(*this).
>=20
> That takes us from 3 -> 2 allocations.
>=20
> An open question is whether this is always a good idea, or whether th=
ere are
> cases where 2 allocates are better, e.g. when len is exactly one page=
, and
> we're better off with a mempool allocation for raw and page separatel=
y.  Or
> maybe for very large buffers?  I'm really not sure what would be bett=
er...
>=20
>=20
> --- make bufferlist use boost::intrusive::list ---
>=20
> Most buffers exist in only one list, so the indirection through the p=
tr is mostly
> wasted.
>=20
> 1. embed a boost::intrustive::list node into buffer::ptr.  (Note that=
 doing just
> this buys us nothing... we are just allocating ptr's and using the in=
trusive node
> instead the list<> node with an embedded ptr.)
>=20
> 2. embed a ptr in buffer::raw (or raw_char_combined)
>=20
> When adding a buffer to the bufferlist, we use the raw_char_combined'=
s
> embedded ptr if it is available.  Otherwise, we allocate one as befor=
e.
>=20
> This would need some careful adjustment of hte common append() paths,
> since they currently are all ptr-based.  One way to make this work we=
ll might
> be to embed N ptr's in raw_char_combined, on the assumption that the
> refcount for a buffer is never more than 2 or 3.  Only in extreme cas=
es will we
> need to explicitly allocate ptr's.
>=20
>=20
> Thoughts?
> sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
