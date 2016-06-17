From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: encoding
Date: Fri, 17 Jun 2016 17:28:03 +0000
Message-ID: <BLUPR0201MB15247981D954A0180454544CE8570@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <BLUPR0201MB1524E3853169E4292D16F710E8570@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1606171657530.21827@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0075.outbound.protection.outlook.com ([157.56.110.75]:48722
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750751AbcFQR2N convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jun 2016 13:28:13 -0400
In-Reply-To: <alpine.DEB.2.11.1606171657530.21827@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm just trying to work the encoding size.

Igor has point out that unused could be replaced by a bitmap and sugges=
ted that it could be quite small (4 or 8 bytes) -- though he cites some=
 particular examples about it being "small".=20

Do we actually need a full bitmap? Might not a simple left-off pointer =
be almost as good?

w.r.t. ref_map. The comment in the code suggests that it will always be=
 empty for a non-shared blob. If that's correct perhaps it's not a big =
deal.

Allen Samuels
SanDisk |a Western Digital brand
2880 Junction Avenue, Milpitas, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Friday, June 17, 2016 10:03 AM
> To: Allen Samuels <Allen.Samuels@sandisk.com>
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: encoding
>=20
> On Fri, 17 Jun 2016, Allen Samuels wrote:
> > I don=A2t understand the ref_map and unused stuff. What is their pu=
rpose?
>=20
> ref_map:
>=20
> We allocate blobs and write uncompressed data in.  Later, we logicall=
y
> overwrite part of that reference, such that our big 1MB allocation on=
ly has
> part of it referenced.  When that happens we want to release the
> unreferenced part back to the allocator for use by something else.
> ref_map lets us do that, which some additional complexity that counts
> references (from multiple clones).
>=20
> unused:
>=20
> We might allocate a full min_alloc_size but only write one block into=
 it.
> If we do another small write in an adjacent block, we want to write i=
nto the
> existing blob.  In order to do that without with a WAL event, we need=
 to
> know that the block isn't currently referenced by anything.
> ref_map isn't quite sufficient for this because we don't have a compl=
icated
> commit/persist lifecycle sequence on update, and we need to make sure=
 the
> *committed* state has no references before we can safely overwrite a
> block.
>=20
> After pondering this a while I decided that would be very complex to
> implement that, with marginal benefit, and in reality this mostly mat=
ters for
> newly-allocated but never-written blobs... hence unused.  I decided w=
e
> don't care the case when you partially occlude part of a blob (but le=
ss that
> min_alloc_size so it wasn't released back to the allocator) and
> *then* also do a small overwrite such that the space could be reused.
>=20
> sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
