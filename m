From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: bluestore onode diet and encoding overhead
Date: Wed, 13 Jul 2016 08:33:00 +0200
Message-ID: <20160713063300.GA32333@predictor>
References: <9b80fe95-9da5-bffe-c869-a7ba51da70b3@redhat.com>
 <BLUPR0201MB1524775973993917A1A59078E8300@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1607121658240.497@piezo.us.to>
 <0b770e1d-5b3a-b9d1-175c-ccec29ee1737@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:39390 "EHLO predictor.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbcGMGdS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Jul 2016 02:33:18 -0400
Content-Disposition: inline
In-Reply-To: <0b770e1d-5b3a-b9d1-175c-ccec29ee1737@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jul 12, 2016 at 10:13:14PM -0500, Mark Nelson wrote:
>=20
>=20
> On 07/12/2016 08:50 PM, Sage Weil wrote:
> >On Tue, 12 Jul 2016, Allen Samuels wrote:
> >>[..]
> >>I believe we need to revisit the idea of custom encode/decode paths=
 for
> >>high-usage cases, only now the gains need to be focused on CPU
> >>utilization as well as space efficiency.
> >
> >I still think we can get most or all of the way there in a generic w=
ay by
> >revising the way that we interact with bufferlist for encode and dec=
ode.
> >We haven't actually tried to optimize this yet, and the current code=
 is
> >pretty horribly inefficient (asserts all over the place, and many la=
yers
> >of pointer indirection to do a simple append).  I think we need to d=
o two
> >things:
> >
> >1) decode path: optimize the iterator class so that it has a const c=
har
> >*current and const char *current_end that point into the current
> >buffer::ptr.  This way any decode will have a single pointer
> >add+comparison to ensure there is enough data to copy before falling=
 into
> >the slow path (partial buffer, move to next buffer, etc.).
>=20
> I don't have a good sense yet for how much this is hurting us in the
> read path.  We screwed something up in the last couple of weeks and
> small reads are quite slow.

The main issue with decode using bufferlist is that we cannot assume
anything regarding internal data memory layout. We can't do anything li=
ke

 int j =3D *((int*) bufferptr.c_str());

because bufferptr may be too short for "j" to be read in one go.
Possible solution would be to ensure that bufferptrs contain contiguous
blocks large enough to store one unit of data (be it, for example, onod=
e
info).

> >2) Having that comparison is still not ideal, but we shoudl consider=
 ways
> >to get around that too.  For example, if we know that we are going t=
o
> >decode N M-byte things, we could do an iterator 'reserve' or 'check'=
 that
> >ensures we have a valid pointer for that much and then proceed witho=
ut
> >checks.  The interface here would be tricky, though, since in the sl=
ow
> >case we'll span buffers and need to magically fall back to a differe=
nt
> >decode path (hard to maintain) or do a temporary copy (probably fast=
er but
> >we need to ensure the iterator owns it and frees is later).  I'd say=
 this
> >is step 2 and optional; step 1 will have the most benefit.

Exactly my point.
Regarding a copy, we could just do something like rebuild_contiguous() =
and
make sure bufferlist is a one, large bufferptr or it is split on logica=
l
data unit boundary instead of random places that are messenger/underyli=
ng
I/O store dependent. That will take care of both memory ownership and
bufferlist continuity.

> >3) encode path: currently all encode methods take a bufferlist& and =
the
> >bufferlist itself as an append buffer.  I think this is flawed and
> >limiting.  Instead, we should make a new class called
> >buffer::list::appender (or similar) and templatize the encode method=
s so
> >they can take a safe_appender (which does bounds checking) or an
> >unsafe_appender (which does not).  For the latter, the user takes
> >responsibility for making sure there is enough space by doing a rese=
rve()
> >type call which returns an unsafe_appender, and it's their job to ma=
ke
> >sure they don't shove too much data into it.  That should make the e=
ncode
> >path a memcpy + ptr increment (for savvy/optimized callers).
>=20
> Seems reasonable and similar in performance to what Piotr and I were
> discussing this morning.  As a very simple test I was thinking of
> doing a quick size computation and then passing that in to increase
> the append_buffer size when the bufferlist is created in
> Bluestore::_txc_write_nodes.  His idea went a bit farther to break
> the encapsulation, compute the fully encoded message, and dump it
> directly into a buffer of a computed size without the extra assert
> checks or bounds checking.  Obviously his idea would be faster but
> more work.
>=20
> It sounds like your solution would be similar but a bit more formaliz=
ed.

I like the idea, because that way we could add extra checks to debug bu=
ilds
(added via preprocessor define) and have the ability to find bugs easie=
r,
retaining performance on release/optimized builds.
Or we could go that way all-in, have single kind of appender and do bou=
nds
check only on debug builds.

> >I suggest we use bluestore as a test case to make the interfaces wor=
k and
> >be fast.  If we succeed we can take advantage of it across the reset=
 of
> >the code base as well.
>=20
> Do we have other places in the code with similar byte append
> behavior? That's what's really killing us I think, especially with
> how small the new append_buffer is when you run out of space when
> appending bytes.

I still recommend doing a dry bench and measure how fast _txc_write_nod=
es
is. We may be spending a lot of time optimizing bufferlist API, when th=
e
real issue lies in another place. Creation and destruction of bufferlis=
t is
one of my point of concerns in _txc_write_nodes, but then, I have no cl=
ue on
how many times that happen per entire call.
If the following

   // (KeyValueDB::Transaction t, set<OnodeRef>::iterator p)
   t->set(PREFIX_OBJ, (*p)->key, bl);

performs synchronously (i.e. doesn't do anything else with bl contents =
after
leaving t->set call), we could just rewind bl and start overwriting it.=
 In
worst case, we would alloc extra memory, which is still one case out of=
 3
possible (remaining being new onode/bnode of the same or smaller sizes
than previous one).

--=20
Piotr Da=C5=82ek
branch@predictor.org.pl
http://blog.predictor.org.pl
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
