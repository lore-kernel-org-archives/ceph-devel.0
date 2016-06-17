From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: encoding
Date: Fri, 17 Jun 2016 18:53:03 +0000
Message-ID: <BLUPR0201MB152438F87027D1C1496930F4E8570@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <BLUPR0201MB1524E3853169E4292D16F710E8570@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1606171657530.21827@piezo.us.to>
 <BLUPR0201MB15247981D954A0180454544CE8570@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1606171749150.22717@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0083.outbound.protection.outlook.com ([157.56.111.83]:57193
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752337AbcFQTIa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jun 2016 15:08:30 -0400
In-Reply-To: <alpine.DEB.2.11.1606171749150.22717@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Friday, June 17, 2016 10:55 AM
> To: Allen Samuels <Allen.Samuels@sandisk.com>
> Cc: ceph-devel@vger.kernel.org
> Subject: RE: encoding
>=20
> On Fri, 17 Jun 2016, Allen Samuels wrote:
> > I'm just trying to work the encoding size.
> >
> > Igor has point out that unused could be replaced by a bitmap and
> > suggested that it could be quite small (4 or 8 bytes) -- though he
> > cites some particular examples about it being "small".
> >
> > Do we actually need a full bitmap? Might not a simple left-off poin=
ter
> > be almost as good?
>=20
> He's right that it's only useful for a min_alloc_size'd blob, where w=
e expect
> teh bitmap to be about 16 bits.  We could have a left/right boundary =
that
> encodes into 8 bits (two 0..15 values) that would probably capture 70=
% of the
> performance benefit and save one byte.  I'm inclined to go for a bitm=
ap for
> now, though...
>=20
> > w.r.t. ref_map. The comment in the code suggests that it will alway=
s
> > be empty for a non-shared blob. If that's correct perhaps it's not =
a
> > big deal.
>=20
> That was the original thought, but it didn't end up being the case.  =
We could
> write a non-trivial chunk of code to rebuild that info at runtime fro=
m the
> lextent map, but I'd put that pretty far down on the list too.
> Instead, we can probably take advantage of the fact that most of the =
ref
> counts will be 1 or 0 and combine those ~2 bits into a more efficent =
record_t
> encoding.  This should be sequenced after the first pass of varint en=
codings,
> though, which I'm partway through stabilizing.
> Should have a PR by Monday.

With some deeper thinking, it seems to me that the rebuild-ref-map-on-d=
eserialize is pretty trivial. Isn't it just a walk of the lextent map a=
nd for each entry a corresponding call to add_ref for that referenced b=
lob (assuming add_ref correctly combines overlapping references)????


>=20
> sage
>=20
> >
> > Allen Samuels
> > SanDisk |a Western Digital brand
> > 2880 Junction Avenue, Milpitas, CA 95134
> > T: +1 408 801 7030| M: +1 408 780 6416
> > allen.samuels@SanDisk.com
> >
> >
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sweil@redhat.com]
> > > Sent: Friday, June 17, 2016 10:03 AM
> > > To: Allen Samuels <Allen.Samuels@sandisk.com>
> > > Cc: ceph-devel@vger.kernel.org
> > > Subject: Re: encoding
> > >
> > > On Fri, 17 Jun 2016, Allen Samuels wrote:
> > > > I don=A2t understand the ref_map and unused stuff. What is thei=
r
> purpose?
> > >
> > > ref_map:
> > >
> > > We allocate blobs and write uncompressed data in.  Later, we logi=
cally
> > > overwrite part of that reference, such that our big 1MB allocatio=
n only
> has
> > > part of it referenced.  When that happens we want to release the
> > > unreferenced part back to the allocator for use by something else=
=2E
> > > ref_map lets us do that, which some additional complexity that co=
unts
> > > references (from multiple clones).
> > >
> > > unused:
> > >
> > > We might allocate a full min_alloc_size but only write one block =
into it.
> > > If we do another small write in an adjacent block, we want to wri=
te into
> the
> > > existing blob.  In order to do that without with a WAL event, we =
need to
> > > know that the block isn't currently referenced by anything.
> > > ref_map isn't quite sufficient for this because we don't have a
> complicated
> > > commit/persist lifecycle sequence on update, and we need to make =
sure
> the
> > > *committed* state has no references before we can safely overwrit=
e a
> > > block.
> > >
> > > After pondering this a while I decided that would be very complex=
 to
> > > implement that, with marginal benefit, and in reality this mostly=
 matters
> for
> > > newly-allocated but never-written blobs... hence unused.  I decid=
ed we
> > > don't care the case when you partially occlude part of a blob (bu=
t less that
> > > min_alloc_size so it wasn't released back to the allocator) and
> > > *then* also do a small overwrite such that the space could be reu=
sed.
> > >
> > > sage
> >
> >
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
